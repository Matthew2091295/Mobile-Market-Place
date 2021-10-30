import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:market_place/Login.dart';
import 'package:market_place/pallete.dart';
import 'package:market_place/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:market_place/HomePage.dart';
import 'package:market_place/Drawer.dart';

import 'Globals.dart' as Globals;

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key key, @required this.orderID}) : super(key: key);

  final int orderID;

  @override
  Widget build(BuildContext context) {
    //List snap = getData();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Order"),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          children: [
            Text("ABC"),
            Text("ABC"),
            Text("ABC"),
            Text("ABC"),
            Text("ABC"),
          ],
        ));
  }
}
