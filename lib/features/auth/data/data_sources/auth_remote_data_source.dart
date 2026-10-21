import 'package:stor_app/core/constants/api_end_points.dart';
import 'package:stor_app/core/services/api_service.dart';
import 'package:stor_app/features/auth/data/models/auth_account.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<AuthAccount> signIn({
    required String username,
    required String password,
  }) async {
    final response = await _apiService.post(
      ApiEndPoints.login,
      data: {'username': username.trim(), 'password': password},
    );
    return AuthAccount.fromJson(response.data as Map<String, dynamic>);
  }
}
