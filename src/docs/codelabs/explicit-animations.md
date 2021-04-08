---
title: "Explicit animations"
description: "A codelab that uses interactive examples and exercises to teach  how to use explicit animations in Flutter."
toc: true
diff2html: true
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
  - defer: true
    url: /assets/codelabs/js/animations_examples.js
---

<?code-excerpt path-base="../null_safety_examples/animation/explicit"?>

Welcome to the explicit animations codelab,
where you learn how to create animations
with more complex and custom features
than can be achieved using implicit animations.

{{site.alert.note}}
  This codelab is not yet complete.
{{site.alert.end}}

To get the most out of this codelab,
you should have basic knowledge of the following:

* How to [make a Flutter app][].
* How to use [stateful widgets][].

This codelab covers the following material:

* Animation concepts
* Using `AnimationController` to implement explicit animations
* Choosing between implicit and explicit animations


## What are explicit animations?

Explicit animations are a set of controls for
telling Flutter how to rapidly rebuild the widget tree
while changing widget properties to create animation effects.
This approach enables you to create effects that you can't achieve
using [implicit animations][].

## Animation concepts

Learning to create explicit animations can be daunting
if you are new to animation in general.
The following section equips you with animation concepts
that help you better grasp how explicit
animations work in Flutter.
The subsequent sections relate these concepts
to the corresponding tools and methods of explicit animations.
If you are already experienced with animation, you can skip this
section and move on to the [`AnimationController` section][].

### What is animation?

Think about how animations work
in a flip-book, or cartoons on TV, or a movie reel.
What do these animation technologies have in common?
They create the illusion of motion by rapidly transitioning
a single frame that you are viewing to other frames
within a pre-defined sequence.

Suppose you want to create your own Flutter animation
without using the animations library.
Start with the simplest case possible:
Your goal is to animate a ball
so that it repeatedly bounces up and down.
The following example demonstrates a first attempt
using a naive approach.
Can you spot the lines of code that create the effect?

### Example: bouncing ball (starter code 1)

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
between only two frames:*

{{site.alert.note}}
  In this example, you are creating an animation effect
  that *only looks* like it is running at two frames per second.
  In reality, Flutter is running this example at ~60 frames per second.
{{site.alert.end}}

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

PENDING: # image: a frame in Flutter

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
to create the illusion of motion.** You'll learn more
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
  * In Flutter, an animation changes a widget property value
    between frames to create the illusion of motion.
    You can create an animation by telling Flutter
    to rapidly rebuild a widget tree while gradually
    changing a widget property on each iteration
    of the widget tree.
  * The first example uses a timer to trigger
    a change in the top margin of the bouncing ball
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

Now that you are using more frames,
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

Now that you have increased the frame rate
for this animation,
you can also calculate the new value that
the margin should change in each frame.
As the preceding chart makes clear,
now that there are 5 frames instead of 2,
and since the top margin value remains
between 0 and 100 throughout the animation,
each frame either increases or decreases
the ball's top margin value by 25.

{{site.alert.secondary}}
  Change in margin value between each
  frame = total change in margin / # of frames
{{site.alert.end}}

In this case, the top margin changes by 100
over 4 frames, so each frame
changes the top margin value by 25.
(Even though there are 5 total frames,
in this example you are reusing one frame for both
the downward and upward motion of the ball, so you
only need to count 4 frames for the margin change.)

That's it! With the updated frame rate
and the top margin values needed for each frame,
you now have enough information
to update the preceding example
by doubling the frame rate that the animation uses.
Before diving into the following example,
think about how you might refactor the preceding example
using these updated parameters.
You can use the DartPad editor in the preceding example
to try out your solution.
When you're ready, run the next example to
view the updated animation:

### Example: bouncing ball (starter code 2)

{% include explicit-animations/bouncing-ball-starter-code-2.md %}

{{site.alert.secondary}}
  **Quick Review:**
  * Frame rate is measured as the number of frames per second (fps).
  * Flutter aims to provide 60 fps performance,
    or 120 fps performance on devices capable of 120Hz updates.
    For 60fps, frames need to render approximately every 16ms.
    See [performance profiling][] page for more information.
{{site.alert.end}}

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
value for top margin, and leave the rest to an
interpolation function the generates the values
for the frames in between?

Here's a few hints:

* Don't worry about animating the ball
  up and down. Just focus on the first downward motion
  of the ball (from a top margin of 0 to top margin of 100).
* Try using 60 fps for the frame rate.
* For any starting or ending position of the ball,
  you can express the amount to increment top margin
  between each frame as the difference between the margin's
  starting and ending values divided by the total number of frames.

The following example contains one way to implement these updates
to the bouncing ball example. Run the example to the see the difference
that these updates make to your animation:

