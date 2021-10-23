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

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

getMethod() async {
  String theUrl =
      "https://lamp.ms.wits.ac.za/home/s1854457/getItems.php"; //connecting to Wits database
  var res = await http
      .get(Uri.parse(theUrl), headers: {"Accept": "application/json"});
  var responseBody = json.decode(res.body);

  print(responseBody);

  return responseBody;
}

orderItem(productID, name, price, description, quantity) {
  String path = "assets/images/" + productID.toString() + ".jpg";
  return Builder(
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(path, height: 100, width: 100, fit: BoxFit.scaleDown,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace stackTrace) {
              return Text('Error fetching Image');
            }),
            Text(name),
          ],
        ),
      );
    },
  );
}

returnOrder() {
  //Need to get it to pull an order out of a list of order items
  final arr = <Widget>[];
  for (int i = 4; i < 9; i++) {
    arr.add(orderItem(i, "Shoes", 10, "description", 10));
  }
  return arr;
}

listOfOrders() {
  //Would have an orderID, uses it to pull from database and then calls return order for each
  /*
  psuedocode:
  for orders in snap:
    if order.user = userID:
      arr.add(returnOrder(order.items))
  */
  final orderList = <Widget>[];

  for (int i = 0; i < 5; i++) {
    orderList.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 200,
          child: Column(children: [
            Text(
              "Order Number: ",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                  scrollDirection: Axis.horizontal, children: returnOrder()),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  "Total: R200",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ])),
    ));
    orderList.add(Divider(
      height: 20,
      thickness: 5,
      indent: 20,
      endIndent: 20,
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
        body: ListView(
          children: listOfOrders(),
        ));
  }
}
