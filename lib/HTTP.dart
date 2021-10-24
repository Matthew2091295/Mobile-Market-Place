import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:market_place/Globals.dart' as Globals;

class AddToCart {
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
}

class GetProduct {
  getProduct(int productID) async {
    String url = Globals.url + "getItem.php";

    Map<String, String> parameters = {
      'itemID': productID.toString(),
      'username': Globals.username,
    };

    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;

    var response = await http.get(Uri.parse(requestUrl), headers: headers);
    var responseBody = json.decode(response.body);

    return responseBody;
  }
}

class ChangeCart {
  changeCart(int productID, double quantity) async {
    String url = Globals.url + "changeCart.php";

    Map<String, String> parameters = {
      'itemID': productID.toString(),
      'username': Globals.username,
      'quantity': quantity.toString(),
    };

    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;

    await http.get(Uri.parse(requestUrl), headers: headers);
  }
}

class DeleteFromCart {
  deleteFromCart(int productID) async {
    String url = Globals.url + "deleteFromCart.php";

    Map<String, String> parameters = {
      'itemID': productID.toString(),
      'username': Globals.username,
    };

    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;

    await http.get(Uri.parse(requestUrl), headers: headers);
  }
}

class ChangeTotalAndCount {
  changeTotalAndCount(double total, double count) async {
    String url = Globals.url + "changeTotalAndCount.php";

    Map<String, String> parameters = {
      'username': Globals.username,
      'total': total.toString(),
      'item_count': count.toString(),
    };

    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;

    await http.get(Uri.parse(requestUrl), headers: headers);
  }
}

class DeleteCart {
  deleteCart() async {
    String url = Globals.url + "deleteCart.php";

    Map<String, String> parameters = {
      'username': Globals.username,
    };
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;
    await http.get(Uri.parse(requestUrl), headers: headers);
  }
}

class AddToWallet {
  addToWallet(double wallet) async {
    String url = Globals.url + "addToWallet.php";

    Map<String, String> parameters = {
      'username': Globals.username,
      'wallet': wallet.toString(),
    };
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;
    await http.get(Uri.parse(requestUrl), headers: headers);
  }
}

class RemoveFromWallet {
  removeFromWallet(double wallet) async {
    String url = Globals.url + "removeFromWallet.php";

    Map<String, String> parameters = {
      'username': Globals.username,
      'wallet': wallet.toString(),
    };
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    String query = Uri(queryParameters: parameters).query;
    var requestUrl = url + '?' + query;
    await http.get(Uri.parse(requestUrl), headers: headers);
  }
}
