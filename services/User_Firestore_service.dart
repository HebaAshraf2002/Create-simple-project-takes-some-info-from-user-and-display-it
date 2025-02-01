import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasefirestore/models/Firestore_User_Model.dart';

class UserFirestoreService {
  var db = FirebaseFirestore.instance;
  Future<List<User>> getUserFromFirebase() async {
    List<User> users = [];
    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        users.add(User.fromFirestore(doc));
      }
    });
    return users;
  }
}
