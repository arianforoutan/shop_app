import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/di/di.dart';

class AuthManager {
  static final ValueNotifier<String?> authchangeNotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) async {
    _sharedPref.setString('access_token', token);
    authchangeNotifier.value = token;
  }

  static String readAuth() {
    return _sharedPref.getString('access_token') ?? '';
  }

  static void logout() {
    _sharedPref.clear();
    authchangeNotifier.value = null;
  }

  static bool isLogedin() {
    String token = readAuth();
    return token.isNotEmpty;
  }
}
