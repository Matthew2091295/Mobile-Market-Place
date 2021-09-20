import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:market_place/widgets/text-field-input.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  testWidgets('text-field-input should have an icon, and a hint',
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: Scaffold(
          body: new TextInputField(
              icon: FontAwesomeIcons.envelope, hint: "username"),
        )));
    await tester.pumpWidget(testWidget);
    expect(find.widgetWithIcon(TextInputField, FontAwesomeIcons.envelope),
        findsOneWidget);
    expect(find.text("username"), findsOneWidget);
  });
}
