---
title: Introduction to animations
short-title: Animations
description: How to perform animations in Flutter.
---

Well-designed animations make a UI feel more intuitive,
contribute to the slick look and feel of a polished app,
and improve the user experience.
Flutter's animation support makes it easy to implement a variety of
animation types. Many widgets, especially [Material widgets][],
come with the standard motion effects defined in their design spec,
but it's also possible to customize these effects.

## Choosing an approach

There are different approaches you can take when creating
animations in Flutter. Which approach is right for you?
To help you decide, check out the video,
[How to choose which Flutter Animation Widget is right for you?][]
(Also published as a [_companion article_][article1].)

<center><iframe width="560" height="315" src="https://www.youtube.com/embed/GXIJJkq_H8g" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></center>

(To dive deeper into the decision process,
watch the [Animations in Flutter done right][] video,
presented at Flutter Europe.)

As shown in the video, the following
decision tree helps you decide what approach
to use when implementing a Flutter animation:

{% asset ui/animations/animation-decision-tree.png
    alt="The animation decision tree" class="mw-100" %}

If a pre-packaged implicit animation (the easiest animation
to implement) suits your needs, watch
[Animation basics with implicit animations][].
(Also published as a [_companion article_][article2].)

<center><iframe width="560" height="315" src="https://www.youtube.com/embed/IVTjpW3W33s" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></center>

To create a custom implicit animation, watch
[Creating your own custom implicit animations with TweenAnimationBuilder][].
(Also published as a [_companion article_][article3].)

<center><iframe width="560" height="315" src="https://www.youtube.com/embed/6KiPEqzJIKQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></center>

To create an explicit animation (where you control the animation,
rather than letting the framework control it), perhaps
you can use one of the built-in explicit animations classes.
For more information, watch
[Making your first directional animations with
built-in explicit animations][].
(Also published as a [_companion article_][article4].)

<center><iframe width="560" height="315" src="https://www.youtube.com/embed/CunyH6unILQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></center>

If you need to build an explicit animation from scratch, watch
[Creating custom explicit animations with
AnimatedBuilder and AnimatedWidget][].
(Also published as a [_companion article_][article5].)

<center><iframe width="560" height="315" src="https://www.youtube.com/embed/fneC7t4R_B0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></center>

For a deeper understanding of just how animations work in Flutter, watch
[Animation deep dive][].
(Also published as a [_companion article_][article6].)

<center><iframe width="560" height="315" src="https://www.youtube.com/embed/PbcILiN8rbo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></center>

## Codelabs, tutorials, and articles 

The following resources are a good place to start learning
the Flutter animation framework. Each of these documents
shows how to write animation code.

* [Implicit animations codelab][]<br>
  Covers how to use implicit animations
  using step-by-step instructions and interactive examples.

* [Animations tutorial][]<br>
  Explains the fundamental classes in the Flutter animation package
  (controllers, `Animatable`, curves, listeners, builders),
  as it guides you through a progression of tween animations using
  different aspects of the animation APIs. This tutorial shows
  how to create your own custom explicit animations.

* [Zero to One with Flutter, part 1][] and [part 2][]<br>
  Medium articles showing how to create an animated chart using tweening.

* [Write your first Flutter app on the web][]<br>
  Codelab demonstrating how to create a form
  that uses animation to show the user's progress
  as they fill in the fields.

* [Building Beautiful UIs with Flutter][]<br>
  Codelab demonstrating how to build a simple chat app.
  [Step 7 (Animate your app)][] shows how to animate
  the new message&mdash;sliding it from the input area up
  to the message list.

## Animation types

Generally, animations are either tween- or physics-based.
The following sections explain what these terms mean,
and point you to resources where you can learn more.

### Tween animation

Short for _in-betweening_. In a tween animation, the beginning
and ending points are defined, as well as a timeline, and a curve
that defines the timing and speed of the transition.
The framework calculates how to transition from the beginning point
to the end point.

The documents listed above, such as the
[Animations tutorial][], are not specifically
about tweening, but they use tweens in their examples.

### Physics-based animation

In physics-based animation, motion is modeled to resemble real-world
behavior. When you toss a ball, for example, where and when it lands
depends on how fast it was tossed and how far it was from the ground.
Similarly, dropping a ball attached to a spring falls
(and bounces) differently than dropping a ball attached to a string.

* [Animate a widget using a physics simulation][]<br>
  A recipe in the animations section of the Flutter cookbook.

* [Flutter Gallery][]<br>
  Under **Material Components**, the [`Grid`][] example
  demonstrates a fling animation. Select one of the
  images from the grid and zoom in. You can pan the
  image with flinging or dragging gestures.

* Also see the API documentation for
  [`AnimationController.animateWith`][] and
  [`SpringSimulation`][].

## Pre-canned animations

If you are using Material widgets, you might check
out the [animations package][] available on pub.dev.
This package contains pre-built animations for
the following commonly used patterns:
`Container` transforms, shared axis transitions,
fade through transitions, and fade transitions.

## Common animation patterns

Most UX or motion designers find that certain
animation patterns are used repeatedly when designing a UI.
This section lists some of the commonly
used animation patterns, and tells you where to learn more.

### Animated list or grid

This pattern involves animating the addition or removal of
elements from a list or grid.

