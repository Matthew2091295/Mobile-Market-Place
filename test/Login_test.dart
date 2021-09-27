import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_place/Login.dart';
import 'package:market_place/widgets/widgets.dart';

void main() {
  testWidgets(
      "The Login Screen should have a TextInputField with Username as a hint, PasswordInputField with Password as a hint and a Register Button with Login as its text",
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(), child: new MaterialApp(home: new Login()));

    await tester.pumpWidget(testWidget);

    expect(find.widgetWithText(TextInputField, "Username"), findsOneWidget);
    expect(find.widgetWithText(PasswordInput, "Password"), findsOneWidget);
    // ignore: deprecated_member_use
    expect(find.widgetWithText(RaisedButton, "Login"), findsOneWidget);
  });
}
