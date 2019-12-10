---
title: Work with long lists
prev:
  title: Place a floating app bar above a list
  path: /docs/cookbook/lists/floating-app-bar
next:
  title: Report errors to a service
  path: /docs/cookbook/maintenance/error-reporting
---

The standard [`ListView`][] constructor works well
for small lists. To work with lists that contain
a large number of items, it's best to use the
[`ListView.builder`][] constructor.

In contrast to the default `ListView` constructor, which requires
creating all items at once, the `ListView.builder()` constructor
creates items as they're scrolled onto the screen.

## 1. Create a data source

First, you need a data source. For example, your data source
might be a list of messages, search results, or products in a store.
Most of the time, this data comes from the internet or a database.

For this example, generate a list of 10,000 Strings using the
[`List.generate`][] constructor.

<!-- skip -->
```dart
final items = List<String>.generate(10000, (i) => "Item $i");
```

## 2. Convert the data source into widgets

To display the list of strings, render each String as a widget
using `ListView.builder()`.
In this example, display each String on its own line.

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


[`List.generate`]: lh({{site.api}}/flutter/dart-core/List/List.generate.html)
[`ListView`]: {{site.api}}/flutter/widgets/ListView-class.html
[`ListView.builder`]: {{site.api}}/flutter/widgets/ListView/ListView.builder.html
