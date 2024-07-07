import 'package:cloud_firestore/cloud_firestore.dart';

class UserRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> loadUserData(String id, String type) async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection("${type}s").doc(id).get();
      return snapshot.data() as Map<String, dynamic>;
    } catch (e) {
      throw Exception(e);
    }
  }
}
