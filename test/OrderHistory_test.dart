import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:market_place/OrderHistory.dart';
import 'package:market_place/widgets/widgets.dart';

void main() {
  testWidgets(
      'OrderHistory should have a list of images, as well as Order Number and Total',
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new OrderHistory()));
    await tester.pumpWidget(testWidget);

    expect(find.byType(Image), findsWidgets);
  });
}
