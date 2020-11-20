import 'dart:async';
import 'package:cubit/cubit.dart';
import 'groupsState.dart';
import 'package:hubbub/models/group.dart';
import 'package:hubbub/services/groupsService.dart';

class GroupsCubit extends Cubit<GroupsState> {
	final FirebaseGroupsService _groupsService;
	GroupsCubit({FirebaseGroupsService groupsService}) : assert(groupsService!=null),
															_groupsService = groupsService,
															super(GroupsInitial());
	
	
	startLoading() {
		emit(GroupsLoadingState());
	}

	groupsQuery();
	
	loadUserGroupsList() async {
		startLoading();
		List<Group> groups = _groupsServices.fetchUserGroups();
		emit(GroupsLoaded(groups));
	}
	
	
	
	loadGroupDetail(String groupId) async {
				startLoading();
				final group = _groupsService.getGroup(groupId);
				final isMember =  await _groupsService.checkUserStatus(groupId);
				
				if (!isMemebr) {
									
									emit(PublicAccessState(group));
						} else {
									
								List<Place> places = _groupsService.getGroupPlaces(groupId);
								emit(MemberOnlyState(group, places));
						}
	}
						
				


	createGroup(String name) async {
			startLoading();
			final groupId = await _groupsService.processCreateGroup(String name);
			loadGroupDetail(groupId);
		}


	sendInvite(String userId, String groupId) async {
			startLoading();
			final group = await _groupsService.handleInvite(String userId, String groupId);
			loadGroupDetail(group);
		}

	userRequest(String userId, String groupId) async {
			startLoading();
			final group = await _groupsService.handleRequest(String userId, String groupid);
			loadGroupDetail(group);
	}
	userConfirmed(String userId, String groupId) async {
			startLoading();
			final group = await _groupsService.handleConfirm(userId, groupdId);
			loadGroupDetail(groupId);
	}

	userRemove(String userId, String groupId) async {
			startLoading();

			await _groupsService.handleRemove(userId, groupId);
			loadUserGroupsList();	
		}

}




		
		