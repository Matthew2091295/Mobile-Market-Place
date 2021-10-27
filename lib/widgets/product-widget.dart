import 'package:flutter/material.dart';
import 'package:market_place/ProductPage.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/Providers.dart';

import 'package:market_place/HTTP.dart';

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

                        ChangeCart().changeCart(productID, quantity);
                      } else {
                        AddToCart().addToCart(productID);
                        context
                            .read(cartProvider)
                            .addToCart(productID, this.price.toDouble());
                        context
                            .read(quantityProvider)
                            .changeQuantity(productID, 1);
                      }

                      showDialog(
                        // display dialog "product added!"
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: new Text("Product added!"),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );

                      context
                          .read(totalProvider)
                          .addToTotal(this.price.toDouble());
                      context.read(countProvider).addToCount(1);

                      double total = context.read(totalProvider).total;
                      double count = context.read(countProvider).count;

                      ChangeTotalAndCount().changeTotalAndCount(total, count);
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
