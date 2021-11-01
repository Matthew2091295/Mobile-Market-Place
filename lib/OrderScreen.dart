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

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key key, @required this.orderID}) : super(key: key);

  final int orderID;

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

getMethod(int orderID) async {
  String theUrl =
      "https://lamp.ms.wits.ac.za/home/s1854457/getOrderItems.php?orderID=" +
          orderID.toString(); //connecting to Wits database

  var res = await http
      .get(Uri.parse(theUrl), headers: {"Accept": "application/json"});

  var responseBody = json.decode(res.body);

  return responseBody;
}

orderItems(List snap) {
  final orderItems = <Widget>[];

  for (int i = 0; i < snap.length; i++) {
    String path = "assets/images/" + snap[i]['itemid'] + ".jpg";
    orderItems.add(Container(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Image.asset(
            path,
            height: 120,
            width: 120,
          ),
          Text(snap[i]['name']),
        ]),
      ),
    ));
  }
  return orderItems;
}

getTotal(List snap) {
  int total = 0;
  for (int i = 0; i < snap.length; i++) {
    total += int.parse(snap[i]['price']) * int.parse(snap[i]['quantity']);
  }
  return total;
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    //List snap = getData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Number: " + widget.orderID.toString()),
        backgroundColor: Color.fromRGBO(206, 166, 97, 1.0),
      ),
      body: FutureBuilder(
          future: getMethod(widget.orderID),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List snap = snapshot.data;
            int i = getTotal(snap);
            return SafeArea(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total: R" + i.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: PDFButton(orderID: widget.orderID, total: i),
                ),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 8,
                  children: orderItems(snap),
                  shrinkWrap: true,
                ),
              ]),
            );
          }),
    );
  }
}
