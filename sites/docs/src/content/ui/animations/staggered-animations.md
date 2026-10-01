---
title: Staggered animations
description: How to write a staggered animation in Flutter.
shortTitle: Staggered
---

<?code-excerpt path-base="animation"?>

:::secondary What you'll learn
* A staggered animation consists of sequential or overlapping
    animations.
* To create a staggered animation, use multiple `Animation` objects.
* One `AnimationController` controls all of the `Animation`s.
* Each `Animation` object specifies the animation during an `Interval`.
* For each property being animated, create a `Tween`.
:::

:::tip Terminology
If the concept of tweens or tweening is new to you, refer to the
[Animations in Flutter tutorial][].
:::

Staggered animations are a straightforward concept: visual changes
happen as a series of operations, rather than all at once.
The animation might be purely sequential, with one change occurring after
the next, or it might partially or completely overlap. It might also
have gaps, where no changes occur.

This guide shows how to build a staggered animation in Flutter
that applies a series of sequential and overlapping animations
to a single widget. Tapping the screen begins an animation
that changes opacity, size, shape, color, and padding.

The following video demonstrates this staggered animation:

<YouTubeEmbed id="0fFvnZemmh8" title="Staggered animation example"></YouTubeEmbed>

In the video, you see the following animation of a single widget,
which begins as a bordered blue square with slightly rounded corners.
The square runs through changes in the following order:

1. Fades in
1. Widens
1. Becomes taller while moving upwards
1. Transforms into a bordered circle
1. Changes color to orange

After running forward, the animation runs in reverse.

:::secondary New to Flutter?
This page assumes you know how to create a layout using Flutter's
widgets. To learn more, visit [Building Layouts in Flutter][].
:::

## Basic structure of a staggered animation

:::secondary What's the point?
* All of the animations are driven by the same
  [`AnimationController`][].
* Regardless of how long the animation lasts in real time,
  the controller's values must be between 0.0 and 1.0, inclusive.
* Each animation has an [`Interval`][]
  between 0.0 and 1.0, inclusive.
* For each property that animates in an interval, create a
  [`Tween`][]. The `Tween` specifies the start and end
  values for that property.
* The `Tween` produces an [`Animation`][]
  object that is managed by the controller.
:::

The following diagram shows the `Interval`s used in the
staggered animation example.
You might notice the following characteristics:

* The opacity changes during the first 10% of the timeline.
* A tiny gap occurs between the change in opacity
  and the change in width.
* Nothing animates during the last 25% of the timeline.
* Increasing the padding makes the widget appear to rise upward.
* Increasing the border radius to `75.0`
  transforms the `150.0` x `150.0` square with rounded corners into a circle.
* The padding and height changes occur during
  the exact same interval, but they don't have to.

![Diagram showing the interval specified for each motion](/assets/images/docs/ui/animations/StaggeredAnimationIntervals.png)

To set up the animation:

* Create an `AnimationController` that manages all of the
  `Animation` objects.
* Create a `Tween` for each property being animated.
  * The `Tween` defines a range of values.
  * The `Tween`'s `animate` method requires the
    `parent` controller, and produces an `Animation`
    for that property.
* Specify the interval on the `Animation`'s `curve` property.

When the controlling animation's value changes,
the new animation's value changes, triggering the UI to update.

The following code creates a tween for the `width` property.
It builds a [`CurvedAnimation`][],
specifying an eased curve. Consult [`Curves`][] for
other available predefined animation curves.

<?code-excerpt "staggered_animation/lib/main.dart (width)"?>
```dart
width = Tween<double>(begin: 50, end: 150).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(0.125, 0.250, curve: Curves.ease),
  ),
),
```

