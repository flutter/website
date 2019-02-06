import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

CartModel somehowGetMyCartModel(BuildContext context) {
  return ScopedModel.of<CartModel>(context, rebuildOnChange: true);
}

class CartModel extends Model {
  List<String> _items = [];

  void add(String item) {
    _items.add(item);
    notifyListeners();
  }

  @override
  String toString() => '$_items';
}

class MyCart extends StatelessWidget {
  @override
  // #docregion build
  // GOOD
  Widget build(BuildContext context) {
    var cartModel = somehowGetMyCartModel(context);
    return SomeWidget(
      // Just construct the UI once, using the current state of the cart.
      // #enddocregion build
      Text('Cart: $cartModel'),
      // #docregion build
    );
  }
  // #enddocregion build
}

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyCatalogItem("A"),
        MyCatalogItem("B"),
        MyCatalogItem("C"),
      ],
    );
  }
}

class MyCatalogItem extends StatelessWidget {
  final String item;

  MyCatalogItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(item),
        FlatButton(
          onPressed: () => myTapHandler(context),
          child: Text("Add"),
        ),
      ],
    );
  }

  // #docregion myTapHandler
  // GOOD
  void myTapHandler(BuildContext context) {
    var cartModel = somehowGetMyCartModel(context);
    cartModel.add(item);
  }
  // #enddocregion myTapHandler
}

class MyHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(42),
      child: ScopedModel(
        model: CartModel(),
        child: Column(
          children: [
            MyCatalog(),
            MyCart(),
          ],
        ),
      ),
    );
  }
}

class SomeWidget extends StatelessWidget {
  final Widget child;

  SomeWidget(this.child);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
