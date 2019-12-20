
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './../../../services/firestore_service.dart';
import './../../../src/data/models/user.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn;
  Status _status = Status.Uninitialized;
  bool loginSkipped = false;
  String error = '';

  UserRepository.instance()
      : _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn() {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
    _checkIsLoginSkipped();
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  void _checkIsLoginSkipped() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginSkipped = prefs.getBool('login_skipped') ?? false;
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      error = e.message;
      notifyListeners();
      return false;
    }
  }
  Future<bool> signUp(String fullName, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = fullName;
      await user.updateProfile(info);
      await AuthFirestoreService().saveUser(user);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      error = e.message;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      await AuthFirestoreService().saveUser(user);
      return true;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      error = e.message;
      notifyListeners();
      return false;
    }

  }

  Future signOut() async {
    _auth.signOut();
    _googleSignIn.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    _user = firebaseUser;
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}


// Firestore Auth Service
class AuthFirestoreService {
  static final AuthFirestoreService _practiceTestFirestoreService =
      AuthFirestoreService._internal();
  factory AuthFirestoreService() {
    return _practiceTestFirestoreService;
  }
  AuthFirestoreService._internal();

  Future<void> saveUser(FirebaseUser user) {
    return FirestoreService().updateDocument(
        'users',
        user.uid,
        {
          "name": user.displayName,
          "photo_url": user.photoUrl,
          "email": user.email,
        },
        merge: true);
  }

  Stream<User> getUser(String id) {
    return FirestoreService().getDocument('users', id).map(
          (doc) => User.fromMap(doc.data, doc.documentID),
        );
  }
}