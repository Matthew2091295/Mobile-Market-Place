import 'package:flutter/material.dart';

class TotalNotifier extends ChangeNotifier {
  double _total = 0;
  double get total => _total;

  // TEMPORARY
  double _initialTotal = 12803;
  TotalNotifier() {
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

class WalletNotifier extends ChangeNotifier {
  double _wallet = 0;
  double get wallet => _wallet;

  WalletNotifier() {
    _wallet = 12000;
  }

  void addToWallet(double amount) {
    _wallet += amount;
    notifyListeners();
  }

  void removeFromWallet(double amount) {
    _wallet -= amount;
    notifyListeners();
  }
}

class QuantityNotifier extends ChangeNotifier {
  var _cart = <int, double>{};

  get cart => _cart;

  getCartQuantity(int productID) {
    return _cart[productID];
  }

  void changeCart(int productID, double quantity) {
    _cart[productID] = quantity;
    notifyListeners();
  }

  void deleteCart(int productID) {
    _cart.remove(productID);
  }
}
