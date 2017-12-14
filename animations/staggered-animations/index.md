---
layout: page
title: " Staggered Animations"
permalink: /animations/staggered-animations/
---

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What you'll learn:</b>

* A staggered animation consists of sequential or overlapping
  animations.
* Create a staggered animation using multiple Animation objects.
* Each Animation object specifies the animation during an interval.
* Each Animation object specifies one or more Tweens that describe the
  start and end values for the properties being animated during that
  interval.
</div>

<aside class="alert alert-info" markdown="1">
**Terminology:**
If the concept of tweens or tweening is new to you, please see the
[Animations in Flutter tutorial.](/tutorials/animation/)
</aside>

Staggered animations are a straightforward concept: motion
is performed as a series of operations, rather than all at once.
The animation may be purely sequential, with one motion occuring after
the next, or it may partially or completely overlap.

This guide shows how to build a staggered animation.

<aside class="alert alert-info" markdown="1">
**Where's the code?**<br>

This guide provides two staggered animation examples,
though only one is described here. The second, more complex example,
is available for your reference.

[basic_staggered_animation](https://github.com/flutter/website/tree/master/_includes/code/animation/basic_staggered_animation)
: Shows a series of sequential and overlapping animations on a single widget.
  Clicking in the screen begins an animation that changes opacity, size,
  shape, color and padding.

[staggered_pic_selection](https://github.com/flutter/website/tree/master/_includes/code/animation/staggered_pic_selection)
: Shows deleting an image from a list of images displayed in one of three sizes.
  This example uses two animation controllers: one for image selection/de-selection,
  and one for image deletion. The selection/de-selection animation is staggered.
  (To see effect this yourself, you may need to increase the ```timeDilation``` value.)
  Select one of the largest images which shrinks while displaying a checkmark
  inside a blue circle. Then select one of the smallest images. The large image
  expands before the small image shrinks. This behavior is similar to that used
  by Google Photos.

</aside>

The following video demonstrates a simple staggered animation
described in this guide:

<!--
  Use this instead of the default YouTube embed code so that the embed
  is responsive.
-->
<div class="embed-container"><iframe src="https://www.youtube.com/embed/0fFvnZemmh8?rel=0" frameborder="0" allowfullscreen></iframe></div>

In the video, you see the following animation on a single widget,
which begins as a bordered blue square with slightly rounded corners.
The square:

* Fades in
* Widens
* Becomes taller while moving upwards
* Transforms into a bordered circle
* Changes color to orange

After running forwards, the animation runs in reverse.

* TOC Placeholder
{:toc}

<aside class="alert alert-info" markdown="1">
**New to Flutter?**
You should first understand how to create a layout using Flutter’s
widgets.  For more information, see [Building Layouts in
Flutter](/tutorials/layout/).
</aside>

**Basic structure of a staggered animation**<br>

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What's the point?</b>

* Break the animation down into Intervals.
* Regardless of how long the animation lasts in real time,
  Intervals are specified within the range of 0.0 and 1.0.
  For example, an Interval might run from 0.5 to 0.55.
* Create an Animation object for each Interval.
* Create a Tween for each property that animates in an interval.
  The Tween object specifies the start and end values for that property.
  For example, a width tween might specify a starting width of 50 pixels
  and an ending width of 150.
</div>

The following diagram shows the Intervals used in the
[basic_staggered_animation](https://github.com/flutter/website/tree/master/_includes/code/animation/basic_staggered_animation)
example:

<img src="images/StaggeredAnimationIntervals.png" alt="Diagram showing the interval specified for each motion." />

The following code shows how two of the animating properties are
defined in basic_staggered_animation:

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

The final custom animation consists of a widget pair: a stateless
and a stateful widget. The stateless widget specifies the Tweens,
defines the Animation objects, and provides a ```build()```
function to build the portion of the widget tree that animates.
For each tick of the animation,
the values for the properties being animated are updated,
triggering an update of the the affected widget(s) in the UI.

<!-- skip -->
{% prettify dart %}
[[highlight]]class StaggerAnimation extends StatelessWidget[[/highlight]] {
  StaggerAnimation({ Key key, this.controller }) :

    // Each animation defined here transforms its value during the subset
    // of the controller's duration defined by the animation's interval.
    // For example the opacity animation transforms its value during
    // the first 10% of the controller's duration.
    //
    // Most of the Intervals cause the animations' transforms to be
    // "staggered", i.e. to start one after another.

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

    [[highlight]]width = new Tween<double>[[/highlight]](
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

    [[highlight]]height = new Tween<double>[[/highlight]](
      begin: 50.0,
      end: 150.0
    ).animate(
      new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.250, 0.375,
          curve: Curves.ease,
        ),
      ),
    ),

    [[highlight]]padding = new EdgeInsetsTween[[/highlight]](
      begin: const EdgeInsets.only(bottom: 16.0),
      end: const EdgeInsets.only(bottom: 75.0),
    ).animate(
      new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.250, 0.375,
          curve: Curves.ease,
        ),
      ),
    ),

    [[highlight]]borderRadius = new BorderRadiusTween[[/highlight]](
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

    [[highlight]]color = new ColorTween[[/highlight]](
      begin: Colors.indigo[100],
      end: Colors.orange[400],
    ).animate(
      new CurvedAnimation(
        parent: controller,
        curve: new Interval(
          0.500, 0.750,
          curve: Curves.ease,
        ),
      ),
    ),

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
    return new AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
{% endprettify %}

The stateful widget creates the controller, plays the animation,
and builds the non-animating portion of the widget tree.
The animation is kicked off when a "hit" gesture is detected anywhere
in the screen. The animation runs forwards, then backwards.

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  [[highlight]]Future<Null> _playAnimation() async[[/highlight]] {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
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

The following resources may help when writing animations:

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
: Demo app showcasing many Material Design widgets and other Flutter
  features.  The [Shrine
  demo](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery/lib/demo/shrine)
  implements a hero animation.

[Material motion spec](https://material.io/guidelines/motion/)
: Describes motion for Material design apps.
