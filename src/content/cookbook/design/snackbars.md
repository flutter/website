---
title: Display a snackbar
description: How to implement a snackbar to display messages.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/design/snackbars/"?>

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

<?code-excerpt "lib/partial.dart (Scaffold)"?>
```dart
return MaterialApp(
  title: 'SnackBar Demo',
  home: Scaffold(
    appBar: AppBar(title: const Text('SnackBar Demo')),
    body: const SnackBarPage(),
  ),
);
```

## 2. Display a `SnackBar`

With the `Scaffold` in place, display a `SnackBar`.
First, create a `SnackBar`, then display it using `ScaffoldMessenger`.

<?code-excerpt "lib/partial.dart (DisplaySnackBar)"?>
```dart
const snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
ScaffoldMessenger.of(context).showSnackBar(snackBar);
```

:::note
To learn more, watch this short Widget of the Week video on
the `ScaffoldMessenger` widget:

{% ytEmbed 'lytQi-slT5Y', 'ScaffoldMessenger | Flutter widget of the week' %}
:::

## 3. Provide an optional action

You might want to provide an action to the user when
the SnackBar is displayed.
For example, if the user accidentally deletes a message,
they might use an optional action in the SnackBar to recover
the message.

Here's an example of providing
an additional `action` to the `SnackBar` widget:

<?code-excerpt "lib/main.dart (SnackBarAction)"?>
```dart
final snackBar = SnackBar(
  content: const Text('Yay! A SnackBar!'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);
```

## Interactive example

:::note
In this example, the SnackBar displays when a user taps a button.
For more information on working with user input,
see the [Gestures][] section of the cookbook.
:::

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter snackbar hands-on example in DartPad" run="true"
import 'package:flutter/material.dart';

void main() => runApp(const SnackBarDemo());

class SnackBarDemo extends StatelessWidget {
  const SnackBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('SnackBar Demo')),
        body: const SnackBarPage(),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
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
        child: const Text('Show SnackBar'),
      ),
    );
  }
}
```

<noscript>
  <img src="/assets/images/docs/cookbook/snackbar.webp" alt="SnackBar Demo" class="site-mobile-screenshot" />
</noscript>

[Gestures]: /cookbook#gestures
[`Scaffold`]: {{site.api}}/flutter/material/Scaffold-class.html
[`SnackBar`]: {{site.api}}/flutter/material/SnackBar-class.html
[material library]: {{site.api}}/flutter/material/material-library.html
