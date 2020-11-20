import 'package:equatable/equatable.dart';
import 'package:hubbub/models/group.dart';
import 'package:hubbub/models/place.dart';

abstract class GroupsState extends Equatable {}

class GroupsInitialState extends GroupsState {
	@override
	List<Object> get props => [];
}

class MemberOnlyState extends GroupsState {
	Group group;
	List<Place> places;
	MemberOnlyState(this.group, this.places);
	@override
	List<Object> get props => [group, places];
}

class PublicAccessState extends GroupsState {
	Group group;
	PublicAccessState(this.group);
	@override
	List<Object> get props => [group];
}

class GroupsLoaded extends GroupsState {
	List<Group> groups;
	GroupsLoaded(this.groups);
	@override
	List<Object> get props => [groups];
	
}

class GroupsLoading extends GroupsState {
	@override
	List<Object> get props => [];
}

class GroupsError extends GroupsState {
	String message;
	GroupsError(this.message);
	@override
	List<Object> get props => [message];
}