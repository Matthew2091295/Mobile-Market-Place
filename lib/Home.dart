import 'package:flutter/material.dart';
import 'package:market_place/Drawer.dart';
import 'package:market_place/widgets/widgets.dart';
import 'package:tuple/tuple.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var categories = {
    "Clothes": [
      Tuple2<String, double>("Shirt", 400),
      Tuple2<String, double>("Pants", 500),
      Tuple2<String, double>("Belt", 200),
      Tuple2<String, double>("Socks", 150),
      Tuple2<String, double>("Shoes", 300)
    ],
    "Food": [
      Tuple2<String, double>("Chocolate", 200),
      Tuple2<String, double>("Bread", 30),
      Tuple2<String, double>("Sprite", 20),
      Tuple2<String, double>("Mentos", 25),
      Tuple2<String, double>("Cake", 100)
    ],
    "Games": [
      Tuple2<String, double>("Monopoly", 200),
      Tuple2<String, double>("Wood Puzzles", 130),
      Tuple2<String, double>("Snakes and Ladders", 99),
      Tuple2<String, double>("Cards", 25),
      Tuple2<String, double>("Rummy", 150)
    ],
    "Sports": [
      Tuple2<String, double>("Soccer Ball", 500),
      Tuple2<String, double>("Rugby Ball", 180),
      Tuple2<String, double>("Chelsea Shirt", 800),
      Tuple2<String, double>("SA Rugby Shirt", 400),
      Tuple2<String, double>("Tennis Set", 2000)
    ],
    "Technology": [
      Tuple2<String, double>("iPhone", 19000),
      Tuple2<String, double>("Laptop", 6000),
      Tuple2<String, double>("iPad", 5000),
      Tuple2<String, double>("Headphones", 200),
      Tuple2<String, double>("USB", 150)
    ]
  };

  returnProduct(String cat) {
    var products = categories[cat];
    final arr = <Widget>[];
    for (var p in products) {
      arr.add(Product(
        name: p.item1,
        price: p.item2,
        description: "",
        quantity: 0,
      ));
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
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              "Clothes",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 225,
            child: (ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: returnProduct("Clothes"),
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
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
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 225,
            child: (ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: returnProduct("Food"),
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {},
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
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 225,
            child: (ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: returnProduct("Games"),
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {},
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
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 225,
            child: (ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: returnProduct("Sports"),
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {},
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
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 225,
            child: (ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: returnProduct("Technology"),
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  child: Text("View More"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(140, 36),
                      primary: Color.fromRGBO(206, 166, 97, 1.0))),
            ],
          ),
        ]));
  }
}
