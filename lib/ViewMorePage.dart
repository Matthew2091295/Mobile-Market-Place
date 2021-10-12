import 'package:flutter/material.dart';
import 'package:market_place/pallete.dart';
import 'package:market_place/ProductPage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:market_place/widgets/widgets.dart';

class ViewMore extends StatefulWidget {
  const ViewMore({@required this.cat, Key key}) : super(key: key);

  final String cat;

  String getCat() {
    return this.cat;
  }

  @override
  _ViewMoreState createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {
  getMethod() async {
    String theUrl =
        "https://lamp.ms.wits.ac.za/home/s1854457/getItems.php"; //connecting to Wits database
    var res = await http
        .get(Uri.parse(theUrl), headers: {"Accept": "application/json"});
    var responseBody = json.decode(res.body);

    print(responseBody);

    return responseBody;
  }

  returnProduct(String cat, List snap) {
    final arr = <Widget>[];
    for (int i = 0; i < snap.length; i++) {
      if (snap[i]['category'] == cat && snap[i]['name'] != "NULL") {
        print(snap[i]);
        arr.add(Product(
            productID: int.parse(snap[i]['itemid']),
            name: snap[i]['name'],
            price: double.parse(snap[i]['price']),
            description: snap[i]['description'],
            quantity: int.parse(snap[i]['stock_remaining'])));
      }
    }
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(this.widget.cat),
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
              return Container(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  childAspectRatio: 0.8,
                  children: returnProduct(widget.cat, snap),
                ),
              );
            }));
  }
}
