import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spinner_input/spinner_input.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:market_place/widgets/CartItem.dart';

final currencyFormat = new NumberFormat("#,##0.00", "en_US");

void main() {
  String fromRichTextToPlainText(final Widget widget) {
    if (widget is RichText) {
      if (widget.text is TextSpan) {
        final buffer = StringBuffer();
        (widget.text as TextSpan).computeToPlainText(buffer);
        return buffer.toString();
      }
    }
    return null;
  }

  //Product used to test cart item widget
  String productIcon =
      "https://media.takealot.com/covers_tsins/57593134/6009546804725-1-zoom.jpg";
  String productName = "Cat's Life Cat Cube Floral (Pink06) M";
  double productPrice = 590;

  double iconHeight = 100;

  testWidgets("Test Network Image", (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new CartItem(
          productIcon: productIcon,
          productName: productName,
          productPrice: productPrice,
          iconHeight: iconHeight,
        )));

    mockNetworkImagesFor(() => tester.pumpWidget(testWidget));
  });

  testWidgets("Test Rich Texts", (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new CartItem(
          productIcon: productIcon,
          productName: productName,
          productPrice: productPrice,
          iconHeight: iconHeight,
        )));

    await tester.pumpWidget(testWidget);

    expect(
        find.byWidgetPredicate(
            (testWidget) => fromRichTextToPlainText(testWidget) == productName),
        findsOneWidget);

    String displayedPrice = "R" + currencyFormat.format(productPrice);
    expect(
        find.byWidgetPredicate((testWidget) =>
            fromRichTextToPlainText(testWidget) == displayedPrice),
        findsOneWidget);
  });

  testWidgets("Test Spinner Input and Icon Button",
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new CartItem(
          productIcon: productIcon,
          productName: productName,
          productPrice: productPrice,
          iconHeight: iconHeight,
        )));

    await tester.pumpWidget(testWidget);

    expect(find.byType(SpinnerInput), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);
  });
}
