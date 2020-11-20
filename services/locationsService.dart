import 'package:flutter/material.dart';
import 'package:hubbub/repos/locationsRepo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


abstract class locationsService {
	
	String justPlacehold();
}
	
class FirebaseLocationsService implements locationsService {
	
	
	FirebaseLocationsRepo _locationsRepo;
	FirebaseLocationsService({FirebaseLocationsRepo locationsRepo}) : assert(locationsRepo!=null), _locationsRepo = locationsRepo;

	
	@override
	String justPlacehold() {
		return 'placehold';
	}
		}
		
		

	