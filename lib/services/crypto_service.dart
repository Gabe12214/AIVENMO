import 'dart:convert';

import 'package:http/http.dart' as http;

class TokenBalanceService {
  final String ethApiKey =
      "YOUR_ETHERSCAN_API_KEY"; // Replace with your Etherscan API Key
  final String bscApiKey =
      "YOUR_BSCSCAN_API_KEY"; // Replace with your BscScan API Key
  final String solanaApiUrl =
      "https://api.mainnet-beta.solana.com"; // Solana RPC Endpoint

  Future<double> getEthereumBalance(String walletAddress) async {
    final url = Uri.parse(
      "https://api.etherscan.io/api?module=account&action=balance&address=$walletAddress&tag=latest&apikey=$ethApiKey",
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return double.parse(data['result']) / 1e18; // Convert from Wei to ETH
    }
    throw Exception("Failed to load Ethereum balance");
  }

  Future<double> getBscBalance(String walletAddress) async {
    final url = Uri.parse(
      "https://api.bscscan.com/api?module=account&action=balance&address=$walletAddress&tag=latest&apikey=$bscApiKey",
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return double.parse(data['result']) / 1e18; // Convert from Wei to BNB
    }
    throw Exception("Failed to load BSC balance");
  }

  Future<double> getSolanaBalance(String walletAddress) async {
    final response = await http.post(
      Uri.parse(solanaApiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "id": 1,
        "method": "getBalance",
        "params": [walletAddress],
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['result']['value'] as int) /
          1e9; // Convert from Lamports to SOL
    }
    throw Exception("Failed to load Solana balance");
  }
}
