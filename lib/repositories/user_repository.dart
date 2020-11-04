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

  Future<List<String>> signUp(String name, String email, String password) async {
    String code, message;
    try {
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseFirestore.instance.collection('users').doc(credential.user.uid).set({ 'name': name });
      message = 'Пользователь успешно зарегистрирован.';
      code = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'Длина пароля должна быть не меньше 6 символов.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Аккаунт с таким email уже существует.';
      } else {
        message = 'Произошел сбой: ${e.message}';
      }
      code = e.code;
    } catch (e) {
      message = 'Что то пошло не так.';
      code = 'undefined';
    }

    return [code, message];
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
