import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafy/core/helper/shared_preferences.dart';
import 'package:herafy/data/data%20sources/user_remote_data_source.dart';
import 'package:herafy/data/repositories/user_repository.dart';
import 'package:herafy/domain/cubit/user/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  late dynamic _user;

  setUserData(dynamic data) => _user = data;
  // fetchfullUserData() => _user;
  loadUserData() async {
    emit(UserLoading());
    try {
      _user = await UserRepository(remoteDataSource: UserRemoteDataSource())
          .loadUserData(
        id: SharedPreference().getString(key: "userID")!,
        type: SharedPreference().getString(key: "userType")!,
      );
      emit(UserLoaded());
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  dynamic get user => _user;
  String get userType => _user.type;
  bool get isClient => _user.type == "client";
}
