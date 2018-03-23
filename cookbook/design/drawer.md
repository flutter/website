---
layout: page
title: "Add a Drawer to a screen"
permalink: /cookbook/design/drawer/
---

In apps that employ Material Design, there are two primary options for
navigation: tabs and drawers. When there is insufficient space to support tabs, 
Drawers provide a handy alternative.

In Flutter, we can use the [`Drawer`](https://docs.flutter.io/flutter/material/Drawer-class.html) 
Widget in combination with a [`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html)
to create a layout with a Material Design Drawer!

## Directions

  1. Create a `Scaffold`
  2. Add a drawer
  3. Populate the drawer with items
  4. Close the drawer programmatically
  
## 1. Create a `Scaffold`

In order to add a Drawer to our app, we'll need to wrap it in a [Scaffold](https://docs.flutter.io/flutter/material/Scaffold-class.html) 
Widget. The Scaffold Widget provides a consistent visual structure to apps that
follow the Material Design Guidelines. It also supports special Material Design 
components, such as Drawers, AppBars, and SnackBars.

In this case, we'll want to create a `Scaffold` with a `drawer`:

```dart
new Scaffold(
  drawer: // We'll add our Drawer here in the next step!
);
```

## 2. Add a drawer

We can now add a drawer to our `Scaffold`. A drawer could be any Widget, but 
it's often best to use the `Drawer` widget from the [material library](https://docs.flutter.io/flutter/material/material-library.html), 
which adheres to the Material Design spec.

```dart
new Scaffold(
  drawer: new Drawer(
    child: // We'll populate the Drawer in the next step!
  )
);
```

## 3. Populate the drawer with items

Now that we have a `Drawer` in place, we can add content to it! In this example, 
we will use a [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html). 
While we could use a `Column` Widget, `ListView` is handy in this situation 
because it will allow users to scroll through the drawer if the content takes up 
more space than the screen supports.

We will populate the `ListView` with a [`DrawerHeader`](https://docs.flutter.io/flutter/material/DrawerHeader-class.html) 
and two [`ListTile`](https://docs.flutter.io/flutter/material/ListTile-class.html) 
Widgets. For more information on working with Lists, please see the 
[list recipes](/cookbook/#lists).

```dart
new Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the Drawer if there isn't enough vertical
  // space to fit everything.
  child: new ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      new DrawerHeader(
        child: new Text('Drawer Header'),
        decoration: new BoxDecoration(
          color: Colors.blue,
        ),
      ),
      new ListTile(
        title: new Text('Item 1'),
        onTap: () {
          // Update the state of the app
          // ...
        },
      ),
      new ListTile(
        title: new Text('Item 2'),
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
achieve this? Using the [Navigator](https://docs.flutter.io/flutter/widgets/Navigator-class.html)!

When a user opens the Drawer, Flutter will add the drawer to the navigation 
stack under the hood. Therefore, to close the drawer, we can call 
`Navigator.pop(context)`.  

```dart
new ListTile(
  title: new Text('Item 1'),
  onTap: () {
    // Update the state of the app
    // ...
    // Then close the drawer 
    Navigator.pop(context);
  },
),
```

## Complete Example

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: appTitle,
      home: new MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(title)),
      body: new Center(child: new Text('My Page!')),
      drawer: new Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: new ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new Text('Drawer Header'),
              decoration: new BoxDecoration(
                color: Colors.blue,
              ),
            ),
            new ListTile(
              title: new Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            new ListTile(
              title: new Text('Item 2'),
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

![Drawer Demo](/images/cookbook/drawer.png)
