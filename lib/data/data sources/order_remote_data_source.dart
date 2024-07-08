import 'package:cloud_firestore/cloud_firestore.dart';

class OrderRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  getAllOrders() async {
    try {
      firestore.collection("orders").where;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Map<String, dynamic>>> getAllOrdersBySpeciality(
      {required String speciality}) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection("orders")
          .where("speciality", isEqualTo: speciality)
          .get();
      return snapshot.docs.map((e) => e.data()).toList()
          as List<Map<String, dynamic>>;
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<String> createAccountWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     var user = await firebaseAuth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return user.user!.uid;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // Future<Map<String, dynamic>> signInWithGoogle() async {
  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn();
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       await firebaseAuth.signInWithCredential(credential);
  //       if (firebaseAuth.currentUser?.uid == null) {
  //         return throw Exception("no-account-selected");
  //       }
  //       var data = await getUserData(firebaseAuth.currentUser!.uid);

  //       return {"user": firebaseAuth.currentUser!.uid, "data": data};
  //       // return firebaseAuth.currentUser?.uid;
  //     }
  //     return throw Exception("no-account-selected");
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // Future<Map<String, dynamic>> signInWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     var user = await firebaseAuth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     var data = await getUserData(user.user!.uid);
  //     return {"user": user.user!.uid, "data": data};
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // fillClientData({required Map<String, dynamic> client}) {
  //   try {
  //     return firestore.collection('clients').doc(client['id']).set(client);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // fillTechnicianData({required Map<String, dynamic> technician}) {
  //   try {
  //     return firestore
  //         .collection('technicians')
  //         .doc(technician['id'])
  //         .set(technician);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // getUserData(String userId) async {
  //   try {
  //     DocumentSnapshot snapshot =
  //         await firestore.collection("clients").doc(userId).get();
  //     if (snapshot.data() != null) {
  //       return snapshot.data();
  //     } else if (snapshot.data() == null) {
  //       snapshot = await firestore.collection("technicians").doc(userId).get();
  //     }

  //     return snapshot.data();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // signOut() async {
  //   await firebaseAuth.signOut();
  // }
}
