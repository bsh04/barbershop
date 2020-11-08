import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseauthproject/models/master_model.dart';
import 'package:firebaseauthproject/models/response_model.dart';

class MastersService {

  static Future<ResponseModel<List<MasterModel>>> getAllMasters() async {
    var mastersSnapshot = await FirebaseFirestore.instance.collection("staff").get();
    if (mastersSnapshot.docs.isNotEmpty) {
      var masterList = new List<MasterModel>();
      mastersSnapshot.docs.forEach((masterSnapshot) {
        var master = masterSnapshot.data();
        try {
          double rating = (master["rating"]).toDouble();
          masterList.add(new MasterModel(master["name"], rating, master["url"]));
        } catch (e) {
          print("Failed to get master $masterSnapshot");
        }
      });
      if (masterList.isEmpty)
        return new ResponseModel(400, 'Список мастеров пуст.', null);
      return ResponseModel(201, 'Список мастеров получен.', masterList);
    }
    return new ResponseModel(400, 'Список мастеров пуст.', null);
  }

}