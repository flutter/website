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
*only has two frames:*

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

```
framerate =  # of frames / second 

(In this case, 4 fps)
```

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

```
change in margin value between each frame = total change / # of frames

(In this case, the top margin changes by 100
over 4 frames, so each frame
changes the top margin value by 25.)

```

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

### Example: Bouncing Ball (Starter Code 2)

{% include explicit-animations/bouncing-ball-starter-code-2.md %}

### Interpolation

The preceding example improved upon the bouncing ball animation
by increasing the framerate of the animation,
but there is one final improvement you can make to this example
to help you understand how explicit animations work in Flutter!

1. Create a declarative API using start and end values
2. Increase the frame rate from 4fps to 60fps


### Example: Bouncing Ball (Starter Code 3)
{% include explicit-animations/bouncing-ball-starter-code-3.md %}

As you can see, doubling the framerate greatly enhanced
the effect of the animation.  

## AnimationController 
- Creating interpolated values.
- Using animation controls (start, stop, repeat).


## Tween

