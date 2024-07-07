import 'package:herafy/data/model/client.dart';
import 'package:herafy/data/model/technician.dart';
import 'package:herafy/data/data%20sources/user_remote_data_source.dart';

class UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepository({required this.remoteDataSource});

  Future<dynamic> loadUserData({
    required String id,
    required String type,
  }) async {
    try {
      Map<String, dynamic> result =
          await remoteDataSource.loadUserData(id, type);

      return type == "client"
          ? Client.fromJson(result)
          : Technician.fromJson(result);
    } catch (e) {
      throw Exception(e);
    }
  }
}
