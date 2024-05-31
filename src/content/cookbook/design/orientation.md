---
title: Update the UI based on orientation
description: Respond to a change in the screen's orientation.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/design/orientation"?>

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

<?code-excerpt "lib/partials.dart (GridViewCount)"?>
```dart
return GridView.count(
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

<?code-excerpt "lib/partials.dart (OrientationBuilder)"?>
```dart
body: OrientationBuilder(
  builder: (context, orientation) {
    return GridView.count(
      // Create a grid with 2 columns in portrait mode,
      // or 3 columns in landscape mode.
      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
    );
  },
),
```

:::note
If you're interested in the orientation of the screen,
rather than the amount of space available to the parent,
use `MediaQuery.of(context).orientation` instead of an
`OrientationBuilder` widget.
:::

## Interactive example

<?code-excerpt "lib/main.dart"?>
```dartpad run="true"
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Orientation Demo';

    return const MaterialApp(
      title: appTitle,
      home: OrientationList(
        title: appTitle,
      ),
    );
  }
}

class OrientationList extends StatelessWidget {
  final String title;

  const OrientationList({super.key, required this.title});

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
                  style: Theme.of(context).textTheme.displayLarge,
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
  <img src="/assets/images/docs/cookbook/orientation.gif" alt="Orientation Demo" class="site-mobile-screenshot" />
</noscript>

## Locking device orientation

In the previous section, you learned 
how to adapt the app UI to device orientation changes.

Flutter also allows you to specify the orientations your app supports 
using the values of [`DeviceOrientation`]. You can either:

- Lock the app to a single orientation, like only the `portraitUp` position, or...
- Allow multiple orientations, like both `portraitUp` and `portraitDown`, but not landscape.

In the application `main()` method,
call [`SystemChrome.setPreferredOrientations()`]
with the list of preferred orientations that your app supports.

To lock the device to a single orientation, 
you can pass a list with a single item.

For a list of all the possible values, check out [`DeviceOrientation`].

<?code-excerpt "lib/orientation.dart (PreferredOrientations)"?>
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}
```


[Creating a grid list]: /cookbook/lists/grid-lists
[`DeviceOrientation`]: {{site.api}}/flutter/services/DeviceOrientation.html
[`OrientationBuilder`]: {{site.api}}/flutter/widgets/OrientationBuilder-class.html
[`Orientation`]: {{site.api}}/flutter/widgets/Orientation.html
[`SystemChrome.setPreferredOrientations()`]: {{site.api}}/flutter/services/SystemChrome/setPreferredOrientations.html
