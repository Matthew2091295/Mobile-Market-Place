import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/painting.dart';
import 'package:market_place/Providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'Globals.dart' as Globals;

final double padding = 8.0;

final lightGrey = Color(0xFFCFCFCF);
final darkGrey = Color(0xFF535353);

final lightYellow = Color(0xFFDFC598);
final darkYellow = Color(0xFFCEA661);

final currencyFormat = new NumberFormat("#,##0.00", "en_US");

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double profilePictureRatio = contextHeight * 0.2;

    final innerHeight = contextHeight * 0.325;

    String fullNames = "Full Names";
    String username = "Username";
    String birthDate = "";

    if ((Globals.firstName != null) && (Globals.lastName != null)) {
      fullNames = Globals.firstName + " " + Globals.lastName;
    }
    if (Globals.username != null) {
      username = Globals.username;
    }
    if (Globals.birthDate != null) {
      birthDate = Globals.birthDate;
    }

    final TextEditingController addController = TextEditingController();
    final TextEditingController removeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("User Page"),
        backgroundColor: lightYellow,
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.only(left: padding, top: padding, right: padding),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              lightYellow,
              darkYellow,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    height: innerHeight,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          top: (profilePictureRatio) / 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  top: (profilePictureRatio / 2) + padding,
                                  child: Center(
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      spacing: 0.2,
                                      runSpacing: 0.2,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            // USER FULL NAMES
                                            RichText(
                                              text: TextSpan(
                                                text: fullNames,
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: darkYellow,
                                                ),
                                              ),
                                            ),

                                            // USER EMAIL ADDRESS
                                            RichText(
                                              text: TextSpan(
                                                text: username,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkGrey,
                                                ),
                                              ),
                                            ),

                                            // USER BIRTH DATE
                                            RichText(
                                              text: TextSpan(
                                                text: birthDate,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: darkGrey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          child: Container(
                            height: profilePictureRatio,
                            width: profilePictureRatio,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://img.favpng.com/2/24/4/user-profile-computer-icons-png-favpng-6CB3By2TFDKyEjfXFbx3LaRR5.jpg',
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: padding * 2,
                    ),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(padding * 2),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: "Wallet",
                                      style: TextStyle(
                                        color: darkGrey,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Consumer(builder: (context, watch, child) {
                                    final _wallet =
                                        watch(walletProvider).wallet;
                                    return RichText(
                                      text: TextSpan(
                                        text: "R" +
                                            currencyFormat.format(_wallet),
                                        style: TextStyle(
                                          color: darkYellow,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(padding * 2),
                              height: 140,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: darkYellow,
                                        textStyle: const TextStyle(
                                          fontSize: 24,
                                        ),
                                      ),
                                      onPressed: () {
                                        var textInputDialog =
                                            AddDialog(addController);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                textInputDialog);
                                      },
                                      child: const Text('Add'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: padding,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: darkYellow,
                                        textStyle: const TextStyle(
                                          fontSize: 24,
                                        ),
                                      ),
                                      onPressed: () {
                                        var textRemoveDialog =
                                            RemoveDialog(removeController);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                textRemoveDialog);
                                      },
                                      child: const Text('Remove'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddDialog extends StatelessWidget {
  const AddDialog(this.addController);
  final TextEditingController addController;

  addToWallet(double wallet) async {
    String url = Globals.url + "addToWallet.php";

    Map<String, String> parameters = {
      'username': Globals.username,
      'wallet': wallet.toString(),
    };
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;
    await http.get(requestUrl, headers: headers);
  }

  bool validAmount(String value) {
    bool _valid = true;

    if (value.isEmpty) {
      _valid = false;
    }

    RegExp regExp = new RegExp("^(([0-9]+)((.[0-9]{2})?))");

    if ((!regExp.hasMatch(value)) || (value == ".")) {
      _valid = false;
    }

    return _valid;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enter Amount"),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      content: TextField(
        controller: addController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: darkYellow,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: darkYellow,
              width: 2.0,
            ),
          ),
          hintText: "Enter amount to add",
          hintStyle: TextStyle(
            color: darkYellow,
            fontSize: 16,
          ),
        ),
      ),
      actions: <Widget>[
        new TextButton(
          child: new RichText(
              text: TextSpan(
            text: "Cancel",
            style: TextStyle(
                color: darkYellow, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        new TextButton(
          child: new RichText(
              text: TextSpan(
            text: "OK",
            style: TextStyle(
                color: darkYellow, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          onPressed: () {
            if (validAmount(addController.text)) {
              double amount = double.parse(addController.text);
              addToWallet(amount);
              context.read(walletProvider).addToWallet(amount);
              Navigator.of(context, rootNavigator: true).pop();
            } else {
              showToast(context);
            }
          },
        ),
      ],
    );
  }

  void showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: RichText(
          text: TextSpan(
            text: "Please enter a valid amount",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class RemoveDialog extends StatelessWidget {
  const RemoveDialog(this.removeController);
  final TextEditingController removeController;

  removeFromWallet(double wallet) async {
    String url = Globals.url + "removeFromWallet.php";

    Map<String, String> parameters = {
      'username': Globals.username,
      'wallet': wallet.toString(),
    };
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;
    await http.get(requestUrl, headers: headers);
  }

  @override
  Widget build(BuildContext context) {
    bool validAmount(String value) {
      bool _valid = true;

      if (value.isEmpty) {
        _valid = false;
      }

      RegExp regExp = new RegExp("^(([0-9]+)((.[0-9]{2})?))");

      double wallet = context.read(walletProvider).wallet;

      if ((!regExp.hasMatch(value)) ||
          (value == ".") ||
          ((wallet - double.tryParse(value)) < 0)) {
        _valid = false;
      }

      return _valid;
    }

    return AlertDialog(
      title: Text("Enter Amount"),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      content: TextField(
        controller: removeController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: darkYellow,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: darkYellow,
              width: 2.0,
            ),
          ),
          hintText: "Enter amount to remove",
          hintStyle: TextStyle(
            color: darkYellow,
            fontSize: 16,
          ),
        ),
      ),
      actions: <Widget>[
        new TextButton(
          child: new RichText(
              text: TextSpan(
            text: "Cancel",
            style: TextStyle(
                color: darkYellow, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        new TextButton(
          child: new RichText(
              text: TextSpan(
            text: "OK",
            style: TextStyle(
                color: darkYellow, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          onPressed: () {
            if (validAmount(removeController.text)) {
              double amount = double.parse(removeController.text);
              removeFromWallet(amount);
              context.read(walletProvider).removeFromWallet(amount);
              Navigator.of(context, rootNavigator: true).pop();
            } else {
              showToast(context);
            }
          },
        ),
      ],
    );
  }

  void showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: RichText(
          text: TextSpan(
            text: "Please enter a valid amount",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
