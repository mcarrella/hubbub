import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';


abstract class groupsRepo {
	Future<void> createGroup(String groupName);
	
	Future<DocumentSnapshot> undoRequestPeding(String userId, String groupId);




	Future<List<DocumentSnapshot>> allUserGroups(String userId);
	Future<bool> fetchMembershipStatus(String userId, string groupId);
	Future<DocumentSnapshot> processInvite(String userId, String groupId);
	Future<DocumentSnapshot> processRemove(String userId, String groupId)
	Future<String> undoMembershipPending(String userId, String groupId);
	Future<String> undoInvitation(String userId, String groupdId);
	Future<DocumentSnapshot> getGroupDoc(String groupId);
}


class FirebaseGroupsRepo implements groupsRepo {
	FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
	CollectionReference _groupsRef = Firestore.instance.collection("groups");
	CollectionReference _pendingRef = Firestore.instance.collection("pending");
	CollectionReference _usersRef = Firestore.instance.collection("users");
	
	
	@override
	Futre<List<DocumentSnapshot>> allUserGroups(String userId) async {
				List<DocumentSnapshot> groupSnaps = [];
				QuerySnapshot querySnap = _usersRef.document(userId).collection("hasMembership").getDocuments();
				querySnap.document.forEach((doc) async {
									groupSnaps.add(Group.fromDocument(await getGroupDoc(doc.documentID)));
								});
				return groupSnaps;
				}
					
	
		
	Future<DocumentSnapshot> getGroupDoc(String groupId) async {
		return await groupsRef.document(id);
	}
	
	Future<bool> fetchMembershipStatus(String userId, String groupId) async {
		
		DocumentSnapshot membership = await _groupsRef.document(groupId).collection("memberships").document(user.uid).get();
		return membership.exists;
	}

	
	
	@override
	Future<void> createGroup(String groupName, LatLng pos) {
				var user = await _firebaseAuth.currentUser();
				fianl groupId = await createGroupDocument(user.uid, groupname);
				await assignGroupPlace(groupId, pos);
				return await craeteGroupMembership(user.uid, groupId);
	}

	@override
	Future<void> createGroupMembership(String userId, String groupId) async {
				String groupId = groupName + userId;
				await _usersRef.document(userId).collection("memberships").document(groupId).setData({});
				return groupId;
	
			}

	@override
	Future<void> assignGroupPlace(String groupId, LatLng pos) async {
			
			await groupsRef.document(groupId).collection("groupPlaces").document(place.toJson());
			return groupId;

	}

	@override
	Future<void> createGroupDocument(String userId, String groupName) async {
		String groupId = groupName + userId;
		
		
		final doc = await groupsRef.document(groupId).setData({});
		return groupId;
		
	}

	@override
	Future<String> processConfirmed(String userId, String groupId) async {
					
					String groupId = await undoMembershipPending(userId, groupId);
					String groupId = awwit undoInvitation(userId, groupId);
					await _usersRef.document(userId).collection("groupMembers").document(groupId);
					return groupId;
	}
					
	@override
	Future<String> undoInvitation(String userId, String groupdId) async {
			DocumentSnapshot doc = await _pendingRef.document(userId).collection("invites").document(groupId).get();
			return groupId;
	}


	@override
	Future<String> undoMembershipPending(String userId, String groupId) async {
						DocumentSnapshot doc = await _pendingRef.document(groupId).collection("pendingMembers").document(useId);
						if (doc.exists) {
								doc.reference.delete();
						}
						return groupId;
	}

	@override
	Future<DocumentSnapshot> processRemove(String userId, String groupId) {
				DocumentSnapshot doc = await _groupsRef.document(groupId).collection("groupMembers").document(userId).get();
				if (doc.exists) {
							doc.delete();
				}
				retun await _groupsRef.document(groupId).get();
	}
	
	@override
	Future<DocumentSnapshot> processInvite(String userId, String groupId) async {
						
						DocumentSnapshot doc = await pendingRef.document(userId).collection("groupInvites").document(groupId).get();
						if (!doc.exists) {
										_pendingRef.document(userId).collection("groupInvites").document(groupId).setData({});
								}
						return await getGroupDoc(groupId);
			}
										
	
	}
	