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
  const PDFButton({Key key, @required this.orderID, @required this.total})
      : super(key: key);

  final int orderID;
  final int total;

  @override
  _PDFButtonState createState() => _PDFButtonState();
}

List snap;

getOrderItems(int orderID) async {
  String theUrl =
      "https://lamp.ms.wits.ac.za/home/s1854457/getOrderItems.php?orderID=" +
          orderID.toString(); //connecting to Wits database

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

    String title =
        'Order Invoice\nOrder Number: ' + widget.orderID.toString() + '\n';

    final PdfLayoutResult layoutResult = PdfTextElement(
            text: title,
            font: PdfStandardFont(PdfFontFamily.helvetica, 30),
            brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                0, 0, page.getClientSize().width, page.getClientSize().height),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate));

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 30),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 4);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Item ID';
    header.cells[1].value = 'Item Name';
    header.cells[2].value = 'Price per item';
    header.cells[3].value = 'Total Price';

    for (int i = 0; i < snap.length; i++) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = snap[i]['itemid'];
      row.cells[1].value = snap[i]['name'];
      row.cells[2].value = snap[i]['price'];
      row.cells[3].value =
          (int.parse(snap[i]['price']) * int.parse(snap[i]['quantity']))
              .toString();
    }

    final PdfLayoutResult result = grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 10,
            page.getClientSize().width, page.getClientSize().height));

    page.graphics.drawString('Total: ' + widget.total.toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 30),
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 10,
            page.getClientSize().width, page.getClientSize().height),
        format: PdfStringFormat(alignment: PdfTextAlignment.right));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getOrderItems(widget.orderID),
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
