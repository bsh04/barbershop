import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/api/response_model.dart';

class Auth {

  Future<ResponseModel> signUp(String name, String login, String password) async {

    var usersRef = FirebaseFirestore.instance.collection("users");

    var userSnapshot = await usersRef.doc(login).get();
    if (userSnapshot.exists) {
      return new ResponseModel(405, 'Аккаунт с таким email уже существует.', null);
    }

    usersRef.doc(login).set({'name': name, 'login': login, 'password': password});

    return new ResponseModel(201, 'Аккаунт успешно создан.', null);
  }

}