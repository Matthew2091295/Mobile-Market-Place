import 'package:flutter_test/flutter_test.dart';
import 'package:market_place/widgets/product-widget.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets(
      'The product Widget should have an image, name, price and quantity',
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new Product(
          name: "Name",
          price: 10,
          description: "A description",
          quantity: 15,
          productID: 4,
        )));
    await tester.pumpWidget(testWidget);

    expect(find.text("Name"), findsOneWidget);
    expect(find.text("R10.00"), findsOneWidget);
    expect(find.text("Quantity: 15"), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text("Add to cart"), findsOneWidget);

    await tester.tap(find.byType(Image));

    expect(find.text("Name"), findsOneWidget);
  });
}
