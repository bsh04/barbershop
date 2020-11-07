import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/models/response_model.dart';
import 'package:firebaseauthproject/models/users_model.dart';

class UserInfoService {
  CollectionReference _usersRef;

  UserInfoService() :
        _usersRef = FirebaseFirestore.instance.collection("users");

  Future<ResponseModel<UserModel>> getUserInfo(String login) async {
    var userSnapshot = await _usersRef.doc(login).get();
    if (userSnapshot.exists) {
      var name = userSnapshot.data()['name'];
      var userModel = new UserModel(name, login);
      return ResponseModel(201, 'Пользователь $login.', userModel);
    }
    return new ResponseModel(400, 'Пользователь не найден.', null);
  }
}