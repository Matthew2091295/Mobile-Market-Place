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
import 'package:market_place/ProductPage.dart';

import '../Globals.dart' as Globals;

class OrderItem extends StatefulWidget {
  const OrderItem({Key key, this.orderID}) : super(key: key);

  final int orderID;

  @override
  _OrderItemState createState() => _OrderItemState();
}

getItems(String orderID) async {
  String theUrl =
      "https://lamp.ms.wits.ac.za/home/s1854457/getOrderItems.php?orderID=" +
          orderID.toString(); //connecting to Wits database

  var res = await http
      .get(Uri.parse(theUrl), headers: {"Accept": "application/json"});

  var responseBody = json.decode(res.body);

  return responseBody;
}

orderItem(productID, name, price, description, quantity) {
  String path = "assets/images/" + productID.toString() + ".jpg";
  return Builder(
    builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ProductPage(
                        name: name,
                        description: description,
                        price: double.parse(price),
                        quantity: int.parse(quantity),
                        productID: int.parse(productID),
                      )));
        },
        child: Padding(
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
        ),
      );
    },
  );
}

orderItems(List snap) {
  final arr = <Widget>[];

  for (int i = 0; i < snap.length; i++) {
    print(snap[i]);
    arr.add(orderItem(snap[i]['itemid'], snap[i]['name'], snap[i]['price'], "",
        snap[i]['quantity']));
  }
  return arr;
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getItems(widget.orderID.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List snap = snapshot.data;
          print(snap);
          return ListView(
            scrollDirection: Axis.horizontal,
            children: orderItems(snap),
          );
        });
  }
}
