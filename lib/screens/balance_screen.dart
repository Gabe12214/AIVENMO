import 'package:flutter/material.dart';

import '../services/balance_service.dart';

class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final BalanceService balanceService = BalanceService();
  String walletAddress = "YOUR_WALLET_ADDRESS";
  String ethBalance = "Loading...";
  String bscBalance = "Loading...";
  String solBalance = "Loading...";

  void _fetchBalances() async {
    try {
      String eth = await balanceService.getEthBalance(walletAddress);
      String bsc = await balanceService.getBscBalance(walletAddress);
      String sol = await balanceService.getSolanaBalance(walletAddress);

      setState(() {
        ethBalance = "$eth ETH";
        bscBalance = "$bsc BNB";
        solBalance = "$sol SOL";
      });
    } catch (e) {
      print("Error fetching balances: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBalances();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Token Balances")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ethereum Balance: $ethBalance",
              style: TextStyle(fontSize: 18),
            ),
            Text("BSC Balance: $bscBalance", style: TextStyle(fontSize: 18)),
            Text("Solana Balance: $solBalance", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchBalances,
              child: Text("Refresh Balances"),
            ),
          ],
        ),
      ),
    );
  }
}
