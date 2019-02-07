---
title: Displaying SnackBars
short-title: SnackBars
description: How to implement a SnackBar to display messages.
prev:
  title: Add a Drawer to a screen
  path: /docs/cookbook/design/drawer
next:
  title: Exporting fonts from a package
  path: /docs/cookbook/design/package-fonts
---

In some cases, it can be handy to briefly inform our users when certain actions
take place. For example, when a user swipes away a message in a list, we might
want to inform them the message has been deleted. We might even want to give
them an option to undo the action!

In Material Design, this is the job of a
[SnackBar]({{site.api}}/flutter/material/SnackBar-class.html).

## Directions

  1. Create a `Scaffold`
  2. Display a `SnackBar`
  3. Provide an additional action

## 1. Create a `Scaffold`

When creating apps that follow the Material Design guidelines, we'll want to
give our apps a consistent visual structure. In this case, we'll need to display
the `SnackBar` at the bottom of the screen, without overlapping other important
Widgets, such as the `FloatingActionButton`!

The [Scaffold]({{site.api}}/flutter/material/Scaffold-class.html)
Widget from the
[material library]({{site.api}}/flutter/material/material-library.html)
creates this visual structure for us and ensures important Widgets don't
overlap!

<!-- skip -->
```dart
Scaffold(
  appBar: AppBar(
    title: Text('SnackBar Demo'),
  ),
  body: SnackBarPage(), // You'll fill this in below!
);
```

## 2. Display a `SnackBar`

With the `Scaffold` in place, you can display a `SnackBar`! First, you need to
create a `SnackBar`, then display it using the `Scaffold`.

<!-- skip -->
```dart
final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

// Find the Scaffold in the Widget tree and use it to show a SnackBar
Scaffold.of(context).showSnackBar(snackBar);
```

## 3. Provide an additional action

In some cases, you might want to provide an additional action to the user when
the SnackBar is displayed. For example, if they've accidentally deleted a
message, we could provide an action to undo that change.

To achieve this, we can provide an additional `action` to the `SnackBar` Widget.

```dart
final snackBar = SnackBar(
  content: Text('Yay! A SnackBar!'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change!
    },
  ),
);
```

## Complete example

Note: In this example, the SnackBar displays when a user taps on a button. For
more information on working with user input, please see the
[Gestures](/docs/cookbook#gestures) section of the Cookbook.

```dart
import 'package:flutter/material.dart';

void main() => runApp(SnackBarDemo());

class SnackBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SnackBar Demo'),
        ),
        body: SnackBarPage(),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change!
              },
            ),
          );

          // Find the Scaffold in the Widget tree and use it to show a SnackBar!
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}
```

![SnackBar Demo](/images/cookbook/snackbar.gif){:.site-mobile-screenshot}
