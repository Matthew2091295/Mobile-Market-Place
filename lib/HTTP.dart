import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:market_place/Globals.dart' as Globals;

deleteFromCart(int productID) async {
  String url = Globals.url + "deleteFromCart.php";

  Map<String, String> parameters = {
    'itemID': productID.toString(),
    'username': Globals.username,
  };
  var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

  String query = Uri(queryParameters: parameters).query;
  var requestUrl = url + '?' + query;
  var response = await http.get(Uri.parse(requestUrl), headers: headers);

  var responseBody = response.body;
  return responseBody;
}

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
  var response = await http.get(Uri.parse(requestUrl), headers: headers);

  var responseBody = response.body;
  return responseBody;
}
