import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:hubbub/cubits/map/map.dart';


class MapPage extends StatefulWidget {

	@override
	State createState() => MapPageState();
}

class MapPageState extends State<MapPage> {

	CollectionReference _locationsRef = Firestore.instance.collection("locations");


	Location location = new Location();
	
	GoogleMapController mapController;
	Geoflutterfire geo = Geoflutterfire();
	
	

	
	_animateToUser() async {
		var pos = await location.getLocation();
		mapController.animateCamera(CameraUpdate.newCameraPosition(
					CameraPosition(
						target: LatLng(pos.latitude, pos.longitude),
						zoom: 17.0,
						)
					)
				);
		}
		
	
				
				
	
	
																																	
																																	
																																	
																
	Widget build(BuildContext context) {
		return buildUi();
								
			}
			
		buildUi() =>  Stack(
			children: [
				GoogleMap(
					initialCameraPosition: CameraPosition(target: LatLng(24.150, -110.32), zoom: 10),
					onMapCreated: _onMapCreated,
					myLocationEnabled: true,
					mapType:  MapType.hybrid,
					
					
					),
			],
				
		);
		
		
		
	void _onMapCreated(GoogleMapController controller) {
		setState(() {
			mapController = controller;
			});
		}
	
}
		
	