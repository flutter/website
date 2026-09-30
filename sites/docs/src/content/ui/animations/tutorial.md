---
title: Animations tutorial
shortTitle: Tutorial
description: A tutorial showing how to build explicit animations in Flutter.
---

<?code-excerpt path-base="animation"?>

:::secondary What you'll learn
* How to use the fundamental classes from the
  animation library to add animation to a widget.
* When to use `AnimatedWidget` vs. `AnimatedBuilder`.
:::

This tutorial shows you how to build explicit animations in Flutter.
The examples build on each other, introducing you to different aspects of the
animation library. The tutorial is built on essential concepts, classes,
and methods in the animation library that you can learn about in
[Introduction to animations][].

The Flutter SDK also provides built-in explicit animations,
such as [`FadeTransition`][], [`SizeTransition`][],
and [`SlideTransition`][]. These simple animations are
triggered by setting a beginning and ending point.
They are simpler to implement
than custom explicit animations, which are described here.

The following sections walk you through several animation examples.
Each section provides a link to the source code for that example.

## Rendering animations

:::secondary What's the point?
* How to add basic animation to a widget using `addListener()` and
  `setState()`.
* Every time the `Animation` generates a new number, the `addListener()`
  function calls `setState()`.
* How to define an `AnimationController` with the required
  `vsync` parameter.
* How to use the `..` syntax in `..addListener`,
  also known as Dart's _cascade notation_.
:::

An `Animation` object generates a sequence of numbers over time,
but doesn't render anything to the screen.
To render with an `Animation` object, store the `Animation` object as a
member of your widget, then use its value to decide how to draw.

Consider the following app that draws the Flutter logo without animation:

<?code-excerpt "animate0/lib/main.dart"?>
```dart
import 'package:material_ui/material_ui.dart';

void main() => runApp(const LogoApp());

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 300,
        width: 300,
        child: const FlutterLogo(),
      ),
    );
  }
}
```

**App source:** [animate0][]

The following shows the same code modified to animate the
logo to grow from nothing to full size.
When defining an `AnimationController`, you must pass in a
`vsync` object. The `vsync` parameter is described in the
[`AnimationController` section][].

The changes from the non-animated example are highlighted:

```dart diff
- class _LogoAppState extends State<LogoApp> {
+ class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
+   late Animation<double> animation;
+   late AnimationController controller;
+
+   @override
+   void initState() {
+     super.initState();
+     controller = AnimationController(
+       duration: const Duration(seconds: 2),
+       vsync: this,
+     );
+     animation = Tween<double>(begin: 0, end: 300).animate(controller)
+       ..addListener(() {
+         setState(() {
+           // The state that has changed here is the animation object's value.
+         });
+       });
+     controller.forward();
+   }
+
    @override
    Widget build(BuildContext context) {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
-         height: 300,
-         width: 300,
+         height: animation.value,
+         width: animation.value,
          child: const FlutterLogo(),
        ),
      );
    }
+
+   @override
+   void dispose() {
+     controller.dispose();
+     super.dispose();
+   }
  }
```

**App source:** [animate1][]

The `addListener()` function calls `setState()`,
so every time the `Animation` generates a new number,
the current frame is marked dirty, which forces
`build()` to be called again. In `build()`,
the container changes size because its height and
width now use `animation.value` instead of a hardcoded value.
Dispose of the controller when the `State` object is
discarded to prevent memory leaks.

With these few changes,
you've created your first animation in Flutter.

:::tip Dart language trick
You might not be familiar with Dart's cascade notation&mdash;the two
dots in `..addListener()`. This syntax means that the `addListener()`
method is called with the return value from `animate()`.
Consider the following example:

<?code-excerpt "animate1/lib/main.dart (add-listener)"?>
```dart highlightLines=2
animation = Tween<double>(begin: 0, end: 300).animate(controller)
  ..addListener(() {
    // ···
  });
```

This code is equivalent to:

