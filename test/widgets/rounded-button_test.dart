import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:market_place/widgets/rounded-button.dart';

void main() {
  testWidgets('rounded-button test', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: Scaffold(
          body: new RoundedButton(
              // icon: FontAwesomeIcons.envelope, hint: "username"),
              buttonName: "btn"),
        )));
    await tester.pumpWidget(testWidget);
  });
}
