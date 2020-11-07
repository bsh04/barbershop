import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/models/response_model.dart';
import 'package:firebaseauthproject/models/value_model.dart';
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

}