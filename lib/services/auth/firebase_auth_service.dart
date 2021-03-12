import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth auth, GoogleSignIn googleSignIn})
      : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  //Google Sign-In
  Future<UserCredential> signInWithGoogle() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    return _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    return Future.wait([_googleSignIn.signOut(), _auth.signOut()]);
  }

  Future<User> registerWithEmailPassword(String email, String password) async {
    // Initialize Firebase
    await Firebase.initializeApp();

    return (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
  }

  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    // Initialize Firebase
    await Firebase.initializeApp();

    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  bool isSignedIn() {
    final currentUser = _auth?.currentUser;
    return currentUser != null;
  }

  User getUser() {
    return _auth?.currentUser;
  }
}
