import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hubbub/models/user.dart';
import 'package:hubbub/repos/usersRepo.dart';
import 'package:hubbub/enums/users_relation.dart';


abstract class UsersService {
	Future<User> currentUser();
	Future<User> getUser(String uid);
	Future<UserRelation> findRelation(String uid1, String uid2);
	Future<bool> areFriends(String uid1, String uid2);
	Future<bool> requestPending(String uid1, String uid2);
	
	void handleRequest(String uid);
	void handleApprove(String uid);
	void handleDeny(String uid);
	void handleUndo(String uid);
	
	Future<List<User>> fetchFriends();
	Future<List<User>> fetchPending();
	
	
	
}

class FirebaseUsersService implements UsersService {
	FirebaseUsersRepo _usersRepo;
	FirebaseUsersService({FirebaseUsersRepo usersRepo}) : assert(usersRepo!=null),
															_usersRepo = usersRepo;
															
															
	CollectionReference usersRef = Firestore.instance.collection("users");
															
	
	@override
	Future<UserRelation> findRelation(String uid1, String uid2) async {
			return UserRelation.SELF;
			}
	
	@override
	void handleRequest(String uid)  {
		_usersRepo.handleRequest(uid);
	}
	
	@override
	void handleUndo(String uid)  async {
		await _usersRepo.handleUndo(uid);
	}
	
	@override
	void handleApprove(String uid)  {
		_usersRepo.handleApprove(uid);
	}
	
	@override
	void handleDeny(String uid)  {
		_usersRepo.handleDeny(uid);
	}
	
	@override
	void handleRemove(String uid) {
		_usersRepo.handleRemove(uid);
	}
	
	
	
	
	
	@override
	Future<bool> areFriends(uid1, uid2) {
		return  _usersRepo.checkFriends(uid1, uid2);
	}
	
	@override
	Future<bool> requestPending(uid1, uid2) async  {
		return await _usersRepo.checkPending(uid1, uid2);
	
				
	}
	
	@override
	Future<User> getUser(String uid) async {
		
		return User.fromDocument(await _usersRepo.getUser(uid));
		
	}
	
	@override
	Future<User> currentUser() async {
	
		return await _usersRepo.currentUser();
		}
	
	
	@override
	Future<List<User>> fetchFriends() async {
		final qsnap = await _usersRepo.fetchFriendsData();
		List<User> friends = [];
		qsnap.documents.forEach((doc) async {
			User user = await getUser(doc.documentID);
			friends.add(user);
			});
		
		return friends;
		
	}
		
	@override
	Future<List<User>> fetchPending() async {
		
		final qsnap = await _usersRepo.fetchPendingData();
		List<User> pending = [];
		qsnap.documents.forEach((doc) async {
			User user = await getUser(doc.documentID);
			pending.add(user);
			});
		
		return pending;
	}
		
		
	
		
													
}
											
											

						
						
													
			
				
		