* [`AnimatedList` example][]<br>
  This demo, from the [Sample app catalog][], shows how to
  animate adding an element to a list, or removing a selected element.
  The internal Dart list is synced as the user modifies the list using
  the plus (+) and minus (-) buttons.

### Shared element transition

In this pattern, the user selects an element&mdash;often an
image&mdash;from the page, and the UI animates the selected element
to a new page with more detail. In Flutter, you can easily implement
shared element transitions between routes (pages)
using the `Hero` widget.

* [Hero animations][]
  How to create two styles of Hero animations:
  * The hero flies from one page to another while changing position
    and size.
  * The hero's boundary changes shape, from a circle to a square,
    as its flies from one page to another.

* [Flutter Gallery][]<br>
  You can build the Gallery app yourself,
  or download it from the Play Store. The [Shrine][]
  demo includes an example of a hero animation.

* Also see the API documentation for the
  [`Hero`][], [`Navigator`][], and [`PageRoute`][] classes.

### Staggered animation

Animations that are broken into smaller motions,
where some of the motion is delayed.
The smaller animations might be sequential,
or might partially or completely overlap.

* [Staggered Animations][]

{% comment %}
  Save so I can remember how to add it back later.
  <img src="/images/ic_new_releases_black_24px.svg" alt="this doc is new!"> NEW<br>
{% endcomment -%}

## Other resources

Learn more about Flutter animations at the following links:

* [Animation samples][] from the [Sample app catalog][].

* [Animation recipes][] from the Flutter cookbook.

* [Animation videos][] from the Flutter YouTube channel.

* [Animations: overview][]<br>
  A look at some of the major classes in the
  animations library, and Flutter's animation architecture.

* [Animation and motion widgets][]<br>
  A catalog of some of the animation widgets
  provided in the Flutter APIs.

* The [animation library][] in the [Flutter API documentation][]<br>
  The animation API for the Flutter framework. This link
  takes you to a technical overview page for the library.


[Animate a widget using a physics simulation]: /docs/cookbook/animation/physics-simulation
[`AnimatedList` example]: /docs/catalog/samples/animated-list
[Animation and motion widgets]: /docs/development/ui/widgets/animation
[Animation basics with implicit animations]: https://www.youtube.com/watch?v=IVTjpW3W33s&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=1
[Animation deep dive]: https://www.youtube.com/watch?v=PbcILiN8rbo&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=5
[animation library]: {{site.api}}/flutter/animation/animation-library.html
[Animation recipes]: /docs/cookbook/animation
[Animation samples]: {{site.github}}/flutter/samples/tree/master/animations#animation-samples
[Animation videos]: https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw/search?query=animation
[Animations in Flutter done right]: https://www.youtube.com/watch?v=wnARLByOtKA&t=3s
[Animations: overview]: /docs/development/ui/animations/overview.html
[animations package]: {{site.pub}}/packages/animations
[Animations tutorial]: /docs/development/ui/animations/tutorial
[`AnimationController.animateWith`]: {{site.api}}/flutter/animation/AnimationController/animateWith.html
[article1]: {{site.medium}}/flutter/how-to-choose-which-flutter-animation-widget-is-right-for-you-79ecfb7e72b5
[article2]: {{site.medium}}/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916
[article3]: {{site.medium}}/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185
[article4]: {{site.medium}}/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7
[article5]: {{site.medium}}/flutter/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8
[article6]: {{site.medium}}/flutter/animation-deep-dive-39d3ffea111f
[Building Beautiful UIs with Flutter]: {{site.codelabs}}/codelabs/flutter
[Creating your own custom implicit animations with TweenAnimationBuilder]: https://www.youtube.com/watch?v=6KiPEqzJIKQ&feature=youtu.be
[Creating custom explicit animations with AnimatedBuilder and AnimatedWidget]:https://www.youtube.com/watch?v=fneC7t4R_B0&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=4
[Flutter API documentation]: {{site.api}}
[Flutter Gallery]: {{site.github}}/flutter/gallery
[`Grid`]: {{site.github}}/flutter/gallery/blob/master/lib/demos/material/grid_list_demo.dart
[`Hero`]: {{site.api}}/flutter/widgets/Hero-class.html
[Hero animations]: /docs/development/ui/animations/hero-animations
[How to choose which Flutter Animation Widget is right for you?]: https://www.youtube.com/watch?v=GXIJJkq_H8g
[Implicit animations codelab]: /docs/codelabs/implicit-animations
[Making your first directional animations with built-in explicit animations]: https://www.youtube.com/watch?v=CunyH6unILQ&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=3
[Material widgets]: /docs/development/ui/widgets/material
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`PageRoute`]: {{site.api}}/flutter/widgets/PageRoute-class.html
[part 2]: {{site.medium}}/dartlang/zero-to-one-with-flutter-part-two-5aa2f06655cb
[Sample app catalog]: /docs/catalog/samples
[Shrine]: {{site.github}}/flutter/gallery/tree/master/lib/studies/shrine
[`SpringSimulation`]: {{site.api}}/flutter/physics/SpringSimulation-class.html
[Staggered Animations]: /docs/development/ui/animations/staggered-animations
[Step 7 (Animate your app)]: {{site.codelabs}}/codelabs/flutter/#6
[Write your first Flutter app on the web]: /docs/get-started/codelab-web
[Zero to One with Flutter, part 1]: {{site.medium}}/dartlang/zero-to-one-with-flutter-43b13fd7b354
