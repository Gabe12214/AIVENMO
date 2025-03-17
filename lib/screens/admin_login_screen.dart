import 'package:flutter/material.dart';

import 'admin_screen.dart'; // Admin dashboard

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _privateKeyController = TextEditingController();
  String errorMessage = "";

  void _login() {
    const String adminPrivateKey = "Efowambby"; // Default Admin Key

    if (_privateKeyController.text == adminPrivateKey) {
      // Navigate to AdminScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminScreen()),
      );
    } else {
      setState(() {
        errorMessage = "Invalid private key!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // ✅ FIXED
          crossAxisAlignment: CrossAxisAlignment.center, // ✅ FIXED
          children: [
            Text(
              "Enter Admin Private Key",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _privateKeyController,
              obscureText: true, // Hide private key input
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Private Key",
              ),
            ),
            if (errorMessage.isNotEmpty) ...[
              SizedBox(height: 10),
              Text(errorMessage, style: TextStyle(color: Colors.red)),
            ],
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
