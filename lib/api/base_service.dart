import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/models/base_model.dart';
import 'package:firebaseauthproject/models/master_model.dart';
import 'package:firebaseauthproject/models/post_model.dart';

typedef S ItemCreator<S>(DocumentSnapshot document);

class BaseService<TModel extends IBaseModel> {

  ItemCreator<TModel> creator;
  BaseService(this.creator);

  Future<List<TModel>> getAllFromCollection(String collectionName) async {

    var collectionSnapshot = await FirebaseFirestore.instance.collection(collectionName).get();
    if (collectionSnapshot.docs.isNotEmpty) {
      var collectionList = new List<TModel>();
      collectionSnapshot.docs.forEach((documentSnapshot) {
        TModel item = creator(documentSnapshot);
        collectionList.add(item);
      });
      return collectionList;
    }
    return null;

  }

  final factories = <Type, Function>{
    PostModel: (DocumentSnapshot x) => PostModel.fromDb(x),
    MasterModel: (DocumentSnapshot x) => MasterModel.fromDb(x),
  };

  T make<T extends IBaseModel>(DocumentSnapshot x) {
    return factories[T](x);
  }

}