import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './../src/data/models/user.dart';

class FirestoreService {
  static final FirestoreService _firestoreService  = FirestoreService._internal();
  Firestore _db = Firestore.instance;

  factory FirestoreService() {
    return _firestoreService;
  }

  FirestoreService._internal();

  Stream<QuerySnapshot> getDocumentSnapshots(String path) {
    return _db
      .collection(path)
      .snapshots();
  }

  Stream<DocumentSnapshot> getDocument(String path,String id) {
    return _db
      .collection(path)
      .document(id)
      .snapshots();
  }

  Future<void> updateDocument(String path, String id, Map<String,dynamic> data,{bool merge = true}) {
    return _db
      .collection(path)
      .document(id)
      .setData(data,merge: merge);
  }

}

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
