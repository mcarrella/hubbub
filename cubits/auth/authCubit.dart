import 'dart:async';
import 'package:cubit/cubit.dart';
import 'package:hubbub/models/user.dart';
import 'authState.dart';
import 'package:hubbub/services/services.dart';

class AuthCubit extends Cubit<AuthState> {
	IAuthService _authService;
	AuthCubit({IAuthService authService}) : assert(authService!=null),
													_authService = authService,
													super(AuthInitialState());
	
	signInWithEmailAndPassword(String email, String password) async {
		startLoading();
		final result = await _authService.signInWithEmailAndPassword(email, password);
		setResultOfAuthState(result);
	}
	
	
	signInWithGoogle() async {
		startLoading();
		var result = await _authService.signInWithGoogle();
		if (result!=null) {
			print('RESULT OBTAINED');
			setResultOfAuthState(result);
			} else { 
				print('RESULT NULL');
				emit(AuthErrorState("error"));
				}
				
		}
	
		
		
		
	
	void signUp(String email, String password) async {
		startLoading();
		_authService.signUp(email, password);
		await _authService.signUp(email, password);
		final user = await signInWithEmailAndPassword(email, password);
		emit(AuthSuccessState(user));
	
	}
		
	setResultOfAuthState(String uid) {
		startLoading();
		emit(AuthSuccessState(uid));
	}
	
	void startLoading() {
		print('STARTED LOADING');
		emit(AuthLoadingState());
	}
	
	signout() async {
		startLoading();
		
		_authService.signOut();
	
			emit(SignOutSuccessState());
	}
	
}