---
layout: page
title: "Updating the UI based on orientation"
permalink: /cookbook/design/orientation/
---

In certain cases, it can be handy to update the design of an app when the user
rotates their screen from portrait mode to landscape mode. For example, we may 
want to show one item after the next in portrait mode, yet put those same items 
side-by-side in landscape mode.

In Flutter, we can build different layouts depending on the 
[`Orientation`](https://docs.flutter.io/flutter/widgets/Orientation-class.html)
of the screen. In this example, we'll build a list that displays 2 columns in 
portrait mode and 3 columns in landscape mode.

## Directions

  1. Build a `GridView` with 2 columns
  2. Use an `OrientationBuilder` to change the number of columns

## 1. Build a `GridView` with 2 columns

First, we'll need a list of items to work with. Rather than using a normal list,
we'll want a list that displays items in a Grid. For now, we'll create a grid
with 2 columns.

```dart
new GridView.count(
  // A list with 2 columns
  crossAxisCount: 2,
  // ...
);
```

To learn more about working with `GridViews`, please see the 
[Creating a grid list](/cookbook/lists/grid-lists/) recipe.

## 2. Use an `OrientationBuilder` to change the number of columns

In order to determine the `Orientation` of the screen, we can use the 
[`OrientationBuilder`](https://docs.flutter.io/flutter/widgets/OrientationBuilder-class.html) 
Widget. The `OrientationBuilder` will determine the current `Orientation` and
rebuild when the `Orientation` changes.

Using the `Orientation`, we can build a list that displays 2 columns in portrait 
mode, or 3 columns in landscape mode.

```dart
new OrientationBuilder(
  builder: (context, orientation) {
    return new GridView.count(
      // Create a grid with 2 columns in portrait mode, or 3 columns in
      // landscape mode.
      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
    );
  },
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
    final appTitle = 'Orientation Demo';

    return new MaterialApp(
      title: appTitle,
      home: new OrientationList(
        title: appTitle,
      ),
    );
  }
}

class OrientationList extends StatelessWidget {
  final String title;

  OrientationList({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(title)),
      body: new OrientationBuilder(
        builder: (context, orientation) {
          return new GridView.count(
            // Create a grid with 2 columns in portrait mode, or 3 columns in
            // landscape mode.
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
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
        },
      ),
    );
  }
}
```

![Orientation Demo](/images/cookbook/orientation.gif)