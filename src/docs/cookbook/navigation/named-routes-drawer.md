---
title: Navigate with named routes within a drawer
---

In the
[Navigate with named routes](/docs/cookbook/navigation/named-routes/)
recipe, we learned how to Navigate to the same screen in many parts of our apps
via a "named route". In the
[Add a Drawer to a screen](/docs/cookbook/navigation/design/drawer/) recipe, we
learned how to user a drawer for Navigation.

This example will replicate the functionality from the original two recipes,
demonstrating how to combine named routes with a drawer to Navigate between
pages at the root of an application.

## Directions

  1. Create a Drawer
  1. Create two screens
  3. Define the routes

## 1. Create a Drawer

In order to share Navigation logic used in the drawer between screens we'll
create a `NavigationDrawer` widget. Within the `onTap` of our `ListTitle`
widgets we'll use the
[`Navigator.pushReplacementNamed`](https://docs.flutter.io/flutter/widgets/Navigator/pushReplacementNamed.html)
function. This associates the list items in our `Drawer` with the screens we'll
define our `routes` table.

<!-- skip -->
```dart
class NavigationDrawer extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    // Create the Drawer which defines Navigation logic we'll reuse in each
    // widget residing at the root of our application.
    return Drawer(
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
            title: Text('First'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: Text('Second'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushReplacementNamed(context, '/second');
            },
          ),
        ],
      ),
    );
  }
}
```

## 2. Create two screens

Second, we'll need two screens to navigate to. Both just contain Text widgets.

<!-- skip -->
```dart
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Reuse our NavigationDrawer between widgets
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: Text('One!'),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Reuse our NavigationDrawer between widgets
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: Text('Two!'),
      ),
    );
  }
}
```

## 3. Define the routes

Next, we'll need to define our routes by providing additional properties to the
[`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html)
constructor: the `initialRoute` and the `routes` themselves.

The `initialRoute` property defines which route our app should start with. The
`routes` property defines the available named routes and the Widgets that should
be built when we navigate to those routes.

<!-- skip -->
```dart
MaterialApp(
  title: 'Named Routes Drawer Demo',
  // Start the app with the "/" named route. In our case, the app will start
  // on the FirstScreen Widget
  initialRoute: '/',
  routes: {
    // When we navigate to the "/" route, build the FirstScreen Widget
    '/': (context) => FirstScreen(),
    // When we navigate to the "/second" route, build the SecondScreen Widget
    '/second': (context) => SecondScreen(),
  },
);
```

Note: When using `initialRoute`, be sure you do not define a `home` property.

## Complete example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Drawer Demo',
    // Start the app with the "/" named route. In our case, the app will start
    // on the FirstScreen Widget
    initialRoute: '/',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      '/': (context) => FirstScreen(),
      // When we navigate to the "/second" route, build the SecondScreen Widget
      '/second': (context) => SecondScreen(),
    },
  ));
}

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            title: Text('First'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: Text('Second'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pushReplacementNamed(context, '/second');
            },
          ),
        ],
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: Text('One!'),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: Text('Two!'),
      ),
    );
  }
}
```

![Named Routes Drawer Demo](/images/cookbook/named-routes-drawer.gif){:.site-mobile-screenshot}
