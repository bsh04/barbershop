import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/models/product_model.dart';
import 'package:firebaseauthproject/models/response_model.dart';

class ProductsService {

  static Future<ResponseModel<List<ProductModel>>> getProductsList() async {
    var productsSnapshot = await FirebaseFirestore.instance.collection("products").get();
    if (productsSnapshot.docs.isNotEmpty) {
      var productsList = new List<ProductModel>();
      productsSnapshot.docs.forEach((productSnapshot) {
        var product = productSnapshot.data();
        try {
          double price = (product["price"]).toDouble();
          productsList.add(new ProductModel(product["id"], product["name"], product["description"], price, product["url"]));
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