import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geopoint/geopoint.dart';

class LocationWidget extends StatefulWidget {
	String id;
	GeoPoint point;
	String tag;
	LocationWidget(this.id, this.point, this.tag);
	@override
	
	_LocationWidgetState createState() => _LocationWidgetState();
}


class _LocationWidgetState extends State<LocationWidget> {
	BitmapDescriptor pinLocationIcon;
	
	void initState() {
		super.initState();
		setCustomPin();
	}
	
	void setCustomPin() async {
		pinLocationIcon = await BitmapDescriptor.fromAssetImage(
																	ImageConfiguration(devicePixelRatio: 2.5),
																	'assets/destination_map_marker.png');
																	
					}
					
	@override
	Widget build(BuildContext context) {
		return Marker(
							markerId: widget.id,
							position: LatLng(widget.point.latitude,
												widget.point.longitude),
							icon: BitmapDescriptor.defaultMarkerWithHut(BitmapDescriptor.hueViolet),
							infoWindow: InfoWindow(
													title: document.data['tag']
													),
									);
						}
}