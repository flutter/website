import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(
      // #docregion Items
      items: List<String>.generate(10000, (i) => 'Item $i'),
      // #enddocregion Items
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<String> items;

  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    const title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        // #docregion ListView
        body: ListView.builder(
          itemCount: items.length,
          //when the listview is scrolled using the scrollbar all the way to
          //the bottom of the view,
          //chrome gets unresponsive
          // specifying prototypeItem fixes the issue because the scrolling
          //machinery can make use of the foreknowledge of the children's
          //extent
          prototypeItem: const ListTile(title: Text('prototype item')),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]),
            );
          },
        ),
        // #enddocregion ListView
      ),
    );
  }
}
