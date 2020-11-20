import 'package:flutter/material.dart';
import 'package:hubbub/models/place.dart';
import 'package:hubbub/widgets/widgets.dart';
import 'modal.dart';

class FavoritesModal extends StatelessWidget {
	List<Place> places;
	FavoritesModal(this.places);
	Widget _buildPlaceCard(List<Place> places, int index) {
		print('GROUPS HERE' + places.length.toString());
		return PlaceCard(places, index);
	}
	
	
Widget _buildPlaces(ScrollController scrollController) {
	print('NUMBER OF Places RECEIVED: ' + places.length.toString());
	return Expanded(
			child: GridView.builder(
						padding: EdgeInsets.all(26),
						controller: scrollController,
						gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
							crossAxisCount: 2,
							childAspectRatio: 1.55,
							crossAxisSpacing: 10,
							mainAxisSpacing: 10,
							),
						itemCount: places.length,
						itemBuilder: (_, index) => _buildPlaceCard(places, index),
						),
					);
				}
				
	@override
	
	Widget build(BuildContext context) {
		return DraggableScrollableSheet(
			expand: true,
			initialChildSize: 0.7,
			minChildSize: 0.5,
			builder: (_, scrollController) {
				return Modal(
					title: 'Favorites',
					child: _buildPlaces(scrollController),
					);
				}
			);
		}
}
				
				