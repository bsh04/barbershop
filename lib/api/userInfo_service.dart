import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/models/response_model.dart';
import 'package:firebaseauthproject/models/users_model.dart';

class UserInfoService {

  static Future<ResponseModel<UserModel>> getUserInfo(String login) async {
    var userSnapshot = await FirebaseFirestore.instance.collection("users").doc(login).get();
    if (userSnapshot.exists) {
      double balance;
      try {
        balance = userSnapshot.data()['balance'].toDouble();
      } catch (e) {
        print(e);
      }
      var name = userSnapshot.data()['name'];
      var userModel = new UserModel(name, login, balance);
      return ResponseModel(201, 'Пользователь $login.', userModel);
    } else {
      print('123');
    }
    return new ResponseModel(400, 'Пользователь не найден.', null);
  }

}