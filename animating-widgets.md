---
layout: page
title: Animating Widgets
sidebar: home_sidebar
permalink: /animating-widgets/
---

This guide shows some common ways you can add animation
effects to your apps using Flutter’s animation system.

* TOC
{:toc}

## Introduction

You can use animations to make the user experience on your mobile app feel more
intuitive, dynamic, and polished. Animations are especially useful when the
screen changes state, such as when content loads or when new actions become
available.

The [`flutter/animation`](https://docs.flutter.io/flutter/animation/animation-library.html)
package in the Flutter SDK provides APIs to create animation effects in user
interfaces (UIs) that are built on the
[`StatelessWidget`](https://docs.flutter.io/flutter/widgets/StatelessWidget-class.html)
and [`StatefulWidget`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html)
classes.

Animations in Flutter are encapsulated as
[`Animation`](https://docs.flutter.io/flutter/animation/Animation-class.html)
objects that contain these key properties:

+ **Value:** The animation object’s typed value represents a data point within
a range (also called an interpolation). You can define an animation class to
generate values based on a given functional mapping, such as a linear, curve,
or step-wise function.
+ **Status:** The animation object’s current status (such as forward,
backward, completed, and dismissed), as listed by the
[`AnimationStatus`](https://docs.flutter.io/flutter/animation/AnimationStatus-class.html)
constants.

To create an animation effect in your app, you need to write code to do the
following:

1. Attach an animation object to a widget or a listener to detect changes to the
animation object.
2. Specify how the the animation is *interpolated* (that is, how the animation
objects’s value and status changes over
time) as it runs.

Based on the animation object’s properties at a specific frame, Flutter
dynamically modifies your widget visual appearence, and rebuilds the widget
tree to produce visual transitions such as sliding, scaling, rotation, height
or width changes, and fading.

Flutter's flexible animation model allows you to define interpolations for
spatial positioning, color gradients, image scaling, and others. You can define
your own subclass of
[`Animation`](https://docs.flutter.io/flutter/animation/Animation-class.html)
or use an animation subclass that the framework provides.

To learn more about
using the other key classes in the
[`flutter/animation`](https://docs.flutter.io/flutter/animation/animation-library.html)
package, see the [Animations in Flutter](/animations) guide.

## Render a basic widget animation

To render your widget with an animation, set one or more of the widget’s
members to the animation object, then use the animation’s value to decide how
to draw your object.

If you are animating a stateful widget, you can notify your widget of changes
to the animation’s values by using the
[`addListener()`](https://docs.flutter.io/flutter/animation/Animation/addListener.html)
method. The framework invokes the listener callback whenever the value of the
animation changes. Typically, you’ll want to call the
[`setState()`](http://docs.flutter.io/flutter/material/State/setState.html)
method when the animation value change occurs, to trigger the framework to
rebuild the widget tree.

The following code snippet shows how you might create a simple animation
effect to make an logo image appear to expand.

```dart
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class LogoApp extends StatefulWidget {
  LogoAppState createState() => new LogoAppState();
}

class LogoAppState extends State<LogoApp> {
  Animation<double> animation;

  initState() {
    AnimationController controller = new AnimationController(
      duration: const Duration(milliseconds: 5000)
    );
    animation = new Tween(begin: 0.0, end: 200.0).animate(controller);
    animation.addListener(() {
      setState(() {
      // the state that has changed here is the animation object’s value
      });
    });
    controller.forward();
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new AssetImage(
          name: 'assets/flutter_logo.png',
          fit: ImageFit.contain
        )
      )
    );
  }
}

void main() {
  runApp(
    new MaterialApp(
      title: 'My Animation Test',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new LogoApp()
      }
    )
  );
}
```

You can simplify the code snippet above further by using the
[`AnimatedWidget`](http://docs.flutter.io/flutter/material/AnimatedWidget-class.html)
class. This class hides the state object and listener you previously had to
implement to run the animation.

```dart
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class LogoApp extends AnimatedWidget {
  LogoApp({Key key, Animation<double> animation})
      : super(key: key, animation: animation);

  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new AssetImage(
           name: 'assets/flutter_logo.png',
           fit: ImageFit.contain
        )
      )
    );
  }
}

void main() {
  final AnimationController controller = new AnimationController(
    duration: const Duration(milliseconds: 5000)
  );
  final animation = new Tween(
    begin: 0.0,
    end: 200.0)
  .animate(controller);
  runApp(
    new MaterialApp(
      title: 'My Animation Test',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new LogoApp(
          animation: animation
        )
      }
    )
  );
  controller.forward();
}
```

For more complex animations involving additional state, consider using the
[`AnimatedBuilder`](http://docs.flutter.io/flutter/material/AnimatedBuilder-class.html)
class.

## Render simultaneous widget animations

The following example shows how you can apply two simultaneous animation
effects: one that controls the size of the widget and another that controls
the opacity to fade the widget in and out.

You can use the
[`addStatusListener()`](http://docs.flutter.io/flutter/animation/Animation/addStatusListener.html)
method to notify your widget when the current status of an animation changes.
In this example, we use the status listener to switch the animation’s playback
between going forward or reverse.

```dart
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class LogoApp extends AnimatedWidget {

  // Declare the Tween objects as static because we don't change them.
  static final _opacityTween = new Tween<double>(begin: 1.0, end: 0.3);
  static final _sizeTween = new Tween<double>(begin: 0.0, end: 300.0);

  LogoApp({Key key, Animation<double> animation})
      : super(key: key, animation: animation);

  Widget build(BuildContext context) {
    return new Center(
      child: new Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: new Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: new AssetImage(
            name: 'assets/flutter_logo.png',
            fit: ImageFit.contain
          )
        )
      )
    );
  }
}

void main() {
  final AnimationController controller = new AnimationController(
    duration: const Duration(milliseconds: 5000)
  );

  final Animation<double> animation =
      new CurvedAnimation(parent: controller, curve: Curves.bounceIn);

  animation.addStatusListener((status) {
    if (status == AnimationStatus.completed)
      controller.reverse();
    else if (status == AnimationStatus.dismissed)
      controller.forward();
  });

  runApp(
    new MaterialApp(
      title: 'My Animation Test',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new LogoApp(
          animation: animation
        )
      }
    )
  );
  controller.forward();
}
```

## Dispose your widget animation

It’s good practice to dispose your animation controller and free up your
resources when they are no longer needed. To do so, call the
[`dispose()`](http://docs.flutter.io/flutter/material/AnimationController/dispose.html)
method on the
[`AnimationController`](http://docs.flutter.io/flutter/material/AnimationController-class.html)
object for the animation object you want to free. This stops the animation from
running.

The following snippet shows how to call the animation controller’s
[`dispose()`](http://docs.flutter.io/flutter/material/AnimationController/dispose.html)
method from within a
[`State`](http://docs.flutter.io/flutter/material/State-class.html) object’s
[`dispose()`](http://docs.flutter.io/flutter/material/State/dispose.html) method
implementation. The framework typically invokes the
[`State`](http://docs.flutter.io/flutter/material/State-class.html)
object’s [`dispose()`](http://docs.flutter.io/flutter/material/State/dispose.html)
method when switching between screens, as directed by the routes property.

```dart
class LogoAppState extends State<LogoApp> {

  // Implementation code omitted for brevity.

  @override
  void dispose() {
     controller.dispose();
     super.dispose();
  }
}
```
