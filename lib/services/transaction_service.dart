import 'dart:convert';

import 'package:http/http.dart' as http;

class TransactionService {
  final String ethApiKey = "YOUR_ETHERSCAN_API_KEY";
  final String bscApiKey = "YOUR_BSCSCAN_API_KEY";
  final String solanaRpcUrl = "https://api.mainnet-beta.solana.com";

  Future<List<dynamic>> getEthereumTransactions(String walletAddress) async {
    final url = Uri.parse(
      "https://api.etherscan.io/api?module=account&action=txlist&address=$walletAddress&startblock=0&endblock=99999999&sort=desc&apikey=$ethApiKey",
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body)["result"];
    } else {
      throw Exception("Failed to fetch Ethereum transactions");
    }
  }

  Future<List<dynamic>> getBscTransactions(String walletAddress) async {
    final url = Uri.parse(
      "https://api.bscscan.com/api?module=account&action=txlist&address=$walletAddress&startblock=0&endblock=99999999&sort=desc&apikey=$bscApiKey",
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body)["result"];
    } else {
      throw Exception("Failed to fetch BSC transactions");
    }
  }

  Future<List<dynamic>> getSolanaTransactions(String walletAddress) async {
    final body = json.encode({
      "jsonrpc": "2.0",
      "id": 1,
      "method": "getConfirmedSignaturesForAddress2",
      "params": [
        walletAddress,
        {"limit": 10},
      ],
    });

    final response = await http.post(
      Uri.parse(solanaRpcUrl),
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)["result"];
    } else {
      throw Exception("Failed to fetch Solana transactions");
    }
  }
}
