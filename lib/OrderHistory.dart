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

createSnap() {
  return [
    {"order_history_id": "1"}
  ];
}

listOfOrders(BuildContext context, List snap) {
  final orderList = <Widget>[];

  if (snap?.isEmpty ?? true) {
    snap = createSnap();
  }

  for (int i = 0; i < snap.length; i++) {
    orderList.add(Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
          height: 200,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Order Number: " + (i + 1).toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => OrderScreen(
                                orderID:
                                    int.parse(snap[i]['order_history_id']))));
                  },
                  child: OrderItem(
                    orderID: int.parse(snap[i]['order_history_id']),
                  ),
                ),
              ),
              Divider(
                thickness: 2,
              ),
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
