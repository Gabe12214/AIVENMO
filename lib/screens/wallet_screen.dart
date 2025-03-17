import 'package:flutter/material.dart';

import '../services/token_balance_service.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final TokenBalanceService tokenBalanceService = TokenBalanceService(
    ethAddress: "0xYourWalletAddress",
  );

  Map<String, dynamic>? balances;

  @override
  void initState() {
    super.initState();
    _fetchBalances();
  }

  Future<void> _fetchBalances() async {
    try {
      final ethBalance = await tokenBalanceService.getBalance("1");
      final bscBalance = await tokenBalanceService.getBalance("56");

      setState(() {
        balances = {"Ethereum": ethBalance, "BSC": bscBalance};
      });
    } catch (e) {
      print("Error fetching balances: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wallet")),
      body:
          balances == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                children:
                    balances!.entries.map((entry) {
                      return ListTile(
                        title: Text(entry.key),
                        subtitle: Text("${entry.value['balance']}"),
                      );
                    }).toList(),
              ),
    );
  }
}
