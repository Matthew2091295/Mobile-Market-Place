import 'package:flutter_test/flutter_test.dart';
import 'package:market_place/Notifiers.dart';

void main() {
  group("Testing TotalNotifier:", () {
    final totalNotifier = TotalNotifier();
    double total = 1;

    test("Initial Total", () {
      expect(totalNotifier.total, 0);
    });

    test("Set Total", () {
      totalNotifier.setTotal(total);
      expect(totalNotifier.total, total);
    });

    test("Add To Total", () {
      totalNotifier.addToTotal(total);
      expect(totalNotifier.total, total * 2);
    });

    test("Remove From Total", () {
      totalNotifier.removeFromTotal(total * 2);
      expect(totalNotifier.total, 0);
    });
  });

  group("Testing WalletNotifier:", () {
    final walletNotifier = WalletNotifier();
    double amount = 1;

    test("Initial Wallet", () {
      expect(walletNotifier.wallet, 0);
    });

    test("Set Wallet", () {
      walletNotifier.setWallet(amount);
      expect(walletNotifier.wallet, amount);
    });

    test("Add To Wallet", () {
      walletNotifier.addToWallet(amount);
      expect(walletNotifier.wallet, amount * 2);
    });

    test("Remove From Wallet", () {
      walletNotifier.removeFromWallet(amount * 2);
      expect(walletNotifier.wallet, 0);
    });
  });

  group("Testing CountNotifier:", () {
    final countNotifier = CountNotifier();
    double count = 1;

    test("Initial Count", () {
      expect(countNotifier.count, 0);
    });

    test("Set Count", () {
      countNotifier.setCount(count);
      expect(countNotifier.count, count);
    });

    test("Clear Count", () {
      countNotifier.clearCount();
      expect(countNotifier.count, 0);
    });

    test("Add To Count", () {
      countNotifier.addToCount(count);
      expect(countNotifier.count, count);
    });

    test("Remove From Count", () {
      countNotifier.removeFromCount(count);
      expect(countNotifier.count, 0);
    });
  });

  group("Testing CartNotifier:", () {
    final cartNotifier = CartNotifier();

    int productID = 1;
    double price = 1;

    test("Initial Cart", () {
      expect(cartNotifier.cart.length, 0);
    });

    test("Initial Price", () {
      expect(cartNotifier.price.length, 0);
    });

    test("Add To Cart", () {
      cartNotifier.addToCart(productID, price);
      expect(cartNotifier.cart[0], productID);
      expect(cartNotifier.price[productID], price);
    });

    test("Change Cart", () {
      cartNotifier.changeCart(productID, price * 2);
      expect(cartNotifier.price[productID], price * 2);
    });

    test("Remove From Cart", () {
      cartNotifier.removeFromCart(productID);
      expect(cartNotifier.cart.length, 0);
      expect(cartNotifier.price.length, 0);
    });

    test("Clear Cart", () {
      cartNotifier.addToCart(productID, price);
      cartNotifier.clearCart();
      expect(cartNotifier.cart.length, 0);
      expect(cartNotifier.price.length, 0);
    });
  });

  group("Testing QuantityNotifier:", () {
    final quantityNotifier = QuantityNotifier();

    int productID1 = 1;
    int productID2 = 2;

    double quantity = 1;

    test("Initial Quanity", () {
      expect(quantityNotifier.quantity.length, 0);
    });

    test("Change Quantity", () {
      quantityNotifier.changeQuantity(productID1, quantity);
      expect(quantityNotifier.quantity[productID1], quantity);

      quantityNotifier.changeQuantity(productID2, quantity);
      expect(quantityNotifier.quantity[productID2], quantity);

      expect(quantityNotifier.quantity.length, 2);
    });

    test("Get Quantity", () {
      expect(quantityNotifier.getQuantity(productID1), quantity);
    });

    test("Exists", () {
      expect(quantityNotifier.exists(productID1), true);
      expect(quantityNotifier.exists(productID2), true);
    });

    test("Remove Quantity", () {
      quantityNotifier.removeQuantity(productID1);
      expect(quantityNotifier.exists(productID1), false);
    });

    test("Clear Quantities", () {
      quantityNotifier.clearQuantities();
      expect(quantityNotifier.quantity.length, 0);
    });
  });
}
