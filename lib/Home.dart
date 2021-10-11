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

  listDefault() {
    List d = [
      {
        "itemid": "4",
        "name": "Shoes",
        "description": "A pair of shoes",
        "stock_remaining": "100",
        "category": "Clothes",
        "price": "100"
      },
      {
        "itemid": "5",
        "name": "Bread",
        "description": "A loaf of bread",
        "stock_remaining": "100",
        "category": "Food",
        "price": "10"
      },
      {
        "itemid": "6",
        "name": "Cards",
        "description": "A deck of cards",
        "stock_remaining": "100",
        "category": "Games",
        "price": "50"
      },
      {
        "itemid": "7",
        "name": "Rugby ball",
        "description": "A Rugby Ball",
        "stock_remaining": "100",
        "category": "Sports",
        "price": "40"
      },
      {
        "itemid": "8",
        "name": "Keyboard",
        "description": "A keyboard",
        "stock_remaining": "100",
        "category": "Technology",
        "price": "200"
      },
      {
        "itemid": "9",
        "name": "Belt",
        "description": "A belt",
        "stock_remaining": "100",
        "category": "Clothes",
        "price": "100"
      },
      {
        "itemid": "10",
        "name": "Pants",
        "description": "A pair of pants",
        "stock_remaining": "100",
        "category": "Clothes",
        "price": "250"
      },
      {
        "itemid": "11",
        "name": "Shirt",
        "description": "A shirt",
        "stock_remaining": "100",
        "category": "Clothes",
        "price": "150"
      },
      {
        "itemid": "12",
        "name": "Socks",
        "description": "A pair of socks",
        "stock_remaining": "100",
        "category": "Clothes",
        "price": "50"
      },
      {
        "itemid": "13",
        "name": "Cake",
        "description": "A cake",
        "stock_remaining": "100",
        "category": "Food",
        "price": "75"
      },
      {
        "itemid": "14",
        "name": "Chocolate",
        "description": "A bar of chocolate",
        "stock_remaining": "100",
        "category": "Food",
        "price": "20"
      },
      {
        "itemid": "15",
        "name": "Mentos",
        "description": "A tube of Mentos",
        "stock_remaining": "100",
        "category": "Food",
        "price": "30"
      },
      {
        "itemid": "16",
        "name": "Sprite",
        "description": "A bottle of Sprite",
        "stock_remaining": "100",
        "category": "Food",
        "price": "18"
      },
      {
        "itemid": "17",
        "name": "Monopoly",
        "description": "Monopoly board game",
        "stock_remaining": "100",
        "category": "Games",
        "price": "300"
      },
      {
        "itemid": "18",
        "name": "Puzzle",
        "description": "A puzzle",
        "stock_remaining": "100",
        "category": "Games",
        "price": "100"
      },
      {
        "itemid": "19",
        "name": "Rummy",
        "description": "Rummy board game",
        "stock_remaining": "100",
        "category": "Games",
        "price": "250"
      },
      {
        "itemid": "20",
        "name": "Snakes and ladders",
        "description": "Snakes and ladders board game",
        "stock_remaining": "100",
        "category": "Games",
        "price": "180"
      },
      {
        "itemid": "21",
        "name": "Rugby shirt",
        "description": "A rugby shirt",
        "stock_remaining": "100",
        "category": "Sports",
        "price": "500"
      },
      {
        "itemid": "22",
        "name": "Soccer ball",
        "description": "A soccor ball",
        "stock_remaining": "100",
        "category": "Sports",
        "price": "150"
      },
      {
        "itemid": "23",
        "name": "Soccer shirt",
        "description": "A soccor shirt",
        "stock_remaining": "100",
        "category": "Sports",
        "price": "450"
      },
      {
        "itemid": "24",
        "name": "Tennis racket",
        "description": "A tennis racket",
        "stock_remaining": "100",
        "category": "Sports",
        "price": "385"
      },
      {
        "itemid": "25",
        "name": "Headphones",
        "description": "A pair of headphones",
        "stock_remaining": "100",
        "category": "Technology",
        "price": "500"
      },
      {
        "itemid": "26",
        "name": "Laptop",
        "description": "A expensive Laptop",
        "stock_remaining": "100",
        "category": "Technology",
        "price": "2000"
      },
      {
        "itemid": "27",
        "name": "Phone",
        "description": "A samsung phone",
        "stock_remaining": "100",
        "category": "Technology",
        "price": "1000"
      },
      {
        "itemid": "28",
        "name": "Tablet",
        "description": "An apple tablet",
        "stock_remaining": "100",
        "category": "Technology",
        "price": "1500"
      },
      {
        "itemid": "29",
        "name": "Catmor - Dry Cat Food - Tuna -",
        "description": "Cat Food Adult 4kg",
        "stock_remaining": "95",
        "category": "Food",
        "price": "125"
      }
    ];
    return d;
  }

  returnProduct(String cat, List snap) {
    final arr = <Widget>[];
    int i = 0;
    int r = 0;
    if (snap?.isEmpty ?? true) {
      snap = listDefault();
    }
    while (r < 5) {
      i++;
      if (snap[i]['category'] == cat && snap[i]['name'] != "NULL") {
        r++;
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
          productID: 0,
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
              if (snapshot.hasError) {}
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
                  height: 225,
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
