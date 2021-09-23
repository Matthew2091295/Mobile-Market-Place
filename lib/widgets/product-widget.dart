import 'package:flutter/material.dart';
import 'package:market_place/pallete.dart';
import 'package:market_place/ProductPage.dart';
import 'dart:io';

class Product extends StatelessWidget {
  const Product(
      {Key key,
      //Image
      @required this.name,
      @required this.price,
      @required this.description,
      @required this.quantity,
      this.image = ""})
      : super(key: key);
  final String name;
  final int quantity;
  final double price;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                Image.asset("assets/images/Clothes/Belt.jpg",
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ProductPage(
                                  name: this.name,
                                  description: this.description,
                                  price: this.price,
                                  quantity: this.quantity)));
                    },
                    child: Text("More"))
              ],
            ),
          )),
    );
  }
}
