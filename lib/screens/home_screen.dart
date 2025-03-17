import 'package:flutter/material.dart';

import '../services/token_balance_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TokenBalanceService tokenBalanceService = TokenBalanceService(
    ethAddress: "0xYourWalletAddress",
  );

  double ethBalance = 0.0;
  double bscBalance = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchBalances();
  }

  Future<void> _fetchBalances() async {
    try {
      final ethData = await tokenBalanceService.getBalance("1");
      final bscData = await tokenBalanceService.getBalance("56");

      setState(() {
        ethBalance = double.tryParse(ethData['balance'].toString()) ?? 0.0;
        bscBalance = double.tryParse(bscData['balance'].toString()) ?? 0.0;
      });
    } catch (e) {
      print("Error fetching balances: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AIVENMO Dashboard"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Balance",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "Ethereum: $ethBalance ETH",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "BSC: $bscBalance BNB",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchBalances,
              child: Text("Refresh Balance"),
            ),
          ],
        ),
      ),
    );
  }
}
