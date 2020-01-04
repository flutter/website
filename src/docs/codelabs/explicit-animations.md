---
title: "Explicit animations codelab"
description: "A codelab that uses interactive examples and exercises to teach  how to use explicit animations in Flutter."
toc: true
diff2html: true
js:
  - defer: true
    url: https://dartpad.dev/experimental/inject_embed.dart.js
  - defer: true
    url: /assets/codelabs/js/animations_examples.js
---

Welcome to the explicit animations codelab,
where you learn how to create animations
with more complex and custom features
than can be achieved using implicit animations.

To get the most out of this codelab,
you should have basic knowledge of the following:

* How to [make a Flutter app](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1/).
* How to use [stateful widgets](https://flutter.dev/docs/development/ui/interactive#stateful-and-stateless-widgets).

This codelab covers the following material:

* Animations concepts.
* How to use AnimationController, Ticker, AnimatedBuilder,
  and AnimatedWidget to implement explicit animations.
* How to choose between implicit and explicit animations.
* How to choose between AnimatedBuilder and AnimatedWidget.


## What are explicit animations?

Explicit animations make use of
the basic buildings blocks of Flutter's animation library,
enabling you to create effects that you can't achieve using [implicit animations](https://flutter.dev/docs/development/ui/animations/implicit-animations).


## Animations Concepts

Learning to create explicit animations can be conceptually daunting
if you are new to animation in general.
The following sections help you understand explicit animations
by introducing you to foundational animation concepts,
and relating those concepts to the corresponding tools
of explicit animations.

### Frames

Suppose you want to create your own Flutter animation
without using the animations library.
Start with the simplest case possible:
Your goal is to animate a ball
so that it repeatedly bounces up and down.
The following example demonstrates a first attempt
using a naive approach.
Can you spot the lines of code that create the effect?

<?code-excerpt path-base="animation/explicit"?>

{% include explicit-animations/bouncing-ball-starter-code-1.md %}

The preceding example uses the container's `margin` property
to alternate the position of the ball on the screen,
and a periodic timer to control
how frequently the ball changes its position (once every second).
As a viewer, this approach leaves a lot to be desired.
The ball only has two positions,
so the animation looks pretty choppy;
You might even mistake the animation for a glitch.
To describe the problem with this exapmle in animations terms,
you would say that the animation has only two frames:

| frame 1 | margin-top: 0   |
| frame 2 | margin-top: 100 |

**A frame is a single still image that can be used
within a sequence of other still images
to create an illusion of motion.**

Even though the preceding example doesn't use
Flutter's animation framework,
it shares something fundamental in common with it:
it creates an illusion of motion
by telling Flutter to rebuild its widget tree
so as to move between "frames**
within a specified over a period of time.
This is an important takeaway to keep in mind
while creating explicit animations:
**explicit animations provide you with controls
for telling Flutter how to quickly rebuild a widget tree
to create the illusion of motion.** You will learn more
about these controls later in this codelab.

Given what you've learned so far,
can you think of a way to improve the bouncing ball effect?
Try to come up with an answer before diving into the next section.

### Interpolation

{% include explicit-animations/bouncing-ball-starter-code-2.md %}


## AnimationController 
- Creating interpolated values.
- Using animation controls (start, stop, repeat).


## Tween

