---
title: Updating the UI based on orientation
prev:
  title: Exporting fonts from a package
  path: /docs/cookbook/design/package-fonts
next:
  title: Using Themes to share colors and font styles
  path: /docs/cookbook/design/themes
---

In certain cases, it can be handy to update the design of an app when the user
rotates their screen from portrait mode to landscape mode. For example, we may
want to show one item after the next in portrait mode, yet put those same items
side-by-side in landscape mode.

In Flutter, we can build different layouts depending on a given
[`Orientation`]({{site.api}}/flutter/widgets/Orientation-class.html).
In this example, we'll build a list that displays 2 columns in portrait mode and
3 columns in landscape mode.

## Directions

  1. Build a `GridView` with 2 columns
  2. Use an `OrientationBuilder` to change the number of columns

## 1. Build a `GridView` with 2 columns

First, we'll need a list of items to work with. Rather than using a normal list,
we'll want a list that displays items in a Grid. For now, we'll create a grid
with 2 columns.

<!-- skip -->
```dart
GridView.count(
  // A list with 2 columns
  crossAxisCount: 2,
  // ...
);
```

To learn more about working with `GridViews`, please see the
[Creating a grid list](/docs/cookbook/lists/grid-lists/) recipe.

## 2. Use an `OrientationBuilder` to change the number of columns

In order to determine the current `Orientation`, we can use the
[`OrientationBuilder`]({{site.api}}/flutter/widgets/OrientationBuilder-class.html)
Widget. The `OrientationBuilder` calculates the current `Orientation` by
comparing the width and height available to the parent widget, and rebuilds
when the size of the parent changes.

Using the `Orientation`, we can build a list that displays 2 columns in portrait
mode, or 3 columns in landscape mode.

<!-- skip -->
```dart
OrientationBuilder(
  builder: (context, orientation) {
    return GridView.count(
      // Create a grid with 2 columns in portrait mode, or 3 columns in
      // landscape mode.
      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
    );
  },
);
```

Note: If you're interested in the orientation of the screen, rather than
the amount of space available to the parent, please use
`MediaQuery.of(context).orientation` instead of an `OrientationBuilder` Widget.

## Complete example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Orientation Demo';

    return MaterialApp(
      title: appTitle,
      home: OrientationList(
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
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            // Create a grid with 2 columns in portrait mode, or 3 columns in
            // landscape mode.
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
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
        },
      ),
    );
  }
}
```

![Orientation Demo](/images/cookbook/orientation.gif){:.site-mobile-screenshot}
