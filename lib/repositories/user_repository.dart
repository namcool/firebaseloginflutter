import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  //contructor
  UserRepository({auth.FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn}) :
      _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn();
  Future<void> signInWithEmailAndPassword (String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim()
    );
  }
  Future<auth.User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final auth.AuthCredential authCredential = auth.GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
    );
    await _firebaseAuth.signInWithCredential(authCredential);
  }
  Future<void> createUserWithEmailAndPassword (String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim()
    );
  }
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut()
    ]);
  }
  Future<bool> isSignIn() async {
    return await auth.FirebaseAuth.instance.currentUser != null;
  }
  Future<auth.User> getUser() async {
    return await auth.FirebaseAuth.instance.currentUser;
  }
}