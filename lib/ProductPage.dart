import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/Providers.dart';

import 'package:http/http.dart' as http;
import 'package:market_place/Globals.dart' as Globals;

class ProductPage extends StatelessWidget {
  const ProductPage(
      {Key key,
      @required this.name,
      @required this.description,
      @required this.price,
      @required this.quantity,
      @required this.productID})
      : super(key: key);

  final String name;
  final String description;
  final double price;
  final int quantity;
  final int productID;

  addToCart(int productID) async {
    String url = Globals.url + "addToCart.php";

    Map<String, String> parameters = {
      'itemID': productID.toString(),
      'username': Globals.username,
    };
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;
    await http.get(Uri.parse(requestUrl), headers: headers);
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
    String path = "assets/images/" + this.productID.toString() + ".jpg";
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Image.asset(path),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: const Divider(
                  height: 10,
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                ),
              ),
            ),
            Stack(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      this.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
              ),
            ]),
            Stack(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Price:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "R " + this.price.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
              ),
            ]),
            Stack(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Quantity:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      this.quantity.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
              ),
            ]),
            Stack(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    this.description,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      child: Text("Add to cart"),
                      onPressed: () {
                        bool exists =
                            context.read(quantityProvider).exists(productID);

                        if (exists) {
                          double quantity = context
                              .read(quantityProvider)
                              .getQuantity(productID);

                          quantity++;

                          context
                              .read(quantityProvider)
                              .changeQuantity(productID, quantity);

                          changeCart(productID, quantity.toString());
                        } else {
                          addToCart(productID);
                          context
                              .read(cartProvider)
                              .addToCart(productID, this.price.toDouble());
                          context
                              .read(quantityProvider)
                              .changeQuantity(productID, 1);
                        }

                        context
                            .read(totalProvider)
                            .addToTotal(this.price.toDouble());
                        context.read(countProvider).addToCount(1);

                        double total = context.read(totalProvider).total;
                        double count = context.read(countProvider).count;

                        changeTotalAndCount(total, count);
                      },
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
