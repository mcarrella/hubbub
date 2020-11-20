import 'package:flutter/material.dart';
import 'package:hubbub/models/place.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter/gestures.dart';

class PlaceCard extends StatelessWidget {
	final List<Place> places;
	final int index;
	const PlaceCard(this.places, this.index);

	@override
	Widget build(BuildContext context) {
		
			return Container(
							child: GestureDetector(
										onTap: () {
											CubitProvider.of<PlacesCubit>(context)._selectPlace(places[index].name);
											}
										child: Center(
												Text(places[index].name),
												),
										),
										
									
														
							);
							
		
				}
			
	}
