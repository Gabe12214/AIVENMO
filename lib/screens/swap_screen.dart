import 'package:flutter/material.dart';

import '../services/swap_service.dart';

class SwapScreen extends StatefulWidget {
  @override
  _SwapScreenState createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  final SwapService swapService = SwapService();
  String fromToken = "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE"; // ETH
  String toToken = "0x6B175474E89094C44Da98b954EedeAC495271d0F"; // DAI
  String amount = "1000000000000000000"; // 1 ETH (in Wei)
  String walletAddress =
      "0xYourWalletAddress"; // Replace with actual user address
  String swapResult = "Enter details to swap";

  void _swapTokens() async {
    try {
      String result = await swapService.swapTokens(
        fromToken,
        toToken,
        amount,
        walletAddress,
      );
      setState(() {
        swapResult = "Swap Successful! Tx Hash: $result";
      });
    } catch (e) {
      setState(() {
        swapResult = "Swap Failed: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Swap Tokens")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Swap 1 ETH for DAI", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _swapTokens, child: Text("Swap Now")),
            SizedBox(height: 20),
            Text(swapResult, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
