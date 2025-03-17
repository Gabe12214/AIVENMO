import 'dart:convert';

import 'package:http/http.dart' as http;

class TokenBalanceService {
  final String ethAddress;
  TokenBalanceService({required this.ethAddress});

  Future<Map<String, dynamic>> getBalance(String chain) async {
    final String apiUrl =
        "https://api.1inch.io/v5.0/$chain/balance/$ethAddress";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load balance");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
