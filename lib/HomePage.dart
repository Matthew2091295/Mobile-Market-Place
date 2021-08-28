
import 'package:flutter/material.dart';
import 'package:market_place/Categories.dart';
import 'package:market_place/Drawer.dart';
import 'package:market_place/Home.dart';
import 'package:market_place/Lists.dart';
import 'package:market_place/More.dart';

import 'Login.dart';
import 'Registration.dart';
import 'UserPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [Home(), Categories(), Lists(), More()];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MainDrawer(),
        body: _children[_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.white,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(206, 166, 97, 1.0),
          //iconSize: 30,
          //selectedFontSize: 15,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text("Categories"),
              backgroundColor: Colors.grey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_toggle_off_outlined),
              title: Text("Deals"),
              backgroundColor: Colors.yellow,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("Lists"),
              backgroundColor: Colors.pink,
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
