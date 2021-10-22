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

class CountNotifier extends ChangeNotifier {
  double _count = 0;
  double get count => _count;

  void setCount(double count) {
    _count = count;
    notifyListeners();
  }

  void clearCount() {
    _count = 0;
    notifyListeners();
  }

  void addToCount(double count) {
    _count += count;
    notifyListeners();
  }

  void removeFromCount(double count) {
    _count -= count;
    notifyListeners();
  }
}

class CartNotifier extends ChangeNotifier {
  var _cart = [];
  var _price = <int, double>{};

  get cart => _cart;
  get price => _price;

  void addToCart(int productID, double price) {
    _cart.add(productID);
    _price[productID] = price;
    notifyListeners();
  }

  void changeCart(int productID, double price){
    _price[productID] = price;
    notifyListeners();
  }

  void removeFromCart(int productID) {
    _cart.remove(productID);
    _price.remove(productID);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    _price.clear();
    notifyListeners();
  }
}

class QuantityNotifier extends ChangeNotifier {
  var _quantity = <int, double>{};
  get quantity => _quantity;

  getQuantity(int productID) {
    return _quantity[productID];
  }

  void changeQuantity(int productID, double quantity) {
    _quantity[productID] = quantity;
    notifyListeners();
  }

  void removeQuantity(int productID) {
    _quantity.remove(productID);
    notifyListeners();
  }

  void clearQuantities() {
    _quantity.clear();
    notifyListeners();
  }
}
