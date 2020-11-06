import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/api/response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  CollectionReference _usersRef;

  Auth() :
        _usersRef = FirebaseFirestore.instance.collection("users");

  Future<ResponseModel> signUp(String name, String login, String password) async {

    var userSnapshot = await _usersRef.doc(login).get();
    if (userSnapshot.exists) {
      return new ResponseModel(405, 'Аккаунт с таким email уже существует.', null);
    }

    _usersRef.doc(login).set({'name': name, 'login': login, 'password': password});

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('login', login);

    return new ResponseModel(201, 'Аккаунт успешно создан.', null);
  }

  Future<ResponseModel> signIn(String login, String password) async {
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

}