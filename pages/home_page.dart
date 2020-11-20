import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:hubbub/models/user.dart';
import 'package:hubbub/cubits/cubits.dart';
import 'package:hubbub/repos/repos.dart';
import 'package:hubbub/services/services.dart';

import 'package:hubbub/pages/pages.dart';

class HomePage extends StatefulWidget {

	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
	final _scaffoldKey = GlobalKey<ScaffoldState>();
	String lead;
	String end;
	
	PageController _pageController;
	int pageIndex = 0;
	List<User> friends = [];

	
	onTap(int pageIndex) {
		_pageController.animateToPage(
			pageIndex,
			duration: Duration(milliseconds: 200),
			curve: Curves.bounceInOut,
			);
	}
	
	
	onPageChanged(int pageIndex) {
		setState(() {
			this.pageIndex = pageIndex;
			
			});
	}
	

	
	@override
	void initState() {
		super.initState();
		_pageController = PageController();
		int pageIndex = 0;
		final scaffoldKey = GlobalKey<ScaffoldState>();
		lead = "Group";
		end = "Connection";
	
		

	}
	

	buildPlacesPage() {
		lead = "Explore";
		end = "Places";

		return CubitProvider<PlacesCubit>(
					create: (BuildContext context) => PlacesCubit(),
					child: PlacesPage(),
					);
	}


	buildMapPage() {
			lead = "Geo";
			end = " Real time";
			return CubitProvider<MapCubit>(
							create: (BuildContext context) => MapCubit(),
							child: MapPage(),
						);
		}
	
	
	
	@override
	Widget build(BuildContext context) {
			
			print('USER HAS ' + friends.length.toString() + 'FRIENDS');
			String appbar_title = lead + end;
			return Scaffold(
					appBar: AppBar(title: Text(appbar_title), actions: <Widget>[
																		IconButton(
																						icon: Icon(
																										Icons.face,
																										color: Colors.white,
																										),
																						onPressed: () {
																									
																									},
																								),
																		IconButton(
																						icon: Icon(
																										Icons.settings,
																										color: Colors.white,
																										),
																						onPressed: () {
																									CubitProvider.of<SettingsCubit>(context).toggleSettings();
																									},
																								),
																								
																		IconButton(
																						icon: Icon(
																										Icons.exit_to_app,
																										color: Colors.white,
																										),
																						onPressed: () {
																									
																									},
																								),
																								
																							],
																			
																						),
																	
										
					key: _scaffoldKey,
				body: 
							PageView(
									children: <Widget>[
										GroupsPage(),
						
										buildPlacesPage(),
										buildMapPage(),
								
									],
								controller: _pageController,
								onPageChanged: onPageChanged,
								physics: NeverScrollableScrollPhysics(),
								),
							
						
						
					bottomNavigationBar: CupertinoTabBar(
				currentIndex: pageIndex,
				onTap: onTap,
				activeColor: Theme.of(context).primaryColor,
				items: [
						BottomNavigationBarItem(icon: Icon(Icons.mediation)),
						
						BottomNavigationBarItem(icon: Icon(Icons.explore)),
						
						BottomNavigationBarItem(icon: Icon(Icons.public)),
        
						],
					),
				);
			
			}
		
}

