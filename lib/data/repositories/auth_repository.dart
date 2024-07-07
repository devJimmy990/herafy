import 'package:herafy/data/data%20sources/auth_remote_data_source.dart';
import 'package:herafy/data/model/client.dart';
import 'package:herafy/data/model/technician.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository({required this.remoteDataSource});

  Future<String> createAccountWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await remoteDataSource.createAccountWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      Map<String, dynamic> result = await remoteDataSource.signInWithGoogle();
      if (result["data"] == null) {
        return {
          "user": result["user"],
          "hasProfile": false,
        };
      } else {

        return {
          "user": result["user"],
          "hasProfile": true,
          "data": result["data"]["type"] == "client"
              ? Client.fromJson(result["data"])
              : Technician.fromJson(result["data"])
        };
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      Map<String, dynamic> result =
          await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result["data"] == null) {
        return {
          "user": result["user"],
          "hasProfile": false,
        };
      } else {
        return {
          "user": result["user"],
          "hasProfile": true,
          "data": result["data"]["type"] == "client"
              ? Client.fromJson(result["data"])
              : Technician.fromJson(result["data"])
        };
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  fillClientData({required Client client}) {
    try {
      return remoteDataSource.fillClientData(
        client: client.toJson(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  fillTechnicianData({required Technician technician}) {
    try {
      return remoteDataSource.fillTechnicianData(
        technician: technician.toJson(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  signOut() {
    try {
      return remoteDataSource.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
  //  getFavoriteDoctors(String patientId) async {
  //   try {
  //     List<dynamic> favoriteDoctors =
  //         await remoteDataSource.getFavoriteDoctors(patientId);

  //     return favoriteDoctors.map((e) => Doctor.fromJson(e)).toList();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<Doctor?> getFavoriteDoctorById(
  //     {required String doctorId, required String patientId}) async {
  //   try {
  //     final doctor = await remoteDataSource.getFavoriteDoctorById(
  //         doctorId: doctorId, patientId: patientId);
  //     if (doctor == null) return null;
  //     return Doctor.fromJson(doctor);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
