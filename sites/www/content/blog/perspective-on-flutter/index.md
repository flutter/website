---
title: "Perspective on Flutter"
description: >-
  Fun with 3D and the Transform widget
publishDate: 2018-06-18
author: wmleler1
image: images/1WdpLQEC_L1PYDO1KgxxfMQ.webp
category: story
layout: blog
---

tl;dr — The Transform widget allows you to do amazing things in your Flutter apps. Here’s a one-minute video showing off what developers have done with Transform widgets:

<YoutubeEmbed id="9z_YNlRlWfA" title="Transform (Flutter Widget of the Week)" fullwidth="true"/>

This article builds a simple demo program that shows how to use Flutter’s [`Transform`](https://docs.flutter.io/flutter/widgets/Transform-class.html) widget to provide 3D perspective, a *graphic* demonstration of the ease with which Flutter can do something that would be rather difficult to implement in a system based on native widgets. It is also fun to play with!

Here’s the app we are going to build in action (the little circle reflects the position of the user’s finger on the screen):

<DashImage figure src="images/1WdpLQEC_L1PYDO1KgxxfMQ.webp" />

## Getting started

This example starts with the familiar default Flutter app — what you get when you do a `flutter create` or use your IDE to generate a new Flutter project. We are going to add two new things to this app: a [`Transform`](https://docs.flutter.io/flutter/widgets/Transform-class.html) widget and a [`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) widget.

First the transform:

```dart
// v1: move default app to separate function with fixed name
// Add transform widget, rotate and perspective
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perspective',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key); // changed

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Offset _offset = Offset(0.4, 0.7); // new

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(  // Transform widget
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // perspective
        ..rotateX(_offset.dy)
        ..rotateY(_offset.dx),
      alignment: FractionalOffset.center,
      child: _defaultApp(context),
    );
  }

  _defaultApp(BuildContext context) {  // new
    return Scaffold(
      appBar: AppBar(
        title: Text('The Matrix 3D'), // changed
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

}

```

Running this code shows the default app being transformed slightly in 3D, with perspective:

<DashImage figure src="images/1_hmzjJSeyWTnPccV5BsOHg.webp" />

We also removed some things we didn’t need, including all the extra comments, and (in honor of [Dart 2](https://www.dartlang.org/dart-2)) all the `new` keywords. For demonstration purposes we moved the layout part of the default app (the `build` method of `_MyHomePageState`) to a separate method called `_defaultApp` (lines 49–74). And for simplicity we set the AppBar title on line 52, rather than passing it as a parameter to `MyHomePage`.

## Transform widget

The added [Transform](https://docs.flutter.io/flutter/widgets/Transform-class.html) widget is on lines 39–46. Let’s look at this more closely. Transform takes a 3D [transformation matrix](https://en.wikipedia.org/wiki/Transformation_matrix), which is a [Matrix4](https://docs.flutter.io/flutter/vector_math/Matrix4-class.html). Why a 3D matrix? Isn’t Flutter for two-dimensional graphics? Well, kind of.

Pretty much all but the least powerful smartphones include amazingly fast [GPUs](https://en.wikipedia.org/wiki/Graphics_processing_unit), which are optimized for 3D graphics. That means that rendering 3D graphics is *very fast*. Consequently, almost everything you see on your phone is being rendered in 3D, even the 2D stuff. Crazy, huh?

Setting the transformation matrix lets us manipulate what is being viewed (in 3D even!). Common transformations include translate, rotate, scale, and perspective. To create this matrix we start with an [identity matrix](https://docs.flutter.io/flutter/vector_math/Matrix4/Matrix4.identity.html) (line 40) and then apply transformations to it. Transformations are not [commutative](https://en.wikipedia.org/wiki/Commutative_property), so we have to apply them in the right order. The final complete matrix will be sent to the GPU to transform the objects being rendered.

Transformations are a complicated subject, but if you want to learn more about them you can read any introduction to 3D graphics on [transformation matrices](https://en.wikipedia.org/wiki/Transformation_matrix) and [homogeneous coordinates](https://en.wikipedia.org/wiki/Homogeneous_coordinates).

## Perspective

The first transformation (on line 41) implements perspective. [Perspective](https://en.wikipedia.org/wiki/Perspective_(graphical)) makes objects that are farther away appear smaller. Setting row 3, column 2 of the matrix to 0.001 scales things down based on their distance.

Where did the number 0.001 come from? Thin air! You can play with this number to increase and decrease the amount of perspective, something like zooming in and out with a zoom lens on a camera. The bigger this number, the more pronounced is the perspective, which makes it look like you are closer to the viewed object.

Flutter does provide a [`makePerspectiveMatrix`](https://docs.flutter.io/flutter/vector_math/makePerspectiveMatrix.html) function but that method includes arguments for setting the aspect ratio, field of view, and near and far planes — way more than we need — so we will just set the required element of the matrix directly.

## Rotations

Next on lines 42 and 43 we apply two rotations based on the value of the `_offset` variable (from line 29; later we will use this variable to track the position of the user’s finger). Curiously, the X rotation is based on the Y offset, and the Y rotation is based on the X offset. Why?

<DashImage figure src="images/1sSCRNrjBJYifAMUMpIbL7A.webp" />

Consider this image, which has added green arrows showing the X and Y axes for the display. The default origin of these axes is the upper left corner of the display (which is why the Y axis points down), but our program sets the origin (in line 44) to be the center of the display .

Rotation is defined about an axis, so `rotateX` defines rotation around the X axis, which tilts in the Y (up-down) direction. Likewise, `rotateY` tilts in the X (left-right) direction (around the Y axis). That’s why `rotateX` is controlled by `_offset.dy` and `rotateY` is controlled by `_offset.dx`.

There is also a Z axis, whose origin is at the surface of the screen running perpendicular to the screen through the phone and out the back, so that the Z value goes positive the further away a thing is from the viewer. Consequently, the `rotateZ` method rotates in the plane of the display.

## Interaction

The second and final thing we are going to add is a [GestureDetector](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) widget. This is very easy in Flutter.

```dart
// v2: add Gesture detector
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perspective',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key); // changed

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Offset _offset = Offset.zero; // changed

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(  // Transform widget
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // perspective
        ..rotateX(0.01 * _offset.dy) // changed
        ..rotateY(-0.01 * _offset.dx), // changed
      alignment: FractionalOffset.center,
      child: GestureDetector( // new
        onPanUpdate: (details) => setState(() => _offset += details.delta),
        onDoubleTap: () => setState(() => _offset = Offset.zero),
        child: _defaultApp(context),
      )
    );
  }

  _defaultApp(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Matrix 3D'), // changed
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

}

```

In line 28, `_offset` is initialized to zero. Lines 44–48 define a GestureDetector that detects two kinds of gestures: pan gestures (e.g., a finger moving around the screen) and double tap gestures. Line 45 adds the amount of pan movement (in pixels) to `_offset`. Line 46 resets the `_offset` to zero when the user double taps the display. For both of these gestures, `setState()` schedules the display to be redrawn.

Finally, lines 41 and 42 are modified so that the offset (in pixels) is scaled by a factor of 0.01 to make it better to use for rotation (which is in radians, where a complete rotation is 2π — approximately 6.28 — so a complete rotation requires a pan movement of 628 pixels). You can play with the scale factor to make the rotation more or less sensitive to finger movement. Also, the parameter to `rotateY` is negated because as the finger moves to the right, the image rotates counter-clockwise around the Y axis (because the Y axis is pointing downward).

## Done!

[In Flutter](https://hackernoon.com/whats-revolutionary-about-flutter-946915b09514), almost everything is in the app itself (rather than in the platform), including the widgets and renderer. This gives great flexibility. In this case, we had easy access to powerful features provided by the GPU, and even a widget to help us. Our changes consist of a mere 13 lines of code. Not bad!

Note that after you rotate the default app around the X or Y axis, you might have difficulty tapping the FAB to increment the counter. Flutter does compensate for most transforms, including scale and rotateZ, so the UI will still work properly in those cases, but it has some problems with full 3D transforms. We’re working on fixing that.

Of course, none of the objects in the default app are actually 3D. They are all 2D (flat) objects (even the faux shadows cast by the AppBar and FAB). But that doesn’t stop us from spinning them around in 3D space.

## Further ideas

There is so much you could do with this simple program, often with just a few lines of code:

* Make the same changes to some app that is more complex than the default app.

* Add a spin around the Z axis, using `rotateZ`.

* Change the amount of perspective so that it is a negative number. What do you think will happen?

* Translate the [FAB](https://docs.flutter.io/flutter/material/FloatingActionButton-class.html) a bit in the negative Z direction so that it is floating slightly above the body of the [Scaffold](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget. For extra points, create a “real” shadow instead of a faux one.

* Add an animation so that when the user’s finger releases from the screen the app keeps spinning, slowing down to a stop. You can do this with the `onPanEnd` argument to the GestureDetector, which provides the [velocity of the finger](https://docs.flutter.io/flutter/gestures/DragEndDetails-class.html) (in pixels per second) as it loses contact with the screen.

* Create a 3D transition between two screens or tabs in an app. For example, like turning the pages of a book, or one screen spinning and becoming another.

If you think of other ideas, let me know in the comments.

UPDATE: A shout out to the article “[Make 3D flip animation in Flutter](https://medium.com/flutter-community/make-3d-flip-animation-in-flutter-16c006bb3798)”, which references this article to add perspective to a flip animation, like this:

<DashImage figure src="images/1cWO2jnAleFiGh8J-vvpNrQ.gif" />
