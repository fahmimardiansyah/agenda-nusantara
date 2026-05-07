import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String usernameKey = 'username';
  static const String passwordKey = 'password';
  static const String loginKey = 'isLoggedIn';

  // =========================
  // Initialize Default User
  // =========================
  static Future<void> initUser() async {
    final prefs = await SharedPreferences.getInstance();

    final username = prefs.getString(usernameKey);
    final password = prefs.getString(passwordKey);

    if (username == null && password == null) {
      await prefs.setString(usernameKey, 'user');
      await prefs.setString(passwordKey, 'user');
    }
  }

  // =========================
  // Login Validation
  // =========================
  static Future<bool> login(
    String username,
    String password,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final savedUsername =
        prefs.getString(usernameKey);

    final savedPassword =
        prefs.getString(passwordKey);

    if (username == savedUsername &&
        password == savedPassword) {
      await prefs.setBool(loginKey, true);

      return true;
    }

    return false;
  }

  // =========================
  // Logout
  // =========================
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(loginKey, false);
  }

  // =========================
  // Check Login Status
  // =========================
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(loginKey) ?? false;
  }

  // =========================
  // Change Password
  // =========================
  static Future<bool> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final savedPassword =
        prefs.getString(passwordKey);

    if (oldPassword == savedPassword) {
      await prefs.setString(
        passwordKey,
        newPassword,
      );

      return true;
    }

    return false;
  }

  
}