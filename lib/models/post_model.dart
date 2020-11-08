import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/models/base_model.dart';

class PostModel implements IBaseModel {
  String title;
  String description;
  String imageUrl;

  PostModel(this.title, this.description, this.imageUrl);

  PostModel.fromDb(DocumentSnapshot document) {
    title = document['title'];
    description = document['description'];
    imageUrl = document['url'];
  }
}