import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common.dart';

CartModel somehowGetMyCartModel(BuildContext context) {
  return Provider.of<CartModel>(context);
}

// #docregion model
class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Item> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Item item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
// #enddocregion model

class Item {
  final String name;

  Item(this.name);

  @override
  String toString() => name;
}

class MyCartTotalWidget extends StatelessWidget {
  const MyCartTotalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // #docregion descendant
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        return Text('Total price: ${cart.totalPrice}');
      },
    );
    // #enddocregion descendant
  }
}

class MyCartUsingWidget extends StatelessWidget {
  const MyCartUsingWidget({super.key});

  @override
  // #docregion build
  // GOOD
  Widget build(BuildContext context) {
    var cartModel = somehowGetMyCartModel(context);
    return SomeWidget(
      // Just construct the UI once, using the current state of the cart.
      // #enddocregion build
      Text('Cart: ${cartModel.items}'),
      // #docregion build
    );
  }

  // #enddocregion build
}

class MyCatalog extends StatelessWidget {
  const MyCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyCatalogItem(Item('A')),
        MyCatalogItem(Item('B')),
        MyCatalogItem(Item('C')),
      ],
    );
  }
}

class MyCatalogItem extends StatelessWidget {
  const MyCatalogItem(this.item, {super.key});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(item.name),
        TextButton(
          onPressed: () => myTapHandler(context),
          child: Text('Add ${item.name}'),
        ),
      ],
    );
  }

  // #docregion my-tap-handler
  // GOOD
  void myTapHandler(BuildContext context) {
    var cartModel = somehowGetMyCartModel(context);
    cartModel.add(item);
  }

  // #enddocregion my-tap-handler
}

class MyHomepage extends StatelessWidget {
  const MyHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [MyCatalog(), MyCartUsingWidget(), MyCartTotalWidget()],
      ),
    );
  }
}
