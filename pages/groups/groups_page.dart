import 'package:flutter/material.dart';
import 'package:hubbub/models/group.dart';
import 'package:hubbub/models/user.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:hubbub/cubits/cubits.dart';

class HeaderSection extends StatelessWidget {
	Group group;
	
	HeaderSection({
						this.group,
						Key key,
						}) : super(key: ValueKey<String>(group.imageUrl));
						
	
	@override
	Widget build(BuildContext context) {
		return Container(
								child: Column(
													children: <Widget>[
																		Container(
																						height: 110,
																						width: 100,
																						decoration: BoxDecoration(
																													borderRadius: BorderRadius.circular(100),
																													image: DecorationImage(image: AssetImage(group.imageUrl), fit: BoxFit.cover),
																													),
																										),
																		SizedBox(height: 20),
																		Container(
																					alignment: Alignment.center,
																					child: Text(
																										group.groupName,
																										textAlign: TextAlign.center,
																										style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
																										),
																							),
																		SizedBox(height: 20),
																		Container(
																					margin: EdgeInsets.symmetric(horizontal: 20),
																					alignment: Alignment.center,
																					child: Text(
																								'what we do',
																								textAlign: TextAlign.center,
																								),
																						),
																		SizedBox(height: 20),
																		Container(
																			margin: EdgeInsets.symmetric(horizontal: 16),
																			child: Row(
																							mainAxisAlignment: MainAxisAlignment.spaceBetween,
																							children: <Widget>[
																											Column(
																														children: <Widget>[
																																
																																Text('subscribe/suspend')
																																],
																														),
																														
																											Column(
																														children: <Widget>[
																																
																																Text('georeports')
																																],
																														),
																											Column(
																														children: <Widget>[
																																
																																Text('discussion')
																																],
																														),
																											],
																										),
																								)
																						],
																					),
																				);
																	}
}


class GroupsPage extends StatefulWidget {
	GroupsPage({Key key}) : super(key: key);
	
	@override
	_GroupsPageState createState() => _GroupsPageState();
}


class _GroupsPageState extends State<GroupsPage> {
	Group group;


	_usersGroupsUi() =>  ListView(
				children: <Widget>[
										SizedBox(height: 20),
										(group==null) ? _buildLogo(context) : 
										AnimatedSwitcher(
															duration: Duration(milliseconds: 750),
															transitionBuilder: (Widget child, Animation<double> animation) => SlideTransition(
																											child: child,
																											position: Tween<Offset>(begin: Offset(0.0, 1.0),
																																	end: Offset(0.0, 0.0)).animate(animation),
																																	),
															child: HeaderSection(
																		group: group,
																		),
																	),
										SizedBox(height: 40),
										Container(
														child: Wrap(
																		children: <Widget>[
																							for (int i=0; i<DummyGroupData.groups.length; i ++)
																									GestureDetector(
																														onTap: () {
																																		group = DummyGroupData.groups[i];
																																	
																																		setState(() {});
																																	},
																														child: Container(
																																			height: MediaQuery.of(context).size.width / 3,
																																			width: MediaQuery.of(context).size.width / 3,
																																			decoration: BoxDecoration(image: DecorationImage(image: AssetImage(DummyGroupData.groups[i].imageUrl), fit: BoxFit.cover)),
																																			),
																																	)
																															],
																													),
																										)
																							],
															);
																			
	_showLoader() {
		return AlertDialog(
			backgroundColor: Colors.transparent,
			elevation: 0,
			content: Center(
					child: CircularProgressIndicator(
						backgroundColor: Colors.white70,
						),
					),
				);
		}


	
	@override
	void initState() {
		
		super.initState();
	}
	
	
	_buildLogo(BuildContext context) => Container(
        alignment: Alignment.center,
        child: Column(children: [
          
          SizedBox(height: 10.0),
		  Row(children: <Widget>[

							 
							 RichText(
											text: TextSpan(
														text: 'Group  ',
														style: Theme.of(context).textTheme.caption.copyWith(
														color: Colors.black,
														fontSize: 32.0,
														fontWeight: FontWeight.bold,
												),
													children: [
																		TextSpan(
																						text: 'Connections',
																						style: TextStyle(
																						color: Theme.of(context).accentColor,
																					),
																				)
															]),
												),
									]),
                ]),
  
      );
	@override
	Widet build(BuildContext context) {
			return

									SafeArea(
											child:  CubitConsumer<GroupsCubit, GroupsState>(
														builder: (context, state) {
																if (state is GroupsInitialState) {
																		return GroupPageInitial();
																		}
																if (state is MemberOnlyState) {
																		return GroupMap(state.group, state.places);
																					} else if (state is PublicAccessState) {
																									return GroupInfoWidget();
																					} else if (state is GroupsLoaded) {
																									return usersGroupsUi();
																							}
																}
	
																
														listener: (context, state) {
															
																	
																	if (state is GroupsLoading) {
																		_showLoader();
																		}
																	if  (state is ErrorState) {
											
																				
																				Scaffold.of(context).showSnackBar(
																										SnackBar(
																												content: Text(
																																state.message,
																																style: Theme.of(context)
																																					.textTheme
																																					.caption
																																					.copyWith(color: Colors.white, fontSize: 16.0),
																															),
																												),
																									);
																			
																						}
																}),

													
															
														
										
								
									
					
												);
							}
}