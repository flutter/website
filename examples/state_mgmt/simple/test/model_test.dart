import 'package:state_mgmt/src/provider.dart';
import 'package:test/test.dart';

void main() {
  // #docregion test
  test('adding item increases total cost', () {
    final cart = CartModel();
    final startingPrice = cart.totalPrice;
    var i = 0;
    cart.addListener(() {
      expect(cart.totalPrice, greaterThan(startingPrice));
      i++;
    });
    cart.add(Item('Dash'));
    expect(i, 1);
  });
  // #enddocregion test
}
