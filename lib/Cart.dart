import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:market_place/Checkout.dart';
import 'package:market_place/Globals.dart' as Globals;
import 'package:market_place/Providers.dart';
import 'package:market_place/widgets/CartItem.dart';

final double padding = 8.0;

final lightGrey = Color(0xFFA0A0A0);
final darkGrey = Color(0xFF535353);

final lightYellow = Color(0xFFDFC598);
final darkYellow = Color(0xFFCEA661);

final currencyFormat = new NumberFormat("#,##0.00", "en_US");

class Cart extends StatefulWidget {
  const Cart({
    Key key,
  }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  getCart() async {
    String url = Globals.url + "getCart.php";

    Map<String, String> parameters = {
      'username': Globals.username,
    };
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;
    var response = await http.get(Uri.parse(requestUrl), headers: headers);
    var responseBody = json.decode(response.body);

    return responseBody;
  }

  deleteFromCart(int productID) async {
    String url = Globals.url + "deleteFromCart.php";

    Map<String, String> parameters = {
      'itemID': productID.toString(),
      'username': Globals.username,
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

    return FutureBuilder(
        future: getCart(), //retrieving data from database
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<int> _cart = [];

            for (int i = 0; i < snapshot.data.length; i++) {
              _cart.add(snapshot.data[i]["itemid"]);
            }

            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Cart"),
                  backgroundColor: darkYellow,
                  automaticallyImplyLeading: false,
                ),
                body: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      left: padding, top: padding, right: padding),
                  child: ListView.builder(
                    itemCount: _cart.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              int productID = _cart[index];

                              setState(() {});

                              setState(() {
                                _cart.remove(index);
                              });
                              deleteFromCart(productID);

                              double _price = context
                                  .read(quantityProvider)
                                  .getCartPrice(productID);

                              double _count = context
                                  .read(quantityProvider)
                                  .getCartQuantity(productID);

                              double _total = _price * _count;

                              context
                                  .read(totalProvider)
                                  .removeFromTotal(_count * _total);

                              context.read(countProvider).deleteCount(_count);

                              double total = context.read(totalProvider).total;
                              double count = context.read(countProvider).count;

                              changeTotalAndCount(total, count);
                            },
                            child: new CartItem(productID: _cart[index])),
                  ),
                ),
                persistentFooterButtons: [
                  Column(
                    children: [
                      Container(
                        height: iconHeight / 2.65,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Total:",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Consumer(
                                  builder: (context, watch, child) {
                                    final _total = watch(totalProvider).total;
                                    return Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: "R" +
                                              currencyFormat.format(_total),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Consumer(builder: (context, watch, child) {
                              final _count = watch(countProvider).count;

                              return Align(
                                alignment: Alignment.topLeft,
                                child: RichText(
                                  text: TextSpan(
                                    text: "(" +
                                        _count.round().toString() +
                                        " Items)",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
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
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Checkout()))
                                .then((value) {
                              setState(() {
                                _cart.clear();
                              });
                            });
                          },
                          child: const Text('Checkout'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          } else {
            return new LinearProgressIndicator(
                color: darkYellow, backgroundColor: lightGrey);
          }
        });
  }
}
