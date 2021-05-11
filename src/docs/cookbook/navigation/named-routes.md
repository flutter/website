---
title: Navigate with named routes
description: How to implement named routes for navigating between screens.
prev:
  title: Navigate to a new screen and back
  path: /docs/cookbook/navigation/navigation-basics
next:
  title: Pass arguments to a named route
  path: /docs/cookbook/navigation/navigate-with-arguments
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="../null_safety_examples/cookbook/navigation/named_routes"?>

In the [Navigate to a new screen and back][] recipe,
you learned how to navigate to a new screen by creating a new route and
pushing it to the [`Navigator`][].

However, if you need to navigate to the same screen in many parts
of your app, this approach can result in code duplication.
The solution is to define a _named route_,
and use the named route for navigation.

To work with named routes,
use the [`Navigator.pushNamed()`][] function.
This example replicates the functionality from the original recipe,
demonstrating how to use named routes using the following steps:

  1. Create two screens.
  2. Define the routes.
  3. Navigate to the second screen using `Navigator.pushNamed()`.
  4. Return to the first screen using `Navigator.pop()`.

## 1. Create two screens

First, create two screens to work with. The first screen contains a
button that navigates to the second screen. The second screen contains a
button that navigates back to the first.

<?code-excerpt "lib/main_original.dart"?>
```dart
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the second screen when tapped.
          },
          child: Text('Launch screen'),
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
        title: Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
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

Next, define the routes by providing additional properties
to the [`MaterialApp`][] constructor: the `initialRoute`
and the `routes` themselves.

The `initialRoute` property defines which route the app should start with.
The `routes` property defines the available named routes and the widgets
to build when navigating to those routes.

{% comment %}
RegEx removes the trailing comma
{% endcomment %}
<?code-excerpt "lib/main.dart (MaterialApp)" replace="/,$//g"?>
```dart
MaterialApp(
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
)
```

{{site.alert.warning}}
  When using `initialRoute`, **don't** define a `home` property.
{{site.alert.end}}

## 3. Navigate to the second screen

With the widgets and routes in place, trigger navigation by using the
[`Navigator.pushNamed()`][] method.
This tells Flutter to build the widget defined in the
`routes` table and launch the screen.

In the `build()` method of the `FirstScreen` widget, update the `onPressed()`
callback:

{% comment %}
RegEx removes the trailing comma
{% endcomment %}
<?code-excerpt "lib/main.dart (PushNamed)" replace="/,$//g"?>
```dart
// Within the `FirstScreen` widget
onPressed: () {
  // Navigate to the second screen using a named route.
  Navigator.pushNamed(context, '/second');
}
```

## 4. Return to the first screen

To navigate back to the first screen, use the
[`Navigator.pop()`][] function.

{% comment %}
RegEx removes the trailing comma
{% endcomment %}
<?code-excerpt "lib/main.dart (Pop)" replace="/,$//g"?>
```dart
// Within the SecondScreen widget
onPressed: () {
  // Navigate back to the first screen by popping the current route
  // off the stack.
  Navigator.pop(context);
}
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
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
    ),
  );
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the `FirstScreen` widget
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
          child: Text('Launch screen'),
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
        title: Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the SecondScreen widget
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

<noscript>
  <img src="/images/cookbook/navigation-basics.gif" alt="Navigation Basics Demo" class="site-mobile-screenshot" />
</noscript>


[`MaterialApp`]: {{site.api}}/flutter/material/MaterialApp-class.html
[Navigate to a new screen and back]: /docs/cookbook/navigation/navigation-basics
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`Navigator.pop()`]: {{site.api}}/flutter/widgets/Navigator/pop.html
[`Navigator.pushNamed()`]: {{site.api}}/flutter/widgets/Navigator/pushNamed.html
