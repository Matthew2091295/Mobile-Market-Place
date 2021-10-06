import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:market_place/ViewMorePage.dart';
import 'package:market_place/widgets/widgets.dart';
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getMethod() async {
    String theUrl =
        "https://lamp.ms.wits.ac.za/home/s1854457/getItems.php"; //connecting to Wits database
    var res = await http
        .get(Uri.encodeFull(theUrl), headers: {"Accept": "application/json"});
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
    final childrenCat = [];
    for (var i = 0; i < 5; i++) {
      final childrenProd = <Widget>[];
      //For each catagory
      for (var j = 0; j < 5; j++) {
        childrenProd.add(Product(
          name: i.toString(),
          price: 1,
          description: "description",
          quantity: 1,
        ));
      }
      childrenCat.add(childrenProd);
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(206, 166, 97, 1.0),
          title: Text("Market Place"),
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
              return ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    "Clothes",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 200,
                  child: (ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: returnProduct("Clothes", snap),
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ViewMore(cat: "Clothes")));
                      },
                      child: Text("View More"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(140, 36),
                          primary: Color.fromRGBO(206, 166, 97, 1.0)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    "Food",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 225,
                  child: (ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: returnProduct("Food", snap),
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ViewMore(cat: "Food")));
                        },
                        child: Text("View More"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(140, 36),
                            primary: Color.fromRGBO(206, 166, 97, 1.0))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    "Games",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 225,
                  child: (ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: returnProduct("Games", snap),
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ViewMore(cat: "Games")));
                        },
                        child: Text("View More"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(140, 36),
                            primary: Color.fromRGBO(206, 166, 97, 1.0))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    "Sports",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 225,
                  child: (ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: returnProduct("Sports", snap),
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ViewMore(cat: "Sports")));
                        },
                        child: Text("View More"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(140, 36),
                            primary: Color.fromRGBO(206, 166, 97, 1.0))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    "Technology",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 225,
                  child: (ListView(
                    // This next line does the trick.
                    scrollDirection: Axis.horizontal,
                    children: returnProduct("Technology", snap),
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ViewMore(cat: "Technology")));
                        },
                        child: Text("View More"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(140, 36),
                            primary: Color.fromRGBO(206, 166, 97, 1.0))),
                  ],
                ),
              ]);
            }));
  }
}
