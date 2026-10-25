import 'package:dartz/dartz.dart';
import 'package:stor_app/core/services/errors/failure.dart';
import 'package:stor_app/core/services/request_handler.dart';
import 'package:stor_app/core/services/shared_preferences_service.dart';
import 'package:stor_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:stor_app/features/auth/data/models/auth_account.dart';

class AuthRepository {
  const AuthRepository(this._remote, this._preferencesService);

  final AuthRemoteDataSource _remote;
  final SharedPreferencesService _preferencesService;

  Future<Either<Failure, AuthAccount>> signIn({
    required String username,
    required String password,
  }) => requestHandler(() async {
    final account = await _remote.signIn(
      username: username,
      password: password,
    );
    await _preferencesService.setAccessToken(account.accessToken);
    return account;
  });
}
