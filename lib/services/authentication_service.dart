import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges=> _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> signIn({ String? email, String? password}) async {
    try{
      final User? user = (await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!)).user;
      if(user!.uid.isEmpty){
        return false;
      }
    } on FirebaseAuthException catch (e){
        return true; //returns to loginFail
    }
    return false;
  }
}