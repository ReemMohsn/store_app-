sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class LoginLoading extends AuthState {
  const LoginLoading();
}

class LoginSuccess extends AuthState {
  const LoginSuccess({required this.message});

  final String message;
}

class LoginFailure extends AuthState {
  const LoginFailure({required this.errorMessage});

  final String errorMessage;
}
