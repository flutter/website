---
title: Create a grid list
description: How to implement a grid list.
prev:
  title: Create a horizontal list
  path: /docs/cookbook/lists/horizontal-list
next:
  title: Create lists with different types of items
  path: /docs/cookbook/lists/mixed-list
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

In some cases, you might want to display your items as a grid rather than
a normal list of items that come one after the next.
For this task, use the [`GridView`][] widget.

The simplest way to get started using grids is by using the
[`GridView.count()`][] constructor,
because it allows you to specify how many rows or columns you'd like.

To visualize how `GridView` works,
generate a list of 100 widgets that display their index in the list.

<!-- skip -->
```dart
GridView.count(
  // Create a grid with 2 columns. If you change the scrollDirection to
  // horizontal, this produces 2 rows.
  crossAxisCount: 2,
  // Generate 100 widgets that display their index in the List.
  children: List.generate(100, (index) {
    return Center(
      child: Text(
        'Item $index',
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }),
);
```

## Interactive example

```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
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
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(100, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }),
        ),
      ),
    );
  }
}
```

<noscript>
  <img src="/images/cookbook/grid-list.gif" alt="Grid List Demo" class="site-mobile-screenshot" />
</noscript>

[`GridView`]: {{site.api}}/flutter/widgets/GridView-class.html
[`GridView.count()`]: {{site.api}}/flutter/widgets/GridView/GridView.count.html
