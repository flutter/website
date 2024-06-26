---
title: Staggered animations
description: How to write a staggered animation in Flutter.
short-title: Staggered
---

:::secondary What you'll learn
* A staggered animation consists of sequential or overlapping animations.
* To create a staggered animation, use multiple `Animation` objects.
* One `AnimationController` controls all of the `Animation` objects.
* Each `Animation` object specifies the animation during an `Interval`.
* For each property being animated, create a `Tween`.
:::

:::tip Prerequisites
If you don't know about the concept of tweens or tweening,
consult the [Animations in Flutter tutorial][].
The term comes from traditional animation,
where the animator inserts frames "in between" major visual changes
displayed in keyframes.

This guide assumes you know how to create a layout using Flutter's widgets.
To learn more, consult [Building Layouts in Flutter][].
:::

## Concepts

Staggered animations display visual changes as a series of operations,
rather than all at once.
The animation might be sequential,
with one change occurring after the next,
or might overlap in part or in total.
It might also have gaps, where no changes occur.

### Characteristics

Staggered animations share the following features.

* One [`AnimationController`][] manages all of the animations.
* Regardless of how long the animation lasts in real time,
  the controller's values must be between 0.0 and 1.0, inclusive.
* Each animation has an [`Interval`][] between 0.0 and 1.0, inclusive.
* For each property that animates in an interval,
  create a [`Tween`][] object.
  The `Tween` specifies the start and end values for that property.
* The `Tween` produces an [`Animation`][] object that
  the `AnimationController` manages.

{% comment %}
The app animates a `Container` whose
decoration and size are animated. The `Container`
is within another `Container` whose padding moves the
inner container around and an `Opacity` widget that's
used to fade everything in and out.
{% endcomment %}

### Staggered animation example

The following video displays the animation of a single widget.
The widget begins as a bordered blue square with slightly rounded corners.

<iframe
  width="560" height="315" 
  src="{{site.yt.embed}}/0fFvnZemmh8"
  title="Watch this example of a staggered animation in Flutter"
  {{site.yt.set-short}}>
</iframe>

As displayed, the widget undergoes changes in the following order.
You set the total animation duration in the `AnimationController` widget,
but the timing of each change, its `Interval`,
as a percentage of that total duration.

| Step | Displayed change              | Widget change                                                                       | Duration |
|------|-------------------------------|-------------------------------------------------------------------------------------|----------|
| 1    | Fades in                      | Increases opacity from 0 to 100%                                                    |    10.0% |
| 2    | Pauses                        |                                                                                     |     2.5% |
| 3    | Gets wider                    | Increases width from 50 to 150 px                                                   |    12.5% |
| 4    | Gets taller and moves up      | Increases height from 50 to 150 px and<br>increases bottom padding from 16 to 75 px |    12.5% |
| 5    | Changes from square to circle | Increases border radius from 4 to 75 px                                             |    12.5% |
| 6    | Pauses                        |                                                                                     |    25.0% |

{:.table .table-striped}

After running forward for two seconds,
the animation runs in reverse for another two.

The following diagram displays the `Interval` values used in the
previous [basic_staggered_animation][] video example.

{% render docs/captioned-image.liquid,
image:"ui/animations/StaggeredAnimationIntervals.png",
caption:"Timeline of interval of the basic staggered animation example" %}

## Build a basic staggered animation

This guide shows how to build a staggered animation in Flutter
using the [basic_staggered_animation][] example.
This example shows a series of sequential and overlapping animations
of a single widget. Tapping the screen begins an animation
that changes opacity, size, shape, color, and padding.

To set up the animation:

1. Create an `AnimationController` that manages all of the
   `Animations`.
1. Create a `Tween` for each property being animated.
   * The `Tween` defines a range of values.
   * The `Tween`'s `animate` method requires the
     `parent` controller, and produces an `Animation`
     for that property.
1. Specify the interval on the `Animation`'s `curve` property.

When the controlling animation's value changes,
the new animation's value changes, triggering the UI to update.

### Display the changes to a widget's width

The following code creates a tween for the `width` property.
It builds a [`CurvedAnimation`][], specifying an eased curve.

```dart title="main.dart" highlightLines=10
width = Tween<double>(
  begin: 50.0,
  end: 150.0,
).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(
      0.125,
      0.250,
      curve: Curves.ease,
    ),
  ),
),
```

The `begin` and `end` values don't have to be doubles.

To review other available pre-defined animation curves, consult [`Curves`][].

### Display the changes to a widget's border radius

