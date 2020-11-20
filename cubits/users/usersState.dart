import 'package:equatable/equatable.dart';
import 'package:hubbub/models/user.dart';
import 'package:hubbub/enums/users_relation.dart';

abstract class UsersState extends Equatable {}

class InitialState extends UsersState {
	@override
	List<Object> get props => [];
}

class LoadingState extends UsersState {
	@override
	List<Object> get props => [];
}


class LoadedUserState extends UsersState {
	final User user;
	final UserRelation relation;
	LoadedUserState(this.user, this.relation);
	@override
	List<Object> get props => [user, relation];
}