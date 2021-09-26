import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';
import 'package:market_place/Drawer.dart';

void main() {
  testWidgets("Test Drawer", (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new MainDrawer()));

    await tester.pumpWidget(testWidget);
  });
}