<?code-excerpt "animate1/lib/main.dart (add-listener)" replace="/animation.*/$&;/g; /  \./animation/g;"?>
```dart highlightLines=2
animation = Tween<double>(begin: 0, end: 300).animate(controller);
animation.addListener(() {
    // ···
  });
```

To learn more about cascades,
check out [Cascade notation][]
in the [Dart language documentation][].
:::

## Simplifying with AnimatedWidget

:::secondary What's the point?
* How to use the [`AnimatedWidget`][] helper class
  (instead of `addListener()`
  and `setState()`) to create a widget that animates.
* Use `AnimatedWidget` to create a widget that performs
  a reusable animation.
  To separate the transition from the widget, use an
  `AnimatedBuilder`, as shown in the
  [Refactoring with AnimatedBuilder][] section.
* Examples of `AnimatedWidget`s in the Flutter API:
  `AnimatedBuilder`, `AnimatedModalBarrier`,
  `DecoratedBoxTransition`, `FadeTransition`,
  `PositionedTransition`, `RelativePositionedTransition`,
  `RotationTransition`, `ScaleTransition`,
  `SizeTransition`, `SlideTransition`.
:::

The `AnimatedWidget` base class allows you to separate out
the core widget code from the animation code.
`AnimatedWidget` doesn't need to maintain a `State`
object to hold the animation. Add the following `AnimatedLogo` class:

<?code-excerpt path-base="animation/animate2"?>
<?code-excerpt "lib/main.dart (AnimatedLogo)"?>
```dart
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
    : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}
```
<?code-excerpt path-base="animation"?>

`AnimatedLogo` uses the current value of the `animation`
when drawing itself.

The `LogoApp` still manages the `AnimationController` and the `Tween`,
and it passes the `Animation` object to `AnimatedLogo`:

```dart diff
  void main() => runApp(const LogoApp());

+ class AnimatedLogo extends AnimatedWidget {
+   const AnimatedLogo({super.key, required Animation<double> animation})
+     : super(listenable: animation);
+
+   @override
+   Widget build(BuildContext context) {
+     final animation = listenable as Animation<double>;
+     return Center(
+       child: Container(
+         margin: const EdgeInsets.symmetric(vertical: 10),
+         height: animation.value,
+         width: animation.value,
+         child: const FlutterLogo(),
+       ),
+     );
+   }
+ }
+
  class LogoApp extends StatefulWidget {
    // ...

    @override
    void initState() {
      super.initState();
      controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      );
-     animation = Tween<double>(begin: 0, end: 300).animate(controller)
-       ..addListener(() {
-         setState(() {
-           // The state that has changed here is the animation object's value.
-         });
-       });
+     animation = Tween<double>(begin: 0, end: 300).animate(controller);
      controller.forward();
    }

    @override
-   Widget build(BuildContext context) {
-     return Center(
-       child: Container(
-         margin: const EdgeInsets.symmetric(vertical: 10),
-         height: animation.value,
-         width: animation.value,
-         child: const FlutterLogo(),
-       ),
-     );
-   }
+   Widget build(BuildContext context) => AnimatedLogo(animation: animation);

    // ...
  }
```

**App source:** [animate2][]

<a id="monitoring"></a>

## Monitoring the progress of the animation

:::secondary What's the point?
* Use `addStatusListener()` for notifications of changes
  to the animation's state, such as starting, stopping,
  or reversing direction.
* Run an animation in an infinite loop by reversing direction when
  the animation has either completed or returned to its starting state,
  or by calling `controller.repeat(reverse: true)`.
:::

It's often helpful to know when an animation changes state,
such as finishing, moving forward, or reversing.
You can get notifications for this with `addStatusListener()`.
The following code modifies the previous example so that
it listens for a state change and prints an update.
The highlighted line shows the change:

