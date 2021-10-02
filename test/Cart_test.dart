import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_place/CartNotifier.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/Cart.dart';
import 'package:market_place/widgets/CartItem.dart';

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

  //Product used to test cart item widget
  String productIcon =
      "https://media.takealot.com/covers_tsins/57593134/6009546804725-1-zoom.jpg";
  String productName = "Cat's Life Cat Cube Floral (Pink06) M";
  double productPrice = 590;

  double iconHeight = 100;

  testWidgets("Test Network Image", (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
            home: new CartItem(
          productIcon: productIcon,
          productName: productName,
          productPrice: productPrice,
          iconHeight: iconHeight,
        )));

    mockNetworkImagesFor(() => tester.pumpWidget(testWidget));
  });

  testWidgets("Test Rich Texts and Text Button", (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: ProviderScope(child: new MaterialApp(home: new Cart())));

    await tester.pumpWidget(testWidget);

    expect(
        find.byWidgetPredicate(
            (testWidget) => fromRichTextToPlainText(testWidget) == "Total:"),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (testWidget) => fromRichTextToPlainText(testWidget) == "(5 Items)"),
        findsOneWidget);

    expect(find.widgetWithText(TextButton, "Checkout"), findsOneWidget);
  });

  testWidgets("Test Cart Notifier", (WidgetTester tester) async {
    final cartNotifier = CartNotifier();

    double finalTotal = cartNotifier.total + productPrice;
    cartNotifier.addToTotal(productPrice);
    expect(cartNotifier.total, finalTotal);

    finalTotal = cartNotifier.total - productPrice;
    cartNotifier.removeFromTotal(productPrice);
    expect(cartNotifier.total, finalTotal);
  });
}
