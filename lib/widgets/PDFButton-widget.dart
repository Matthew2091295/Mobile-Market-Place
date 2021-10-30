import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:market_place/OrderScreen.dart';
import 'package:market_place/pallete.dart';
import 'package:market_place/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:market_place/HomePage.dart';
import 'package:market_place/Drawer.dart';
import 'package:market_place/mobile.dart';

import '../Globals.dart' as Globals;

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

class PDFButton extends StatefulWidget {
  const PDFButton({Key key}) : super(key: key);

  @override
  _PDFButtonState createState() => _PDFButtonState();
}

List snap;

getOrderItems() async {
  String theUrl =
      "https://lamp.ms.wits.ac.za/home/s1854457/getOrderItems.php?orderID=1"; //connecting to Wits database

  var res = await http
      .get(Uri.parse(theUrl), headers: {"Accept": "application/json"});

  var responseBody = json.decode(res.body);

  return responseBody;
}

getMethod() async {
  String theUrl =
      "https://lamp.ms.wits.ac.za/home/s1854457/getOrderPdf.php?user=" +
          Globals.username; //connecting to Wits database

  var res = await http
      .get(Uri.parse(theUrl), headers: {"Accept": "application/json"});
  var responseBody = json.decode(res.body);

  print(responseBody);

  return responseBody;
}

class _PDFButtonState extends State<PDFButton> {
  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString(
        'Order History', PdfStandardFont(PdfFontFamily.helvetica, 30));

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 30),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 2);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Order Number';
    header.cells[1].value = 'Order Items';
    int order = 0;
    String items = "";
    PdfGridRow row = grid.rows.add();
    for (int i = 0; i < snap.length; i++) {
      if (int.parse(snap[i]['order_history_id']) != order) {
        print("1");
        if (order != 0) {
          row.cells[0].value = order.toString();
          row.cells[1].value = items;
          row = grid.rows.add();
          order = int.parse(snap[i]['order_history_id']);
          items = "";
          items = items + snap[i]['name'] + ", ";
        } else {
          order = int.parse(snap[i]['order_history_id']);
          items = "";
          items = items + snap[i]['name'] + ", ";
        }
      } else {
        print("2");
        order = int.parse(snap[i]['order_history_id']);
        items = items + snap[i]['name'] + ", ";
      }
    }
    row.cells[0].value = order.toString();
    row.cells[1].value = items;

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMethod(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          snap = snapshot.data;
          return ElevatedButton(
              onPressed: _createPDF,
              child: Text("Download PDF"),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(206, 166, 97, 1.0)));
        });
  }
}
