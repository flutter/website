---
layout: page
title: "Creating a Grid List"
permalink: /cookbook/lists/grid-lists/
---

In some cases, you might want to display your items as a Grid rather than 
a normal list of items that come one after the next. For this task, we'll employ
the [`GridView`](https://docs.flutter.io/flutter/widgets/GridView-class.html) 
Widget. 

The simplest way to get started using grids is by using the 
[`GridView.count`](https://docs.flutter.io/flutter/widgets/GridView/GridView.count.html)
constructor, because it allow us to specify how many rows or columns we'd like.

In this example, we'll generate a List of 100 Widgets that display their
index in the list. This will help us us visualize how `GridView`  works.

```dart
new GridView.count(
  // Create a grid with 2 columns. If you change the scrollDirection to 
  // horizontal, this would produce 2 rows.
  crossAxisCount: 2,
  // Generate 100 Widgets that display their index in the List
  children: new List.generate(100, (index) {
    return new Center(
      child: new Text(
        'Item $index',
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }),
);
```

## Complete Example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';

    return new MaterialApp(
      title: title,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this would produce 2 rows.
          crossAxisCount: 2,
          // Generate 100 Widgets that display their index in the List
          children: new List.generate(100, (index) {
            return new Center(
              child: new Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline,
              ),
            );
          }),
        ),
      ),
    );
  }
}
```
