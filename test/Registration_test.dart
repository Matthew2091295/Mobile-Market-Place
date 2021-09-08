import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_place/Registration.dart';
import 'package:market_place/widgets/widgets.dart';

void main() {
  testWidgets(
      'Registration should have a First Name Field, Last Name Field, Email Field, PAssword field, and Confirm Password Field',
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new Registration()));

    await tester.pumpWidget(testWidget);

    expect(find.widgetWithText(TextInputField, "First Name"), findsOneWidget);
    expect(find.widgetWithText(TextInputField, "Last Name"), findsOneWidget);
    expect(find.widgetWithText(TextInputField, "Email"), findsOneWidget);
    expect(find.widgetWithText(PasswordInput, "Password"), findsOneWidget);
    expect(
        find.widgetWithText(PasswordInput, "Confirm Password"), findsOneWidget);
  });
}
