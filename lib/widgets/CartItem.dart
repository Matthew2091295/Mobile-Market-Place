import 'package:flutter/material.dart';
import 'package:market_place/CartEvent.dart';
import 'package:spinner_input/spinner_input.dart';
import 'package:intl/intl.dart';

final double padding = 8.0;

final lightGrey = Color(0xFFA0A0A0);
final mediumGrey = Color(0xFF414141);
final darkGrey = Color(0xFF222222);

final lightBlue = Color(0xFF679AF1);
final darkBlue = Color(0xFF082352);

final lightYellow = Color(0xFFDFC598);
final darkYellow = Color(0xFFCEA661);

final currencyFormat = new NumberFormat("#,##0.00", "en_US");

class CartItem extends StatefulWidget {
  const CartItem({
    Key key,
    @required this.productIcon,
    @required this.productName,
    @required this.productPrice,
    @required this.iconHeight,
    this.bloc,
  }) : super(key: key);

  final String productIcon;
  final String productName;
  final double productPrice;
  final double iconHeight;
  final bloc;

  @override
  _CartItem createState() =>
      _CartItem(productIcon, productName, productPrice, iconHeight, bloc);
}

class _CartItem extends State<CartItem> {
  double spinnerValue = 1;
  double oldSpinnerValue = 1;

  _CartItem(this.productIcon, this.productName, this.productPrice,
      this.iconHeight, this.bloc);
  final String productIcon;
  final String productName;
  final double productPrice;
  final double iconHeight;
  final bloc;

  @override
  Widget build(BuildContext context) {
    int productIconFlex = 4;
    int productInfoFlex = 4;
    int iconFlex = 1;

    double newPriceDouble = productPrice * spinnerValue;
    String newPrice = currencyFormat.format(newPriceDouble);

    return Container(
      height: iconHeight * 1.12,
      width: double.infinity,
      child: Card(
        elevation: 0,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 0.2,
          runSpacing: 0.2,
          children: <Widget>[
            Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: productIconFlex,
                        child: Container(
                          height: iconHeight,
                          padding: EdgeInsets.only(right: padding),
                          child: Image.network(productIcon,
                              height: iconHeight,
                              width: iconHeight,
                              fit: BoxFit.contain),
                        ),
                      ),
                      Expanded(
                        flex: productInfoFlex,
                        child: Container(
                          height: iconHeight,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: iconHeight,
                                  child: Column(
                                    children: [
                                      Flexible(
                                        child: RichText(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: productName,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            text: "R" + newPrice,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Row(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: "Qty: ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: darkGrey,
                                                ),
                                              ),
                                            ),
                                            SpinnerInput(
                                              spinnerValue: spinnerValue,
                                              minValue: 1,
                                              maxValue: 100,
                                              step: 1,
                                              disabledLongPress: true,
                                              disabledPopup: true,
                                              plusButton: SpinnerButtonStyle(
                                                  color: darkYellow),
                                              minusButton: SpinnerButtonStyle(
                                                  color: darkYellow),
                                              onChange: (newValue) {
                                                setState(() {
                                                  oldSpinnerValue =
                                                      spinnerValue;
                                                  spinnerValue = newValue;

                                                  if (oldSpinnerValue >
                                                      spinnerValue) {
                                                    bloc.cartEventSink.add(
                                                        RemoveFromTotal(
                                                            price:
                                                                productPrice));
                                                  } else {
                                                    bloc.cartEventSink.add(
                                                        AddToTotal(
                                                            price:
                                                                productPrice));
                                                  }
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: iconFlex,
                        child: Container(
                          height: iconHeight,
                          child: Container(
                            height: iconHeight,
                            child: Center(
                              child: Card(
                                elevation: 0,
                                child: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: mediumGrey,
                                  iconSize: 32,
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
