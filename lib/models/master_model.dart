import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/models/base_model.dart';

class MasterModel implements IBaseModel {
  String name;
  double rating;
  String imageUrl;

  MasterModel(this.name, this.rating, this.imageUrl);

  MasterModel.fromDb(DocumentSnapshot document) {
    name = document['name'];
    rating = (document['rating']).toDouble();
    imageUrl = document['url'];
  }
}