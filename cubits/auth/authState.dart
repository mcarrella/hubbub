import 'package:equatable/equatable.dart';
import 'package:hubbub/models/user.dart';

abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
	@override
	List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
	@override
	List<Object> get props => [];
}

class AuthSuccessState extends AuthState {
	String uid;
	AuthSuccessState(this.uid);
	@override
	List<Object> get props => [uid];
}

class AuthErrorState extends AuthState {
	final String message;
	AuthErrorState(this.message);
	@override
	List<Object> get props => [];
}

class SignOutSuccessState extends AuthState {
	@override
	List<Object> get props => [];
}