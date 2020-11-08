import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/api/base_service.dart';
import 'package:firebaseauthproject/models/post_model.dart';
import 'package:firebaseauthproject/models/response_model.dart';

class PostService extends BaseService<PostModel> {
  ItemCreator<PostModel> creator;
  PostService(this.creator) : super(creator);

  static Future<ResponseModel<List<PostModel>>> getAllNews() async {
    var a = new BaseService((document) => creator)
    var productsSnapshot = await FirebaseFirestore.instance.collection("products").get();
    if (productsSnapshot.docs.isNotEmpty) {
      var productsList = new List<PostModel>();
      productsSnapshot.docs.forEach((productSnapshot) {
        var product = productSnapshot.data();
        try {
          double price = (product["price"]).toDouble();
          productsList.add(new PostModel(product["name"], product["description"], price, product["url"]));
        } catch (e) {
          print("Failed to get product $productSnapshot");
        }
      });
      if (productsList.isEmpty)
        return new ResponseModel(400, 'Список товаров пуст.', null);
      return ResponseModel(201, 'Список мастеров получен.', productsList);
    }
    return new ResponseModel(400, 'Список товаров пуст.', null);
  }

}