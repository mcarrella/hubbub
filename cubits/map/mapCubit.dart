import 'dart:async';
import 'package:cubit/cubit.dart';
import 'package:hubbub/services/services.dart';
import 'mapState.dart';

class MapCubit extends Cubit<MapState> {
	final FirebaseLocationsService _locationsService;
	final FirebaseUsersService _usersService;
	
	

	MapCubit({FirebaseLocationsService locationsService,
				FirebaseUsersService usersService}) : assert(locationsService!=null),
													  assert(usersService!=null),
													_locationsService = locationsService,
													_usersService = usersService,
													super(MapInitialState());
	
	
	
	
	
	
	
			
	_loadInitial() {
		updateMarkers();
	}
	
	
	updateMarkers() {

		emit(PageReady(false));
	
	}
}