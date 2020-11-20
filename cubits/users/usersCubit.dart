import 'dart:async';
import 'package:cubit/cubit.dart';
import 'package:hubbub/models/user.dart';
import 'package:hubbub/enums/users_relation.dart';
import 'usersState.dart';
import 'package:hubbub/services/usersService.dart';



class UsersCubit extends Cubit<UsersState> {
	final FirebaseUsersService _usersService;
	UsersCubit({FirebaseUsersService usersService}) : assert(usersService!=null),
													_usersService = usersService,
													super(InitialState());


	_requestFriend(String uid) async {
		startLoading();
		_usersService.handleRequest(uid);
		_loadUserFromId(uid);
		
	}
	
	_undoRequest(String uid) async {
		startLoading();
		_usersService.handleUndo(uid);
		_loadUserFromId(uid);
	}
	
	_approveRequest(String uid) async {
		startLoading();
		_usersService.handleApprove(uid);
		_loadUserFromId(uid);
		
	}
	
	_denyRequest(String uid) async {
		startLoading();
		_usersService.handleDeny(uid);
		_loadUserFromId(uid);
	
	}
	
	_removeFriend(String uid) async {
		startLoading();
		_usersService.handleUndo(uid);
		_loadUserFromId(uid);
	
	}
	
	_laodCurrentUser() async {
		startLoading();
		final user = await _usersService.currentUser();
		emit(LoadedUserState(user, UserRelation.SELF));
	}
	
	_loadUserFromId(String uid) async {
		startLoading();
		final user = await _usersService.getUser(uid);
		UserRelation relation = await _usersService.findRelation(user.uid, uid);
		emit(LoadedUserState(user, relation));
	}
	
	void startLoading() {
		emit(LoadingState());
	}
	
	
}