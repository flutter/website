---
title: Creating a Grid List
prev:
  title: Create a horizontal list
  path: /docs/cookbook/lists/horizontal-list
next:
  title: Creating lists with different types of items
  path: /docs/cookbook/lists/mixed-list
---

In some cases, you might want to display your items as a Grid rather than
a normal list of items that come one after the next. For this task, we'll employ
the [`GridView`]({{site.api}}/flutter/widgets/GridView-class.html) Widget.

The simplest way to get started using grids is by using the
[`GridView.count`]({{site.api}}/flutter/widgets/GridView/GridView.count.html)
constructor, because it allow us to specify how many rows or columns we'd like.

In this example, we'll generate a List of 100 Widgets that display their
index in the list. This will help us visualize how `GridView`  works.

<!-- skip -->
```dart
GridView.count(
  // Create a grid with 2 columns. If you change the scrollDirection to
  // horizontal, this would produce 2 rows.
  crossAxisCount: 2,
  // Generate 100 Widgets that display their index in the List
  children: List.generate(100, (index) {
    return Center(
      child: Text(
        'Item $index',
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }),
);
```

## Complete example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this would produce 2 rows.
          crossAxisCount: 2,
          // Generate 100 Widgets that display their index in the List
          children: List.generate(100, (index) {
            return Center(
              child: Text(
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
