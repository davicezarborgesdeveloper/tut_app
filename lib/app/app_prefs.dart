import 'package:complete_advanced_flutter/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARD_SCREEN = "PREFS_KEY_ONBOARD_SCREEN";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> setOnboardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARD_SCREEN, true);
  }

  Future<bool> isOnboardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARD_SCREEN) ?? false;
  }

  Future<bool> setIsUserLoggedIn() async {
    return _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }
}
