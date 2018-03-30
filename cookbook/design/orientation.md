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

  1. Use the `MediaQuery` class to determine the `Orientation`
  2. Build a List with either 2 or 3 columns

## 1. Use the `MediaQuery` class to determine the `Orientation`

In order to determine the `Orientation` of the screen, we need to use the 
[`MediaQuery`](https://docs.flutter.io/flutter/widgets/MediaQuery-class.html) 
class within our `build` function: 

```dart
final orientation = MediaQuery.of(context).orientation;
```

The `MediaQuery` class returns more than just the `Orientation`. You can
also use this class to determine the size of the screen, the device pixel ratio, 
and more!

## 2. Build a List with either 2 or 3 columns

Now that we know the orientation of the screen, we can build a list that 
displays 2 columns in portrait mode, or 3 columns in landscape mode.

```dart
new GridView.count(
  crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
  // ...
);
```

To learn more about working with `GridViews`, please see the 
[Creating a grid List](/cookbook/lists/grid-lists/) recipe.

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
      home: new OrientationList(title: appTitle,),
    );
  }
}

class OrientationList extends StatelessWidget {
  final String title;

  OrientationList({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new GridView.count(
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
      ),
    );
  }
}
```

![Orientation Demo](/images/cookbook/orientation.gif)