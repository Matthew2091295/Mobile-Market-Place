import 'package:flutter/material.dart';
import 'package:market_place/Drawer.dart';
import 'package:market_place/Staggered.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(206, 166, 97, 1.0),
        title: Text("Market Place"),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: 380.0,
              margin: EdgeInsets.only(top: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search products,brands...",
                  filled: true,
                  hoverColor: Colors.blue,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),

    );
  }
}