import 'dart:async';
import 'package:cubit/cubit.dart';
import 'package:hubbub/models/place.dart';
import 'placesState.dart';

class PlacesCubit extends Cubit<PlacesState> {
	PlacesCubit() : super(NoneSelected());



	
	_selectPlace(Place place) async {
		_startLoading();
		
		emit(PlaceLoaded(place));
	}
	
	_startLoading() {
		emit(PlaceLoadingState());
	}
	
}
		