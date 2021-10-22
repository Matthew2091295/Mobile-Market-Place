import 'package:flutter/material.dart';
import 'package:market_place/Login.dart';
import 'package:market_place/UserPage.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/Providers.dart';

import 'Globals.dart' as Globals;

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userNames = '';
    if ((Globals.firstName != null) && (Globals.lastName != null)) {
      userNames = Globals.firstName + " " + Globals.lastName;
    } else {
      userNames = "Test test";
    }
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: Color.fromRGBO(206, 166, 97, 1.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/4.jpg",
                          ),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Text(
                    userNames,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${Globals.username ?? "Empty"}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              "Profile",
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              "Settings",
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              "Logout",
              style: TextStyle(fontSize: 18.0),
            ),
            onTap: () {
              context.read(cartProvider).clearCart();
              context.read(countProvider).clearCount();
              context.read(quantityProvider).clearQuantities();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Login()));
            },
          ),
        ],
      ),
    );
  }
}
