import 'dart:convert';

import 'package:http/http.dart' as http;

class SwapService {
  final String apiKey = "YOUR_1INCH_API_KEY"; // Replace with your 1inch API key
  final String chainId = "1"; // Ethereum = "1", BSC = "56", Polygon = "137"

  Future<String> getQuote(
    String fromToken,
    String toToken,
    String amount,
    String walletAddress,
  ) async {
    final url = Uri.parse(
      "https://api.1inch.io/v5.0/$chainId/quote?"
      "fromTokenAddress=$fromToken&toTokenAddress=$toToken&amount=$amount&walletAddress=$walletAddress",
    );

    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $apiKey"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['toAmount']; // Amount of `toToken` user will receive
    } else {
      throw Exception("Failed to get quote: ${response.body}");
    }
  }

  Future<String> swapTokens(
    String fromToken,
    String toToken,
    String amount,
    String walletAddress,
  ) async {
    final url = Uri.parse(
      "https://api.1inch.io/v5.0/$chainId/swap?"
      "fromTokenAddress=$fromToken&toTokenAddress=$toToken&amount=$amount&fromAddress=$walletAddress&slippage=1",
    );

    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $apiKey"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['transaction']['hash']; // Swap transaction hash
    } else {
      throw Exception("Swap failed: ${response.body}");
    }
  }
}
