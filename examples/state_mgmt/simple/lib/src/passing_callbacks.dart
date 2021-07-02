import 'package:flutter/material.dart';
import 'package:state_mgmt/src/common.dart';

class CallbackPasser extends StatelessWidget {
  // #docregion methods
  @override
  Widget build(BuildContext context) {
    return SomeWidget(
      // Construct the widget, passing it a reference to the method above.
      MyListItem(myTapCallback),
    );
  }

  void myTapCallback(Item item) {
    print('user tapped on $item');
  }
  // #enddocregion methods
}

class Item {
  // Empty.
}

class MyHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CallbackPasser(),
    );
  }
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
        TextButton(
          onPressed: () => callback(item),
          child: Text("Add"),
        ),
      ],
    );
  }
}