### Example: bouncing ball (starter code 3)

{% include explicit-animations/bouncing-ball-starter-code-3.md %}

At 60 fps, this updated version of the bouncing ball animation
looks smoother than in all prior examples!

This example only creates half of the animation&mdash;the
ball moves down, but not back up again.
Wouldn't it be nice to have a declarative interface
for controlling the direction that the animation proceeds
across the sequence of frames, and the conditions for
starting and stopping it? This way, you could easily
represent when to start the animation, pause it,
play forward, play backward, end it, or repeat it indefinitely.
In the next section, you'll learn how Flutter's animation library
provides an interface for doing all of these things.

{{site.alert.secondary}}
  **Quick review:**
  * Interpolation is the process of computing all animation values
    between a starting and ending value.
  * Instead of thinking about an animation in terms of hundreds (or thousands)
    of frames, interpolation allows you to reason about and define an animation
    in terms of its starting and ending value.
{{site.alert.end}}

{{site.alert.bonus}}
  1. In the prior example, the rate of change for the
     bouncing ball's top margin value is linear
     (the margin changes by the same amount between each frame).
     How would you change this example to make it possible to
     interpolate values between 0 and 100 at a changing rate?

  2. The prior example only animates a single downward motion
     of the bouncing ball. Can you think of a way to:

     * Continue the animation so that the ball bounces back up again?
     * Repeat the animation indefinitely?
{{site.alert.end}}

## AnimationController

The [`AnimationController`][] is a special `Animation`
object that generates a new value whenever the hardware
is ready for a new frame. All explicit
animations require an `AnimationController`.

### What is an AnimationController?

The `AnimationController` class represents an **interpolated
range of values** that define all possible frames
for a particular animation.
`AnimationController` has a `value` property
that represents the current value of the animation within
the range of other frame values.
`AnimationController` is **playable**&mdash;it provides
controls for triggering changes to its `value` property
(between its `lowerBound` and `upperBound`) over
a specified period of time (the `duration` parameter).
Once triggered, `AnimationController`
changes its `value` property over time
to the other values in the range
between `upperBound` and `lowerBound`.
This change in `value` over time
is what creates the animation effect.
`AnimationController` is also highly **configurable**, allowing you
to change the following:

* Whether the animation should progress forward or backward
  through the range of values once triggered.
* The amount(s) that an animation's `value` changes between each frame.

The following sections demonstrate how to use
`AnimationController` by providing step-by-step instructions for
[creating your first explicit animation with
`AnimationController`][Create your first explicit animation
with AnimationController][] and by covering the
[underlying concepts of `AnimationController`][`AnimationController` concepts].

### Create your first explicit animation with AnimationController

The following example **begins with no animation code**&mdash;it
consists of a [Material app][] home screen containing a green ball shape.

PENDING: Insert DartPad here

This section provides guided steps for building
the same bouncing ball animation
created in the [`Animation` concepts][] section&mdash;
the difference is that this example uses an explicit animation,
whereas the animation concepts section
uses a naive approach in order to introduce
fundamental animation concepts.


PENDING : bouncing ball example


Use the following instructions to create an explicit animation
of a bouncing ball:

#### 1. Use a TickerProvider mixin

An `AnimationController` needs a `TickerProvider`&mdash;the
`AnimationController` constructor takes
a required parameter `vsync` that must implement a
`TickerProvider` interface. Therefore, the first step for
creating an explicit animation is to make a `TickerProvider`
object available to pass as the `vsync` argument
to `AnimationController`.
To do this, use a `TickerProvider` mixin with the widget
that you are animating:

<?code-excerpt "explicit{1,2}/lib/main.dart"?>
```diff
--- explicit1/lib/main.dart
+++ explicit2/lib/main.dart
@@ -7,7 +7,7 @@
   _BouncingBallDemoState createState() => _BouncingBallDemoState();
 }

-class _BouncingBallDemoState extends State<BouncingBallDemo> {
+class _BouncingBallDemoState extends State<BouncingBallDemo> with SingleTickerProviderStateMixin {
   @override
   void initState() {
     super.initState();
```

This step uses the `SingleTickerProviderStateMixin`
with `_BouncingBallDemoState`,
but you can also use `TickerProviderStateMixin` to make your widget
available as a `TickerProvider` for `AnimationController`.
Here are some considerations for deciding between the two:

* If you are only creating a single `AnimationController`
  from a `State` object (as in this example)
  you can use the `SingleTickerProviderStateMixin`.
* If you need to create more than one `AnimationController`
  over the lifetime of a `State` object,
  use the `TickerProviderStateMixin` instead.
* The `SingleTickerProviderStateMixin` is slightly more efficient
  than `TickerProviderStateMixin` in the case of the class
  only ever needing one `Ticker`.

