import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthproject/models/response_model.dart';
import 'package:firebaseauthproject/models/value_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  CollectionReference _usersRef;

  AuthService() :
        _usersRef = FirebaseFirestore.instance.collection("users");

  Future<ResponseModel<IValueModel>> signUp(String name, String login, String password) async {

    var userSnapshot = await _usersRef.doc(login).get();
    if (userSnapshot.exists) {
      return new ResponseModel(405, 'Аккаунт с таким email уже существует.', null);
    }

    _usersRef.doc(login).set({'name': name, 'login': login, 'password': password});

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('login', login);

    return new ResponseModel(201, 'Аккаунт успешно создан.', null);
  }

  Future<ResponseModel<IValueModel>> signIn(String login, String password) async {
    var userSnapshot = await _usersRef.doc(login).get();
    if (userSnapshot.exists) {
      var dbPass = userSnapshot.data()['password'];
      if (dbPass == password) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('login', login);
        return new ResponseModel(201, 'Вход выполнен успешно.', null);
      }
      return new ResponseModel(401, 'Неверный пароль.', null);
    }
    return new ResponseModel(400, 'Пользователь не найден.', null);
  }

  Future<ResponseModel<IValueModel>> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount googleUser;
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (e) {
      return new ResponseModel(400, 'Ошибка входа.', null);
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    var cred = await FirebaseAuth.instance.signInWithCredential(credential);
    var login = cred.user.email;
    var userSnapshot = await _usersRef.doc(login).get();

    if (!userSnapshot.exists) {
      _usersRef.doc(login).set({'name': cred.user.displayName, 'login': login});
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('login', login);

    return new ResponseModel(201, 'Вход выполнен успешно.', null);

  }

}