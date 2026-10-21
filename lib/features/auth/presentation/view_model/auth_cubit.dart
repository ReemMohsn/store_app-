import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/features/auth/presentation/view_model/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._dio) : super(AuthInitial());
  final Dio _dio;

  Future<void> signIn({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final response = await _dio.post(
        'https://dummyjson.com/auth/login',
        data: {'username': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200) {
        emit(LoginSuccess(message: 'تم تسجيل الدخول بنجاح'));
      } else {
        emit(LoginFailure(errorMessage: 'بيانات الدخول غير صحيحة'));
      }
    } catch (_) {
      emit(LoginFailure(errorMessage: 'تعذر تسجيل الدخول، تحقق من البيانات والاتصال'));
    }
  }
}
