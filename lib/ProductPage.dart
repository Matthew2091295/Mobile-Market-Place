import 'package:flutter/material.dart';
import 'package:market_place/Drawer.dart';
import 'package:market_place/widgets/widgets.dart';

class ProductPage extends StatelessWidget {
  const ProductPage(
      {Key key,
      @required this.name,
      @required this.description,
      @required this.price,
      @required this.quantity})
      : super(key: key);

  final String name;
  final String description;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Image.asset("assets/images/Clothes/Belt.jpg"),
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
                      onPressed: () {},
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