The following code builds the tween for the `borderRadius` property
(which controls the roundness of the square's corners),
using `BorderRadius.circular()`.

```dart title="main.dart" highlightLines=2-3
borderRadius = BorderRadiusTween(
  begin: BorderRadius.circular(4),
  end: BorderRadius.circular(75),
).animate(
  CurvedAnimation(
    parent: controller,
    curve: const Interval(
      0.375,
      0.500,
      curve: Curves.ease,
    ),
  ),
),
```

## Build an app with a complete staggered animation

Like all interactive widgets, the complete animation consists
of a widget pair: a stateless and a stateful widget.

The stateless widget specifies the `Tween` objects,
defines the `Animation` objects, and provides a `build()` function
responsible for building the animating portion of the widget tree.

The stateful widget creates the controller, plays the animation,
and builds the non-animating portion of the widget tree.
The animation begins when a tap is detected anywhere in the screen.

You can download the
[full code for `basic_staggered_animation` app's
`main.dart`][basic-main.dart] file.

### Stateless widget: StaggerAnimation

In the stateless widget, `StaggerAnimation`,
the `build()` function instantiates an
[`AnimatedBuilder`][]&mdash;a general purpose widget for building
animations. The `AnimatedBuilder`
builds a widget and configures it using the `Tweens`' current values.
The example creates a function named `_buildAnimation()` (which performs
the actual UI updates), and assigns it to its `builder` property.
AnimatedBuilder listens to notifications from the animation controller,
marking the widget tree dirty as values change.
For each tick of the animation, the values are updated,
resulting in a call to `_buildAnimation()`.

```dart title="main.dart" highlightLines=1,9,26-32,37,60-62
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({super.key, required this.controller}) :

    // Each animation defined here transforms its value during the subset
    // of the controller's duration defined by the animation's interval.
    // For example the opacity animation transforms its value during
    // the first 10% of the controller's duration.

    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.100,
          curve: Curves.ease,
        ),
      ),
    ),

    // ... Other tween definitions ...
    );

  final AnimationController controller;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<EdgeInsets> padding;
  final Animation<BorderRadius?> borderRadius;
  final Animation<Color?> color;

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget? child) {
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
            border: Border.all(
              color: Colors.indigo[300]!,
              width: 3,
            ),
            borderRadius: borderRadius.value,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
```

### Stateful widget: StaggerDemo

The stateful widget, `StaggerDemo`, creates the `AnimationController` widget.
This specifies a 2000 ms duration.
It plays the animation and builds the non-animating portion of the widget tree.
The animation begins when a tap is detected in the screen.
The animation runs forward, then backward.

```dart title="main.dart" highlightLines=1,22,24-25,32
class StaggerDemo extends StatefulWidget {
  @override
  State<StaggerDemo> createState() => _StaggerDemoState();
}

class _StaggerDemoState extends State<StaggerDemo>
    with TickerProviderStateMixin {
  late AnimationController_controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  // ...Boilerplate...

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // The animation got canceled, probably because it was disposed of.
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0; // 1.0 is normal animation speed.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered Animation'),
      ),
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
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color:  Colors.black.withOpacity(0.5),
              ),
            ),
            child: StaggerAnimation(controller:_controller.view),
          ),
        ),
      ),
    );
  }
}
```

## Review a staggered pic selection example

This complex example uses the code from the [staggered_pic_selection][] sample.
It displays a list of images in one of three sizes.

{% render docs/captioned-image.liquid,
image:"ui/animations/staggered/no-pic-selected.png",
caption:"The **staggered_pic_animation** example in macOS" %}

The animation uses two [animation controllers][]:

1. One animates the selection or deselection an image.  
   This animation is staggered.
   (To see this effect,
   you might need to increase the `timeDilation` value.)

1. Another animates the deletion of an image.

When you run the app, the animation renders when you click an image.

1. Select one of the largest images.  
   It shrinks as it displays a checkmark inside a purple circle.

    {% render docs/captioned-image.liquid,
    image:"ui/animations/staggered/large-pic-selected.png",
    imgstyle:"w50p",
    caption:"A large image selected in the example app" %}

1. Select one of the smallest images.
   The large image expands as the checkmark disappears.
   Before the large image has finished expanding,
   the small image shrinks to display its checkmark.

    {% render docs/captioned-image.liquid,
    image:"ui/animations/staggered/small-pic-selected.png",
    imgstyle:"w50p",
    caption:"A small image selected in the example app" %}

This staggered behavior resembles the behavior of Google Photos.
  
[`Animation`]: {{site.api}}/flutter/animation/Animation-class.html
[animation controllers]: {{site.api}}/flutter/animation/AnimationController-class.html
[`AnimationController`]: {{site.api}}/flutter/animation/AnimationController-class.html
[`AnimatedBuilder`]: {{site.api}}/flutter/widgets/AnimatedBuilder-class.html
[Animations in Flutter tutorial]: /ui/animations/tutorial
[basic_staggered_animation]: {{site.repo.this}}/tree/{{site.branch}}/examples/_animation/basic_staggered_animation
[Building Layouts in Flutter]: /ui/layout
[staggered_pic_selection]: {{site.repo.this}}/tree/{{site.branch}}/examples/_animation/staggered_pic_selection
[`CurvedAnimation`]: {{site.api}}/flutter/animation/CurvedAnimation-class.html
[`Curves`]: {{site.api}}/flutter/animation/Curves-class.html
[basic-main.dart]: {{site.repo.this}}/tree/{{site.branch}}/examples/_animation/basic_staggered_animation/lib/main.dart
[`Interval`]: {{site.api}}/flutter/animation/Interval-class.html
[`Tween`]: {{site.api}}/flutter/animation/Tween-class.html