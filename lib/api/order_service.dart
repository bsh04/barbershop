import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/api/userInfo_service.dart';
import 'package:firebaseauthproject/models/response_model.dart';

class OrderService {

  static Future<ResponseModel> makeOrder(String productId, String userLogin) async {
    var productSnapshot = await FirebaseFirestore.instance.collection("products").doc(productId).get();
    var userInfo = await UserInfoService.getUserInfo(userLogin);

    if (productSnapshot.exists && userInfo != null && userInfo.data != null) {
      double price = productSnapshot.data()['price'];
      double balance = userInfo.data.balance;

      if (balance < price) {
        return new ResponseModel(400, 'Недостаточно средств.', null);
      }

      FirebaseFirestore.instance.collection("users").doc(userLogin).update({'balance': balance - price});

      return ResponseModel(201, 'Успешная транзакция.', null);
    }
    return new ResponseModel(404, 'Пользователь или товар не найден.', null);
  }

}