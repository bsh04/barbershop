import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/models/post_model.dart';
import 'package:firebaseauthproject/models/response_model.dart';

class PostsService {

  static Future<ResponseModel<List<PostModel>>> getNewsList() async {
    var collectionSnapshot = await FirebaseFirestore.instance.collection("news").get();
    if (collectionSnapshot.docs.isNotEmpty) {
      var collectionList = new List<PostModel>();
      collectionSnapshot.docs.forEach((documentSnapshot) {
        var document = documentSnapshot.data();
        collectionList.add(new PostModel(document["title"], document["description"], document["url"]));
      });
      if (collectionList.isEmpty)
        return new ResponseModel(400, 'Список пуст.', null);
      return ResponseModel(201, 'Список получен.', collectionList);
    }
    return new ResponseModel(400, 'Список пуст.', null);
  }

  static Future<ResponseModel<List<PostModel>>> getPromotionsList() async {
    var collectionSnapshot = await FirebaseFirestore.instance.collection("promotions").get();
    if (collectionSnapshot.docs.isNotEmpty) {
      var collectionList = new List<PostModel>();
      collectionSnapshot.docs.forEach((documentSnapshot) {
        var document = documentSnapshot.data();
        collectionList.add(new PostModel(document["title"], document["description"], document["url"]));
      });
      if (collectionList.isEmpty)
        return new ResponseModel(400, 'Список пуст.', null);
      return ResponseModel(201, 'Список получен.', collectionList);
    }
    return new ResponseModel(400, 'Список пуст.', null);
  }

}