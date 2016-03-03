---
layout: page
title: Animations Tutorial
permalink: /animations-tutorial/
---

Welcome to Flutter's Animations Tutorial. You may also be interested
in our [Animations Overview](/animations/).

## Introduction

The animation system in Flutter is based on typed
[`Animation`](http://docs.flutter.io/flutter/animation/Animation-class.html)
objects that produce values over a certain duration. Widgets can either
incorporate these animations in their `build`
functions directly by reading their current value and listening to their
state changes or they can use the animations as the basis of more elaborate
animations that they pass along to other widgets.

There are two separate animation libraries for Flutter. This documentation
covers the [flutter/animation](http://docs.flutter.io/flutter/animation/animation-library.html)
library, which is intended for animations in
user interfaces that are built on
[StatefulComponent](http://docs.flutter.io/flutter/widgets/StatefulComponent-class.html)
and [StatelessComponent](http://docs.flutter.io/flutter/widgets/StatelessComponent-class.html).
There is a separate library for game development named
[flutter_sprites/flutter_sprites](http://docs.flutter.io/flutter_sprites/flutter_sprites/flutter_sprites-library.html).

## Animation

An Animation object in Flutter is a class that sequentially generates
interpolated numbers between two values over a certain duration. The output of
an Animation object may be linear, a curve, a step function, or anything other
mapping you can device. Depending on how the Animation object is controlled, it
could run in reverse, or even switch directions in the middle.

In addition, an Animation object:

* can interpolate types other than double, such as `Animation<Color>` or
`Animation<Size>`. We’ll talk about other types later in this document.
* has state. Its current value is always available in the `value` member.
* knows nothing about rendering or `build` functions. We’ll see later how to
make the connection.

## AnimationController

To create an animation, first create a
[`AnimationController`](http://docs.flutter.io/flutter/animation/AnimationController-class.html).
As well as being an animation itself, an `AnimationController` lets you control
the animation. For example, you can tell the controller to play the animation
[`forward`](http://docs.flutter.io/flutter/animation/AnimationController/forward.html)
or [`stop`](http://docs.flutter.io/flutter/animation/AnimationController/stop.html)
the animation and later
[`resume`](http://docs.flutter.io/flutter/animation/AnimationController/resume.html)
it. You can also [`fling`](http://docs.flutter.io/flutter/animation/AnimationController/fling.html)
animations, which uses a physical simulation, such as a spring, to drive the
animation.


AnimationController is a special Animation object that generates a new value
whenever the hardware is ready for a new frame. By default, an
AnimationController linearly produces the numbers from 0.0 to 1.0 during a given
duration. For example, this code creates an Animation object, but does not start
it running:

```dart
final AnimationController controller =
    new AnimationController(duration: const Duration(milliseconds: 500));
```

The generation of numbers is tied to the screen refresh, so typically 60 numbers
are generated per second. After each number is generated, each Animation object
calls the attached Listener objects. More on that soon.

## CurvedAnimation

A CurvedAnimation takes the values from another Animation object (typically an
AnimationController) and modifies those values to make the progression be a non-
linear curve:

```dart
final AnimationController controller =
    new AnimationController(duration: const Duration(milliseconds: 500));

final CurvedAnimation animation =
    new CurvedAnimation(parent: controller, curve: Curves.ease);
```

A CurvedAnimation is also of type `Animation<double>`, same as
AnimationController, so you can pass them interchangeably. Note that the
CurvedAnimation wraps the object it’s modifying. You don’t subclass
AnimationController to implement a curve.

After the statements above, you have two Animation objects. The
AnimationController is still producing linear values and the CurvedAnimation is
producing the curved values.

>**For animation experts**
>
>We said above that the AnimationController can go from 0.0 to 1.0, by
default. There is also a
[`fling`](http://docs.flutter.io/flutter/animation/AnimationController/fling.html)
function that
allows you to provide a velocity, a force, and a position (via the Force
object). The position can
be anything and so can be outside of the 0.0 to 1.0 range.
>
>The CurvedAnimation can also exceed its 0.0 to 1.0 range, even if the
AnimationController did not. Depending on the curve selected, the output of
the CurvedAnimation could have a wider range than the input. For example, the
elastic curves such as Curves.elasticIn will significantly overshoot or
undershoot the default range.

## Tween

The AnimationController object by default goes from 0.0 to 1.0. If you need a
different range or a different data type, you can use a
[`Tween`](http://docs.flutter.io/flutter/animation/Tween-class.html) to
configure an animation to interpolate to a different range or data type. First
let’s look at how to create a Tween that goes from -200.0 to 0.0:

```dart
final Tween doubleTween = new Tween<double>(begin: -200.0, end: 0.0);
```

A Tween class is a stateless object that takes only
[`begin`](http://docs.flutter.io/flutter/animation/Tween/begin.html) and
[`end`](http://docs.flutter.io/flutter/animation/Tween/end.html). The sole job
of a Tween class is to define a mapping from an input range to an output range.
The input range is commonly 0.0 to 1.0, but that’s not a requirement.

A Tween inherits from [`Animatable<T>`](http://docs.flutter.io/flutter/animation/Animatable-class.html),
not from `Animation<T>`. An Animatable does not have to output double. For example,
[`ColorTween`](http://docs.flutter.io/flutter/animation/ColorTween-class.html)
specifies a progression between two colors.

```dart
final Tween colorTween =
    new ColorTween(begin: Colors.transparent, end: Colors.black54);
```

A Tween object does not store any state. Instead, it exposes
[`evaluate(Animation<double> animation)`](http://docs.flutter.io/flutter/animation/Tween/evaluate.html), which applies the mapping function to
the current value of the animation. The current value of the Animation object can be found in the
[`.value`](http://docs.flutter.io/flutter/animation/Animation/value.html) method. The
[`evaluate`](http://docs.flutter.io/flutter/animation/Animatable/evaluate.html)
function also performs some housekeeping, such as ensuring that begin and end
are returned when the animation values are 0.0 and 1.0, respectively.

## Tween.animate()

To use a Tween object, you configure an Animation to use the Tween (Animatable)
with the [`animate`](http://docs.flutter.io/flutter/animation/Animatable/animate.html)
function on the Animatable object. For example:

```dart
final AnimationController animation =
    new AnimationController(duration: const Duration(milliseconds: 500));
Animation<int> alpha = new IntTween(
  begin: 0,
  end: 255
).animate(animation);
```

Notice that `animate` returns an `Animation`, not an `Animatable`.

The code above linearly generates the integral values from 0 to 255 over the course of 500 ms.

Here’s an example with a controller, a curve, and a `Tween`:

```dart
final AnimationController animation = new AnimationController(
                        duration: const Duration(milliseconds: 500));
final Animation curve =
    new CurvedAnimation(parent: animation, curve: Curves.easeOut);
Animation<int> alpha = new IntTween(
  begin: 0,
  end: 255
).animate(curve);
```

You can also chain Tweens together using the
[`chain`](http://docs.flutter.io/flutter/animation/Animatable/chain.html)
method, in which case a single `Animation` object will be configured by multiple
`Tween` objects called in succession. This is different than calling `.animate`
twice, in which case you have two Animate objects, each configured with a
single Tween.

## Animation notifications

An Animation object can have Listeners and StatusListeners, defined with
[`addListener`](http://docs.flutter.io/flutter/animation/Animation/addListener.html) and
[`addStatusListener`](http://docs.flutter.io/flutter/animation/Animation/addStatusListener.html).
A Listener is called whenever the value of the animation changes. The most common behavior of a Listener is to call setState() to cause a rebuild. A StatusListener is called when an animation begins, ends, moves forward, or moves reverse, as defined by [`AnimationStatus`](http://docs.flutter.io/flutter/animation/AnimationStatus-class.html).

We’ll use `addListener` in the next section and we’ll use `addStatusListener` in Monitoring the progress of the animation.

## Rendering animations

So far all we’ve done is to generate a sequence of numbers over time. You’ll notice we haven’t actually rendered anything.

To render with an `Animation<>` object, store the `Animation<>` object as a member of your `Widget`, then use its value to decide how to draw.

Consider this application that draws the Flutter logo without animation:

```dart
import 'package:flutter/material.dart';

const kLogoUrl = 'https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png';

class LogoApp extends StatefulComponent {
  LogoAppState createState() => new LogoAppState();
}

class LogoAppState extends State<LogoApp> {

  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            margin: new EdgeDims.symmetric(vertical: 10.0),
            height: 300.0,
            width: 300.0,
            child: new NetworkImage(src: kLogoUrl)));
  }
}

void main() {
  runApp(new LogoApp());
}
```

This listing shows the changes necessary to animate the logo to
grow outward: (Changes noted with comments.)

```dart
import 'package:flutter/animation.dart'; // New
import 'package:flutter/material.dart';

const kLogoUrl = "https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png";

class LogoApp extends StatefulComponent {
  LogoAppState createState() => new LogoAppState();
}

class LogoAppState extends State<LogoApp> {
  Animation<double> animation;

// Begin new

  initState() {
    super.initState();
    AnimationController controller =
        new AnimationController(duration: const Duration(milliseconds: 2000));
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

// End new

  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            margin: new EdgeDims.symmetric(vertical: 10.0),
            height: animation.value,  // New
            width: animation.value,   // New
            child: new NetworkImage(src: kLogoUrl)));
  }
}

void main() {
  runApp(new LogoApp());
}
```

Because `addListener` calls `setState`, every time the animation generates a new
number, the current frame will be marked dirty, which in turn will force `build`
to be called again. In `build`, the container changes size because its height
and width now use `animation.value` instead of hardcoding 300.0.

With these short changes, you’ve created your first animation in Flutter!

## Simplifying with AnimatedComponent

The code for `addListener` and `setState` is an obvious candidate for
refactoring, which you’ll find in a helper class named
[`AnimatedComponent`](http://docs.flutter.io/flutter/widgets/AnimatedComponent-class.html).
The simplified code is shown below. LogoApp now derives from AnimatedComponent
instead of from
[`StatefulComponent`](http://docs.flutter.io/flutter/widgets/StatefulComponent-class.html), and
your `AnimatedComponent` does not need to maintain a State object to hold the animation.

You’ll notice that `LogoApp` passes the `Animation` object to the base class and
uses `animation.value` to set the height and width of the container, so it works
exactly the same as the previous example. This animation is just 26 lines!

```dart
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

const kLogoUrl = "https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png";

class LogoApp extends AnimatedComponent {
  LogoApp({Key key, Animation<double> animation})
      : super(key: key, animation: animation);

  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            margin: new EdgeDims.symmetric(vertical: 10.0),
            height: animation.value,
            width: animation.value,
            child: new NetworkImage(src: kLogoUrl)));
  }
}

void main() {
  final AnimationController controller =
      new AnimationController(duration: const Duration(milliseconds: 2000));
  final Animation<double> animation =
      new Tween(begin: 0.0, end: 300.0).animate(controller);
  runApp(new LogoApp(animation: animation));
  controller.forward();
}
```

## Monitoring the progress of the animation

It’s often helpful to know when an animation changes state, such as finishing,
moving forward, or reversing. You can get notifications for this with
`addStatusListener`.  Here’s a trivial change to the previous example to
demonstrate these notifications: (Changes noted with comments.)

```dart
const kLogoUrl = "https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png";

class LogoApp extends AnimatedComponent {
  LogoApp({Key key, Animation<double> animation})
      : super(key: key, animation: animation);

  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            margin: new EdgeDims.symmetric(vertical: 10.0),
            height: animation.value,
            width: animation.value,
            child: new NetworkImage(src: kLogoUrl)));
  }
}

void main() {
  final AnimationController controller =
      new AnimationController(duration: const Duration(milliseconds: 2000));
  controller.addStatusListener((state) => print("$state") );  // New
  final animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
  runApp(new LogoApp(animation: animation));
  controller.forward();
}
```

If you look at the logs after running this change, you’ll see lines like this as
the animation progresses:

```
I/flutter (21456): AnimationStatus.forward
I/flutter (21456): AnimationStatus.completed
```

Let’s put this to work by automatically reversing the animation as it reaches
the begin and end: (Changes noted with comments.)

```dart
const kLogoUrl = "https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png";

class LogoApp extends AnimatedComponent {
  LogoApp({Key key, Animation<double> animation})
      : super(key: key, animation: animation);

  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
            margin: new EdgeDims.symmetric(vertical: 10.0),
            height: animation.value,
            width: animation.value,
            child: new NetworkImage(src: kLogoUrl)));
  }
}

void main() {
  final AnimationController controller =
      new AnimationController(duration: const Duration(milliseconds: 2000));
  final Animation<double> animation =
      new Tween(begin: 0.0, end: 300.0).animate(controller);

  // Begin new

  animation.addStatusListener((status) {
    if (status == AnimationStatus.completed) controller.reverse();
    else if (status == AnimationStatus.dismissed) controller.forward();
  });

  // End new

  runApp(new LogoApp(animation: animation));
  controller.forward();
}
```

## Refactoring with AnimatedBuilder

One problem with the above code is that we’ve had to make changes to the widget
that renders the logo in order to make the animation work. This means we’d have
to write a different widget to change the animation. A better solution would be
to break the problem down into areas of responsibility:

- Render the logo
- Define the Animation object
- Render the transition

We can do this with the
[`AnimatedBuilder`](http://docs.flutter.io/flutter/widgets/AnimatedBuilder-class.html)
class.  The key difference between AnimatedComponent and
AnimatedBuilder is that your class inherits from `AnimatedComponent`, whereas
`AnimatedBuilder` is a separate, parent class in the render tree. Both classes
automatically listen to notifications from the `Animation` object and mark the
widget tree dirty as necessary, so you don’t need to call `addListener`.

The widget tree we’re building looks like this:

![Animation widget tree](/images/animation-tutorial-chart.png)

Starting from the bottom of the widget tree, the code for rendering the logo is
straightforward:

```dart
const kLogoUrl = 'https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png';

class LogoWidget extends StatelessComponent {
  // Leave out the height and width so it fills the animating parent
  build(BuildContext context) {
    return new Container(
        margin: new EdgeDims.symmetric(vertical: 10.0),
        child: new NetworkImage(
            src: kLogoUrl));
  }
}
```

The middle three blocks in the diagram are all created in the build() method in
`GrowTransition`. The `GrowTransition` widget itself is stateless and holds the
set of final variables necessary to define the transition animation. The `build`
function creates and returns the `AnimatedBuilder`, which takes the (Anonymous
builder) method and the `LogoWidget` object as parameters. The work of rendering
the transition actually happens in the (Anonymous builder) method, which creates
a [`Container`](http://docs.flutter.io/flutter/material/Container-class.html) of
the appropriate size to force the `LogoWidget` to shrink to fit.

One tricky point in the code below is that the child looks like it’s specified
twice. What’s happening is that the outer reference of child is passed to
`AnimatedBuilder`, which passes it to the anonymous closure, which then uses
that object as its child. The net result is that the `AnimatedBuilder` is
inserted in between the two widgets in the render tree.

```dart
class GrowTransition extends StatelessComponent {
  GrowTransition({this.child, this.animation});

  Widget child;
  Animation<double> animation;

  Widget build(BuildContext context) {
    return new AnimatedBuilder(animation: animation,
        builder: (BuildContext context, Widget child) {
      return new Center(
          child: new Container(
              height: animation.value,
              width: animation.value,
              child: child));
    }, child: child);
  }
}
```

Finally, the code to initialize the animation looks very similar to our first
example. The `initState` method creates an `AnimationController` and a `Tween`,
then binds them with `animate`. The magic happens in the `build` method, which
returns a `GrowTransition` object with a `LogoWidget` as a child and an
animation object to drive the transition. These are the three elements listed in
the bullet points above.

```dart
const kLogoUrl = 'https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png';

class GrowTransition extends StatelessComponent {
  GrowTransition({this.child, this.animation});

  Widget child;
  Animation<double> animation;

  Widget build(BuildContext context) {
    return new AnimatedBuilder(animation: animation,
        builder: (BuildContext context, Widget child) {
      return new Center(
          child: new Container(
              height: animation.value,
              width: animation.value,
              child: child));
    }, child: child);
  }
}

class LogoWidget extends StatelessComponent {
  // Leave out the height and width so it fills the animating parent
  build(BuildContext context) {
    return new Container(
        margin: new EdgeDims.symmetric(vertical: 10.0),
        child: new NetworkImage(
            src: kLogoUrl));
  }
}

class LogoApp extends StatefulComponent {
  LogoAppState createState() => new LogoAppState();
}

class LogoAppState extends State<LogoApp> {
  Animation animation;

  initState() {
    super.initState();
    final controller =
        new AnimationController(
            duration: const Duration(milliseconds: 2000)
        );
    final curve = new CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn
    );
    animation = new Tween(begin: 0.0, end: 300.0).animate(curve);
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new GrowTransition(
      child: new LogoWidget(),
      animation: animation
    );
  }
}
```

## Simultaneous animations

In this section, we’ll build on the third example that used `AnimatedComponent`
to animate in
and out continuously. Consider the case where we want to go in and out AND the
opacity to fade
out and in. This is typically done by adding more `Tween` objects to the
animation chain, like this:

```dart
  final AnimationController controller =
      new AnimationController(duration: const Duration(milliseconds: 2000));
  final Animation<double> sizeAnimation =
      new Tween(begin: 0.0, end: 300.0).animate(controller);
  final Animation<double> opacityAnimation =
      new Tween(begin: 1.0, end: 0.3).animate(controller);
```

The additional `Animation` objects provide the size with `sizeAnimation.value`
and the opacity with `opacityAnimation.value`. But the constructor for
`AnimatedComponent` only takes a single Animation object. To solve this problem,
we’ll create our own `Tween` objects and explicitly calculate the values we
need. Here’s the code:  (Changes noted in with comments.)

```dart
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

const kLogoUrl = 'https://raw.githubusercontent.com/dart-lang/logos/master/logos_and_wordmarks/dart-logo.png';

class LogoApp extends AnimatedComponent {

  // Begin new

  // We can make the Tweens static because we don't change them.
  static final _opacityTween = new Tween<double>(begin: 1.0, end: 0.3);
  static final _sizeTween = new Tween<double>(begin: 0.0, end: 300.0);

  // End new

  LogoApp({Key key, Animation<double> animation})
      : super(key: key, animation: animation);

  Widget build(BuildContext context) {
    return new Center(
        child: new Opacity(                              // New
            opacity: _opacityTween.evaluate(animation),  // New
            child: new Container(
                margin: new EdgeDims.symmetric(vertical: 10.0),
                height: _sizeTween.evaluate(animation),  // New
                width: _sizeTween.evaluate(animation),   // New
                child: new NetworkImage(src: kLogoUrl))));
  }
}

void main() {
  final AnimationController controller =
      new AnimationController(duration: const Duration(milliseconds: 2000));
  // Use a bounceIn curve, just for fun.
  final Animation<double> animation =
      new CurvedAnimation(parent: controller, curve: Curves.bounceIn);
  animation.addStatusListener((status) {
    if (status == AnimationStatus.completed) controller.reverse();
    else if (status == AnimationStatus.dismissed) controller.forward();
  });

  runApp(new LogoApp(animation: animation));
  controller.forward();
}
```

You can see that the `GrowTransition` class was changed to encapsulate its own
`Tween` objects, whose `.evaluate` functions were called with the parent’s
animation object to calculate the required size and opacity values.

## Next steps

There are many more classes to explore, including specialized Tween classes,
animations specific to
[`Material Design`](http://docs.flutter.io/flutter/material/material-library.html),
[`ReverseAnimation`](http://docs.flutter.io/flutter/animation/ReverseAnimation-
class.html), physics simulations and `fling` methods. This tutorial should have
given you the foundation to understand these other parts of Flutter animation.
