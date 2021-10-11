import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:market_place/Providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'package:market_place/Globals.dart' as Globals;

final double padding = 8.0;

final lightGrey = Color(0xFFCFCFCF);
final darkGrey = Color(0xFF535353);

final lightYellow = Color(0xFFDFC598);
final darkYellow = Color(0xFFCEA661);

final currencyFormat = new NumberFormat("#,##0.00", "en_US");

class Checkout extends StatefulWidget {
  Checkout({
    Key key,
  }) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  deleteCart() async {
    String url = Globals.url + "deleteCart.php";

    Map<String, String> parameters = {
      'username': Globals.username,
    };
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;
    await http.get(requestUrl, headers: headers);
  }

  changeTotalAndCount(double total, double count) async {
    String url = Globals.url + "changeTotalAndCount.php";

    Map<String, String> parameters = {
      'username': Globals.username,
      'total': total.toString(),
      'item_count': count.toString(),
    };
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;
    await http.get(requestUrl, headers: headers);
  }

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

  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController suburbController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double height = contextHeight * 0.18;

    double total;
    double wallet;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Checkout"),
          backgroundColor: darkYellow,
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: padding,
                  top: padding,
                  right: padding,
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Delivery Address",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    left: padding,
                    top: padding * 2,
                    right: padding,
                  ),
                  child: StreetAddress(streetAddressController)),
              Padding(
                padding: EdgeInsets.only(
                  left: padding,
                  top: padding,
                  right: padding,
                ),
                child: Suburb(suburbController),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: padding,
                  top: padding,
                  right: padding,
                ),
                child: City(cityController),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: padding,
                  top: padding,
                  right: padding,
                ),
                child: Province(provinceController),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: padding,
                  top: padding,
                  right: padding,
                ),
                child: PostCode(postCodeController),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          Container(
            padding: EdgeInsets.all(padding),
            width: double.infinity,
            height: height,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "Wallet:",
                            style: TextStyle(
                              color: darkYellow,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Spacer(),
                      Consumer(builder: (context, watch, child) {
                        final _wallet = watch(walletProvider).wallet;
                        wallet = _wallet;
                        return RichText(
                          text: TextSpan(
                              text: "R" + currencyFormat.format(_wallet),
                              style: TextStyle(
                                color: darkYellow,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                        );
                      }),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "Total:",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Spacer(),
                      Consumer(builder: (context, watch, child) {
                        final _total = watch(totalProvider).total;
                        total = _total;
                        return RichText(
                          text: TextSpan(
                              text: "R" + currencyFormat.format(_total),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                        );
                      }),
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: darkYellow,
                      textStyle: const TextStyle(fontSize: 24),
                    ),
                    onPressed: () async {
                      if (validateInformation(
                          streetAddressController,
                          suburbController,
                          cityController,
                          provinceController,
                          postCodeController)) {
                        if (wallet < total) {
                          var insufficientFundsDialog =
                              AlertDialogInsufficientFunds();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  insufficientFundsDialog);
                        } else {
                          deleteCart();
                          removeFromWallet(total);
                          changeTotalAndCount(0, 0);

                          context.read(walletProvider).removeFromWallet(total);
                          context.read(totalProvider).removeFromTotal(total);
                          context.read(countProvider).clearCount();

                          var submitOrderDialog = AlertDialogSubmitOrder();
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  submitOrderDialog);

                          Navigator.pop(context);
                        }
                      } else {
                        var emptyFieldsDialog = AlertDialogEmptyFields();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                emptyFieldsDialog);
                      }
                    },
                    child: const Text('Confirm Order'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StreetAddress extends StatelessWidget {
  const StreetAddress(this.streetAddressController);
  final TextEditingController streetAddressController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: streetAddressController,
      style: TextStyle(
        color: darkGrey,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: lightGrey,
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
        hintText: "Street Address",
        hintStyle: TextStyle(
          color: darkYellow,
          fontSize: 16,
        ),
      ),
    );
  }
}

class Suburb extends StatelessWidget {
  const Suburb(this.suburbController);
  final TextEditingController suburbController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: suburbController,
      style: TextStyle(
        color: darkGrey,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: lightGrey,
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
        hintText: "Suburb",
        hintStyle: TextStyle(
          color: darkYellow,
          fontSize: 16,
        ),
      ),
    );
  }
}

class City extends StatelessWidget {
  const City(this.cityController);
  final TextEditingController cityController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: cityController,
      style: TextStyle(
        color: darkGrey,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: lightGrey,
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
        hintText: "City",
        hintStyle: TextStyle(
          color: darkYellow,
          fontSize: 16,
        ),
      ),
    );
  }
}

class Province extends StatelessWidget {
  const Province(this.provinceController);
  final TextEditingController provinceController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: provinceController,
      style: TextStyle(
        color: darkGrey,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: lightGrey,
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
        hintText: "Province",
        hintStyle: TextStyle(
          color: darkYellow,
          fontSize: 16,
        ),
      ),
    );
  }
}

class PostCode extends StatelessWidget {
  const PostCode(this.postCodeController);
  final TextEditingController postCodeController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: postCodeController,
      maxLength: 4,
      keyboardType: TextInputType.phone,
      style: TextStyle(
        color: darkGrey,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: lightGrey,
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
        hintText: "Post Code",
        hintStyle: TextStyle(
          color: darkYellow,
          fontSize: 16,
        ),
      ),
    );
  }
}

bool validateInformation(
    TextEditingController streetAddressController,
    TextEditingController suburbController,
    TextEditingController cityController,
    TextEditingController provinceController,
    TextEditingController postCodeController) {
  bool validInformation = true;

  if (streetAddressController.text.isEmpty) {
    validInformation = false;
  }

  if (suburbController.text.isEmpty) {
    validInformation = false;
  }

  if (cityController.text.isEmpty) {
    validInformation = false;
  }

  if (provinceController.text.isEmpty) {
    validInformation = false;
  }

  if (postCodeController.text.isEmpty) {
    validInformation = false;
  }

  return validInformation;
}

class AlertDialogEmptyFields extends StatelessWidget {
  const AlertDialogEmptyFields();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Empty Fields"),
      content: new Text("All fields must be filled in"),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new TextButton(
          child: new RichText(
              text: TextSpan(
            text: "OK",
            style: TextStyle(
                color: darkYellow, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
  }
}

class AlertDialogInsufficientFunds extends StatelessWidget {
  const AlertDialogInsufficientFunds();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Insufficient Funds"),
      content: new Text(
          "There is not enough funds in the wallet to complete this transaction"),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new TextButton(
          child: new RichText(
              text: TextSpan(
            text: "OK",
            style: TextStyle(
                color: darkYellow, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
  }
}

class AlertDialogSubmitOrder extends StatelessWidget {
  const AlertDialogSubmitOrder();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Order Completed"),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new TextButton(
          child: new RichText(
              text: TextSpan(
            text: "OK",
            style: TextStyle(
                color: darkYellow, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
  }
}
