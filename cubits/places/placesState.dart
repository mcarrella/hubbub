import 'package:equatable/equatable.dart';
import 'package:hubbub/models/place.dart';


abstract class PlacesState extends Equatable {}

class NoneSelected extends PlacesState {
	@override
	List<Object> get props => [];
}


class PlaceLoaded extends PlacesState {
	final Place place;
	PlaceLoaded(this.place);
	@override
	List<Object> get props => [place];
}


class PlaceLoadingState extends PlacesState {
	@override
	List<Object> get props => [];
}

