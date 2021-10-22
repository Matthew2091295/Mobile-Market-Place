import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:market_place/Providers.dart';
import 'package:spinner_input/spinner_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'package:market_place/Globals.dart' as Globals;

final double padding = 8.0;

final lightGrey = Color(0xFFA0A0A0);
final mediumGrey = Color(0xFF414141);
final darkGrey = Color(0xFF222222);

final lightYellow = Color(0xFFDFC598);
final darkYellow = Color(0xFFCEA661);

final currencyFormat = new NumberFormat("#,##0.00", "en_US");

class CartItem extends StatefulWidget {
  const CartItem({
    Key key,
    @required this.productID,
  }) : super(key: key);

  final int productID;

  @override
  _CartItem createState() => _CartItem(productID);
}

class _CartItem extends State<CartItem> {
  _CartItem(this.productID);
  final int productID;

  double quantity = 1;
  double oldSpinnerValue = 1;

  String productIcon;
  String productName;
  double productPrice;

  bool first = true;

  getProduct(int productID) async {
    String url = Globals.url + "getItem.php";

    Map<String, String> parameters = {
      'itemID': productID.toString(),
      'username': Globals.username,
    };
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;
    var response = await http.get(Uri.parse(requestUrl), headers: headers);
    var responseBody = json.decode(response.body);

    return responseBody;
  }

  changeCart(int productID, String newValue) async {
    String url = Globals.url + "changeCart.php";
    Map<String, String> parameters = {
      'itemID': productID.toString(),
      'username': Globals.username,
      'quantity': newValue,
    };

    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;
    await http.get(Uri.parse(requestUrl), headers: headers);
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
    await http.get(Uri.parse(requestUrl), headers: headers);
  }

  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double iconHeight = contextHeight * 0.18;

    int productIconFlex = 4;
    int productInfoFlex = 6;

    return FutureBuilder(
        future: getProduct(productID),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          double newPriceDouble = 0;
          String newPrice = "";

          if (snapshot.hasData) {
            productIcon = "assets/images/" + productID.toString() + ".jpg";
            productName = snapshot.data[0]["name"].trim();
            productPrice = snapshot.data[0]["price"].toDouble();

            if (first) {
              quantity = snapshot.data[1]["quantity"].toDouble();
              first = false;
            }

            newPriceDouble = productPrice * quantity;
            newPrice = currencyFormat.format(newPriceDouble);

            return Container(
              height: iconHeight * 1.12,
              width: double.infinity,
              child: Card(
                elevation: 0,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 0.2,
                  runSpacing: 0.2,
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: productIconFlex,
                                child: Container(
                                  height: iconHeight,
                                  padding: EdgeInsets.only(right: padding),
                                  child: Image.asset(productIcon,
                                      height: iconHeight,
                                      width: iconHeight,
                                      fit: BoxFit.contain),
                                ),
                              ),
                              Expanded(
                                flex: productInfoFlex,
                                child: Container(
                                  height: iconHeight,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          height: iconHeight,
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  text: TextSpan(
                                                    text: productName,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: "R" + newPrice,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Row(
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        text: "Qty: ",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: darkGrey,
                                                        ),
                                                      ),
                                                    ),
                                                    Consumer(builder: (context,
                                                        watch, child) {
                                                      double spinnerValue =
                                                          watch(quantityProvider)
                                                              .getQuantity(
                                                                  productID);

                                                      return SpinnerInput(
                                                        spinnerValue:
                                                            spinnerValue,
                                                        minValue: 1,
                                                        maxValue: 100,
                                                        step: 1,
                                                        disabledLongPress: true,
                                                        disabledPopup: true,
                                                        plusButton:
                                                            SpinnerButtonStyle(
                                                                color:
                                                                    darkYellow),
                                                        minusButton:
                                                            SpinnerButtonStyle(
                                                                color:
                                                                    darkYellow),
                                                        onChange: (newValue) {
                                                          setState(() {
                                                            oldSpinnerValue =
                                                                spinnerValue;
                                                            spinnerValue =
                                                                newValue;

                                                            quantity =
                                                                spinnerValue;

                                                            changeCart(
                                                                productID,
                                                                newValue
                                                                    .toString());

                                                            if (oldSpinnerValue >
                                                                spinnerValue) {
                                                              context
                                                                  .read(
                                                                      totalProvider)
                                                                  .removeFromTotal(
                                                                      productPrice);

                                                              context
                                                                  .read(
                                                                      countProvider)
                                                                  .removeFromCount(
                                                                      1);
                                                            } else {
                                                              context
                                                                  .read(
                                                                      totalProvider)
                                                                  .addToTotal(
                                                                      productPrice);

                                                              context
                                                                  .read(
                                                                      countProvider)
                                                                  .addToCount(
                                                                      1);
                                                            }

                                                            context
                                                                .read(
                                                                    quantityProvider)
                                                                .changeQuantity(
                                                                    productID,
                                                                    spinnerValue);

                                                            double _total = context
                                                                .read(
                                                                    totalProvider)
                                                                .total;

                                                            double _count = context
                                                                .read(
                                                                    countProvider)
                                                                .count;

                                                            changeTotalAndCount(
                                                                _total, _count);
                                                          });
                                                        },
                                                      );
                                                    })
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return new LinearProgressIndicator(
                color: darkYellow, backgroundColor: lightGrey);
          }
        });
  }
}
