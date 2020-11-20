import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hubbub/models/token.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class AuthRepo {
	Future<Result<String>> signInWithCredential(AuthCredential credential);
	void signOut();
	Future<String> getCurrentUserId();

	
	
}
	
	
class IAuthRepo implements AuthRepo {
	final FirebaseAuth _firebaseAuth;
	final GoogleSignIn _googleSignIn;
	String name;
	GoogleSignInAccount _currentUser;
	
	IAuthRepo({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
			: _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
			_googleSignIn = googleSignIn ?? GoogleSignIn.standard();
			
			
	Future<String> signInWithGoogle() async {
		final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
		final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
		
		final AuthCredential credential = GoogleAuthProvider.getCredential(
			accessToken: googleSignInAuthentication.accessToken,
			idToken: googleSignInAuthentication.idToken,
			);
		
		final AuthResult result = await _firebaseAuth.signInWithCredential(credential);
		
		
		if (result!=null) {
			
			
			return result.user.uid;
			}
			return null;
		}
	
			
				
			
	@override
	Future<Result<String>> signInWithCredential(AuthCredential credential) async {
		
		final userCredential = await _firebaseAuth.signInWithCredential(credential);
		return (userCredential!=null) 
		? Result.value(userCredential.user.uid)
		: Result.error('there was an error');
		
	}
	
	

	  @override
	Future<String> getCurrentUserId() async {
				return (await _firebaseAuth.currentUser()).uid;
	}
		
	
		

	Future<String> isSignedIn() async {
			var user = await _firebaseAuth.currentUser();
			if (user!=null) {
				return user.uid;
				}
				
  }
	
	@override
	Future<void> signOut() async {
				return Future.wait([
										_firebaseAuth.signOut(),
										_googleSignIn.signOut(),
									]);
	}
	
	
			
  
			
	
		
	
	
	 Future<String> signInWithEmailAndPassword(String email, String password) async {
				await _firebaseAuth.signInWithEmailAndPassword(
															email: email,
															password: password,
						);
				isSignedIn();
  }

	Future<void> signUp(String email, String password) async {
				await _firebaseAuth.createUserWithEmailAndPassword(
							email: email,
							password: password,
				);
   }
  
  

  
  
}
	
	