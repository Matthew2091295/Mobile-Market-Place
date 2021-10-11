import 'package:flutter_test/flutter_test.dart';
import 'package:market_place/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:market_place/Drawer.dart';

void main() {
  testWidgets('Drawer should have widgets', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new MainDrawer()));

    await tester.pumpWidget(testWidget);

    expect(find.text("Empty"), findsOneWidget);
    expect(find.text("Profile"), findsOneWidget);
    expect(find.text("Settings"), findsOneWidget);
    expect(find.text("Logout"), findsOneWidget);
  });
}
