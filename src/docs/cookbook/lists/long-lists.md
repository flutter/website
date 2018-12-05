---
title: Working with long lists
---

The standard [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html)
constructor works well for small lists. In order to work with lists that contain
a large number of items, it's best to use the [`ListView.builder`](https://docs.flutter.io/flutter/widgets/ListView/ListView.builder.html)
constructor.

Whereas the default `ListView` constructor requires us to create all items at
once, the `ListView.builder` constructor will create items as they are scrolled
onto the screen.

## 1. Create a data source

First, we'll need a data source to work with. For example, your data source
might be a list of messages, search results, or products in a store. Most of
the time, this data will come from the internet or a database.

For this example, we'll generate a list of 10000 Strings using the
[`List.generate`](https://docs.flutter.io/flutter/dart-core/List/List.generate.html)
constructor.

<!-- skip -->
```dart
final items = List<String>.generate(10000, (i) => "Item $i");
```

## 2. Convert the data source into Widgets

In order to display our List of Strings, we'll need to render each String as
a Widget!

This is where the `ListView.builder` will come into play. In our case, we'll
display each String on its own line.

<!-- skip -->
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('${items[index]}'),
    );
  },
);
```

## Complete example

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    items: List<String>.generate(10000, (i) => "Item $i"),
  ));
}

class MyApp extends StatelessWidget {
  final List<String> items;

  MyApp({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${items[index]}'),
            );
          },
        ),
      ),
    );
  }
}
```

![Long Lists Demo](/images/cookbook/long-lists.gif){:.site-mobile-screenshot}
