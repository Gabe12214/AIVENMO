import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserService {
  final String adminEmail = "admin@aivenmo.com";
  final String adminPassword = "Admin@123"; // Secure this in a real app

  Future<bool> registerUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? users = prefs.getStringList("users") ?? [];

    if (users.any((user) => user.split("|")[0] == email)) {
      return false; // Email already registered
    }

    String userId = Uuid().v4();
    users.add("$email|$password|$userId");
    await prefs.setStringList("users", users);
    return true;
  }

  Future<String?> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? users = prefs.getStringList("users") ?? [];

    for (String user in users) {
      List<String> data = user.split("|");
      if (data[0] == email && data[1] == password) {
        await prefs.setString("currentUser", data[2]); // Store user session
        return data[2]; // Return user ID
      }
    }
    return null;
  }

  Future<bool> isAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    String? currentUser = prefs.getString("currentUser");

    if (currentUser == null) return false;

    return currentUser == adminEmail; // Check if current user is admin
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("currentUser");
  }
}
