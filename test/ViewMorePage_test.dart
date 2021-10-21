import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:market_place/ViewMorePage.dart';
import 'package:market_place/widgets/widgets.dart';

void main() {
  testWidgets('ViewMorePage should have products', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new ViewMore(cat: "Clothes")));
    await tester.pumpWidget(testWidget);

    expect(find.byType(Product), findsWidgets);
  });
}