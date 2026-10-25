import 'package:shared_preferences/shared_preferences.dart';
import 'package:stor_app/core/constants/shared_preferences_keys.dart';

class SharedPreferencesService {
  SharedPreferencesService({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  Future<bool> get isOnboardingCompleted async =>
      await _preferences.getBool(SharedPreferencesKeys.onboardingCompleted) ??
      false;

  Future<void> setOnboardingCompleted() =>
      _preferences.setBool(SharedPreferencesKeys.onboardingCompleted, true);

  Future<String?> get accessToken async =>
      await _preferences.getString(SharedPreferencesKeys.accessToken);

  Future<void> setAccessToken(String token) =>
      _preferences.setString(SharedPreferencesKeys.accessToken, token);
}
