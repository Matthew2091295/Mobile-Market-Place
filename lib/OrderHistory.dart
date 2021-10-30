import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:market_place/OrderScreen.dart';
import 'package:market_place/pallete.dart';
import 'package:market_place/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:market_place/HomePage.dart';
import 'package:market_place/Drawer.dart';

import 'Globals.dart' as Globals;

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

getMethod() async {
  String theUrl =
      "https://lamp.ms.wits.ac.za/home/s1854457/getOrder.php?user=" +
          Globals.username; //connecting to Wits database

  Map<String, String> params = {
    "Accept": "application/json",
    "user": Globals.username
  };
  var res = await http
      .get(Uri.parse(theUrl), headers: {"Accept": "application/json"});
  var responseBody = json.decode(res.body);

  print(responseBody);

  return responseBody;
}

listOfOrders(BuildContext context, List snap) {
  final orderList = <Widget>[];

  orderList.add(PDFButton());

  for (int i = 0; i < snap.length; i++) {
    orderList.add(Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
          height: 200,
          child: Column(
            children: [
              Text(
                "Order Number: " + (i + 1).toString(),
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: OrderItem(
                orderID: int.parse(snap[i]['order_history_id']),
              )),
            ],
          )),
    ));
  }
  return orderList;
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: const Text("Order History"),
          backgroundColor: Color.fromRGBO(206, 166, 97, 1.0),
        ),
        body: FutureBuilder(
            future: getMethod(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List snap = snapshot.data;
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error fetching Data"),
                );
              }
              return ListView(children: listOfOrders(context, snap));
            }));
  }
}
