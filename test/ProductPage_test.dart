import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:market_place/ProductPage.dart';
import 'package:market_place/widgets/widgets.dart';

void main() {
  testWidgets('ProductPage ...', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new ProductPage(
                name: "Name",
                description: "A description",
                price: 10.0,
                quantity: 10,
                productID: 4)));
    await tester.pumpWidget(testWidget);

    expect(find.byType(Image), findsOneWidget);
    expect(find.text("Name"), findsOneWidget);
    expect(find.text("A description"), findsOneWidget);
    //expect(find.text("R10.0"), findsOneWidget);
    expect(find.text("10"), findsOneWidget);
  });
}
