---
title: Add a Drawer to a screen
prev:
  title: Fade a Widget in and out
  path: /docs/cookbook/animation/opacity-animation
next:
  title: Displaying SnackBars
  path: /docs/cookbook/design/snackbars
---

In apps that employ Material Design, there are two primary options for
navigation: tabs and drawers. When there is insufficient space to support tabs,
Drawers provide a handy alternative.

In Flutter, we can use the [`Drawer`]({{site.api}}/flutter/material/Drawer-class.html)
Widget in combination with a [`Scaffold`]({{site.api}}/flutter/material/Scaffold-class.html)
to create a layout with a Material Design Drawer.

## Directions

  1. Create a `Scaffold`
  2. Add a drawer
  3. Populate the drawer with items
  4. Close the drawer programmatically

## 1. Create a `Scaffold`

In order to add a Drawer to our app, we'll need to wrap it in a
[Scaffold]({{site.api}}/flutter/material/Scaffold-class.html)
Widget. The Scaffold Widget provides a consistent visual structure to apps that
follow the Material Design Guidelines. It also supports special Material Design
components, such as Drawers, AppBars, and SnackBars.

In this case, we'll want to create a `Scaffold` with a `drawer`:

<!-- skip -->
```dart
Scaffold(
  drawer: // We'll add our Drawer here in the next step!
);
```

## 2. Add a drawer

We can now add a drawer to our `Scaffold`. A drawer could be any Widget, but
it's often best to use the `Drawer` widget from the
[material library]({{site.api}}/flutter/material/material-library.html),
which adheres to the Material Design spec.

<!-- skip -->
```dart
Scaffold(
  drawer: Drawer(
    child: // We'll populate the Drawer in the next step!
  )
);
```

## 3. Populate the drawer with items

Now that we have a `Drawer` in place, we can add content to it. In this example,
we will use a [`ListView`]({{site.api}}/flutter/widgets/ListView-class.html).
While we could use a `Column` Widget, `ListView` is handy in this situation
because it will allow users to scroll through the drawer if the content takes up
more space than the screen supports.

We will populate the `ListView` with a
[`DrawerHeader`]({{site.api}}/flutter/material/DrawerHeader-class.html)
and two [`ListTile`]({{site.api}}/flutter/material/ListTile-class.html)
Widgets. For more information on working with Lists, please see the
[list recipes](/docs/cookbook#lists).

<!-- skip -->
```dart
Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the Drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text('Drawer Header'),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        title: Text('Item 1'),
        onTap: () {
          // Update the state of the app
          // ...
        },
      ),
      ListTile(
        title: Text('Item 2'),
        onTap: () {
          // Update the state of the app
          // ...
        },
      ),
    ],
  ),
);
```

## 4. Close the drawer programmatically

After a user taps on an item, we often want to close the drawer. How can we
achieve this? Using the [Navigator]({{site.api}}/flutter/widgets/Navigator-class.html)!

When a user opens the Drawer, Flutter adds the drawer to the navigation
stack under the hood. Therefore, to close the drawer, we can call
`Navigator.pop(context)`.

<!-- skip -->
```dart
ListTile(
  title: Text('Item 1'),
  onTap: () {
    // Update the state of the app
    // ...
    // Then close the drawer
    Navigator.pop(context);
  },
),
```

## Complete example

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('My Page!')),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

![Drawer Demo](/images/cookbook/drawer.png){:.site-mobile-screenshot}
