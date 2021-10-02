import 'package:flutter/material.dart';

class CartNotifier extends ChangeNotifier {
  double _total = 0;
  double get total => _total;

  // TEMPORARY
  double _initialTotal = 12803;
  CartNotifier() {
    _total = _initialTotal;
  }

  void addToTotal(double price) {
    _total += price;
    notifyListeners();
  }

  void removeFromTotal(double price) {
    _total -= price;
    notifyListeners();
  }
}
