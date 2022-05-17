import 'package:flutter/material.dart';
import 'common.dart';

class CallbackPasser extends StatelessWidget {
  const CallbackPasser({super.key});

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
  const MyHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const CallbackPasser(),
    );
  }
}

class MyListItem extends StatelessWidget {
  MyListItem(this.callback, {super.key});

  final void Function(Item) callback;

  final Item item = Item();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Item!'),
        TextButton(
          onPressed: () => callback(item),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
