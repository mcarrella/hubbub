import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class locationsRepo {
	
	String justPlacehold();
	}
	
class FirebaseLocationsRepo implements locationsRepo {
	final FirebaseAuth _auth;
	
	
	FirebaseLocationsRepo({FirebaseAuth auth}) : _auth = auth ?? FirebaseAuth.instance;
	
	CollectionReference _locationsRef = Firestore.instance.collection("locations");
	Geoflutterfire geo = Geoflutterfire();
	Location location = new Location();

	
	@override
	String justPlacehold() {
		return 'placehold';
		}
}
			
	
			