#### 2. Instantiate and dispose of AnimationController in lifecycle methods

Instantiate `AnimationController` in a widget lifecycle method,
and call the `AnimationController.dispose()` within the
`State.dispose()` lifecycle method:

<?code-excerpt "explicit{2,3}/lib/main.dart"?>
```diff
--- explicit2/lib/main.dart
+++ explicit3/lib/main.dart
@@ -8,9 +8,12 @@
 }

 class _BouncingBallDemoState extends State<BouncingBallDemo> with SingleTickerProviderStateMixin {
+  late AnimationController controller;
+
   @override
   void initState() {
     super.initState();
+    controller = AnimationController();
   }

   @override
@@ -27,6 +30,12 @@
       ),
     );
   }
+
+  @override
+  void dispose() {
+    controller.dispose();
+    super.dispose();
+  }
 }

 class MyApp extends StatelessWidget {
```

This code is not yet valid because it passes no arguments
to `AnimationController`'s constructor.

Remember the following observations whenever performing
this step with `AnimationController`:

* You can instantiate `AnimationController` in several
  different lifecycle methods,
  but it is most common to use `initState()`.
* You should dispose of an `AnimationController`
  when it is no longer needed&mdash;this reduces
  the likelihood of memory leaks.
* Always dispose of `AnimationController`
  within the `dispose()` lifecycle method.

#### 3. Pass AnimationController parameters

Pass arguments for `vsync`, `duration`, `lowerBound`,
and `upperBound` to the `AnimationController` constructor:

<?code-excerpt "explicit{3,4}/lib/main.dart"?>
```diff
--- explicit3/lib/main.dart
+++ explicit4/lib/main.dart
@@ -13,7 +13,12 @@
   @override
   void initState() {
     super.initState();
-    controller = AnimationController();
+    controller = AnimationController(
+      vsync: this, // the SingleTickerProviderStateMixin
+      duration: Duration(seconds: 1),
+      lowerBound: 0,
+      upperBound: 100,
+    );
   }

   @override
```
The `vsync` parameter makes use of the
`SingleTickerProviderStateMixin` you added in [step 1][]:

* **vsync**:
Remember from [step 1][] that `vsync` is a required parameter
that takes a `TickerProvider`.
By passing `this` for the `vsync` parameter,
you are passing `_BouncingBallDemoState`
as the `TickerProvider` object to the `AnimationController` constructor.
`_BouncingBallDemoState` implements the `TickerProvider` interface
because [step 1][] adds the `SingleTickerProviderStateMixin`
with `_BouncingBallDemoState`.

The `duration`, `upperBound`, and `lowerBound` parameters
define the following parts of your animation:
* **duration**: The `duration` of the animation is 1 second.
* **upperBound** and **lowerBound**:
Since the bouncing ball animation moves the ball
by transitioning its top-margin value from 0 to 100,
this step passes 0 as the `lowerBound` and 100 as the `upperBound`.

#### 4. Add listener(s)

An `AnimationController` doesn't know anything
about the UI&mdash;it merely triggers changes to its `value`
property over a specified `duration`.
To make your UI respond to the changes
that `AnimationController` makes to its `value` property,
register a listener with `AnimationController`
that calls `setState()` each time `AnimationController`
changes its value:

<?code-excerpt "explicit{4,5}/lib/main.dart"?>
```diff
--- explicit4/lib/main.dart
+++ explicit5/lib/main.dart
@@ -19,12 +19,16 @@
       lowerBound: 0,
       upperBound: 100,
     );
+
+    controller.addListener(() {
+      setState(() {});
+    });
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

`AnimationController` provides an `addListener()` method
that takes a callback function. `AnimationController`
invokes this callback function every time
`AnimationController` changes its `value` property.
In order to rebuild the widget tree to reflect each change
in `AnimationController`'s `value` property, you
must call `setState()` from within the listener callback
that you pass to `addListener()`.
This is why explicit animations require `StatefulWidget`s.

#### 5. Trigger the animation

To start the bouncing ball animation so that
it repeats indefinitely, call `AnimationController.repeat()`:

<?code-excerpt "explicit{5,6}/lib/main.dart"?>
```diff
--- explicit5/lib/main.dart
+++ explicit6/lib/main.dart
@@ -23,6 +23,8 @@
     controller.addListener(() {
       setState(() {});
     });
+
+    controller.repeat(reverse: true);
   }

   @override
