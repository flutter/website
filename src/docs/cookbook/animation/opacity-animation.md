---
title: Fade a widget in and out
description: How to fade a widget in and out.
prev:
  title: Animate the properties of a container
  path: /docs/cookbook/animation/animated-container
next:
  title: Add a drawer to a screen
  path: /docs/cookbook/design/drawer
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
---

<?code-excerpt path-base="../null_safety_examples/cookbook/animation/opacity_animation/"?>

UI developers often need to show and hide elements on screen.
However, quickly popping elements on and off the screen can
feel jarring to end users. Instead,
fade elements in and out with an opacity animation to create
a smooth experience.

The [`AnimatedOpacity`][] widget makes it easy to perform opacity
animations. This recipe uses the following steps:

  1. Create a box to fade in and out.
  2. Define a `StatefulWidget`.
  3. Display a button that toggles the visibility.
  4. Fade the box in and out.

## 1. Create a box to fade in and out

First, create something to fade in and out. For this example,
draw a green box on screen.

<!-- skip -->
```dart
Container(
  width: 200.0,
  height: 200.0,
  color: Colors.green,
);
```

## 2. Define a `StatefulWidget`

Now that you have a green box to animate,
you need a way to know whether the box should be visible.
To accomplish this, use a [`StatefulWidget`][].

A `StatefulWidget` is a class that creates a `State` object.
The `State` object holds some data about the app and provides a way to
update that data. When updating the data,
you can also ask Flutter to rebuild the UI with those changes.

In this case, you have one piece of data:
a boolean representing whether the button is visible.

To construct a `StatefulWidget`, create two classes: A
`StatefulWidget` and a corresponding `State` class.
Pro tip: The Flutter plugins for Android Studio and VSCode include
the `stful` snippet to quickly generate this code.

<?code-excerpt "lib/starter.dart (Starter)" remove="return Container();"?>
```dart
// The StatefulWidget's job is to take data and create a State class.
// In this case, the widget takes a title, and creates a _MyHomePageState.
class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// The State class is responsible for two things: holding some data you can
// update and building the UI using that data.
class _MyHomePageState extends State<MyHomePage> {
  // Whether the green box should be visible.
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    // The green box goes here with some other Widgets.
  }
}
```

## 3. Display a button that toggles the visibility

Now that you have some data to determine whether the green box
should be visible, you need a way to update that data.
In this example, if the box is visible, hide it.
If the box is hidden, show it.

To handle this, display a button. When a user presses the button,
flip the boolean from true to false, or false to true.
Make this change using [`setState()`][],
which is a method on the `State` class.
This tells Flutter to rebuild the widget.

For more information on working with user input,
see the [Gestures][] section of the cookbook.

<?code-excerpt "lib/main.dart (FAB)" replace="/^floatingActionButton: //g;/,$//g"?>
```dart
FloatingActionButton(
  onPressed: () {
    // Call setState. This tells Flutter to rebuild the
    // UI with the changes.
    setState(() {
      _visible = !_visible;
    });
  },
  tooltip: 'Toggle Opacity',
  child: Icon(Icons.flip),
)
```

## 4. Fade the box in and out

You have a green box on screen and a button to toggle the visibility
to `true` or `false`. How to fade the box in and out? With an
[`AnimatedOpacity`][] widget.

The `AnimatedOpacity` widget requires three arguments:

  * `opacity`: A value from 0.0 (invisible) to 1.0 (fully visible).
  * `duration`: How long the animation should take to complete.
  * `child`: The widget to animate. In this case, the green box.

<?code-excerpt "lib/main.dart (AnimatedOpacity)" replace="/^child: //g;/,$//g"?>
```dart
AnimatedOpacity(
  // If the widget is visible, animate to 0.0 (invisible).
  // If the widget is hidden, animate to 1.0 (fully visible).
  opacity: _visible ? 1.0 : 0.0,
  duration: Duration(milliseconds: 500),
  // The green box must be a child of the AnimatedOpacity widget.
  child: Container(
    width: 200.0,
    height: 200.0,
    color: Colors.green,
  ),
)
```

## Interactive example

<?code-excerpt "lib/main.dart"?>
```run-dartpad:theme-light:mode-flutter:run-true:width-100%:height-600px:split-60:ga_id-interactive_example:null_safety-true
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Opacity Demo';
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

// The StatefulWidget's job is to take data and create a State class.
// In this case, the widget takes a title, and creates a _MyHomePageState.
class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// The State class is responsible for two things: holding some data you can
// update and building the UI using that data.
class _MyHomePageState extends State<MyHomePage> {
  // Whether the green box should be visible
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedOpacity(
          // If the widget is visible, animate to 0.0 (invisible).
          // If the widget is hidden, animate to 1.0 (fully visible).
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          // The green box must be a child of the AnimatedOpacity widget.
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.green,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call setState. This tells Flutter to rebuild the
          // UI with the changes.
          setState(() {
            _visible = !_visible;
          });
        },
        tooltip: 'Toggle Opacity',
        child: Icon(Icons.flip),
      ),
    );
  }
}
```

<noscript>
  <img src="/images/cookbook/fade-in-out.gif" alt="Fade In and Out Demo" class="site-mobile-screenshot" />
</noscript>

[`AnimatedOpacity`]: {{site.api}}/flutter/widgets/AnimatedOpacity-class.html
[Gestures]: /docs/cookbook#gestures
[`StatefulWidget`]: {{site.api}}/flutter/widgets/StatefulWidget-class.html
[`setState()`]: {{site.api}}/flutter/widgets/State/setState.html
