sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAccountCreated extends AuthState {
  final String? user;
  AuthAccountCreated({required this.user});
}

class AuthSuccessLogin extends AuthState {
  final String user;
  final bool status;
  AuthSuccessLogin({
    required this.user,
    required this.status,
  });
}

class AuthSuccessLoginWithProfile extends AuthState {
  final dynamic data;
  final String user;
  final bool status;
  AuthSuccessLoginWithProfile({
    required this.data,
    required this.user,
    required this.status,
  });
}

class AuthSignOutSuccess extends AuthState {}

class AuthSuccessFillData extends AuthState {
  final dynamic data;
  AuthSuccessFillData({required this.data});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
