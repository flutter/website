---
layout: page
title: Animations in Flutter
sidebar: home_sidebar
permalink: /animations/
---

* TOC Placeholder
{:toc}

## Introduction

The animation system in Flutter is based on typed
[`Animation`](http://docs.flutter.io/flutter/animation/Animation-class.html)
objects. Widgets can either incorporate these animations in their build
functions directly by reading their current value and listening to their
state changes or they can use the animations as the basis of more elaborate
animations that they pass along to other widgets.

## Key animation classes

This section describes some of the common APIs you will use for creating
animation effects and controlling how they run.

### Animation

The primary building block of the animation system is the
[`Animation`](http://docs.flutter.io/flutter/animation/Animation-class.html)
class. An animation represents a value of a specific type that can change
over the lifetime of the animation. Most widgets that perform an animation
receive an [`Animation`](http://docs.flutter.io/flutter/animation/Animation-class.html)
object as a parameter, from which they read the current value of the animation
and to which they listen for changes to that value.

Two key methods of this class are:

+ **[`addListener()`](http://docs.flutter.io/flutter/animation/Animation/addListener.html):**
Whenever the animation's value changes, the animation
notifies all the listeners added with
[`addListener`](http://docs.flutter.io/flutter/animation/Animation/addListener.html).
Typically, a [`State`](http://docs.flutter.io/flutter/widgets/State-class.html)
object that listens to an animation will call
[`setState`](http://docs.flutter.io/flutter/widgets/State/setState.html) on
itself in its listener callback to notify the widget system that it needs to
rebuild with the new value of the animation.

     This pattern is so common that there are two widgets that help widgets rebuild
when animations change value:
[`AnimatedWidget`](http://docs.flutter.io/flutter/widgets/AnimatedWidget-class.html)
and
[`AnimatedBuilder`](http://docs.flutter.io/flutter/widgets/AnimatedBuilder-class.html).
The first, `AnimatedWidget`, is most useful for stateless animated widgets.
To use `AnimatedWidget`, simply subclass it and implement the
[`build`](http://docs.flutter.io/flutter/widgets/AnimatedWidget/build.html)
function. The second, `AnimatedBuilder`, is useful for more complex widgets
that wish to include an animation as part of a larger build function. To use
`AnimatedBuilder`, simply construct the widget and pass it a `builder` function.

+ **[`addStatusListener()`](http://docs.flutter.io/flutter/animation/Animation/addStatusListener.html):**
Animations also provide an
[`AnimationStatus`](http://docs.flutter.io/flutter/animation/AnimationStatus-class.html),
which indicates how the animation will evolve over time. Whenever the animation's
status changes, the animation notifies all the listeners added with
[`addStatusListener`](http://docs.flutter.io/flutter/animation/Animation/addStatusListener.html).
Typically, animations start out in the `dismissed` status, which means they're
at the beginning of their range. For example, animations that progress from 0.0
to 1.0 will be `dismissed` when their value is 0.0. An animation might then run
`forward` (e.g., from 0.0 to 1.0) or perhaps in `reverse` (e.g., from 1.0 to
0.0). Eventually, if the animation reaches the end of its range (e.g., 1.0), the
animation reaches the `completed` status.

### AnimationController

Use the [`AnimationController`](http://docs.flutter.io/flutter/animation/AnimationController-class.html)
class to specify how an animation should run. The
[`AnimationController`](http://docs.flutter.io/flutter/animation/AnimationController-class.html)
class lets you define important characteristics of the animation, such as its
duration and playback direction (forward or reverse).

The following snippet shows how you might create an animation that runs for
500 milliseconds:

```dart
final AnimationController controller = new AnimationController(
  duration: const Duration(milliseconds: 500)
);
```

As well as being an animation itself, an
[`AnimationController`](http://docs.flutter.io/flutter/animation/AnimationController-class.html)
lets you control the animation. For example, you can tell the controller to play the animation
[`forward`](http://docs.flutter.io/flutter/animation/AnimationController/forward.html)
or [`stop`](http://docs.flutter.io/flutter/animation/AnimationController/stop.html)
the animation and later [`resume`](http://docs.flutter.io/flutter/animation/AnimationController/resume.html)
it. You can also [`fling`](http://docs.flutter.io/flutter/animation/AnimationController/fling.html)
animations, which uses a physical simulation, such as a spring, to drive the
animation.

To create an animation, first create an
[`AnimationController`](http://docs.flutter.io/flutter/animation/AnimationController-class.html).
Once you've created an animation controller, you can start building other
animations based on it. For example, you can create a
[`ReverseAnimation`](http://docs.flutter.io/flutter/animation/ReverseAnimation-class.html)
that mirrors the original animation but runs in the opposite direction (e.g.,
from 1.0 to 0.0). Similarly, you can create a
[`CurvedAnimation`](http://docs.flutter.io/flutter/animation/CurvedAnimation-class.html)
whose value is adjusted by a [curve](http://docs.flutter.io/flutter/animation/Curves-class.html).

### CurvedAnimation

Use the [`CurvedAnimation`](http://docs.flutter.io/flutter/material/CurvedAnimation-class.html)
class to apply a non-linear curve to an animation object it wraps.
By applying different curve types, you can visually modify the spatial movement
pattern for the wrapped animation object.

The
[`Curves`](http://docs.flutter.io/flutter/animation/Curves-class.html) class
lists the available curve types, such as
[`bounceIn`](http://docs.flutter.io/flutter/animation/Curves/bounceIn-constant.html),
[`easeOut`](http://docs.flutter.io/flutter/animation/Curves/easeOut-constant.html),
and others.

The following snippet shows how you might create a curved animation object that
wraps a linear animation produced by an animation controller and applies the
[`easeIn`](http://docs.flutter.io/flutter/animation/Curves/easeIn-constant.html)
curve type to it.

```dart
final AnimationController controller =
    new AnimationController(duration: const Duration(milliseconds: 500));

final curve = new CurvedAnimation(
    parent: controller,
    curve: Curves.easeIn
);
```

### Tween

The [`Tween`](http://docs.flutter.io/flutter/material/Tween-class.html) class
represents a changing value between a range with a
[`begin`](http://docs.flutter.io/flutter/material/Tween/begin.html) and
[`end`](http://docs.flutter.io/flutter/material/Tween/end.html) value. To get
the interpolated value for a given animation, call the
[`evaluate()`](http://docs.flutter.io/flutter/animation/Tween/evaluate.html)
method on the Tween object. You can override the
[`lerp()`](http://docs.flutter.io/flutter/material/Tween/lerp.html)
(or *linear interpolation*) method for the
[`Tween`](http://docs.flutter.io/flutter/material/Tween-class.html) object,
which returns a value based on a given animation clock time.

You can use these subclasses of
[`Tween`](http://docs.flutter.io/flutter/material/Tween-class.html) to apply
specialized interpolations to your animations:

+ [`ColorTween`](http://docs.flutter.io/flutter/animation/ColorTween-class.html):
Interpolation between colors.
+ [`SizeTween`](https://docs.flutter.io/flutter/animation/SizeTween-class.html):
Interpolation between rectangle sizes.
+ [`ThemeDataTween`](https://docs.flutter.io/flutter/material/ThemeDataTween-class.html):
Interpolation between
[`ThemeData`](https://docs.flutter.io/flutter/material/ThemeData-class.html) objects.

The following snippet shows how you might create a
[`Tween`](http://docs.flutter.io/flutter/material/Tween-class.html) object that
interpolates between the double values of -200.0 to 0.0.

```dart
final Tween doubleTween = new Tween<double>(begin: -200.0, end: 0.0);
```

You can also specify a progression between two colors. For example:

```dart
final Tween colorTween =
    new ColorTween(begin: Colors.transparent, end: Colors.black54);
```

To apply a Tween to a given animation object, use the [`animate()`]()
method which returns a new Animation instance. For example, the following code
snippet shows how you might create an animation represented by integral values
from 0 to 255, over a duration of 500 milliseconds, using linear interpolation.

```dart
final AnimationController animation =
    new AnimationController(duration: const Duration(milliseconds: 500));

Animation<int> alpha = new IntTween(
  begin: 0,
  end: 255)
.animate(animation);
```

To animate beyond the 0.0 to 1.0 interval, you can use a
[`Tween<T>`](http://docs.flutter.io/flutter/animation/Tween-class.html), which
interpolates between its
[`begin`](http://docs.flutter.io/flutter/animation/Tween/begin.html)
and [`end`](http://docs.flutter.io/flutter/animation/Tween/end.html)
values. Many types have specific `Tween` subclasses that provide type-specific
interpolation. For example,
[`ColorTween`](http://docs.flutter.io/flutter/animation/ColorTween-class.html)
interpolates between colors and
[`RectTween`](http://docs.flutter.io/flutter/animation/RectTween-class.html)
interpolates between rects. You can define your own interpolations by creating
your own subclass of `Tween` and overriding its
[`lerp`](http://docs.flutter.io/flutter/animation/Tween/lerp.html)
function.

By itself, a tween just defines how to interpolate between two values. To get
a concrete value for the current frame of an animation, you also need an
animation to determine the current state.

Use these methods if you need to combine a tween with an animation to get a
concrete value:

+ [`evaluate()`](http://docs.flutter.io/flutter/animation/Tween/evaluate.html):
Evaluates the tween at the current value of an animation. This approach is most
useful for widgets that are already listening to the animation and hence
rebuilding whenever the animation changes value.
+ [`animate()`](http://docs.flutter.io/flutter/animation/Animatable/animate.html)
   Animates the tween based on the animation object's properties. Rather than
returning a single value, the animate function returns a new
[`Animation`](http://docs.flutter.io/flutter/animation/Animation-class.html)
that incorporates the tween. This approach is most useful when you want to give
the newly created animation to another widget, which can then read the current
value that incorporates the tween as well as listen for changes to the value.

### Scheduler

The
[`Scheduler`](http://docs.flutter.io/flutter/scheduler/Scheduler-class.html)
is a singleton class that exposes the Flutter scheduling primitives.

For this discussion, the key primitive is the frame callbacks. Each
time a frame needs to be shown on the screen, Flutter's engine
triggers a "begin frame" callback which the scheduler multiplexes to
all the listeners registered using
[`addFrameCallback()`](http://docs.flutter.io/flutter/scheduler/Scheduler/addFrameCallback.html).
All these callbacks are given the official time stamp of the frame, in
the form of a `Duration` from some arbitrary epoch. Since all the
callbacks have the same time, any animations triggered from these
callbacks will appear to be exactly synchronised even if they take a
few milliseconds to be executed.

### Tickers

The
[`Ticker`](http://docs.flutter.io/flutter/scheduler/Ticker-class.html)
class hooks into the scheduler's
[`addFrameCallback()`](http://docs.flutter.io/flutter/scheduler/Scheduler/addFrameCallback.html)
mechanism to invoke a callback every tick.

A `Ticker` can be started and stopped. When started, it returns a
`Future` that will resolve when it is stopped. Each tick, the `Ticker`
provides the callback with the duration since the first tick after it was
started.

Because tickers always give their elapsed time relative to the first
tick after they were started, tickers are all synchronised. If you
start three ticks at different times between two frames, they will all
nonetheless be synchronised with the same starting time, and will
subsequently tick in lockstep.

### Simulations

The
[`Simulation`](http://docs.flutter.io/newton/newton/Simulation-class.html)
abstract class maps a relative time value (an elapsed time) to a
double value, and has a notion of completion. In principle, simulations are
stateless but in practice some simulations (e.g.
[`ScrollSimulation`](http://docs.flutter.io/newton/newton/ScrollSimulation-class.html))
change state irreversibly when queried.

There are [various concrete
implementations](http://docs.flutter.io/newton/newton/newton-library.html)
of the `Simulation` class for different effects.

The
[`Force`](http://docs.flutter.io/flutter/animation/Force-class.html)
abstract class provides a factory for `Simulation` instances.

### Animatables

The
[`Animatable`](http://docs.flutter.io/flutter/animation/Animatable-class.html)
abstract class maps a double to a value of a particular type. `Animatable`
classes are stateless and immutable. The
[`Tween`](http://docs.flutter.io/flutter/animation/Tween-class.html)
abstract class is an `Animatable`.

Passing an `Animatable<double>` (the parent) to an `Animatable`'s
`chain()` method creates a new `Animatable` subclass that applies the
parent's mapping then the child's mapping.

Passing an `Animation<double>` (the new parent) to an `Animatable`'s
`animate()` method creates a new `Animation` subclass that acts like
the `Animatable` but is driven from the given parent.

## Chainable animations

Most [`Animation`](http://docs.flutter.io/flutter/animation/Animation-class.html)
subclasses take an explicit parent `Animation<double>`. They are
driven by that parent.

For example:

+ The [`CurvedAnimation`](http://docs.flutter.io/flutter/material/CurvedAnimation-class.html)
subclass takes an `Animation<double>` class (the
parent) and some `Curve` classes (the forward and reverse
curves) as input, and uses the value of the parent as input to the
curves to determine its output.

+ The [`ReverseAnimation`](https://docs.flutter.io/flutter/widgets/ReverseAnimation-class.html)
subclass takes an `Animation<double>` class as its parent and reverses all the
values of the animation. It assumes the parent is using a value nominally in
the range 0.0-1.0 and returns a value in the range 1.0-0.0. The status and
direction of the parent animation are also reversed.

+ The [`ProxyAnimation`](https://docs.flutter.io/flutter/animation/ProxyAnimation-class.html)
subclass takes an `Animation<double>` class as its parent and merely forwards
the current state of that parent. However, the parent is mutable.

+ The [`TrainHoppingAnimation`](https://docs.flutter.io/flutter/animation/TrainHoppingAnimation-class.html)
subclass takes two parents, and switches between them when their values cross.