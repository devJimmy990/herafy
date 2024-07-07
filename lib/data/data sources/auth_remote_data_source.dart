import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSource {
  var firebaseAuth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;

  Future<String> createAccountWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user.user!.uid;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await firebaseAuth.signInWithCredential(credential);
        if (firebaseAuth.currentUser?.uid == null) {
          return throw Exception("no-account-selected");
        }
        var data = await getUserData(firebaseAuth.currentUser!.uid);
        return {"user": firebaseAuth.currentUser!.uid, "data": data};
        // return firebaseAuth.currentUser?.uid;
      }
      return throw Exception("no-account-selected");
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      var data = await getUserData(user.user!.uid);
      return {"user": user.user!.uid, "data": data};
    } catch (e) {
      throw Exception(e);
    }
  }

  fillClientData({required Map<String, dynamic> client}) {
    try {
      return firestore.collection('clients').doc(client['id']).set(client);
    } catch (e) {
      throw Exception(e);
    }
  }

  fillTechnicianData({required Map<String, dynamic> technician}) {
    try {
      return firestore
          .collection('technicians')
          .doc(technician['id'])
          .set(technician);
    } catch (e) {
      throw Exception(e);
    }
  }

  isUserHasProfile(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection("clients").doc(userId).get();
      if (snapshot.data() != null) {
        return snapshot.data();
      } else if (snapshot.data() == null) {
        snapshot = await firestore.collection("technicians").doc(userId).get();
      }
      return snapshot.data() == null ? false : true;
    } catch (e) {
      throw Exception(e);
    }
  }

  getUserData(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection("clients").doc(userId).get();
      if (snapshot.data() != null) {
        return snapshot.data();
      } else if (snapshot.data() == null) {
        snapshot = await firestore.collection("technicians").doc(userId).get();
      }

      return snapshot.data();
    } catch (e) {
      throw Exception(e);
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }
  // Future<void> addFavoriteDoctorToPatient(
  //     {required String patientId, required Doctor doctor}) async {
  //   try {
  //     final patientDocRef = firestore
  //         .collection('patients')
  //         .doc(patientId)
  //         .collection("favorite_doctors");

  //     await patientDocRef.doc(doctor.id).set(doctor.toJson());
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // Future<void> removeFavoriteDoctorFromPatient(
  //     {required String patientId, required String doctorId}) async {
  //   try {
  //     final patientDocRef = firestore
  //         .collection('patients')
  //         .doc(patientId)
  //         .collection('favorite_doctors');

  //     await patientDocRef.doc(doctorId).delete();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // Future<List<dynamic>> getFavoriteDoctors(String patientId) async {
  //   try {
  //     final patientDocRef = firestore
  //         .collection('patients')
  //         .doc(patientId)
  //         .collection('favorite_doctors');
  //     final snapshot = await patientDocRef.get();

  //     final List<Map<String, dynamic>> favoriteDoctors =
  //         snapshot.docs.map((doc) => doc.data()).toList();

  //     return favoriteDoctors;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // Future<Map<String, dynamic>?> getFavoriteDoctorById(
  //     {required String patientId, required String doctorId}) async {
  //   try {
  //     final patientDocRef = firestore
  //         .collection('patients')
  //         .doc(patientId)
  //         .collection('favorite_doctors');

  //     final snapshot =
  //         await patientDocRef.where('id', isEqualTo: doctorId).get();

  //     if (snapshot.docs.isNotEmpty) {
  //       final Map<String, dynamic> favoriteDoctor = snapshot.docs.first.data();
  //       return favoriteDoctor;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
