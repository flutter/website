---
layout: page
title: Animations in Flutter
permalink: /animations/
---

* TOC Placeholder
{:toc}

Well designed animations makes a UI feel more intuitive,
contribute to the slick look and feel of a polished app,
and improve the user experience.
Flutter supports several kinds of animations and,
if you can't find what you want, you can always build your own.

## Animation types

Animations fall into several categories. The following list describes
several types of animation, and directs you to where you can learn more.

### Animated list or grid
An animated list (or grid) animates adding, or deleting,
elements from a list (or grid).

* [AnimatedList example](/catalog/samples/animated-list/)<br>
This demo, from the [Sample App Catalog](/catalog/samples), shows how to
animate adding an element to a list, or removing a selected element.
The internal Dart list is synced as the user modifies the list using
the plus (+) and minus (-) buttons.

### Hero animation

Also called a _shared element transition_. A common pattern involves
a grouping of elements, often images. The user clicks one of the images
and it flies, while growing, and lands (for example) on a new page
featuring the larger image and more detail.
Hero animations sometimes occur within the same page.

* [Flutter Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery)<br>
You can build the Gallery app yourself, or download it from the Play Store.
The [Shrine](https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/shrine_demo.dart)
demo includes an example of a hero animation.
{% comment %}
According to Hans, the demo in the Flutter Gallery that is called
"Animation" isn't really an animation demo. It's more of a
"scroll driven layout demo".
{% endcomment %}

### Physics-based animation

In physics-based animation, motion is modeled to resemble real-world
behavior. When you toss a ball, for example, where and when
it lands depends on how fast it was tossed, how heavy it is, and how
far off the ground. Similarly, dropping a ball attached to a spring falls
(and bounces) differently than dropping a ball attached to a string.

* [Flutter Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery)<br>
Under **Material Components**, the
[Grid](https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/grid_list_demo.dart) example
demonstrates a fling animation. Select one of the images from
the grid and zoom in. You can pan the image with flinging or dragging
gestures.

### Tween animation

Short for _in-betweening_. In a tween animation, the beginning
and ending points are defined, as well as a timeline, and a curve
that defines the timing and speed of the transition.
The framework calculates how to transition from the beginning point
to the end point.

* [Tween Animations in Flutter](/animations/tween-animations.html)<br>
This doc guides you through a progression of tween animations using
different aspects of the Flutter animation APIs.

* [Zero to One with Flutter, part 1](https://medium.com/dartlang/zero-to-one-with-flutter-43b13fd7b354) and [part 2](https://medium.com/dartlang/zero-to-one-with-flutter-part-two-5aa2f06655cb)<br>
Medium articles showing how to create an animated chart using tweening.

* [Building Beautiful UIs with
Flutter](https://codelabs.developers.google.com/codelabs/flutter/index.html#0)<br>
Codelab demonstrating how to build a simple chat app. [Step 7 (Animate
your app)](https://codelabs.developers.google.com/codelabs/flutter/index.html#6)
shows how to animate the new message&mdash;sliding it from the input area up
to the message list.

{% comment %}
## Staggered animation
??
{% endcomment %}

## Other resources

Learn more about Flutter animations at the following links:

* [Animations: Technical Overview](/animations/overview.html)<br>
A look at some of the major classes in the animations library,
and Flutter's animation architecture.

* The [animation
library](https://docs.flutter.io/flutter/animation/animation-library.html)
in the [Flutter API docs](https://docs.flutter.io/)<br>
The animation API for the Flutter framework.
If you are writing a [hero
animation](https://docs.flutter.io/flutter/widgets/Hero-class.html),
you may also want to reference the
[Navigator](https://docs.flutter.io/flutter/widgets/Navigator-class.html) and
[PageRoute](https://docs.flutter.io/flutter/widgets/PageRoute-class.html)
widgets.

<hr>

We are currently working on creating more animation docs and examples.
If there is something specific you'd like to see, please
[file an issue](https://github.com/flutter/flutter/issues).

