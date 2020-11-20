import 'dart:async';
import 'package:cubit/cubit.dart';
import 'settingsState.dart';


class SettingsCubit extends Cubit<SettingsState> {
	bool isOpen = false;

	SettingsCubit() : 
													super(SettingsInitialState());

	toggleSettings() {
		print('TOGGLING');
		if (isOpen) {
			print('IS OPEN...CLOSING');
			isOpen = false;
			closeSettings();
			} else {
				print('IS CLOSED...OPENING');
				isOpen = true;
				openSettings();
				}
			}

			
	void startLoading() {
		emit(SettingsLoadingState());
	}
	
	loadSettingsData() {
		
		emit(LoadedSettingsData('data'));
	}
	
	settingsInitial() {
		emit(SettingsInitialState());
	}
	
	void closeSettings() {
		settingsInitial();
	}
	
	openSettings() {
		emit(SettingsOpened());
	}
	
	nameChange(String name) {
		
		loadSettingsData();
	}
	

}
		
		
		
	
	