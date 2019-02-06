import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<String> _items = [];

  void add(String item) => _items.add(item);
}

class MyHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(42),
      child: ScopedModel(
        model: CartModel(),
        child: MyCatalog(),
      ),
    );
  }
}

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MyListItem("A"),
        MyListItem("B"),
        MyListItem("C"),
      ],
    );
  }
}

class MyListItem extends StatelessWidget {
  final String item;

  MyListItem(this.item);

  CartModel somehowGetMyCartModel(BuildContext context) {
    return ScopedModel.of<CartModel>(context);
  }

  // #docregion myTapHandler
  // GOOD
  void myTapHandler(BuildContext context) {
    var cartModel = somehowGetMyCartModel(context);
    cartModel.add(item);
  }
  // #enddocregion myTapHandler

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
}