<?code-excerpt "animate3/lib/main.dart (print-state)" plaster="none" replace="/\/\/ (\.\..*)/$1;/g; /\n  }/$&\n  \/\/ .../g"?>
```dart highlightLines=13
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((status) => debugPrint('$status'));
    controller.forward();
  }
  // ...
}
```

Running this code produces this output:

```console
AnimationStatus.forward
AnimationStatus.completed
```

Next, use `addStatusListener()` to reverse the animation
at the beginning or the end. This creates a "breathing" effect:

```dart diff
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
-   animation = Tween<double>(begin: 0, end: 300).animate(controller);
+   animation = Tween<double>(begin: 0, end: 300).animate(controller)
+     ..addStatusListener((status) {
+       if (status == AnimationStatus.completed) {
+         controller.reverse();
+       } else if (status == AnimationStatus.dismissed) {
+         controller.forward();
+       }
+     })
+     ..addStatusListener((status) => debugPrint('$status'));
    controller.forward();
  }
```

**App source:** [animate3][]

:::tip Repeating an animation
While `addStatusListener()` is useful for reacting to status changes,
if your only goal is to loop an animation continuously in one or both
directions, you can call [`controller.repeat(reverse: true)`][repeat]
instead of manually toggling `forward()` and `reverse()` in a status listener.
:::

## Refactoring with AnimatedBuilder

:::secondary What's the point?
* An [`AnimatedBuilder`][] separates the transition from the widget being
  animated.
* An `AnimatedBuilder` doesn't render the widget itself,
  nor does it manage the `Animation` object.
* Use `AnimatedBuilder` to describe an animation as
  part of a `build()` method for another widget.
  To define a widget with a reusable
  animation, use an `AnimatedWidget`, as shown in
  the [Simplifying with AnimatedWidget][] section.
* Examples of `AnimatedBuilder`s in the Flutter API: `BottomSheet`,
  `ExpansionTile`, `PopupMenu`, `ProgressIndicator`,
  `RefreshIndicator`, `Scaffold`, `SnackBar`, `TabBar`,
  `TextField`.
:::

One problem with the code in the [animate3][] example
is that changing the animation required changing the widget
that renders the logo. A better solution
is to separate responsibilities into different classes:

* Render the logo
* Define the `Animation` object
* Render the transition

You can accomplish this separation with the help of the
`AnimatedBuilder` class (or its general-purpose counterpart,
[`ListenableBuilder`][]). An `AnimatedBuilder` is a
separate class in the render tree. Like `AnimatedWidget`,
`AnimatedBuilder` automatically listens to notifications
from the `Animation` object, and marks the widget tree
dirty as necessary, so you don't need to call `addListener()`.

The widget tree for the [animate4][]
example looks like this:

<DashImage figure image="ui/AnimatedBuilder-WidgetTree.png" alt="AnimatedBuilder widget tree" />

Starting from the bottom of the widget tree, the code for rendering
the logo is straightforward:

<?code-excerpt "animate4/lib/main.dart (logo-widget)"?>
```dart
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  // Leave out the height and width so it fills the animating parent.
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}
```

The middle three blocks in the diagram are all created in the
`build()` method in `GrowTransition`, shown below.
The `GrowTransition` widget itself is stateless and holds
the set of final variables necessary to define the transition animation.
The `build()` method creates and returns the `AnimatedBuilder`,
which takes the anonymous `builder` callback and the
`LogoWidget` object as parameters. The work of rendering the
transition actually happens in the anonymous `builder`
callback, which creates a `SizedBox` (labeled `Container` in the diagram)
of the appropriate size to force the `LogoWidget` to shrink to fit.

One tricky point in the code below is that the child looks
like it's specified twice. What's happening is that the
outer reference to `child` is passed to `AnimatedBuilder`,
which passes it to the anonymous closure, which then uses
that object as its child. The net result is that the
`AnimatedBuilder` is inserted in between the two widgets
in the render tree, and the static `child` subtree is built only once
rather than on every animation frame.

