import 'package:equatable/equatable.dart';

abstract class MapState extends Equatable {}

class MapInitialState extends MapState {
	@override
	List<Object> get props => [];
}

class MapLoadingState extends MapState {
	@override
	List<Object> get props => [];
}

class PageReady extends MapState {
	bool trackUser;
	PageReady(this.trackUser);
	@override
	List<Object> get props => [];
}

class DocsReady extends MapState {

	@override
	List<Object> get props => [];
}
class DataReady extends MapState {

	@override
	List<Object> get props => [];
}