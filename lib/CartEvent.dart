import 'package:flutter/material.dart';

abstract class CartEvent {}

class AddToTotal extends CartEvent {
  double price;
  AddToTotal({@required this.price});
}

class RemoveFromTotal extends CartEvent {
  double price;
  RemoveFromTotal({@required this.price});
}
