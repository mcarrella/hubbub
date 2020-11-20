import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';


class User {
	final String uid;
	final String displayName;
	final String email;
	final String password;
	final String imageUrl;

	

	User({this.uid, this.displayName, this.email, this.password, this.imageUrl});
	
	factory User.fromDocument(DocumentSnapshot document) {
									return User(
											uid: document['uid'],
											displayName: document['displayName'],
											email: document['email'],
											password: document['password'],
											imageUrl: document['imateUrl'],
											);
									}

									
									
	Map<String, dynamic> toJson() {
									return {
													'uid': uid,
													'displayName': displayName,
													'email': email,
													'password': password,
													'imageUrl': imageUrl,
												};
									}
						}
									
							