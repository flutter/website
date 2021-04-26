---
title: Update the UI based on orientation
description: Respond to a change in the screen's orientation.
prev:
  title: Export fonts from a package
  path: /docs/cookbook/design/package-fonts
next:
  title: Use custom fonts
  path: /docs/cookbook/design/fonts
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="../null_safety_examples/cookbook/design/orientation"?>

In some situations,
you want to update the display of an app when the user
rotates the screen from portrait mode to landscape mode. For example,
the app might show one item after the next in portrait mode,
yet put those same items side-by-side in landscape mode.

In Flutter, you can build different layouts depending
on a given [`Orientation`][].
In this example, build a list that displays two columns in
portrait mode and three columns in landscape mode using the
following steps:

  1. Build a `GridView` with two columns.
  2. Use an `OrientationBuilder` to change the number of columns.

## 1. Build a `GridView` with two columns

First, create a list of items to work with.
Rather than using a normal list,
create a list that displays items in a grid.
For now, create a grid with two columns.

<!-- skip -->
```dart
GridView.count(
  // A list with 2 columns
  crossAxisCount: 2,
  // ...
);
```

To learn more about working with `GridViews`,
see the [Creating a grid list][] recipe.

## 2. Use an `OrientationBuilder` to change the number of columns

To determine the app's current `Orientation`, use the
[`OrientationBuilder`][] widget.
The `OrientationBuilder` calculates the current `Orientation` by
comparing the width and height available to the parent widget,
and rebuilds when the size of the parent changes.

Using the `Orientation`, build a list that displays two columns in portrait
mode, or three columns in landscape mode.

<!-- skip -->
```dart
OrientationBuilder(
  builder: (context, orientation) {
    return GridView.count(
      // Create a grid with 2 columns in portrait mode,
      // or 3 columns in landscape mode.
      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
    );
  },
);
```

{{site.alert.note}}
  If you're interested in the orientation of the screen,
  rather than the amount of space available to the parent,
  use `MediaQuery.of(context).orientation` instead of an
  `OrientationBuilder` widget.
{{site.alert.end}}

## Interactive example

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-500px:split-60:ga_id-interactive_example:null_safety-true
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

  OrientationList({Key? key, required this.title}) : super(key: key);

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
            // Generate 100 widgets that display their index in the List.
            children: List.generate(100, (index) {
              return Center(
                child: Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.headline1,
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

<noscript>
  <img src="/images/cookbook/orientation.gif" alt="Orientation Demo" class="site-mobile-screenshot" />
</noscript>


[Creating a grid list]: /docs/cookbook/lists/grid-lists
[`Orientation`]: {{site.api}}/flutter/widgets/Orientation-class.html
[`OrientationBuilder`]: {{site.api}}/flutter/widgets/OrientationBuilder-class.html
