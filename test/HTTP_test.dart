import 'package:flutter_test/flutter_test.dart';
import 'package:market_place/HTTP.dart';
import 'package:mockito/mockito.dart';

class AddToCartMock extends Mock implements AddToCart {}

class GetProductMock extends Mock implements GetProduct {}

class ChangeCartMock extends Mock implements ChangeCart {}

class DeleteFromCartMock extends Mock implements DeleteFromCart {}

class ChangeTotalAndCountMock extends Mock implements ChangeTotalAndCount {}

class DeleteCartMock extends Mock implements DeleteCart {}

class AddToWalletMock extends Mock implements AddToWallet {}

class RemoveFromWalletMock extends Mock implements RemoveFromWallet {}

void main() {
  group("Test HTTP:", () {
    int productID = 1;
    double quantity = 1;

    double total = 100;
    double count = 1;

    String mockProduct = '{"itemid": 1, "name": "mock", "price": 100}';
    String mockCart =
        '{"itemid": 1, "name": "mock1", "price": 100},{"itemid": 2, "name": "mock2", "price": 100}';

    test("AddToCart", () async {
      var addToCartMock = AddToCartMock();

      when(addToCartMock.addToCart(any))
          .thenAnswer((realInvocation) => null);
      expect(addToCartMock.addToCart(productID), null);
    });

    test("GetProduct", () async {
      var getProductMock = GetProductMock();

      when(getProductMock.getProduct(any)).thenReturn(mockProduct);
      expect(getProductMock.getProduct(productID), mockProduct);
    });

    test("ChangeCart", () async {
      var changeCartMock = ChangeCartMock();

      when(changeCartMock.changeCart(any, any))
          .thenAnswer((realInvocation) => null);
      expect(changeCartMock.changeCart(productID, quantity), null);
    });

    test("DeleteFromCart", () {
      var deleteFromCartMock = DeleteFromCartMock();

      when(deleteFromCartMock.deleteFromCart(productID))
          .thenAnswer((realInvocation) => null);
      expect(deleteFromCartMock.deleteFromCart(productID), null);
    });

    test("ChangeTotalAndCount", () {
      var changeTotalAndCountMock = ChangeTotalAndCountMock();

      when(changeTotalAndCountMock.changeTotalAndCount(any, any))
          .thenAnswer((realInvocation) => null);
      expect(changeTotalAndCountMock.changeTotalAndCount(total, count), null);
    });

    test("DeleteCart", () {
      var deleteCartMock = DeleteCartMock();

      when(deleteCartMock.deleteCart())
          .thenAnswer((realInvocation) => null);
      expect(deleteCartMock.deleteCart(), null);
    });

    test("AddToWallet", () {
      var addToWalletMock = AddToWalletMock();

      when(addToWalletMock.addToWallet(any))
          .thenAnswer((realInvocation) => null);
      expect(addToWalletMock.addToWallet(total), null);
    });

    test("RemoveFromWallet", () {
      var removeFromWallet = RemoveFromWalletMock();

      when(removeFromWallet.removeFromWallet(any))
          .thenAnswer((realInvocation) => null);
      expect(removeFromWallet.removeFromWallet(total), null);
    });
  });
}