The `begin` and `end` values don't have to be doubles.
The following code builds the tween for the `borderRadius` property
(which controls the roundness of the square's corners),
using `BorderRadius.circular()`.

<?code-excerpt "staggered_animation/lib/main.dart (border-radius)"?>
```dart
borderRadius =
    BorderRadiusTween(
      begin: BorderRadius.circular(4),
      end: BorderRadius.circular(75),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.375, 0.500, curve: Curves.ease),
      ),
    ),
```

### Complete staggered animation

Like all interactive widgets, the complete animation consists
of a widget pair: a stateless and a stateful widget.

The stateless widget specifies the `Tween`s,
defines the `Animation` objects, and provides a `build()` function
responsible for building the animating portion of the widget tree.

The stateful widget creates the controller, plays the animation,
and builds the non-animating portion of the widget tree.
The animation begins when a tap is detected anywhere on the screen.

### Stateless widget: StaggerAnimation

In the stateless widget, `StaggerAnimation`,
the `build()` function instantiates an
[`AnimatedBuilder`][]&mdash;a general-purpose widget for building
animations. The `AnimatedBuilder`
builds a widget and configures it using the `Tween`s' current values.
The example creates a function named `_buildAnimation()` (which performs
the actual UI updates), and assigns it to its `builder` property.
`AnimatedBuilder` listens to notifications from the animation controller,
marking the widget tree dirty as values change.
For each tick of the animation, the values are updated,
resulting in a call to `_buildAnimation()`.

:::tip
This example uses an `Opacity` widget inside `AnimatedBuilder` to keep all
animated properties in a single builder. When animating opacity on its own,
prefer [`FadeTransition`][] to avoid rebuilding the child widget on each frame.
:::

<?code-excerpt "staggered_animation/lib/main.dart (stagger-animation)" replace="/(class StaggerAnimation extends StatelessWidget|opacity = Tween[^\(]*|final Animation.*|Widget _buildAnimation.*|Widget build\(BuildContext context\)|AnimatedBuilder|builder: _buildAnimation)/[!$&!]/g"?>
```dart
import 'dart:async';

import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:material_ui/material_ui.dart';

[!class StaggerAnimation extends StatelessWidget!] {
  StaggerAnimation({super.key, required this.controller})
    : // Each animation defined here transforms its value during the subset
      // of the controller's duration defined by the animation's interval.
      // For example, the opacity animation transforms its value during
      // the first 10% of the controller's duration.
      [!opacity = Tween<double>!](begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0, 0.100, curve: Curves.ease),
        ),
      ),

      width = Tween<double>(begin: 50, end: 150).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.125, 0.250, curve: Curves.ease),
        ),
      ),

      height = Tween<double>(begin: 50, end: 150).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.250, 0.375, curve: Curves.ease),
        ),
      ),

      padding =
          EdgeInsetsTween(
            begin: const EdgeInsets.only(bottom: 16),
            end: const EdgeInsets.only(bottom: 75),
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.250, 0.375, curve: Curves.ease),
            ),
          ),

      borderRadius =
          BorderRadiusTween(
            begin: BorderRadius.circular(4),
            end: BorderRadius.circular(75),
          ).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.375, 0.500, curve: Curves.ease),
            ),
          ),

      color = ColorTween(begin: Colors.indigo[100], end: Colors.orange[400])
          .animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.500, 0.750, curve: Curves.ease),
            ),
          );

  [!final Animation<double> controller;!]
  [!final Animation<double> opacity;!]
  [!final Animation<double> width;!]
  [!final Animation<double> height;!]
  [!final Animation<EdgeInsets> padding;!]
  [!final Animation<BorderRadius?> borderRadius;!]
  [!final Animation<Color?> color;!]

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  [!Widget _buildAnimation(BuildContext context, Widget? child) {!]
    return Container(
      padding: padding.value,
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: opacity.value,
        child: Container(
          width: width.value,
          height: height.value,
          decoration: BoxDecoration(
            color: color.value,
            border: Border.all(color: Colors.indigo[300]!, width: 3),
            borderRadius: borderRadius.value,
          ),
        ),
      ),
    );
  }

  @override
  [!Widget build(BuildContext context)!] {
    return [!AnimatedBuilder!]([!builder: _buildAnimation!], animation: controller);
  }
}
```

### Stateful widget: StaggerDemo

The stateful widget, `StaggerDemo`, creates the `AnimationController`,
specifying a 2000 ms duration. It plays the animation,
and builds the non-animating portion of the widget tree.
The animation begins when a tap is detected on the screen.
The animation runs forward, then backward.

<?code-excerpt "staggered_animation/lib/main.dart (stagger-demo)" replace="/(class StaggerDemo extends StatefulWidget|Future.* _playAnimation\(\) async|await _controller\.(forward|reverse)\(\)\.orCancel;|Widget build\(BuildContext context\))/[!$&!]/g"?>
```dart
[!class StaggerDemo extends StatefulWidget!] {
  const StaggerDemo({super.key});

  @override
  State<StaggerDemo> createState() => _StaggerDemoState();
}

class _StaggerDemoState extends State<StaggerDemo>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  [!Future<void> _playAnimation() async!] {
    try {
      [!await _controller.forward().orCancel;!]
      [!await _controller.reverse().orCancel;!]
    } on TickerCanceled {
      // The animation got canceled, probably because it was disposed of.
    }
  }

  @override
  [!Widget build(BuildContext context)!] {
    timeDilation = 10; // 1 is normal animation speed.
    return Scaffold(
      appBar: AppBar(title: const Text('Staggered Animation')),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
              border: Border.all(color: Colors.black.withValues(alpha: 0.5)),
            ),
            child: StaggerAnimation(controller: _controller.view),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: StaggerDemo()));
}
```

[`Animation`]: {{site.api}}/flutter/animation/Animation-class.html
[`AnimationController`]: {{site.api}}/flutter/animation/AnimationController-class.html
[`AnimatedBuilder`]: {{site.api}}/flutter/widgets/AnimatedBuilder-class.html
[Animations in Flutter tutorial]: /ui/animations/tutorial
[Building Layouts in Flutter]: /ui/layout
[`CurvedAnimation`]: {{site.api}}/flutter/animation/CurvedAnimation-class.html
[`Curves`]: {{site.api}}/flutter/animation/Curves-class.html
[`FadeTransition`]: {{site.api}}/flutter/widgets/FadeTransition-class.html
[`Interval`]: {{site.api}}/flutter/animation/Interval-class.html
[`Tween`]: {{site.api}}/flutter/animation/Tween-class.html