<?code-excerpt "animate4/lib/main.dart (grow-transition)"?>
```dart
class GrowTransition extends StatelessWidget {
  const GrowTransition({
    required this.child,
    required this.animation,
    super.key,
  });

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
```

Finally, the code to initialize the animation looks very
similar to the [animate2][] example. The `initState()`
method creates an `AnimationController` and a `Tween`,
then binds them with `animate()`. Next,
the `build()` method returns a `GrowTransition`
object with a `LogoWidget` as a child, and an animation object to
drive the transition. These are the three elements listed
in the bullet points above.

```dart diff
  void main() => runApp(const LogoApp());

+ class LogoWidget extends StatelessWidget {
+   const LogoWidget({super.key});
+
+   // Leave out the height and width so it fills the animating parent.
+   @override
+   Widget build(BuildContext context) {
+     return Container(
+       margin: const EdgeInsets.symmetric(vertical: 10),
+       child: const FlutterLogo(),
+     );
+   }
+ }
+
+ class GrowTransition extends StatelessWidget {
+   const GrowTransition({
+     required this.child,
+     required this.animation,
+     super.key,
+   });
+
+   final Widget child;
+   final Animation<double> animation;
+
+   @override
+   Widget build(BuildContext context) {
+     return Center(
+       child: AnimatedBuilder(
+         animation: animation,
+         builder: (context, child) {
+           return SizedBox(
+             height: animation.value,
+             width: animation.value,
+             child: child,
+           );
+         },
+         child: child,
+       ),
+     );
+   }
+ }

  class LogoApp extends StatefulWidget {
    // ...

    @override
-   Widget build(BuildContext context) => AnimatedLogo(animation: animation);
+   Widget build(BuildContext context) {
+     return GrowTransition(animation: animation, child: const LogoWidget());
+   }

    // ...
  }
```

**App source:** [animate4][]

## Simultaneous animations

:::secondary What's the point?
* The [`Curves`][] class defines an array of
  commonly used curves that you can
  use with a [`CurvedAnimation`][].
:::

In this section, you'll build on the example from
[Monitoring the progress of the animation][]
([animate3][]), which used `AnimatedWidget`
to animate in and out continuously. Consider the case
where you want to animate in and out while the
opacity animates from transparent to opaque.

:::note
This example shows how to use multiple tweens on the same animation
controller, where each tween manages a different effect in
the animation. It is for illustrative purposes only.
If you were tweening opacity and size in production code,
prefer [`FadeTransition`][] and [`SizeTransition`][]
(avoid animating the `Opacity` widget directly, which can force
a costly offscreen `saveLayer` pass on each frame).
:::

Each tween manages an aspect of the animation. For example:

<?code-excerpt "animate5/lib/main.dart (tweens)" plaster="none"?>
```dart
controller = AnimationController(
  duration: const Duration(seconds: 2),
  vsync: this,
);
sizeAnimation = Tween<double>(begin: 0, end: 300).animate(controller);
opacityAnimation = Tween<double>(begin: 0.1, end: 1).animate(controller);
```

You can get the size with `sizeAnimation.value` and the opacity
with `opacityAnimation.value`, but the constructor for `AnimatedWidget`
only takes a single `Animation` object. To solve this problem,
the example creates its own `Tween` objects and explicitly calculates the
values.

Change `AnimatedLogo` to encapsulate its own `Tween` objects,
and its `build()` method calls `Tween.evaluate()`
on the parent's animation object to calculate
the required size and opacity values.
The following code shows the changes with highlights:

<?code-excerpt "animate5/lib/main.dart (diff)" replace="/(static final|child: Opacity|opacity:|_sizeTween\.|CurvedAnimation).*/[!$&!]/g"?>
```dart
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation})
    : super(listenable: animation);

  // Make the Tweens static because they don't change.
  [!static final _opacityTween = Tween<double>(begin: 0.1, end: 1);!]
  [!static final _sizeTween = Tween<double>(begin: 0, end: 300);!]

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      [!child: Opacity(!]
        [!opacity: _opacityTween.evaluate(animation),!]
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: [!_sizeTween.evaluate(animation),!]
          width: [!_sizeTween.evaluate(animation),!]
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = [!CurvedAnimation(parent: controller, curve: Curves.easeIn)!]
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
```

