import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_place/Cart.dart';
import 'package:flutter/material.dart';

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

  group("Testing Cart:", () {
    testWidgets("Total", (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: ProviderScope(child: new MaterialApp(home: new Cart())));

      await tester.pumpWidget(testWidget);

      expect(
          find.byWidgetPredicate(
              (testWidget) => fromRichTextToPlainText(testWidget) == "R0.00"),
          findsOneWidget);
    });

    testWidgets("Total Title", (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: ProviderScope(child: new MaterialApp(home: new Cart())));

      await tester.pumpWidget(testWidget);

      expect(
          find.byWidgetPredicate(
              (testWidget) => fromRichTextToPlainText(testWidget) == "Total:"),
          findsOneWidget);
    });

    testWidgets("Item Counter", (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: ProviderScope(child: new MaterialApp(home: new Cart())));

      await tester.pumpWidget(testWidget);

      expect(
          find.byWidgetPredicate((testWidget) =>
              fromRichTextToPlainText(testWidget) == "(0 Items)"),
          findsOneWidget);
    });

    testWidgets("Checkout Button", (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: ProviderScope(child: new MaterialApp(home: new Cart())));

      await tester.pumpWidget(testWidget);

      expect(find.widgetWithText(TextButton, "Checkout"), findsOneWidget);
    });

    //expect(find.byType(SpinnerInput), findsOneWidget);
    testWidgets("ListView", (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: ProviderScope(child: new MaterialApp(home: new Cart())));

      await tester.pumpWidget(testWidget);

      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
