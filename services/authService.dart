import 'package:flutter/material.dart';
import 'package:hubbub/repos/authRepo.dart';
import 'package:hubbub/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';

abstract class authService {
	Future<String> getCurrentUser();
	Future<String> signInWithEmailAndPassword(String email, String password);
	Future<String> signInWithGoogle();
	Future<String> signUp(String email, String password);
	Future<String> isSignedIn();
	Future<void> signOut();
	
}


class IAuthService implements authService {
	IAuthRepo _authRepo;
	
	IAuthService({AuthRepo authRepo}) : assert(authRepo!=null), _authRepo = authRepo;
	CollectionReference usersRef = Firestore.instance.collection("users");
	
	@override
	Future<String> getCurrentUser() async {
		

		final userId = await _authRepo.getCurrentUserId();
		
		return 'placeholder';
			
		
	}
	
	@override
	Future<String> signInWithEmailAndPassword(String email, String password) async {
		_authRepo.signInWithEmailAndPassword(email, password);
		return getCurrentUser();
	}
	
	@override
	Future<String> signInWithGoogle() async {
		return await _authRepo.signInWithGoogle();
	}
		
	
	
	@override
	Future<String> signUp(String email, String password) async {
		await _authRepo.signUp(email, password);
		return getCurrentUser();
		
	}
	
	@override
	Future<void> signOut() async {
		_authRepo.signOut();
	}
	
	@override
	Future<String> isSignedIn() async {
		var result = await _authRepo.isSignedIn();
		if (result!=null) {
			return getCurrentUser();
			}
	}
	
}
	