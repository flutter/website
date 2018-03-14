---
layout: page
title: "Working with long lists"
permalink: /cookbook/lists/long-lists/
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

```dart
final items = new List<String>.generate(10000, (i) => "Item $i");
```

## 2. Convert the data source into Widgets

In order to display our List of Strings, we'll need to render each String as 
a Widget!

This is where the `ListView.builder` will come into play. In our case, we'll 
display each String on it's own line. 

```dart
new ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return new ListTile(
      title: new Text('${items[index]}'),
    );
  },
);
```

## Complete Example

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp(
    items: new List<String>.generate(10000, (i) => "Item $i"),
  ));
}

class MyApp extends StatelessWidget {
  final List<String> items;

  MyApp({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Long List';

    return new MaterialApp(
      title: title,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return new ListTile(
              title: new Text('${items[index]}'),
            );
          },
        ),
      ),
    );
  }
}
```

![Long Lists Demo](/images/cookbook/long-lists.gif)