import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  double _transactionLimit = 1.0; // Default transaction limit
  bool _transactionsFrozen = false;
  double _transactionFee = 0.01; // Default fee
  List<Map<String, dynamic>> _transactions = [
    {
      "id": "TX123",
      "user": "0x123...456",
      "amount": 0.5,
      "status": "Completed",
    },
    {"id": "TX124", "user": "0x789...abc", "amount": 1.0, "status": "Pending"},
  ];

  void _updateTransactionLimit(double newLimit) {
    setState(() {
      _transactionLimit = newLimit;
    });
    _showMessage("Transaction limit updated to $_transactionLimit ETH");
  }

  void _toggleFreezeTransactions() {
    setState(() {
      _transactionsFrozen = !_transactionsFrozen;
    });
    _showMessage(
      _transactionsFrozen
          ? "Transactions are now frozen!"
          : "Transactions unfrozen!",
    );
  }

  void _updateTransactionFee(double newFee) {
    setState(() {
      _transactionFee = newFee;
    });
    _showMessage("Transaction fee updated to $_transactionFee ETH");
  }

  void _editTransaction(int index) {
    setState(() {
      _transactions[index]["status"] = "Completed";
    });
    _showMessage(
      "Transaction ${_transactions[index]['id']} marked as completed.",
    );
  }

  void _deleteTransaction(int index) {
    setState(() {
      _transactions.removeAt(index);
    });
    _showMessage("Transaction deleted.");
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Dashboard")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, Admin!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Transaction Limit Control
            Text("Transaction Limit:", style: TextStyle(fontSize: 18)),
            DropdownButton<double>(
              value: _transactionLimit,
              onChanged: (newValue) => _updateTransactionLimit(newValue!),
              items:
                  [0.5, 1.0, 2.0, 5.0].map((limit) {
                    return DropdownMenuItem<double>(
                      value: limit,
                      child: Text("$limit ETH"),
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),

            // Freeze/Unfreeze Transactions Button
            ElevatedButton(
              onPressed: _toggleFreezeTransactions,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _transactionsFrozen ? Colors.red : Colors.green,
              ),
              child: Text(
                _transactionsFrozen
                    ? "Unfreeze Transactions"
                    : "Freeze Transactions",
              ),
            ),
            SizedBox(height: 20),

            // Adjust Fees
            Text("Adjust Transaction Fee:", style: TextStyle(fontSize: 18)),
            DropdownButton<double>(
              value: _transactionFee,
              onChanged: (newValue) => _updateTransactionFee(newValue!),
              items:
                  [0.01, 0.05, 0.1, 0.2].map((fee) {
                    return DropdownMenuItem<double>(
                      value: fee,
                      child: Text("$fee ETH"),
                    );
                  }).toList(),
            ),
            SizedBox(height: 20),

            // Transaction List
            Text("User Transactions:", style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  var tx = _transactions[index];
                  return Card(
                    child: ListTile(
                      title: Text("${tx['id']} - ${tx['user']}"),
                      subtitle: Text(
                        "Amount: ${tx['amount']} ETH - Status: ${tx['status']}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check, color: Colors.green),
                            onPressed: () => _editTransaction(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTransaction(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
