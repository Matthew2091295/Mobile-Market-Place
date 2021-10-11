import 'package:flutter/material.dart';

class TotalNotifier extends ChangeNotifier {
  double _total = 0;
  double get total => _total;

  void setTotal(double total) {
    _total = total;
    notifyListeners();
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

  void setWallet(double amount) {
    _wallet = amount;
    notifyListeners();
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
  var _price = <int, double>{};

  get cart => _cart;
  get price => _price;

  getCartQuantity(int productID) {
    return _cart[productID];
  }

  getCartPrice(int productID) {
    return _price[productID];
  }

  void changeCart(int productID, double quantity, double price) {
    _cart[productID] = quantity;
    _price[productID] = price;
    notifyListeners();
  }

  void deleteCart(int productID) {
    _cart.remove(productID);
  }
}

class CountNotifier extends ChangeNotifier {
  double _count = 0;
  double get count => _count;

  void setCount(double count) {
    _count = count;
    notifyListeners();
  }

  void incrementCount() {
    _count++;
    notifyListeners();
  }

  void decrementCount() {
    _count--;
    notifyListeners();
  }

  void deleteCount(double count) {
    _count -= count;
    notifyListeners();
  }

  void clearCount() {
    _count = 0;
    notifyListeners();
  }
}
