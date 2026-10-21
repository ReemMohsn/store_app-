import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/core/constants/app_strings.dart';
import 'package:stor_app/features/auth/data/repositories/auth_repository.dart';
import 'package:stor_app/features/auth/presentation/view_model/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthInitial());

  final AuthRepository _repository;

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    emit(const LoginLoading());
    final result = await _repository.signIn(
      username: username,
      password: password,
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(LoginFailure(errorMessage: failure.message)),
      (_) => emit(const LoginSuccess(message: AppStrings.welcomeBack)),
    );
  }
}
