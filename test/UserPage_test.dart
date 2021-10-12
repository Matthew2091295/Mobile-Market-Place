import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

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

  testWidgets("Test Network Image", (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: ProviderScope(child: new MaterialApp(home: new UserPage())));

    mockNetworkImagesFor(() => tester.pumpWidget(testWidget));
  });

  // testWidgets("Test Rich Texts", (WidgetTester tester) async {
  //   Widget testWidget = new MediaQuery(
  //       data: new MediaQueryData(),
  //       child: new MaterialApp(home: new UserPage()));

  //   await tester.pumpWidget(testWidget);

  //   expect(
  //       find.byWidgetPredicate((testWidget) =>
  //           fromRichTextToPlainText(testWidget) == "Full Names"),
  //       findsOneWidget);

  //   expect(
  //       find.byWidgetPredicate(
  //           (testWidget) => fromRichTextToPlainText(testWidget) == "Username"),
  //       findsWidgets);

  //   expect(
  //       find.byWidgetPredicate(
  //           (testWidget) => fromRichTextToPlainText(testWidget) == ""),
  //       findsOneWidget);
  // });
}
