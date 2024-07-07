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

class AuthSuccessLoginWithProfile extends AuthSuccessLogin {
  final dynamic data;

  AuthSuccessLoginWithProfile({
    required this.data,
    required super.user,
    required super.status,
  });
}

class AuthSuccessFillData extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
