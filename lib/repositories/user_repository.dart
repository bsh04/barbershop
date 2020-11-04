import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository()
      : _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp(String name, String email, String password) async {
    UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    FirebaseFirestore.instance.collection('users').doc(credential.user.uid).set({ 'name': name });

    return credential;
  }

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  User getUser() {
     return _firebaseAuth.currentUser;
  }

}
