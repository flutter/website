---
title: Display a snackbar
description: How to implement a snackbar to display messages.
prev:
  title: Add a drawer to a screen
  path: /docs/cookbook/design/drawer
next:
  title: Export fonts from a package
  path: /docs/cookbook/design/package-fonts
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="../null_safety_examples/cookbook/design/snackbars/"?>

It can be useful to briefly inform your users when certain actions
take place. For example, when a user swipes away a message in a list,
you might want to inform them that the message has been deleted.
You might even want to give them an option to undo the action.

In Material Design, this is the job of a [`SnackBar`][].
This recipe implements a snackbar using the following steps:

  1. Create a `Scaffold`.
  2. Display a `SnackBar`.
  3. Provide an optional action.

## 1. Create a `Scaffold`

When creating apps that follow the Material Design guidelines,
give your apps a consistent visual structure.
In this example, display the `SnackBar` at the bottom of the screen,
without overlapping other important
widgets, such as the `FloatingActionButton`.

The [`Scaffold`][] widget, from the [material library][],
creates this visual structure and ensures that important
widgets don't overlap.

<!-- skip -->
```dart
Scaffold(
  appBar: AppBar(
    title: Text('SnackBar Demo'),
  ),
  body: SnackBarPage(), // Complete this code in the next step.
);
```

## 2. Display a `SnackBar`

With the `Scaffold` in place, display a `SnackBar`.
First, create a `SnackBar`, then display it using `ScaffoldMessenger`.

<!-- skip -->
```dart
final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
ScaffoldMessenger.of(context).showSnackBar(snackBar);
```

## 3. Provide an optional action

You might want to provide an action to the user when
the SnackBar is displayed.
For example, if the user accidentally deletes a message,
they might use an optional action in the SnackBar to recover
the message.

Here's an example of providing
an additional `action` to the `SnackBar` widget:

<!-- skip -->
```dart
final snackBar = SnackBar(
  content: Text('Yay! A SnackBar!'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);
```

## Interactive example

{{site.alert.note}}
  In this example, the SnackBar displays when a user taps a button.
  For more information on working with user input,
  see the [Gestures][] section of the cookbook.
{{site.alert.end}}

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
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
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}
```

<noscript>
  <img src="/images/cookbook/snackbar.gif" alt="SnackBar Demo" class="site-mobile-screenshot" />
</noscript>


[Gestures]: /docs/cookbook#gestures
[`Scaffold`]: {{site.api}}/flutter/material/Scaffold-class.html
[`SnackBar`]: {{site.api}}/flutter/material/SnackBar-class.html
[material library]: {{site.api}}/flutter/material/material-library.html
