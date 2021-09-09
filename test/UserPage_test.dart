import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_place/UserPage.dart';

void main() {
  String fromRichTextToPlainText(final Widget widget) {
    if (widget is RichText) {
      if (widget.text is TextSpan) {
        final buffer = StringBuffer();
        (widget.text as TextSpan).computeToPlainText(buffer);
        return buffer.toString();
      }
    }
    return null;
  }

  testWidgets("Rich Text Tests", (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new UserPage()));

    await tester.pumpWidget(testWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => fromRichTextToPlainText(widget) == "Name Surname"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => fromRichTextToPlainText(widget) == "Username"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => fromRichTextToPlainText(widget) == "Date of Birth"),
        findsOneWidget);
  });
}
