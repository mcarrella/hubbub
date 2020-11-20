import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hubbub/repos/groupsRepo.dart';

abstract class GroupsService {
	Future<Group> getGroup(String groupId);
	Future<String> processCreateGroup(String userId, String groupName, LatLng pos);
	Future<bool> checkUserStatus(String groupId);
	Future<bool> checkMemberStatus(String groupId);
	Future<List<Group>> fetchUserGroups();
	Future<Group> handleInvite(String userId, String groupId);
	Future<Group> handleRequest(String userId, String groupId);
	Future<Group> handleAccept(String groupId);
	Future<void> handledDecline(String groupId);
	Future<void> handleRemove(String groupId);

	
}



class FirebaseGroupsService implements GroupsServices {

	FirebaseGroupsRepo _groupsRepo;
	FirebaseGroupsService({FirebaseGroupsRepo groupsRepo}) : assert(groupsRepo!=null),
																_groupsRepo = groupsRepo;


	FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

	CollectionReference pendingRef = Firestore.instance.collection("pending");
	CollectionReference groupsRef = Firestore.instance.collection("groups");

	@override
	Future<Group> getGroup(String groupId) async {
				final docSnap = groupsRef.document(groupId).get();
				return Group.fromDocument(docSnap);
	}
		


	@override
	Future<DocumentSnapshot> processCreateGroup(String userId, String groupName, LatLng pos) async {
				
				
				String groupId = await _groupsRepo.createGroupMembership(userId, groupName);
				await _groupsRepo.createGroupDocument(groupId)
				await _groupsRepo.assingGroupPlace(groupId, pos);
	}


	@override
	Future<bool> checkUserStatus(String groupId) async {
			
			var user = await _firebaseAuth.currentUser;
			return await checkMemberStatus(user.uid, groupId);
		}
			

	@override
	Future<bool> checkMemberStatus(String userId, String groupId) async {
			return await _groupsRepo.fetchMembershipStatus(userId, groupId);
	}
	
	
	@override
	Future<List<Group>> fetchUserGroups() async {
		var user = await _firebaseAtuh.currentUser();
		final groupsDocs = _groupsRepo.fetchGroupsForUser(user.uid);
		List<Group> groupsList = [];
		qsnap.documents.forEach((doc) async {
			Group group = Group.fromDocument(doc);
			groupsList.add(group);
			});
	
		return groupsList;

	}


	@override
	Future<void> createGroup(String groupName) async {
		var user = await _firebaseAuth.currentUser();
		await groupsRef.document(groupName + user.uid).collection("members").document(uid).setData({});
	}
	

	@override
	Future<Group> handleInvite(String userId, String groupId) async {
			final docSnap = await groupsRepo.processInvite(userId, grouId);
			return Group.fromDocument(docSnap);
			

	}
	
	
	
	@override
	Future<Group> handleConfirm(String userId, String groupId) async {
		final docSnap = await groupsRepo.processConfirmed(groupId);
		return Group.fromDocument(docSnap);

	}
	

	
	@override
	Future<void> handleDecline(String groupId) async {
		
		var user = await _firebaseAuth.currentUser();
		
		DocumentSnapshot docSnap = await pendingRef.document(user.uid).collection("invitesPending").document(groupId).get();
		if (docSnap.exists) {
			docSnap.reference.delete();
			}
		}
		

	@override
	Future<void>  handleRemove(String userId, String groupId) async {
		DocumentSnapshot docSnap = await userseRef.document(userId).collection("memberships").document(groupId).get();
		
	
		if (docSnap.exists) {
			docSnap.reference.delete();
			}
		}
}

		
	
		
		
		
	
	
		
		
