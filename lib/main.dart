

import 'package:flutter/material.dart';
import 'package:market_place/HomePage.dart';
import 'package:market_place/Login.dart';
import 'package:market_place/Registration.dart';
import 'package:market_place/UserPage.dart';

void main() {
  runApp(MaterialApp(
    home: Main(),
  ));
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Login(),
    );
  }
}
