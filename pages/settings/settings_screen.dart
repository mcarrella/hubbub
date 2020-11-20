import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:hubbub/cubits/settings/settings.dart';

class SettingsScreen extends StatefulWidget {
	@override
	
	_SettingsScreenState createState() => _SettingsScreenState();
}


class _SettingsScreenState extends State<SettingsScreen> {
	bool amVisible;
	bool notificationsEnabled;
	
	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: AppBar(title: Text('Settings UI'), actions: <Widget>[
			
																		IconButton(
																						icon: Icon(
																										Icons.settings,
																										color: Colors.white,
																										),
																						onPressed: () {
																									CubitProvider.of<SettingsCubit>(context).toggleSettings();
																									},
																								),
																							],
																						),
			body: CubitConsumer<SettingsCubit, SettingsState>(builder: (_, state) {
				return _buildUi();
			}, listener: (context, state) {
				if (state is SettingsLoadingState) {
					showLoader();
					} if (state is SettingsErrorState) {
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
											hideLoader();
										}
								}),
				);
		}
		
		hideLoader() {
			Navigator.of(context, rootNavigator: true).pop();
		}
	
		showLoader() {
		var alert = AlertDialog(
			backgroundColor: Colors.transparent,
			elevation: 0,
			content: Center(
					child: CircularProgressIndicator(
						backgroundColor: Colors.white70,
						),
					),
				);
		}
		
		
		_buildUi() =>
					
				SettingsList(
					sections: [
						SettingsSection(
										title: 'Common',
										tiles: [
													SettingsTile(
															title: 'Language',
															subtitle: 'English',
															leading: Icon(Icons.language),
															onTap: () {},
														),
													SettingsTile(
															title: 'Environment',
															subtitle: 'Production',
															leading: Icon(Icons.cloud_queue),
															onTap: () => print('e'),
														),
												],
										),
					SettingsSection(
						
								title: 'Account',
								tiles: [
											SettingsTile(title: 'Phone number', leading: Icon(Icons.phone)),
											SettingsTile(title: 'Email', leading: Icon(Icons.email)),
											SettingsTile(title: 'Sign out', leading: Icon(Icons.exit_to_app)),
										],
									),
						],
				
					
			
		);
	}

									
							

									