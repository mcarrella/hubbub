import 'dart:async';
import 'dart:math' show max;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:hubbub/widgets/widgets.dart';
import 'package:hubbub/modals/search_modal.dart';
import 'package:hubbub/modals/favorites_modal.dart';
import 'package:hubbub/models/place.dart';



const animationDuration = Duration(milliseconds: 260);

class PlacesPage extends StatefulWidget {
	const PlacesPage();
	@override
	State<StatefulWidget> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> 
						with SingleTickerProviderStateMixin {
		
		
		static const double _endReachedThreshold = 200;
		final ScrollController _scrollController = ScrollController();
		Animation<double> _fabAnimation;
		AnimationController _fabController;
		bool _isFabMenuVisible = false;
	
		
		@override
		void initState() {
				_fabController = AnimationController(
						vsync: this,
						duration: animationDuration,
						);
				_fabAnimation = _fabController.curvedTweenAnimation(
										begin: 0.0,
										end: 1.0,
										);
										
			
				super.initState();
		}
		
		@override
		void dispose() {
			_fabController?.dispose();
			_scrollController?.dispose();
			super.dispose();
		}
	
		void _toggleFabMenu() {
			_isFabMenuVisible = !_isFabMenuVisible;
			if (_isFabMenuVisible) {
				_fabController.forward();
			} else {
				_fabController.reverse();
			}
		}
		
		void _showSearchModal() {
			showModalBottomSheet(
					context: context,
					backgroundColor: Colors.transparent,
					builder: (context) => SearchBottomModal(),
					);
		}
		
		void _showFavoritesModal() {
			List<Place> places = [Place(name: 'hendricks park'), Place(name: 'eugene airport')];
			showModalBottomSheet(
					context: context,
					backgroundColor: Colors.transparent,
					builder: (context) => FavoritesModal(places),
					);
		}
		
		Widget _buildTitle() {
			return Padding(
				padding: EdgeInsets.only(
					top: 18,
					left: 26,
					right: 26,
					bottom: 4,
					),
				child: Text(
					'PLACES',
					style: TextStyle(
								fontSize: 30,
								fontWeight: FontWeight.bold,
								),
							),
						);
				}
				
		Widget _buildGrid() {
			GridView.count(
									crossAxisCount: 2,
									children: List.generate(50, (index) {
																			return Container(
																								child: Card(
																												color: Colors.blue,
																												),
																										);
																							}
																					)
																			);
															}
		_buildLogo(BuildContext context) => Container(
        alignment: Alignment.center,
        child: Column(children: [
          
          SizedBox(height: 10.0),
          RichText(
            text: TextSpan(
                text: 'Explore ',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: 'Places',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  )
                ]),
          )
        ]),
      );								
	
		
		Widget placeListView() => Column(
										mainAxisSize: MainAxisSize.max,
										crossAxisAlignment: CrossAxisAlignment.stretch,
										children:
										
										
										
										
										
										
										<Widget>[
												_buildLogo(context),
												
												],
										);
										
										
		Widget placeDetailView(Place place) => Column(
											mainAxisSize: MainAxisSize.max,
											crossAxisAlignment: CrossAxisAlignment.stretch,
											children: <Widget>[
																	Container(
																					child: Center(child: Text('this is the place named ' + place.name),
																					),
																				),
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
		Widget build(BuildContext context) {
			
			return Scaffold(
						body: CubitConsumer<PlacesCubit, PlacesState>(
														builder: (context, state) {
														if (state is PlaceLoaded) {
																return placeDetailView();
																}
															else { return placeListView(state.place); }
															
															},
																
														listener: (context, state) {
															
																	
																	if (state is AuthLoadingState) {
																				print('BUILDING LOADING UI');
																		_showLoader();
																		}
																	
																	
																			
																	}
																})
						floatingActionButton: FabMenu(
									animation: _fabController,
									toggle: _toggleFabMenu,
									onAllGenPress: _showFavoritesModal,
									onSearchPress: _showSearchModal,
									),
							);
					}
}
		