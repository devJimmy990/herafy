sealed class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {}

class UserError extends UserState {
  final String message;
  UserError({required this.message});
}
