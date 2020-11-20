import 'package:flutter/material.dart';
import 'package:hubbub/models/group.dart';
import 'package:hubbub/widgets/widgets.dart';
import 'modal.dart';

class GroupModal extends StatelessWidget {
	List<Group> groups;
	GroupModal(this.groups);
	Widget _buildGroupCard(List<Group> groups, int index) {
		print('GROUPS HERE' + groups.length.toString());
		return GroupCard(groups, index);
	}
	
	
Widget _buildGroups(ScrollController scrollController) {
	print('NUMBER OF GROUPS RECEIVED: ' + groups.length.toString());
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
						itemCount: groups.length,
						itemBuilder: (_, index) => _buildGroupCard(groups, index),
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
					child: _buildGroups(scrollController),
					);
				}
			);
		}
}
				
				