import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'package:hubbub/repos/repos.dart';
import 'package:hubbub/services/services.dart';
import 'package:hubbub/cubits/cubits.dart';


import 'root_page.dart';

	IAuthRepo authRepo = IAuthRepo();
FirebaseUsersRepo usersRepo = FirebaseUsersRepo();
FirebaseLocationsRepo locationsRepo = FirebaseLocationsRepo();
final authService = IAuthService(authRepo: authRepo);
final usersService = FirebaseUsersService(usersRepo: usersRepo);
final locationsService = FirebaseLocationsService(locationsRepo: locationsRepo);


class SuccessPage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
						body: Center(child: Text('user'),
						),
		);
		}
}

class MyAppSettings {
	MyAppSettings(StreamingSharedPreferences preferences) : hbusername = preferences.getString('hbusername', defaultValue: '');
	final Preference<String> hbusername;
}

void main() {
	

	runApp(MultiCubitProvider(
					providers: [
					
						CubitProvider<SettingsCubit>(
								create: (BuildContext context) => SettingsCubit(),
									),
						CubitProvider<AuthCubit>(
								create: (BuildContext context) => AuthCubit(authService: authService),
									),	
						
							
							
							
						
						
						
				
						],
					child: MyApp(),
				));


				
}

class MyApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: RootPage(),
			);
		}
}








		

					
					
					


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
	
	
	
	
		
	
	
	
	