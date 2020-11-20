import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hubbub/models/user.dart';


class DummyMembersData {
	static List<User> membersA = [
			User(
							uid: '2jk2l34234', 
							displayName: 'tommy', 
							imageUrl: 'assets/image1.jpeg'
							),
			User(
							uid: '23423ssdfs', 
							displayName: 'carol', 
							imageUrl: 'assets/image2.jpeg'
							),
			User(
					uid: '009kss343w', 
					displayName: 'erin', 
					imageUrl: 'assets/image3.jpeg'
					),
			];
			
	static List<User> membersB = [
				User(
						uid: 'sdfds343sfds', 
						displayName: 'george', 
						imageUrl: 'assets/image4.jpeg'
						),
				User(
					uid: '2jk2l34234', 
					displayName: 'tommy', 
					imageUrl:  'assets/image1.jpeg'
					),
				User(
					uid: '23423ssdfs', 
					displayName: 'carol', 
					imageUrl: 'assets/image2.jpeg'
					),
			];
				
			
		}

class DummyGroupData {
	static List<Group> groups = [
		
		Group(
					groupName: 'nature lovers',
					groupId: 'naturelovers342342',
					members: DummyMembersData.membersA,
					imageUrl: 'assets/image4.jpeg',
					),
		Group(
					groupName: 'neighborhood watch',
					groupId: 'neighborhoodwatch23432',
					members: DummyMembersData.membersB,
					imageUrl: 'assets/destination_map_marker.png',
					),
					
		Group(
					groupName: 'neighborhood watch',
					groupId: 'neighborhoodwatch23432',
					members: DummyMembersData.membersB,
					imageUrl: 'assets/image1.jpeg',
					),
					
		Group(
					groupName: 'neighborhood watch',
					groupId: 'neighborhoodwatch23432',
					members: DummyMembersData.membersB,
					imageUrl: 'assets/destination_map_marker.png',
					),
		Group(
					groupName: 'neighborhood watch',
					groupId: 'neighborhoodwatch23432',
					members: DummyMembersData.membersB,
					imageUrl: 'assets/image3.jpeg',
					),
				];
	}

class Group {
	final String groupName;
	final String groupId;
	final List<User> members;
	final String imageUrl;
	
	
	
	Group({this.groupName, this.groupId, this.members, this.imageUrl});
	
	factory Group.fromDocument(DocumentSnapshot document) {
		return Group(
						groupName: document['groupName'],
						groupId: document['groupId'],
						members: document['members'],
						imageUrl: document['imageUrl'],
						);
		}
		
	Map<String, dynamic> toJson() {
		return {
					'groupName': groupName,
					'groupId': groupId,
					'members': members,
					'imageUrl': imageUrl,
					};
			}

	


						}
									
							