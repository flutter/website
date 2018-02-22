---
layout: page
title: "Staggered Animations"
permalink: /animations/staggered-animations/
---

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What you'll learn:</b>

* A staggered animation consists of sequential or overlapping
  animations.
* To create a staggered animation, use multiple Animation objects.
* One AnimationController controls all of the Animations.
* Each Animation object specifies the animation during an Interval.
* For each property being animated, create a Tween.
</div>

<aside class="alert alert-info" markdown="1">
**Terminology:**
If the concept of tweens or tweening is new to you, see the
[Animations in Flutter tutorial.](/tutorials/animation/)
</aside>

Staggered animations are a straightforward concept: visual changes
happen as a series of operations, rather than all at once.
The animation might be purely sequential, with one change occuring after
the next, or it might partially or completely overlap. It might also
have gaps, where no changes occur.

This guide shows how to build a staggered animation in Flutter.

<aside class="alert alert-info" markdown="1">
**Examples**<br>

This guide explains the basic_staggered_animation example. You can also
refer to a more complex example, staggered_pic_selection.

[basic_staggered_animation](https://github.com/flutter/website/tree/master/_includes/code/animation/basic_staggered_animation)
: Shows a series of sequential and overlapping animations of a single widget.
  Tapping the screen begins an animation that changes opacity, size,
  shape, color, and padding.

[staggered_pic_selection](https://github.com/flutter/website/tree/master/_includes/code/animation/staggered_pic_selection)
: Shows deleting an image from a list of images displayed in one of three sizes.
  This example uses two [animation
  controllers](https://docs.flutter.io/flutter/animation/AnimationController-class.html):
  one for image selection/deselection, and one for image deletion.
  The selection/deselection animation is staggered. (To see this effect,
  you might need to increase the `timeDilation` value.)
  Select one of the largest images&mdash;it shrinks as it displays a checkmark
  inside a blue circle. Next, select one of the smallest images&mdash;the
  large image expands as the checkmark disappears. Before the large image
  has finished expanding, the small image shrinks to display its checkmark.
  This staggered behavior is similar to what you might see in Google Photos.

</aside>

* TOC Placeholder
{:toc}

The following video demonstrates the animation performed by
basic_staggered_animation:

<!--
  Use this instead of the default YouTube embed code so that the embed
  is responsive.
-->
<div class="embed-container"><iframe src="https://www.youtube.com/embed/0fFvnZemmh8?rel=0" frameborder="0" allowfullscreen></iframe></div>

In the video, you see the following animation of a single widget,
which begins as a bordered blue square with slightly rounded corners.
The square runs through changes in the following order:

1. Fades in
1. Widens
1. Becomes taller while moving upwards
1. Transforms into a bordered circle
1. Changes color to orange

After running forward, the animation runs in reverse.

<aside class="alert alert-info" markdown="1">
**New to Flutter?**<br>
This page assumes you know how to create a layout using Flutter’s
widgets.  For more information, see [Building Layouts in
Flutter](/tutorials/layout/).
</aside>

## Basic structure of a staggered animation

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What's the point?</b>

* All of the animations are driven by the same
  [AnimationController](https://docs.flutter.io/flutter/animation/AnimationController-class.html).
* Regardless of how long the animation lasts in real time,
  the controller's values must be between 0.0 and 1.0, inclusive.
* Each animation has an
  [Interval](https://docs.flutter.io/flutter/animation/Interval-class.html)
  between 0.0 and 1.0, inclusive.
* For each property that animates in an interval, create a
  [Tween.](https://docs.flutter.io/flutter/animation/Tween-class.html)
  The Tween specifies the start and end values for that property.
* The Tween produces an
  [Animation](https://docs.flutter.io/flutter/animation/Animation-class.html)
  object that is managed by the controller.
</div>

{% comment %}
The app is essentially animating a Container whose decoration and size are
animated. The Container is within another Container whose padding moves the
inner container around and an Opacity widget that's used to fade everything
in and out.
{% endcomment %}

The following diagram shows the Intervals used in the
[basic_staggered_animation](https://github.com/flutter/website/tree/master/_includes/code/animation/basic_staggered_animation)
example. You might notice the following characteristics:

* The opacity changes during the first 10% of the timeline.
* A tiny gap occurs between the change in opacity, and the change in width.
* Nothing animates during the last 25% of the timeline.
* Increasing the padding makes the widget appear to rise upward.
* Increasing the border radius to 0.5, transforms the square with rounded
  corners into a circle.
* The padding and border radius changes occur during the same exact interval,
  but they don't have to.

<img src="images/StaggeredAnimationIntervals.png" alt="Diagram showing the interval specified for each motion." />

To set up the animation:

* Create an AnimationController that manages all of the Animations.
* Create a Tween for each property being animated.
  * The Tween defines a range of values.
  * The Tween's `animate` method requires the `parent` controller, and
    produces an Animation for that property.
* Specify the interval on the Animation's `curve` property.

When the controlling animation's value changes, the new animation's
value changes, triggering the UI to update.

The following code creates a tween for the `width` property.
It builds a
[CurvedAnimation](https://docs.flutter.io/flutter/animation/CurvedAnimation-class.html),
specifying an eased curve.
See [Curves](https://docs.flutter.io/flutter/animation/Curves-class.html)
for other available pre-defined animation curves.

<!-- skip -->
{% prettify dart %}
width = new Tween<double>(
  begin: 50.0,
  end: 150.0,
).animate(
  new CurvedAnimation(
    parent: controller,
    curve: new Interval(
      0.125, 0.250,
      curve: Curves.ease,
    ),
  ),
),
{% endprettify %}

The `begin` and `end` values don't have to be doubles.
The following code builds the tween for the `borderRadius` property
(which controls the roundness of the square's corners), using
`BorderRadius.circular()`.

{% prettify dart %}
borderRadius = new BorderRadiusTween(
  begin: new BorderRadius.circular(4.0),
  end: new BorderRadius.circular(75.0),
).animate(
  new CurvedAnimation(
    parent: controller,
    curve: new Interval(
      0.375, 0.500,
      curve: Curves.ease,
    ),
  ),
),
{% endprettify %}

### Complete staggered animation

Like all interactive widgets, the complete animation consists
of a widget pair: a stateless and a stateful widget.

The stateless widget specifies the Tweens,
defines the Animation objects, and provides a `build()` function
responsible for building the animating portion of the widget tree.

The stateful widget creates the controller, plays the animation,
and builds the non-animating portion of the widget tree.
The animation begins when a tap is detected anywhere in the screen.

[Full code for basic_staggered_animation's main.dart](https://raw.githubusercontent.com/flutter/website/master/_includes/code/animation/basic_staggered_animation/main.dart)

### Stateless widget: StaggerAnimation

In the stateless widget, StaggerAnimation, the `build()` function instantiates an
[AnimatedBuilder](https://docs.flutter.io/flutter/widgets/AnimatedBuilder-class.html)&mdash;a
general purpose widget for building animations. The AnimatedBuilder
builds a widget and configures it using the Tweens' current values.
The example creates a function named `_buildAnimation()` (which performs
the actual UI updates), and assigns it to its `builder` property.
AnimatedBuilder listens to notifications from the animation controller,
marking the widget tree dirty as values change.
For each tick of the animation, the values are updated,
resulting in a call to `_buildAnimation()`.

<!-- skip -->
{% prettify dart %}
[[highlight]]class StaggerAnimation extends StatelessWidget[[/highlight]] {
  StaggerAnimation({ Key key, this.controller }) :

    // Each animation defined here transforms its value during the subset
    // of the controller's duration defined by the animation's interval.
    // For example the opacity animation transforms its value during
    // the first 10% of the controller's duration.

    [[highlight]]opacity = new Tween<double>[[/highlight]](
      begin: 0.0,
      end: 1.0,
    ).animate(
      new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.0, 0.100,
          curve: Curves.ease,
        ),
      ),
    ),

    // ... Other tween definitions ...

    super(key: key);

  [[highlight]]final Animation<double> controller;[[/highlight]]
  [[highlight]]final Animation<double> opacity;[[/highlight]]
  [[highlight]]final Animation<double> width;[[/highlight]]
  [[highlight]]final Animation<double> height;[[/highlight]]
  [[highlight]]final Animation<EdgeInsets> padding;[[/highlight]]
  [[highlight]]final Animation<BorderRadius> borderRadius;[[/highlight]]
  [[highlight]]final Animation<Color> color;[[/highlight]]

  // This function is called each the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  [[highlight]]Widget _buildAnimation(BuildContext context, Widget child)[[/highlight]] {
    return new Container(
      padding: padding.value,
      alignment: Alignment.bottomCenter,
      child: new Opacity(
        opacity: opacity.value,
        child: new Container(
          width: width.value,
          height: height.value,
          decoration: new BoxDecoration(
            color: color.value,
            border: new Border.all(
              color: Colors.indigo[300],
              width: 3.0,
            ),
            borderRadius: borderRadius.value,
          ),
        ),
      ),
    );
  }

  @override
  [[highlight]]Widget build(BuildContext context)[[/highlight]] {
    return [[highlight]]new AnimatedBuilder[[/highlight]](
      [[highlight]]builder: _buildAnimation[[/highlight]],
      animation: controller,
    );
  }
}
{% endprettify %}

### Stateful widget: StaggerDemo

The stateful widget, StaggerDemo, creates the AnimationController
(the one who rules them all), specifying a 2000 ms duration. It plays
the animation, and builds the non-animating portion of the widget tree.
The animation begins when a tap is detected in the screen.
The animation runs forward, then backward.

<!-- skip -->
{% prettify dart %}
[[highlight]]class StaggerDemo extends StatefulWidget[[/highlight]] {
  @override
  _StaggerDemoState createState() => new _StaggerDemoState();
}

class _StaggerDemoState extends State<StaggerDemo> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this
    );
  }

  // ...Boilerplate...

  [[highlight]]Future<Null> _playAnimation() async[[/highlight]] {
    try {
      [[highlight]]await _controller.forward().orCancel;[[/highlight]]
      [[highlight]]await _controller.reverse().orCancel;[[/highlight]]
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  [[highlight]]Widget build(BuildContext context)[[/highlight]] {
    timeDilation = 10.0; // 1.0 is normal animation speed.
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Staggered Animation'),
      ),
      body: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: new Center(
          child: new Container(
            width: 300.0,
            height: 300.0,
            decoration: new BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: new Border.all(
                color:  Colors.black.withOpacity(0.5),
              ),
            ),
            child: new StaggerAnimation(
              controller: _controller.view
            ),
          ),
        ),
      ),
    );
  }
}
{% endprettify %}

## Resources

The following resources might help when writing animations:

[Animations landing page](/animations/)
: Lists the available documentation for Flutter animations.
  If tweens are new to you, check out the
  [Animations tutorial](/tutorials/animation/).

[Flutter API documentation](https://docs.flutter.io/)
: Reference documentation for all of the Flutter libraries.
  In particular, see the [animation
  library](https://docs.flutter.io/flutter/animation/animation-library.html)
  documentation.

[Flutter Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery)
: Demo app showcasing many Material Components and other Flutter
  features.  The [Shrine
  demo](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery/lib/demo/shrine)
  implements a hero animation.

[Material motion spec](https://material.io/guidelines/motion/)
: Describes motion for Material apps.
