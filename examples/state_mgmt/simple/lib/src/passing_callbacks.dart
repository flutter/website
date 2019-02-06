import 'package:flutter/material.dart';
import 'package:state_mgmt/src/common.dart';

class Item {
  // Empty.
}

class MyHomepage extends StatelessWidget {
  // #docregion methods
  void myTapCallback(Item item) {
    print('user tapped on $item');
  }

  @override
  Widget build(BuildContext context) {
    return SomeWidget(
      // Construct the widget, passing it a reference to the method above.
      MyListItem(myTapCallback),
    );
  }
  // #enddocregion methods
}

class MyListItem extends StatelessWidget {
  final void Function(Item) callback;

  final Item item = Item();

  MyListItem(this.callback);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Item!'),
        FlatButton(
          onPressed: () => callback(item),
          child: Text("Add"),
        ),
      ],
    );
  }
}
