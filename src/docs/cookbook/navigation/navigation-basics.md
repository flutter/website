---
title: Navigate to a new screen and back
description: How to navigate between routes
prev:
  title: Animating a Widget across screens
  path: /docs/cookbook/navigation/hero-animations
next:
  title: Navigate with named routes
  path: /docs/cookbook/navigation/named-routes
---

Most apps contain several screens for displaying different types of information.
For example, an app might have a screen that displays products. Users can then
tap the image of a product to get more detailed information on a new screen.

{{site.alert.info}}
  **Terminology**: In Flutter, _screens_ and _pages_ are called _routes_.
  The remainder of this doc refers to routes.
{{site.alert.end}}

In Android, a route is equivalent to an Activity.
In iOS, a route is equivalent to a ViewController.
In Flutter, a route is just a widget.

How do you navigate to a new route? By using the
[`Navigator`]({{site.api}}/flutter/widgets/Navigator-class.html).

## Directions

The next few sections show how to navigate between two routes,
using these steps:

  1. Create two routes
  2. Navigate to the second route using Navigator.push()
  3. Return to the first route using Navigator.pop()

## 1. Create two routes

First, create two routes to work with. Since this is a basic example,
each route contains only a single button. Tapping the button on the
first route navigates to the second route. Tapping the button on the
second route returns to the first route.

First, set up the visual structure:

```dart
class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
```

## 2. Navigate to the second route using Navigator.push()

To switch to a new route, use the
[`Navigator.push()`]({{site.api}}/flutter/widgets/Navigator/push.html)
method. The `push()` method adds a `Route` to the stack of routes managed by
the Navigator. Where does the `Route` come from?
You can create your own, or use a
[`MaterialPageRoute`]({{site.api}}/flutter/material/MaterialPageRoute-class.html),
out of the box. `MaterialPageRoute` is handy because it transitions to the
new route using a platform-specific animation.

In the `build()` method of the `FirstRoute` widget, update the `onPressed()`
callback:

<!-- skip -->
```dart
// Within the `FirstRoute` widget
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SecondRoute()),
  );
}
```

## 3. Return to the first route using Navigator.pop()

How do you close the second route and return to the first? By using the
[`Navigator.pop()`]({{site.api}}/flutter/widgets/Navigator/pop.html)
method. The `pop()` method removes the current `Route` from the stack of
routes managed by the navigator.

To implement a return to the original route, update the `onPressed()`
callback in the `SecondRoute` widget:

<!-- skip -->
```dart
// Within the SecondRoute widget
onPressed: () {
  Navigator.pop(context);
}
```

## Complete example

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
```

{% comment %}
We need a new GIF that shows "Route" instead of "Screen".
{% endcomment %}

![Navigation Basics Demo](/images/cookbook/navigation-basics.gif){:.site-mobile-screenshot}
