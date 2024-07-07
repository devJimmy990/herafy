import 'package:herafy/core/helper/shared_preferences.dart';
import 'package:herafy/data/model/client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/data/model/technician.dart';
import 'package:herafy/domain/cubit/auth/auth_state.dart';
import 'package:herafy/data/repositories/auth_repository.dart';
import 'package:herafy/data/data%20sources/auth_remote_data_source.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  late String user;
  createAccountWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      user = await AuthRepository(remoteDataSource: AuthRemoteDataSource())
          .createAccountWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthAccountCreated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  signInWithGoogle() async {
    emit(AuthLoading());
    try {
      Map<String, dynamic> result =
          await AuthRepository(remoteDataSource: AuthRemoteDataSource())
              .signInWithGoogle();

      user = result['user'];

      if (result['hasProfile']) {
        saveCurretnUserData(
          id: result['data'].id,
          type: result['data'].type,
        );

        emit(AuthSuccessLoginWithProfile(
          data: result['data'],
          user: result['user'],
          status: result['hasProfile'],
        ));
      } else {
        emit(AuthSuccessLogin(
          user: user,
          status: result['hasProfile'],
        ));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      Map<String, dynamic> result =
          await AuthRepository(remoteDataSource: AuthRemoteDataSource())
              .signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = result['user'];
      if (result['hasProfile']) {
        saveCurretnUserData(
          id: result['data'].id,
          type: result['data'].type,
        );

        emit(AuthSuccessLoginWithProfile(
          data: result['data'],
          user: result['user'],
          status: result['hasProfile'],
        ));
      } else {
        emit(AuthSuccessLogin(
          user: user,
          status: result['hasProfile'],
        ));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  fillClientData({required Client client}) async {
    emit(AuthLoading());
    try {
      client.id = user;
      await AuthRepository(remoteDataSource: AuthRemoteDataSource())
          .fillClientData(client: client);
      saveCurretnUserData(
        id: client.id!,
        type: "client",
      );
      emit(AuthSuccessFillData(data: client));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  fillTechnicianData({required Technician technician}) async {
    emit(AuthLoading());
    try {
      technician.id = user;
      await AuthRepository(remoteDataSource: AuthRemoteDataSource())
          .fillTechnicianData(technician: technician);
      saveCurretnUserData(
        id: technician.id!,
        type: "technician",
      );
      emit(AuthSuccessFillData(data: technician));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  saveCurretnUserData({required String type, required String id}) async {
    SharedPreference().setString(key: "userID", value: id);
    SharedPreference().setString(key: "userType", value: type);
  }

  signOut() async {
    emit(AuthLoading());
    try {
      await AuthRepository(remoteDataSource: AuthRemoteDataSource()).signOut();
      SharedPreference().clearData(key: "userID");
      SharedPreference().clearData(key: "userType");
      emit(AuthSignOutSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