**App source:** [animate5][]

## Next steps

This tutorial gives you a foundation for creating explicit animations in
Flutter using `Tween`s, but there are many other animation APIs to explore:

* [Implicit animations][] and [`TweenAnimationBuilder`][] for simpler
  animations that don't require managing an `AnimationController`.
* Specialized [`Tween`][] subclasses, such as [`ColorTween`][],
  [`RectTween`][], and [`IntTween`][].
* [Staggered animations][] for coordinating sequential or overlapping motions.
* [Hero animations][] for shared element transitions between routes.
* [Physics simulations][] and [`fling()`][] methods for motion modeled on
  real-world physics.
* [`ReverseAnimation`][] and the [Animations overview][] for a deeper look
  at Flutter's animation architecture.

[animate0]: {{site.repo.this}}/tree/main/examples/animation/animate0
[animate1]: {{site.repo.this}}/tree/main/examples/animation/animate1
[animate2]: {{site.repo.this}}/tree/main/examples/animation/animate2
[animate3]: {{site.repo.this}}/tree/main/examples/animation/animate3
[animate4]: {{site.repo.this}}/tree/main/examples/animation/animate4
[animate5]: {{site.repo.this}}/tree/main/examples/animation/animate5
[`AnimatedWidget`]: {{site.api}}/flutter/widgets/AnimatedWidget-class.html
[`AnimatedBuilder`]: {{site.api}}/flutter/widgets/AnimatedBuilder-class.html
[Animations overview]: /ui/animations/overview
[Introduction to animations]: /ui/animations
[`AnimationController`]: {{site.api}}/flutter/animation/AnimationController-class.html
[`AnimationController` section]: /ui/animations#animationcontroller
[`ColorTween`]: {{site.api}}/flutter/animation/ColorTween-class.html
[`Curves`]: {{site.api}}/flutter/animation/Curves-class.html
[`CurvedAnimation`]: {{site.api}}/flutter/animation/CurvedAnimation-class.html
[Cascade notation]: {{site.dart-site}}/language/operators#cascade-notation
[Dart language documentation]: {{site.dart-site}}/language
[`FadeTransition`]: {{site.api}}/flutter/widgets/FadeTransition-class.html
[`fling()`]: {{site.api}}/flutter/animation/AnimationController/fling.html
[Hero animations]: /ui/animations/hero-animations
[Implicit animations]: /ui/animations/implicit-animations
[`IntTween`]: {{site.api}}/flutter/animation/IntTween-class.html
[`ListenableBuilder`]: {{site.api}}/flutter/widgets/ListenableBuilder-class.html
[Monitoring the progress of the animation]: #monitoring
[Physics simulations]: /cookbook/animation/physics-simulation
[`RectTween`]: {{site.api}}/flutter/animation/RectTween-class.html
[Refactoring with AnimatedBuilder]: #refactoring-with-animatedbuilder
[repeat]: {{site.api}}/flutter/animation/AnimationController/repeat.html
[`ReverseAnimation`]: {{site.api}}/flutter/animation/ReverseAnimation-class.html
[`SlideTransition`]: {{site.api}}/flutter/widgets/SlideTransition-class.html
[Simplifying with AnimatedWidget]: #simplifying-with-animatedwidget
[`SizeTransition`]: {{site.api}}/flutter/widgets/SizeTransition-class.html
[Staggered animations]: /ui/animations/staggered-animations
[`Tween`]: {{site.api}}/flutter/animation/Tween-class.html
[`TweenAnimationBuilder`]: {{site.api}}/flutter/widgets/TweenAnimationBuilder-class.html
