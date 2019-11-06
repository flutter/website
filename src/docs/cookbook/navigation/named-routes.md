---
title: Navigate with named routes
prev:
  title: Navigate to a new screen and back
  path: /docs/cookbook/navigation/navigation-basics
next:
  title: Pass arguments to a named route
  path: /docs/cookbook/navigation/navigate-with-arguments
---

In the [Navigate to a new screen and
back](/docs/cookbook/navigation/navigation-basics) recipe,
you learned how to navigate to a new screen by creating a new route and
pushing it to the
[`Navigator`]({{site.api}}/flutter/widgets/Navigator-class.html).

However, if you need to navigate to the same screen in many parts
of your app, this approach can result in code duplication.
The solution is to define a _named route_,
and use the named route for navigation.

To work with named routes, use the
[`Navigator.pushNamed()`]({{site.api}}/flutter/widgets/Navigator/pushNamed.html)
function. This example replicates the functionality from the original
recipe, demonstrating how to use named routes using the following steps:

  1. Create two screens.
  2. Define the routes.
  3. Navigate to the second screen using `Navigator.pushNamed()`.
  4. Return to the first screen using `Navigator.pop()`.

## 1. Create two screens

First, create two screens to work with. The first screen contains a
button that navigates to the second screen. The second screen contains a
button that navigates back to the first.

```dart
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen when tapped.
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first screen when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
```

## 2. Define the routes

Next, define the routes by providing additional properties to the
[`MaterialApp`]({{site.api}}/flutter/material/MaterialApp-class.html)
constructor: the `initialRoute` and the `routes` themselves.

The `initialRoute` property defines which route the app should start with.
The `routes` property defines the available named routes and the widgets
to build when navigating to those routes.

<!-- skip -->
```dart
MaterialApp(
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => FirstScreen(),
    // When navigating to the "/second" route, build the SecondScreen widget.
    '/second': (context) => SecondScreen(),
  },
);
```

{{site.alert.warning}}
  When using `initialRoute`, **don't** define a `home` property.
{{site.alert.end}}

## 3. Navigate to the second screen

With the widgets and routes in place, trigger navigation by using the
[`Navigator.pushNamed()`]({{site.api}}/flutter/widgets/Navigator/pushNamed.html)
method. This tells Flutter to build the widget defined in the
`routes` table and launch the screen.

In the `build()` method of the `FirstScreen` widget, update the `onPressed()`
callback:

<!-- skip -->
```dart
// Within the `FirstScreen` widget
onPressed: () {
  // Navigate to the second screen using a named route.
  Navigator.pushNamed(context, '/second');
}
```

## 4. Return to the first screen

To navigate back to the first screen, use the
[`Navigator.pop()`]({{site.api}}/flutter/widgets/Navigator/pop.html)
function.

<!-- skip -->
```dart
// Within the SecondScreen widget
onPressed: () {
  // Navigate back to the first screen by popping the current route
  // off the stack.
  Navigator.pop(context);
}
```

## Complete example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => FirstScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => SecondScreen(),
    },
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Launch screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
```

![Navigation Basics Demo](/images/cookbook/navigation-basics.gif){:.site-mobile-screenshot}
