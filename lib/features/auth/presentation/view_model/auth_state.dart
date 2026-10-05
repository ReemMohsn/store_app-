abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  LoginSuccess({required this.message});

  final String message;
}

class LoginFailure extends AuthState {
  LoginFailure({required this.errorMessage});

  final String errorMessage;
}
