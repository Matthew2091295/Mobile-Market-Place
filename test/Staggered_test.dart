import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_place/Staggered.dart';
import 'package:market_place/widgets/widgets.dart';

void main() {
  testWidgets('Staggered should have category images',
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new Staggered()));

    await tester.pumpWidget(testWidget);

    expect(find.byWidgetPredicate((widget) => widget is Image), findsWidgets);
  });
}
