import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/Providers.dart';
import 'package:market_place/widgets/widgets.dart';
import 'package:intl/intl.dart';

final double padding = 8.0;

final darkGrey = Color(0xFF535353);

final lightYellow = Color(0xFFDFC598);
final darkYellow = Color(0xFFCEA661);

final currencyFormat = new NumberFormat("#,##0.00", "en_US");

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double iconHeight = contextHeight * 0.18;

    //PRODUCT1
    String productIcon1 =
        "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSKf6ItRWh4z0wvwmJwKgHts30nK53G6HmLt8piKkRFOpTaTLTGLkfTbZNfmpOCcO59QCPS1yRDJnYKDlkH-rcWKCNX9vbJu9FtcgEJ5Rm1HAaFzoKHkyTi&usqp=CAE";
    String productName1 = "Catmor - Dry Cat Food - Tuna - 4kg";
    double productPrice1 = 125;

    //PRODUCT2
    String productIcon2 =
        "https://media.takealot.com/covers_tsins/57593134/6009546804725-1-zoom.jpg";
    String productName2 = "Cat's Life Cat Cube Floral (Pink06) M";
    double productPrice2 = 590;

    //PRODUCT3
    String productIcon3 =
        "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTb6T6Ii_vHURzQeokPnORA-R5nfzIt7AvAtqjTwt70Qiz9qgEPEPzcCbgeNaUy-MfmMZ9zzAH0uLlmNGX8wvwtb07s73R-zC6a8GgXs5hbB2Zg7gyp0IyBgA&usqp=CAY";
    String productName3 = "PUMA Essentials Logo Youth Hoodie in Apricot Blush";
    double productPrice3 = 360;

    //PRODUCT4
    String productIcon4 =
        "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRSEzLc0TdbZmuDJreKWuBGCgvM9RcF7gnuF1NrWbzehhc2na_G7PwhaM2KQe32E43iQ0YRfsIn1swv-14TejOKL6QkaOqXk_qmWC_m-XHV6DofFz7YomTm&usqp=CAE";
    String productName4 = "Samsung Galaxy S20 FE 128GB - Cloud Mint";
    double productPrice4 = 10999;

    //PRODUCT5
    String productIcon5 =
        "https://media.takealot.com/covers_tsins/32662535/32662535-1-zoom.jpg";
    String productName5 = "Bennett Read - Zoom Vacuum Cleaner";
    double productPrice5 = 729;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          automaticallyImplyLeading: false,
          backgroundColor: darkYellow,
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: padding, top: padding, right: padding),
          child: ListView(
            children: [
              CartItem(
                productIcon: productIcon1,
                productName: productName1,
                productPrice: productPrice1,
              ),
              CartItem(
                productIcon: productIcon2,
                productName: productName2,
                productPrice: productPrice2,
              ),
              CartItem(
                productIcon: productIcon3,
                productName: productName3,
                productPrice: productPrice3,
              ),
              CartItem(
                productIcon: productIcon4,
                productName: productName4,
                productPrice: productPrice4,
              ),
              CartItem(
                productIcon: productIcon5,
                productName: productName5,
                productPrice: productPrice5,
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          Column(
            children: [
              Container(
                height: iconHeight / 2.65,
                child: Column(
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Total:",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        Consumer(
                          builder: (context, watch, child) {
                            final _total = watch(totalProvider).total;
                            return Container(
                              child: RichText(
                                text: TextSpan(
                                  text: "R" + currencyFormat.format(_total),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          text: "(5 Items)",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: darkYellow,
                    textStyle: const TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    // Need to close _bloc
                  },
                  child: const Text('Checkout'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
