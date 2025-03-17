import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String adminPassword =
      "Admin@123"; // Change this to a more secure password

  Future<bool> login(String password) async {
    if (password == adminPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isAdmin", true);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("isAdmin");
  }

  Future<bool> isAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isAdmin") ?? false;
  }
}
