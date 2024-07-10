import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herafy/data/model/order.dart' as custom_order;

class OrderRemoteDataSource {
  var firestore = FirebaseFirestore.instance;

  getAllOrders() async {
    try {
      QuerySnapshot snapshot = await firestore.collection("orders").get();
      return snapshot.docs.map((e) => e.data()).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Object?>> getAllOrdersBySpeciality(
      {required String speciality}) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection("orders")
          .where("speciality", isEqualTo: speciality)
          .get();
      return snapshot.docs.map((e) => e.data()).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<custom_order.Order> addNewOrder(custom_order.Order order) async {
    try {
      var docRef = await firestore.collection("orders").add(order.toJson());

      String generatedId = docRef.id;

      order.id = generatedId;

      await docRef.update({'id': generatedId});

      return order;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Object?>> getOrdersByClientID({required String clientId}) async {
    try {
      final snapshot = await firestore
          .collection('orders')
          .where('clientID', isEqualTo: clientId)
          .get();

      final ordersWithProposals =
          await Future.wait(snapshot.docs.map((orderDoc) async {
        final orderData = orderDoc.data(); // Assuming data always exists
        final proposalIds = orderData['proposals'] as List<dynamic>;
        final proposalsData = await _fetchProposals(proposalIds);
        return {...orderData, 'proposals': proposalsData};
      }));
      return ordersWithProposals.toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<dynamic>> _fetchProposals(
      List<dynamic> proposalIds) async {
    print("ordersWithProposals: _fetchProposals");
    final proposals = await Future.wait(proposalIds
        .map((id) => firestore.collection('technicians').doc(id).get()));
    return proposals
        .where((snapshot) => snapshot.exists)
        .map((snapshot) => snapshot.data()!)
        .toList();
  }

  addProposal(String order, String technician) async {
    try {
      await firestore.collection("orders").doc(order).update({
        "proposals": FieldValue.arrayUnion([technician]),
      });
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
