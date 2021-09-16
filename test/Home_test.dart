import 'package:flutter_test/flutter_test.dart';
import 'package:market_place/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:market_place/Home.dart';

void main() {
  testWidgets('Home should have 5 rows of 5 products each',
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(), child: new MaterialApp(home: new Home()));

    const findWidget = Product(
        name: "name", price: 0, description: "description", quantity: 0);

    await tester.pumpWidget(testWidget);

    final dynamic p = Product;

    expect(find.byType(Product), findsWidgets);
    expect(find.byType(ElevatedButton), findsWidgets);
  });
}
