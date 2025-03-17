import 'package:flutter/material.dart';

import '../services/admin_service.dart';
import '../services/user_service.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final AdminService adminService = AdminService();
  final UserService userService = UserService();
  List<dynamic> transactions = [];
  bool isAdmin = false;

  void _loadTransactions() async {
    transactions = await adminService.getTransactions();
    isAdmin = await userService.isAdmin();
    setState(() {});
  }

  void _editTransaction(int index, String newHash) async {
    if (!isAdmin) return;
    setState(() {
      transactions[index]["hash"] = newHash;
    });
    await adminService.saveTransactions(transactions);
  }

  void _logout() async {
    await userService.logout();
    Navigator.pushReplacementNamed(context, "/login"); // Redirect to login
  }

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: _logout)],
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          var tx = transactions[index];
          return ListTile(
            title:
                isAdmin
                    ? TextFormField(
                      initialValue: tx["hash"],
                      onChanged: (value) => _editTransaction(index, value),
                    )
                    : Text("Hash: ${tx["hash"]}"),
            subtitle: Text("From: ${tx["from"] ?? ""}\nTo: ${tx["to"] ?? ""}"),
          );
        },
      ),
    );
  }
}
