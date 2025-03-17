import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AdminService {
  Future<void> saveTransactions(List<dynamic> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("transactions", json.encode(transactions));
  }

  Future<List<dynamic>> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("transactions");
    return data != null ? json.decode(data) : [];
  }
}
