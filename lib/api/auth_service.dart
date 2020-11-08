import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthproject/models/response_model.dart';
import 'package:firebaseauthproject/models/base_model.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  CollectionReference _usersRef;

  AuthService() :
        _usersRef = FirebaseFirestore.instance.collection("users");

  Future<ResponseModel<IBaseModel>> signUp(String name, String login, String password) async {

    var userSnapshot = await _usersRef.doc(login).get();
    if (userSnapshot.exists) {
      return new ResponseModel(405, 'Аккаунт с таким email уже существует.', null);
    }

    _usersRef.doc(login).set({'name': name, 'login': login, 'password': password});

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('login', login);

    return new ResponseModel(201, 'Аккаунт успешно создан.', null);
  }

  Future<ResponseModel<IBaseModel>> signIn(String login, String password) async {
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

  Future<ResponseModel<IBaseModel>> signInWithGoogle() async {

    GoogleSignInAccount googleUser;
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (e) {
      return new ResponseModel(400, 'Ошибка входа.', null);
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

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

  Future<ResponseModel<IBaseModel>> signInWithVk() async {
    // Trigger the authentication flow
    final vk = new VKLogin();
    final appId = '7654749'; // Your application ID
    await vk.initSdk(appId);

    // Log in
    final res = await vk.logIn(scope: [
      VKScope.email,
      VKScope.friends,
    ]);

    // Check result
    if (res.isValue) {
      // There is no error, but we don't know yet
      // if user loggen in or not.
      // You should check isCanceled
      final VKLoginResult data = res.asValue.value;

      if (data.isCanceled) {
        // User cancel log in
        return new ResponseModel(400, 'Вход отменен.', null);
      } else {
        // Logged in

        // Send access token to server for validation and auth
        //final VKAccessToken accessToken = data.accessToken;
        //print('Access token: ${accessToken.token}');

        // Get profile data
        var result = await vk.getUserProfile();
        VKUserProfile profile = result.asValue.value;

        final login = await vk.getUserEmail();
        final name = "${profile.firstName} ${profile.lastName}";
        var userSnapshot = await _usersRef.doc(login).get();

        if (!userSnapshot.exists) {
          _usersRef.doc(login).set({'name': name, 'login': login});
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('login', login);

        return new ResponseModel(201, 'Вход выполнен успешно.', null);
      }
    }
    return new ResponseModel(400, 'Ошибка входа: ${res.asError}.', null);

  }

}