import 'package:aivenmo/screens/home_screen.dart'; // Adjust the path as necessary
import 'package:aivenmo/screens/wallet_screen.dart'; // Adjust the path as necessary
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), // Ensure HomeScreen is defined or imported
    WalletScreen(), // Ensure WalletScreen is defined or imported
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Wallet',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
