import 'package:equatable/equatable.dart';


abstract class SettingsState extends Equatable {}

class SettingsInitialState extends SettingsState {
	@override
	List<Object> get props => [];
}


class SettingsOpened extends SettingsState {
	@override
	List<Object> get props => [];
}


class SettingsLoadingState extends SettingsState {
	@override
	List<Object> get props => [];
}

class LoadedSettingsData extends SettingsState {
	final String data;
	LoadedSettingsData(this.data);
	@override
	List<Object> get props => [data];
}

class SettingsErrorState extends SettingsState {
	final String message;
	SettingsErrorState(this.message);
	@override
	List<Object> get props => [];
}
