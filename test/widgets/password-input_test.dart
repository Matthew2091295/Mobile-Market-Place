import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:market_place/widgets/password-input.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  testWidgets('The password Widget should have a hint and an icon',
      (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: Scaffold(
          body: new PasswordInput(
              icon: FontAwesomeIcons.lock,
              hint: "password",
              inputAction: TextInputAction.done),
        )));
    await tester.pumpWidget(testWidget);
    expect(find.widgetWithIcon(PasswordInput, FontAwesomeIcons.lock),
        findsOneWidget);
    expect(find.text("password"), findsOneWidget);
  });
}
