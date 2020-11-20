import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hubbub/models/user.dart';
import 'package:hubbub/enums/users_relation.dart';


abstract class UsersRepo {
	Future<bool> checkFriends(String uid1, String uid2);
	Future<bool> checkPending(String uid1, String uid2);
	Future<QuerySnapshot> fetchFriendsData();
	Future<QuerySnapshot> fetchPendingData();
	
	Future<void> handleRequest(String uid);
	Future<void> handleApprove(String uid);
	Future<void> handleDeny(String uid);
	Future<void> handleRemove(String uid);
	Future<DocumentSnapshot> getUser(String uid);
	Future<User> currentUser();
	Future<String> isSignedIn();
	
}


class FirebaseUsersRepo implements UsersRepo {
	FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
	CollectionReference usersRef = Firestore.instance.collection("users");
	CollectionReference friendsRef = Firestore.instance.collection("friends");
	CollectionReference pendingRef = Firestore.instance.collection("pending");
	
	
		
	
	@override
	Future<DocumentSnapshot> getUser(String uid) async {
			return await usersRef.document(uid).get();
	}
	
	@override
	Future<User> currentUser() async {
		final uid = await isSignedIn();
		final docSnap = await getUser(uid);
		User user = User.fromDocument(docSnap);
		print('USER NAME: ' + user.displayName);
		return user;
	}
			
	
	
	@override
	Future<void> handleRequest(String uid) async {
		String current = await isSignedIn();
		pendingRef.document(uid).collection("requestsPending").document(current).setData({});
	}
	
	@override
	Future<void> handleUndo(String uid) async {
			String current = await isSignedIn();
			DocumentSnapshot pendingDoc = await pendingRef.document(uid).collection("requestsPending").document(current).get();
			if (pendingDoc.exists) {
				pendingDoc.reference.delete();
				}
	}
	
	@override
	Future<void> handleApprove(String uid) async {
		String current = await isSignedIn();
		friendsRef.document(current).collection("friendsWith").document(uid).setData({});
		friendsRef.document(uid).collection("friendsWith").document(current).setData({});
		DocumentSnapshot docSnap = await pendingRef.document(current).collection("requestsPending").document(uid).get();
		if (docSnap.exists) {
			docSnap.reference.delete();
			}
		}
		
	@override
	Future<void> handleDeny(String uid) async {
		String current = await isSignedIn();
		DocumentSnapshot docSnap = await pendingRef.document(current).collection("requestPending").document(uid).get();
		if (docSnap.exists) {
			docSnap.reference.delete();
		}
	}
	
	Future<void> handleRemove(String uid) async {
			String current = await isSignedIn();
			DocumentSnapshot docSnap1 = await friendsRef.document(current).collection("friendsWith").document(uid).get();
			DocumentSnapshot docSnap2 = await friendsRef.document(uid).collection("friendsWith").document(current).get();
			if (docSnap1.exists) {
				docSnap1.reference.delete();
			}
			if (docSnap2.exists) {
				docSnap2.reference.delete();
			}
		}
		
	@override
	Future<bool> checkFriends(String uid1, String uid2) async {

		
			DocumentSnapshot docSnap = await friendsRef.document(uid2).collection("friendsWith").document(uid2).get();
			if (docSnap.exists) {
					return true;
					} else {
						return false;
						}
				
	}
	
	@override
	Future<bool> checkPending(String uid1, String uid2) async {
		
			DocumentSnapshot docSnap = await pendingRef.document(uid2).collection("requestsPending").document(uid2).get();
			if (docSnap.exists) {
					return true;
					} else {
						return false;
						}
				
	}
	
	@override
	Future<bool> checkRequested(String uid1, String uid2) async {
		
			DocumentSnapshot docSnap = await pendingRef.document(uid1).collection("requestsPending").document(uid2).get();
			if (docSnap.exists) {
					return true;
					} else {
						return false;
						}
				
	}
	@override
	Future<String> isSignedIn() async {
			var user = await _firebaseAuth.currentUser();
			if (user!=null) {
				return user.uid;
				}
		}

	@override
	Future<QuerySnapshot> fetchFriendsData() async {
		var user = await _firebaseAuth.currentUser();
		return await friendsRef.document(user.uid).collection("friendsWith").getDocuments();

	}
	
	@override
	Future<QuerySnapshot> fetchPendingData() async {
		var user = await _firebaseAuth.currentUser();
		return await pendingRef.document(user.uid).collection("requestsPending").getDocuments();
		
	}
	
	
	
}

		
	