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

* How to [make a Flutter app][].
* How to use [stateful widgets][].

This codelab covers the following material:

* Animation concepts.
* How to use AnimationController to implement explicit animations.
* How to choose between implicit and explicit animations.


## What are explicit animations?

Explicit animations are a set of controls for
telling Flutter how to rapidly rebuild the widget tree
while changing widget properties to create animation effects.
This approach enables you to create effects that you can't achieve
using [implicit animations][].

## Animation Concepts

Learning to create explicit animations can be daunting
if you are new to animation in general.
The following section equips you with animation concepts
that help you better grasp how explicit
animations work in Flutter.
The subsequent sections relate these concepts
to the corresponding tools and methods of explicit animations.
If you are already experienced with animation, you can skip this
section and move on to the [AnimationController][]section.

### What is an animation?
For the moment, forget about Flutter. 
How do animations work in other contexts?
Consider the humble flipbook, or hand-drawn cartoons,
or movie reels. What do all these animation implementations have in common?
They create the illusion of motion by rapidly transitioning
the current frame within a pre-defined sequence of other frames.

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
so the animation looks pretty choppy&mdash;you could
easily mistake the animation for a glitch.
To describe this problem in animation terms,
you would say that *the animation alternates
between only two frames:*<sup><a href="#a1">1</a></sup>

<div class="table-wrapper" markdown="1">
| frame # | position        | movement direction |
|       1 | top margin: 0   |                    |
|       2 | top margin: 100 | down               |
|       1 | top margin: 0   | up                 |
{:.table.table-striped}
</div>

Most importantly, this example demonstrates at a basic
level how frames are used to create animations:
**A frame is a single still image that can be used
within a sequence of other still images
to create the illusion of motion.**
In this case, the first frame consists of a
ball centered on the screen,
and the second frame consists of the same ball
placed further down on the screen using
the top margin property.

