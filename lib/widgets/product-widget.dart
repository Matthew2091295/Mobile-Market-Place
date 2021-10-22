import 'package:flutter/material.dart';
import 'package:market_place/ProductPage.dart';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/Providers.dart';

import 'package:http/http.dart' as http;
import 'package:market_place/Globals.dart' as Globals;

class Product extends StatelessWidget {
  const Product(
      {Key key,
      //Image
      @required this.productID,
      @required this.name,
      @required this.price,
      @required this.description,
      @required this.quantity,
      this.image})
      : super(key: key);
  final int productID;
  final String name;
  final int quantity;
  final double price;
  final String description;
  final String image;

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

  @override
  Widget build(BuildContext context) {
    String path = "assets/images/" + this.productID.toString() + ".jpg";
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ProductPage(
                      name: this.name,
                      description: this.description,
                      price: this.price,
                      quantity: this.quantity,
                      productID: this.productID,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(path,
                    height: 100,
                    width: 100,
                    fit: BoxFit.scaleDown, errorBuilder: (BuildContext context,
                        Object exception, StackTrace stackTrace) {
                  return Text('Error fetching Image');
                }),
                Text(this.name),
                Text("R" + this.price.toStringAsFixed(2)),
                Text("Quantity: " + this.quantity.toString()),
                ElevatedButton(
                    onPressed: () {
                      addToCart(productID);
                      context
                          .read(cartProvider)
                          .addToCart(productID, this.price.toDouble());
                      context
                          .read(quantityProvider)
                          .changeQuantity(productID, 1);
                      context
                          .read(totalProvider)
                          .addToTotal(this.price.toDouble());
                      context.read(countProvider).addToCount(1);
                    },
                    child: Text("Add to cart"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
