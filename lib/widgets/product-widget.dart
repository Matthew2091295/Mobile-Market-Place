import 'package:flutter/material.dart';
import 'package:market_place/pallete.dart';

class Product extends StatelessWidget {
  const Product({
    Key key,
    //Image
    @required this.name,
    @required this.price,
    @required this.description,
    @required this.quantity,
  }) : super(key: key);
  final String name;
  final int quantity;
  final double price;
  final String description;

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
                Image(
                  image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                  height: 100,
                  width: 100,
                  fit: BoxFit.scaleDown,
                ),
                Text(this.name),
                Text("R" + this.price.toString()),
                Text("Quantity: " + this.quantity.toString()),
                ElevatedButton(onPressed: () {}, child: Text("More"))
              ],
            ),
          )),
    );
  }
}
