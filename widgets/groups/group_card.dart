import 'package:flutter/material.dart';
import 'package:hubbub/models/group.dart';


class GroupCard extends StatelessWidget {
	final List<Group> groups;
	final int index;
	const GroupCard(this.groups, this.index);

	@override
	Widget build(BuildContext context) {
		
			return Container(
							child: Center(
										child: Text(groups[index].groupName),
									),
														
							);
							
		
				}
			
	}