[//]: # image: a frame in Flutter

Even this though example doesn't use Flutter's
animation library, it creates an animation
in fundamentally the same way:
by telling Flutter to rebuild its widget tree
so as to rapidly move between frames
over a specified period of time.
This is an important takeaway to keep in mind
while creating explicit animations.
At a fundamental level,
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
* In Flutter, you can think of a single frame as
  a static configuration of a widget tree.
* An animation is a sequence of frames that,
  when rapidly displayed over time,
  creates the illusion of motion.
* In Flutter, an animation is widget property value
  that changes between frames to create the illusion
  of motion.
  You can create an animation by telling Flutter
  to rapidly rebuild a widget tree while gradually
  changing a widget property on each iteration
  of the widget tree.
* The first example uses a timer to trigger
  a change in the top margin of the Bouncing Ball
  once every second.
{{site.alert.end}}

### Frame rate

The previous example represents a naive approach
to animating a bouncing ball:
it alternates the position of the ball
between only two frames,
switching frames once every second.
One way to improve this animation is to use more frames,
which smoothes out the animation
and provides a more convincing illusion of movement.
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
**The frame rate is the rate of frames per second (fps).**
In this case, you are increasing the frame rate
from 2 frames per second to 4 fps.
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
and since the top margin value remains
between 0 and 100 throughout the animation,
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
Well, they don't! Instead, animators set an initial
position and a final position for the object they are animating.
Next, they rely on software to compute all of the
positions for the object between the initial and the
final position that they defined.
**The process of computing animation values between
a starting and ending position is called interpolation.**

As a developer, interpolation vastly simplifies
how you reason about and create your animations.
Instead of thinking of an animation
in terms of hundreds (or thousands) of frames,
you can think of an animation
as a starting value and an ending value,
and allow interpolation to take care of the rest!

The preceding example uses an imperative approach for
calculating the values for each frame
in the animation:
you explicitly provide
values for the frame rate as well as
the value needed to increment
the top margin property for each frame.
Can you think of a way to refactor this example
so that you only need to provide a starting and ending
value for top margin, and an interpolation function
handles providing values for frames between the
starting and ending ones?

Here's a few hints:
* Don't worry about animating the ball
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

Notice that this example only creates half of the animation&mdash;the
ball moves down, but not back up again!
Wouldn't it be nice to have a declarative interface
for controlling how our animation proceeds across the sequence of frames?
This way, we could easily represent when to start the animation,
pause it, play forward, play backward, stop it, or repeat it indefinitely.

{{site.alert.bonus}}
In the prior example, the rate of change for the
bouncing ball's top margin value is linear
(the margin changes by the same amount between each frame).
How would you change this example to make it possible to interpolate
values between 0 and 100 at a changing rate?
{{site.alert.end}}

{{site.alert.bonus}}
The prior example only animates a single downward motion
of the bouncing ball.
Can you think of a way to:
1. Continue the animation so that the ball bounces back up again?
2. Repeat the animation indefinitely?
{{site.alert.end}}

## AnimationController

### Introduction: What is an AnimationController?
The `AnimationController` class represents an **interpolated
range of values** that define all possible frames
for a particular animation.
`AnimationController` has a `value` property,
which represents the current value of the animation within
the range of other frame values.
`AnimationController` is **playable**&mdash;once triggered,
`AnimationController` changes its `value` property, over time,
between the other values in the range.
This change in `value` over time within the range
of values is what creates the animation effect.
`AnimationController` is also highly **configurable**, allowing you
to define any of the following:
* The range of values to use for an animation.
* The amount of time it takes to cycle the `value`
  property through the range of possible values.
* Whether `value` should move forward or backward through the range.
* The conditions for starting, stopping, or repeating the animation.
* Changes in the rate that `value` switches to other values in the range.


To generate this range of values,
instantiate `AnimationController` and
pass it a few basic arguments like the `duration` of your animation,
as well as the starting and ending values,
`lowerBound` and `upperBound`, for your animation.
Once instantiated, `AnimationController` creates an interpolated
range of values between the provided starting value and an ending value
over a given duration, and offers control over the following functionality:

[//]: Image of values in AnimationController

* `AnimationController` makes it easy to access
the current value of the animation&mdash;just use the `value` property.

* To "play" an animation,
you can use one one of several methods that
initiate the sequence of changes to `value`.
For example, to "play" an animation
from its starting value to its ending value,
simply call `forward()`.

* Use `.addListener()` to register a callback invoked whenever
  `AnimationController` changes its `value` property.
  Most commonly, you register `setState()` with `AnimationController`.
  This tells Flutter to rebuild the widget tree whenever `AnimationController`'s
  value changes.

* `AnimationController` needs a `TickerProvider` to synchronize the animation's
behavior to the device's display. 
  
The following sections demonstrate how to use `AnimationController`
by providing step-by-step instructions for
[creating your first explicit animation with AnimationController][Create your first explicit animation with AnimationController]
and by covering the
[underlying concepts of `AnimationController`][AnimationController Concepts].

### Create your first explicit animation with AnimationController

The following example **begins with no animation code**&mdash;it consists of a [Material App][]
home screen containing a static green ball shape. 

[//]: Insert DartPad Here


The following steps guide you through the changes to this example that are
necessary to implement the same bouncing ball animation
created in the [Animation Concepts][] section.
The difference is that this example creates the bouncing ball
animation by creating an explicit animation, whereas the
[Animation Concepts][] section uses a naive approach
to creating animations in Flutter.


[//]: bouncing ball example


Use the following instructions to create an explicit animation of a bouncing ball:

#### 1. Add a TickerProvider
<?code-excerpt "explicit{1,2}/lib/main.dart"?>
```diff
--- explicit1/lib/main.dart
+++ explicit2/lib/main.dart
@@ -6,7 +6,7 @@
   _BouncingBallDemoState createState() => _BouncingBallDemoState();
 }

-class _BouncingBallDemoState extends State<BouncingBallDemo> {
+class _BouncingBallDemoState extends State<BouncingBallDemo> with SingleTickerProviderStateMixin {

   void initState() {
     super.initState();
```
An `AnimationController` needs a `TickerProvider`,
so the first step for creating an explicit animation
is to add a `TickerProvider` to the widget that you are animating. 
If you are creating an `AnimationController` from a `State`
you can use the `SingleTickerProviderStateMixin` (as in this example)
to make a `TickerProvider` available to your `AnimationController`.

In this example, you only need to instantiate `AnimationController`
once to create the desired animation effect.
For other animations, if you need multiple `AnimationController` objects
over the lifetime of the `State`,
use a full `TickerProviderStateMixin` instead.
The next step also covers how to configure `TickerProvider`
with the `vsync` argument
passed to `AnimationController`'s constructor.

#### 2. Instantiate `AnimationController`
<?code-excerpt "explicit{2,3}/lib/main.dart"?>
```diff
--- explicit2/lib/main.dart
+++ explicit3/lib/main.dart
@@ -7,9 +7,17 @@
 }

 class _BouncingBallDemoState extends State<BouncingBallDemo> with SingleTickerProviderStateMixin {
+  AnimationController controller;

   void initState() {
     super.initState();
+    controller = AnimationController(
+      vsync: this,
+      duration: Duration(seconds: 1),
+      lowerBound: 0,
+      upperBound: 100,
+    );
+
   }

   @override
@@ -26,6 +34,10 @@
         )
       );
   }
+  void dispose() {
+    controller.dispose();
+    super.dispose();
+  }
 }

 class MyApp extends StatelessWidget {
```
When used with a `StatefulWidget`,
it is common to instantiate `AnimationController`
in the `State.initState` lifecycle method and then
dispose in the `State.dispose` method.

An `AnimationController` should be disposed when it is no longer needed.
This reduces the likelihood of leaks.


#### 3. Add listener(s)
<?code-excerpt "explicit{3,4}/lib/main.dart"?>
```diff
--- explicit3/lib/main.dart
+++ explicit4/lib/main.dart
@@ -18,6 +18,10 @@
       upperBound: 100,
     );

+    controller.addListener(() {
+      setState((){});
+    });
+
   }

   @override
```

#### 4. Trigger the animation
<?code-excerpt "explicit{4,5}/lib/main.dart"?>
```diff
--- explicit4/lib/main.dart
+++ explicit5/lib/main.dart
@@ -22,12 +22,13 @@
       setState((){});
     });

+    controller.repeat(reverse: true);
   }

   @override
   Widget build(BuildContext context) {
     return Container(
-      margin: EdgeInsets.only(top: 0),
+      margin: EdgeInsets.only(top: controller.value),
         child: Container(
           decoration: BoxDecoration(
             shape: BoxShape.circle,
```

<?code-excerpt "explicit{1,5}/lib/main.dart"?>
```diff
--- explicit1/lib/main.dart
+++ explicit5/lib/main.dart
@@ -6,16 +6,29 @@
   _BouncingBallDemoState createState() => _BouncingBallDemoState();
 }

-class _BouncingBallDemoState extends State<BouncingBallDemo> {
+class _BouncingBallDemoState extends State<BouncingBallDemo> with SingleTickerProviderStateMixin {
+  AnimationController controller;

   void initState() {
     super.initState();
+    controller = AnimationController(
+      vsync: this,
+      duration: Duration(seconds: 1),
+      lowerBound: 0,
+      upperBound: 100,
+    );
+
+    controller.addListener(() {
+      setState((){});
+    });
+
+    controller.repeat(reverse: true);
   }

   @override
   Widget build(BuildContext context) {
     return Container(
-      margin: EdgeInsets.only(top: 0),
+      margin: EdgeInsets.only(top: controller.value),
         child: Container(
           decoration: BoxDecoration(
             shape: BoxShape.circle,
@@ -26,6 +39,10 @@
         )
       );
   }
+  void dispose() {
+    controller.dispose();
+    super.dispose();
+  }
 }

 class MyApp extends StatelessWidget {
```

The following example provides an easy way to see how
`AnimationController` interpolates values for you:

{% include explicit-animations/bouncing-ball-starter-code-4.md %}


{{site.alert.secondary}}
**Quick review**

Creating animations
* Generates interpolated values (Tweens, or from: param)
* Provides controls for triggering animations (forward, reverse,..)

Configuration
* Sets up vsync
* Listens for `Ticker` events
{{site.alert.end}}


{% include explicit-animations/bouncing-ball-starter-code-5.md %}

### AnimationController Concepts
AnimationController is the central class that you use
to create explicit animations.
AnimationController's capabilities fall into four categories:
Defining animations, generating animation values,
registering listeners, and play/sequence controls.


The preceding [Animation Concepts][] section uses an `interpolate()`
method to generate frame values between a starting value and an
ending value of the `margin` property.
The example uses each interpolated value in a separate frame
to animate a circle up and down,
making it appear like a bouncing ball.
The first thing to know about `AnimationController`
is that, within this process, `AnimationController`
handles the interpolation part for you.
The following example renders a blank screen,
but uses `AnimationController` to print values from 0 to 100
at 60fps over 1 second.
Click **Run**, then check the values that are
being printed by clicking the **Console** area at the bottom
of the editor:

{% include explicit-animations/animation-controller-starter-code-1.md %}

**AnimationController interpolates the `value` property for you**.

  `AnimationController`
  abstracts away the the work of interpolation,
  allowing you to reason about and create an animation
  in terms of its duration, and the starting and ending
  values of the property that you are animating:

This example demonstrates the following
important concepts for using `AnimationController`:

**AnimationController doesn't interact with Flutter UI widgets on its own.**

#### Why TickerProvider?

#### Define a range of frame values

In this example,
the AnimationController constructor takes the optional parameters `lowerBound`,
and `upperBound`, and `duration`:

Instantiate AnimationController:

  ```dart
  controller = AnimationController(
    lowerBound: 0,
    upperBound: 100,
    duration: const Duration(seconds: 1),
    vsync: this, // Don't worry about vsync for now.
  );
  ```
Notice that when you instantiate AnimationController,
you define an animation in terms of its starting value (`lowerBound`),
its ending value (`upperBound`), and the amount of time it takes to change
from one to the other (`duration`).

The default values for `lowerBound` and `upperBound`
are 0 and 1, respectively; `duration` doesn't have a default value.
These aren’t the only parameters
that the AnimationController constructor takes&mdash;`vsync` and other parameters
are covered in subsequent sections.

#### Access animation values with controller.value
AnimationController provides a `value` property.
You can access this property directly&mdash;there is no getter method for `value`:
   ```dart
   print(controller.value);
   ```
By default, the `value` property begins at the `lowerBound` value.
You can set the starting value of `controller.value` to a specific
value between `lowerBound` and `upperBound` using the `from` parameter.
Once triggered, the AnimationController will automatically update the `value`
property to a new value.

#### Listen to animations
**addListener()**

  `AnimationController` allows you to listen for changes
  in the value you are animating:
  ```dart
    controller.addListener(() {
      print("current value: ${controller.value}");
    });
  ```

#### Trigger, sequence, and terminate animations:
**forward(), repeat(), reverse() and stop()**
  `AnimationController` provides the
  `forward()`, `repeat()`, `reverse()`, and `stop()` methods
  for triggering, repeating, playing in reverse, and halting an animation:
  ```dart
  controller.forward();
  ```

* **Frame syncing**

  With a little bit of boilerplate,
  `AnimationController` syncs your animation frames
  to the target device at 60 fps:
  ```dart

  class _BouncingBallDemoState extends State<BouncingBallDemo> with TickerProviderStateMixin {
  AnimationController controller;

  void initState() {
    super.initState();
    controller = AnimationController( vsync: this, duration: Duration(seconds: 3));

    ...

  }
  ```

## Tweens
## AnimatedBuilder
## AnimatedWidget

---
**Footnotes:**

<sup><a name="a1">1</a></sup>
  In this example, you are creating an animation effect
  that *only looks* like it is running at two frames per second.
  In reality, Flutter is running this example at ~60 frames per second.

<sup><a name="a2">2</a></sup>
  Flutter aims to provide 60 fps performance,
  or 120 fps performance on devices capable of 120Hz updates.
  For 60fps, frames need to render approximately every 16ms.
  See [performance profiling][] page for more information.


[Animation Concepts]: /#Animation-Concepts
[AnimationController]: /#AnimationController
[AnimationController Concepts]: /#animationcontroller-concepts
[Create your first explicit animation with AnimationController]: /#create-your-first-explicit-animation-with-animationcontroller
[Material App]: {{site.api}}/flutter/material/MaterialApp-class.html
[performance profiling]: /docs/perf/rendering/ui-performance
[implicit animations]: /docs/development/ui/animations/implicit-animations
[make a Flutter app]: https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1
[stateful widgets]: https://flutter.dev/docs/development/ui/interactive#stateful-and-stateless-widgets
[`SingleTickerProviderStateMixin`]: https://api.flutter.dev/flutter/widgets/SingleTickerProviderStateMixin-mixin.html




---
TODO:
1. Intro section: add images to this section
2. Refactor all DartPad samples to use non-working defaults, & offer solution
2. Update vanilla bouncing ball final example to use *both* upward and downward motion
3. Explain why setState listener boilerplate is required
4. AnimatedWidget and AnimatedBuilder?
5. How to choose between AnimatedBuilder and AnimatedWidget.
6. Answer question: when to use a Tween,
  if you can just use upper and lower bound args for
  AnimationController?
  - when we need something other than a double?