```
This step calls `repeat()` within `initState()` because
the bouncing ball animation can begin immediately
when this view is 

`AnimationController` provides several methods for "driving" an animation:

* `repeat()`
* `forward()`
* `reverse()`
* `stop()`
* `reset()`

Run the following example to see this explicit animation in action!

{% include explicit-animations/bouncing-ball-starter-code-4.md %}

### AnimationController concepts

As the name suggests, the `AnimationController` controls the
animation. 

#### The Animation object

Lifecycle of an animation (completed, dismissed)

* An `Animation` has a `status` and a `value`.
* The `value` depends on what the user wants,
  and can be of any type, such as <Color> or <Size>.
* The controller's `status` has four possible
  values: dismissed, forward, reverse, and completed.

`AnimationController` is the central class that you use
to create explicit animations; its capabilities
fall into four categories:
defining animations, generating animation values,
registering listeners, and play or sequence controls:

* `AnimationController` makes it easy to access
  the current value of the animation&mdash;just
  use the `value` property.
* To "play" an animation,
  you can use one of several methods that
  initiate the sequence of changes to `value`.
  For example, to "play" an animation
  from its starting value to its ending value,
  simply call `forward()`.
* Use `.addListener()` to register a callback invoked whenever
  `AnimationController` changes its `value` property.
  Most commonly, you register `setState()` with `AnimationController`.
  This tells Flutter to rebuild the widget tree
  whenever `AnimationController`'s value changes.
* `AnimationController` needs a `TickerProvider` to
  synchronize the animation's behavior to the device's display.

#### AnimationController interpolates frame values

To generate its range of values,
instantiate `AnimationController` and
pass it a few basic arguments like the `duration` of your animation,
as well as the starting and ending values,
`lowerBound` and `upperBound`, for your animation.
Once instantiated, `AnimationController` creates an interpolated
range of values between `upperBound` and `lowerBound`
over the given `duration`.

PENDING: Image of values in AnimationController

In this example,
the `AnimationController` constructor takes the
optional parameters `lowerBound`, `upperBound`,
and `duration`:

Instantiate `AnimationController`:

<!-- skip -->
 ```dart
controller = AnimationController(
  lowerBound: 0,
  upperBound: 100,
  duration: const Duration(seconds: 1),
  vsync: this, // Don't worry about vsync for now.
);
```

When you instantiate `AnimationController`,
you define an animation in terms of its starting value
(`lowerBound`), its ending value (`upperBound`),
and the amount of time it takes to change
from one to the other (`duration`).

The default values for `lowerBound` and `upperBound`
are 0 and 1, respectively; `duration` doesn't have a default value.

The preceding [`Animation` concepts][] section uses an `interpolate()`
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


  `AnimationController`
  abstracts away the work of interpolation,
  allowing you to reason about and create an animation
  in terms of its duration, and the starting and ending
  values of the property that you are animating:

#### AnimationController doesn't know anything about the UI



##### Access animation values with controller.value

`AnimationController` provides a `value` property.
You can access this property directly&mdash;there
is no getter method for `value`:

  <!-- skip -->
   ```dart
   print(controller.value);
   ```

By default, the `value` property begins at the `lowerBound` value.
You can set the starting value of `controller.value` to a specific
value between `lowerBound` and `upperBound` using the `from` parameter.
Once triggered, the `AnimationController` automatically updates
the `value` property to a new value.

## Curves

- Use CurvedAnimation
- you can use presets, or create your own

## Tweens

- To use a `Tween` call `animate()` passing in the controller. (example)

## AnimatedBuilder

## AnimatedWidget


[`Animation` concepts]: #animation-concepts
[`AnimationController`]: {{site.api}}/flutter/animation/AnimationController-class.html
[`AnimationController` section]: #animationcontroller
[`AnimationController` concepts]: #animationcontroller-concepts
[Create your first explicit animation with AnimationController]: #create-your-first-explicit-animation-with-animationcontroller
[Material app]: {{site.api}}/flutter/material/MaterialApp-class.html
[performance profiling]: /docs/perf/rendering/ui-performance
[implicit animations]: /docs/development/ui/animations/implicit-animations
[make a Flutter app]: https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1
[stateful widgets]: /docs/development/ui/interactive#stateful-and-stateless-widgets
[step 1]: #1-use-a-tickerprovider-mixin
[`SingleTickerProviderStateMixin`]: {{site.api}}/flutter/widgets/SingleTickerProviderStateMixin-mixin.html




---
TODO:
* Explain that setState listener boilerplate isn't normal.
* Add section that uses AnimatedBuilder/AnimatedWidget
* Refactor all DartPad samples to use non-working defaults,
  & offer solution
* Update vanilla bouncing ball final example to use *both*
  upward and downward motion
* "Why TickerProvider?" in animationController concepts section
* How to choose between AnimatedBuilder and AnimatedWidget.
* Answer question: when to use a Tween,
  if you can just use upper and lower bound args for
  AnimationController?
  - when we need something other than a double?
* Add margin-bottom to DartPads
* Add diffs between each solution in the introduction section




