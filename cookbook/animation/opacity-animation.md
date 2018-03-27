---
layout: page
title: "Fade a Widget in and out"
permalink: /cookbook/animation/opacity-animation/
---

As UI developers, we often need to show and hide elements on screen. However, 
quickly popping elements on and off the screen can feel jarring to end users.
Instead, we can fade elements in and out with an opacity animation to create
a smooth experience.

In Flutter, we can achieve this task using the [`AnimatedOpacity`](https://docs.flutter.io/flutter/widgets/AnimatedOpacity-class.html)
Widget.

## Directions

  1. Show a box to fade in and out
  2. Define a `StatefulWidget`
  3. Display a button that toggles the visibility
  4. Fade the box in and out
  
## 1. Create a box to fade in and out

First, we'll need something to fade in and out! In this example, we'll draw a
green box on screen.

```dart
new Container(
  width: 200.0,
  height: 200.0,
  color: Colors.green,
);
```

## 2. Define a `StatefulWidget`

Now that we have a green box to animate, we'll need a way to know whether the 
box should be visible or invisible. To accomplish this, we can use a 
[`StatefulWidget`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html).

A `StatefulWidget` is a class that creates a `State` object. The `State` object
holds some data about our app and provides a way to update that data. When we 
update the data, we can also ask Flutter to rebuild our UI with those changes.

In our case, we'll have one piece of data: a boolean representing whether the 
button is visible or invisible. 

To construct a `StatefulWidget`, we need to create two classes: A 
`StatefulWidget` and a corresponding `State` class. Pro tip: The Flutter plugins 
for Android Studio and VSCode include the `stful` snippet to quickly generate 
this code!

```dart
// The StatefulWidget's job is to take in some data and create a State class.
// In this case, our Widget takes in a title, and creates a _MyHomePageState.
class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

// The State class is responsible for two things: holding some data we can 
// update and building the UI using that data.
class _MyHomePageState extends State<MyHomePage> {
  // Whether the green box should be visible or invisible
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    // The green box will go here with some other Widgets!
  }
}
```

## 3. Display a button that toggles the visibility

Now that we have some data to determine whether our green box should be visible
or invisible, we'll need a way update that data. In our case, if the box is
visible, we want to hide it. If the box is hidden, we want to show it!  

To achieve this, we'll display a button. When a user presses the button, we'll 
flip the boolean from true to false, or false to true. We need to make this 
change using [`setState`](https://docs.flutter.io/flutter/widgets/State/setState.html),
which is a method on the `State` class. This will let Flutter know it needs to 
rebuild the Widget.

Note: For more information on working with user input, please see the 
[Handling Gestures](/cookbook/#handling-gestures) section of the Cookbook.

```dart
new FloatingActionButton(
  onPressed: () {
    // Make sure we call setState! This will tell Flutter to rebuild the
    // UI with our changes!
    setState(() {
      _visible = !_visible;
    });
  },
  tooltip: 'Toggle Opacity',
  child: new Icon(Icons.flip),
);
``` 

## 4. Fade the box in and out

We've got a green box on screen. We've got a button to toggle the visibility
to `true` or `false`. So how do we fade the box in and out? With an 
[`AnimatedOpacity`](https://docs.flutter.io/flutter/widgets/AnimatedOpacity-class.html) 
Widget!

The `AnimatedOpacity` Widget requires three arguments:

  * `opacity`: A value from 0.0 (invisible) to 1.0 (fully visible).
  * `duration`: How long the animation should take to complete
  * `child`: The Widget to animate. In our case, the green box.

```dart
new AnimatedOpacity(
  // If the Widget should be visible, animate to 1.0 (fully visible). If
  // the Widget should be hidden, animate to 0.0 (invisible).
  opacity: _visible ? 1.0 : 0.0,
  duration: new Duration(milliseconds: 500),
  // The green box needs to be the child of the AnimatedOpacity
  child: new Container(
    width: 200.0,
    height: 200.0,
    color: Colors.green,
  ),
);
```

## Complete Example

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Opacity Demo';
    return new MaterialApp(
      title: appTitle,
      home: new MyHomePage(title: appTitle),
    );
  }
}

// The StatefulWidget's job is to take in some data and create a State class.
// In this case, our Widget takes in a title, and creates a _MyHomePageState.
class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

// The State class is responsible for two things: holding some data we can
// update and building the UI using that data.
class _MyHomePageState extends State<MyHomePage> {
  // Whether the green box should be visible or invisible
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new AnimatedOpacity(
          // If the Widget should be visible, animate to 1.0 (fully visible). If
          // the Widget should be hidden, animate to 0.0 (invisible).
          opacity: _visible ? 1.0 : 0.0,
          duration: new Duration(milliseconds: 500),
          // The green box needs to be the child of the AnimatedOpacity
          child: new Container(
            width: 200.0,
            height: 200.0,
            color: Colors.green,
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          // Make sure we call setState! This will tell Flutter to rebuild the
          // UI with our changes!
          setState(() {
            _visible = !_visible;
          });
        },
        tooltip: 'Toggle Opacity',
        child: new Icon(Icons.flip),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

![Fade In and Out Demo](/images/cookbook/fade-in-out.gif)
