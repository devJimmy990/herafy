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
      emit(AuthSuccessLogin(
        user: user,
        status: result['hasProfile'],
      ));
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
        emit(AuthSuccessLoginWithProfile(
          data: result['data'],
          user: result['user'],
          status: result['hasProfile'],
        ));
      }

      emit(AuthSuccessLogin(
        user: user,
        status: result['hasProfile'],
      ));
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
      emit(AuthSuccessFillData());
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
      emit(AuthSuccessFillData());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
