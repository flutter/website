import 'package:state_mgmt/src/provider.dart';
import 'package:test/test.dart';

void main() {
  // #docregion test
  test('adding item increases total cost', () {
    final cart = CartModel();
    final startingPrice = cart.totalPrice;
    cart.addListener(() {
      expect(cart.totalPrice, greaterThan(startingPrice));
    });
    cart.add(Item('Dash'));
  });
  // #enddocregion test
}
