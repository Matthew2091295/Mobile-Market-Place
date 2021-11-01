import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:market_place/OrderScreen.dart';
import 'package:market_place/widgets/widgets.dart';

void main() {
  testWidgets('OrderScreen should have a list of all the items in an order',
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new OrderScreen(orderID: 1)));
    await tester.pumpWidget(testWidget);

    expect(find.text("Order Number: 1"), findsOneWidget);
    expect(find.text("Total: R100"), findsOneWidget);
    expect(find.byType(GridView), findsWidgets);
  });
}
