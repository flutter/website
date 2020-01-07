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

<?code-excerpt path-base="animation/explicit"?>

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
* How to use AnimationController to implement explicit animations.
* How to choose between implicit and explicit animations.


## What are explicit animations?
Explicit animations provide a set of controls for telling
Flutter how to rapidly rebuild a widget tree to create the
illusion of motion. Explicit animations make use of
the basic buildings blocks of Flutter's animation library to
enable you to create effects that you can't achieve using
[implicit animations](https://flutter.dev/docs/development/ui/animations/implicit-animations).


## Animations Concepts

Learning to create explicit animations can be conceptually daunting
if you are new to animation in general.
The following sections help you understand explicit animations
by introducing you to foundational animation concepts,
and ultimately relate those concepts to the corresponding tools
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

### Example: Bouncing Ball (Starter Code)

{% include explicit-animations/bouncing-ball-starter-code-1.md %}

The preceding example uses the container's `margin` property
to alternate the position of the ball on the screen,
and a periodic timer to control
how frequently the ball changes its position (once every second).
As a viewer, this approach leaves a lot to be desired.
The ball only has two positions,
so the animation looks pretty choppy;
You might even mistake the animation for a glitch.
To describe the problem with this example in animations terms,
you would say that the animation
*only has two frames:*<sup><a href="#a1">1</a></sup>

<div class="table-wrapper" markdown="1">
| frame # | position        | movement direction        |
|       1 | top margin: 0   |                           |
|       2 | top margin: 100 | ball appears to move down |
|       1 | top margin: 0   | ball appears to move up   |
{:.table.table-striped}
</div>

**A frame is a single still image that can be used
within a sequence of other still images
to create the illusion of motion.**
In this case, the first frame consists of a
ball centered on the screen,
and the second frame consists of the same ball
placed further down on the screen using
the margin property.

Even though the preceding example doesn't use
Flutter's animation framework,
it shares something fundamental in common with it:
it creates an illusion of motion
by telling Flutter to rebuild its widget tree
so as to move between two frames
within a specified over a period of time.
This is an important takeaway to keep in mind
while creating explicit animations:
**explicit animations provide you with controls
for telling Flutter how to quickly rebuild a widget tree
to create the illusion of motion.** You will learn more
about these controls later in this codelab.

Given what you've learned so far,
can you think of a way to improve the bouncing ball effect
in the preceding example?
Try to come up with an answer before diving into the next section.

{{site.alert.secondary}}
**Quick review:**
* A frame is a single still image that can be used
  within a sequence of other still images
  to create the illusion of motion. 
* An animation is a rapid sequence of frames that
  create the illusion of motion.
* In Flutter, you can think of a single frame as
  a static configuration of a widget tree.
  You can create an animation by telling Flutter
  to rapidly rebuild a widget tree while gradually
  changing a widget property on each iteration.
{{site.alert.end}}

### Frame rate

The previous example represents a naive approach
to animating a bouncing ball:
it alternates the position of the ball
between only two frames,
switching frames once every second.
One way to improve this animation is to use more frames,
which will smoothen the animation
and provide a more convincing illusion of movement.
Consider what changes you need to make to the example
so that, instead of having just two positions,
the ball has five:

<div class="table-wrapper" markdown="1">
| frame # | position        | movement direction |
|       1 | top margin: 0   |                    |
|       2 | top margin: 25  | down               |
|       3 | top margin: 50  | down               |
|       4 | top margin: 75  | down               |
|       5 | top margin: 100 | down               |
|       4 | top margin: 75  | up                 |
|       3 | top margin: 50  | up                 |
|       2 | top margin: 25  | up                 |
|       1 | top margin: 0   | up                 |
{:.table.table-striped}
</div>

Notice that, now that you are using more frames,
in order to keep the ball bouncing at the same rate
(one bounce per second)
you  need to increase the frame rate. 
**The frame rate is the rate of frames per second.**
In this case, you are increasing the frame rate
from 2 frames per second ("fps") to 4 fps.
Even though you are using five total frames,
the first frame gets re-used for the downward and upward
motion of the ball,
so you only need to count it once
for the purpose of determining the frame rate.

{{site.alert.secondary}}
frame rate =  # of frames / second 

(In this case, 4 fps)
{{site.alert.end}}

Now that you have calculated the updated frame rate
for this animation,
you can also calculate the value that
the margin should change in each frame.
As the preceding chart makes clear, 
now that there are 5 frames instead of 2,
and since the top margin value will remain
somewhere between 0 and 100,
each frame will either increase or decrease
the ball's top margin value by 25.

{{site.alert.secondary}}
change in margin value between each frame = total change / # of frames

(In this case, the top margin changes by 100
over 4 frames, so each frame
changes the top margin value by 25.)
{{site.alert.end}}

That's it! With the updated frame rate
and the top margin values needed for each frame,
you now have enough information
to update the preceding example
by doubling both the number of frames
and the frame rate that the animation uses.
Before diving into the following example, 
think about how you might refactor the preceding example
using these updated parameters.
You can use the DartPad editor in the preceding example
to try out your solution.
When you're ready, run the next example to
view the updated animation:

{{site.alert.secondary}}
**Quick Review:**
* Frame rate is measured as the number of frames per second (fps).
* Flutter uses 60 fps.<sup><a href="#a2">2</a></sup>
{{site.alert.end}}

### Example: Bouncing Ball (Starter Code 2)

{% include explicit-animations/bouncing-ball-starter-code-2.md %}

### Interpolation
Have you ever wondered how computer graphics animators
draw each and every frame of your favorite CGI movies?
Well, they don't! To make their lives easier,
animators use key frames:
to animate an object, they set its beginning position,
and its ending position,
and rely on software to generate the images in between.
**The process of computing animation values between
a starting and ending position is called interpolation.**

As a developer, interpolation vastly simplifies how you
create and reason about your animations.
Instead of thinking of an animation
in terms of hundreds (or thousands) of frames,
you can reason about an animation
as a starting value and an ending value,
and let interpolation to take care of the rest!

The preceding example uses an imperative approach to
calculating the values to use for each frame
that makes up the animation: you provide values for
the frame rate as well as the value needed to increment
the top margin property for each frame.
Can you think of a way to refactor this example
to use interpolation so that
you only need to provide the starting and ending
values for top margin?

Here's a few hints:
* To start out, don't worry about animating the ball
  up and down. Just focus on the first downward motion
  of the ball (from a top margin of 0 to top margin of 100).
* Remember from the preceding frame rate section that
  Flutter uses a fixed frame rate (60 fps). You can
  do the same.
* For any starting or ending position of the ball,
  you can express the amount to increment top margin
  between each frame as the difference between the margin's
  starting and ending values divided by the total number of frames.

### Example: Bouncing Ball (Starter Code 3)
{% include explicit-animations/bouncing-ball-starter-code-3.md %}

At 60 fps, this final version of the bouncing ball animation
looks smoother than in all prior examples. 

Wouldn't it be nice to have a declarative interface
for controlling how our animation proceeds across the sequence of frames? 
This way, we could easily represent when to start the animation,
pause it, play forward, play backward, stop it, or repeat it indefinitely?


## AnimationController 

This section builds upon the prior sections by providing
an introduction to using `AnimationController`
with explanations about how its capabilities encompass
the fundamental animations concepts
covered in the previous sections.

### What is an AnimationController?

`AnimationController` is the central class 
for building explicit animations. `AnimationController`'s
capabilities fall into three broad categories:
* **Define an animation with start and end values**: `AnimationController`
  abstracts away the the work of interpolation,
  allowing you to reason about and create an animation
  in terms of its beginning and an ending value.
* **Trigger & sequence controls**:
  `AnimationController` provides the
  `forward()`, `repeat()`, `reverse()`, and `stop()` methods
  for triggering, halting, and controlling the sequence of an animation.
* **Frame syncing**: With just a little bit of boilerplate,
  `AnimationController` manages syncing your animation frames
  to the target device at 60 fps.
 
The following sections cover each of these capabilities in greater detail.

### Generating interpolated values

The following example provides an easy way to see how
`AnimationController` interpolates values for you:


{% include explicit-animations/bouncing-ball-starter-code-4.md %}





### Controlling animation frames


{{site.alert.secondary}}
Creating animations
* Generates interpolated values (Tweens, or from: param)
* Provides controls for triggering animations (forward, reverse,..)

Configuration
* Sets up vsync
* Listens for `Ticker` events
{{site.alert.end}}

Take a look at how using the animation controller simplifies
the bouncing ball example you used in the Animations Concepts section:

{% include explicit-animations/bouncing-ball-starter-code-5.md %}



- Creating interpolated values.
- Using animation controls (start, stop, repeat).


## Tween














---
**Footnotes:**

<sup><a name="a1">1</a></sup> 
  In this example, you are creating an animation effect
  that *only looks* like it is running at two frames per second.
  In reality, Flutter is running this example at ~60 frames per second. 

<sup><a name="a2">2</a></sup> Flutter aims to provide
  60 frames per second (fps) performance,
  or 120 fps performance on devices capable of 120Hz updates.
  For 60fps, frames need to render approximately every 16ms.
  See [performance profiling] page for more information.


[performance profiling]: /docs/perf/rendering/ui-performance





---
Todo:
1. Create diffs w/ explanations of each diff
2. AnimatedWidget and AnimatedBuilder?
3. How to choose between AnimatedBuilder and AnimatedWidget.
