---
title: "Implicit animations"
description: >
  Learn how to use Flutter's implicitly animated widgets
  through interactive examples and exercises.
toc: true
diff2html: true
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
  - defer: true
    url: /assets/js/codelabs/animations_examples.js
---

<?code-excerpt path-base="animation/implicit"?>

Welcome to the implicit animations codelab, where you learn how to use Flutter
widgets that make it easy to create animations for a specific set of properties.

{% include docs/dartpad-troubleshooting.md %}

To get the most out of this codelab, you should have basic knowledge about:

- How to [make a Flutter app][].
- How to use [stateful widgets][].

This codelab covers the following material:

- Using `AnimatedOpacity` to create a fade-in effect.
- Using `AnimatedContainer` to animate transitions in size, color, and margin.
- Overview of implicit animations and techniques for using them.

**Estimated time to complete this codelab: 15-30 minutes.**

## What are implicit animations?

With Flutter's [animation library][],
you can add motion and create visual effects
for the widgets in your UI.
One widget set in the library manages animations for you.
These widgets are collectively referred to as _implicit animations_,
or _implicitly animated widgets_, deriving their name from the
[ImplicitlyAnimatedWidget][] class that they implement.
With implicit animations,
you can animate a widget property by setting a target value;
whenever that target value changes,
the widget animates the property from the old value to the new one.
In this way, implicit animations trade control for convenience&mdash;they
manage animation effects so that you don't have to.

## Example: Fade-in text effect

The following example shows how to add a fade-in effect to existing UI
using an implicitly animated widget called [AnimatedOpacity][].
**The example begins with no animation code**&mdash;it
consists of a [Material App][] home screen containing:

- A photograph of an owl.
- One **Show details** button that does nothing when clicked.
- Description text of the owl in the photograph.

### Fade-in (starter code)

To view the example, Click **Run**:

{% render docs/implicit-animations/fade-in-starter-code.md %}

### Animate opacity with AnimatedOpacity widget

This section contains a list of steps you can use to add an
implicit animation to the
[fade-in starter code][]. After the steps, you can also run the
[fade-in complete][] code with the changes already made.
The steps outline how to use the `AnimatedOpacity`
widget to add the following animation feature:

- The owl's description text remains hidden until the user clicks
  **Show details**.
- When the user clicks **Show details**,
  the owl's description text fades in.

#### 1. Pick a widget property to animate

To create a fade-in effect, you can animate the
`opacity` property using the`AnimatedOpacity` widget. 
Wrap the `Column` widget in an `AnimatedOpacity` widget:

```diff2html
--- opacity1/lib/main.dart
+++ opacity2/lib/main.dart
@@ -26,12 +26,14 @@
         ),
         onPressed: () => {},
       ),
-      const Column(
-        children: [
-          Text('Type: Owl'),
-          Text('Age: 39'),
-          Text('Employment: None'),
-        ],
+      AnimatedOpacity(
+        child: const Column(
+          children: [
+            Text('Type: Owl'),
+            Text('Age: 39'),
+            Text('Employment: None'),
+          ],
+        ),
       )
     ]);
   }
```

:::note
You can reference the line numbers in the example code to help track where
to make these changes in the [fade-in starter code][].
:::

#### 2. Initialize a state variable for the animated property

To hide the text before the user clicks **Show details**, set
the starting value for `opacity` to zero:

```diff2html
--- opacity2/lib/main.dart
+++ opacity3/lib/main.dart
@@ -15,6 +15,8 @@
 }

 class _FadeInDemoState extends State<FadeInDemo> {
+  double opacity = 0;
+
   @override
   Widget build(BuildContext context) {
     return ListView(children: <Widget>[
@@ -27,6 +29,7 @@
         onPressed: () => {},
       ),
       AnimatedOpacity(
+        opacity: opacity,
         child: const Column(
           children: [
             Text('Type: Owl'),
```

#### 3. Set the duration of the animation

In addition to an `opacity` parameter, `AnimatedOpacity` requires a
[duration][] to use for its animation. For this example,
you can start with 2 seconds:

```diff2html
--- opacity3/lib/main.dart
+++ opacity4/lib/main.dart
@@ -29,6 +29,7 @@
         onPressed: () => {},
       ),
       AnimatedOpacity(
+        duration: const Duration(seconds: 2),
         opacity: opacity,
         child: const Column(
           children: [
```

#### 4. Set up a trigger for animation and choose an end value

Configure the animation to trigger when the user clicks **Show details**.
To do this, change `opacity` state using the `onPressed()` handler for
`TextButton`. To make the `FadeInDemo` widget become fully visible when
the user clicks **Show details**, use the `onPressed()` handler
to set `opacity` to 1:

```diff2html
--- opacity4/lib/main.dart
+++ opacity5/lib/main.dart
@@ -26,7 +26,9 @@
           'Show Details',
           style: TextStyle(color: Colors.blueAccent),
         ),
-        onPressed: () => {},
+        onPressed: () => setState(() {
+          opacity = 1;
+        }),
       ),
       AnimatedOpacity(
         duration: const Duration(seconds: 2),
```

:::note
You only need to set the start and end values of `opacity`.
The `AnimatedOpacity` widget manages everything in between.
:::

### Fade-in (complete)

Here's the example with the completed changes you've made.
Run this example then click **Show details** to trigger the animation.

{% render docs/implicit-animations/fade-in-complete.md %}

### Putting it all together

The [Fade-in text effect][] example demonstrates the following features
of the `AnimatedOpacity` widget.

- It listens for state changes to its `opacity` property.
- When the `opacity` property changes,
  it animates the transition to the new value for `opacity`.
- It requires a `duration` parameter to define how long
  the transition between the values should take.

:::note
- Implicit animations can only animate the
  properties of a parent stateful widget.
  The preceding example enables this with the
  `FadeInDemo` widget that extends `StatefulWidget`.

- The `AnimatedOpacity` widget only animates the `opacity` property.
  Some implicitly animated widgets can animate many properties
  at the same time. The following example showcases this.
:::

## Example: Shape-shifting effect

The following example shows how to use the [`AnimatedContainer`][] widget to
animate multiple properties (`margin`, `borderRadius`, and `color`) with
different types (`double` and `Color`).
**The example begins with no animation code**.
It starts with a [Material App][] home screen that contains:

- A `Container` widget configured with a
 `borderRadius`, `margin`, and `color`.
  These properties are setup to be regenerated 
  each time you run the example.
- A **Change** button that does nothing when clicked.

### Shape-shifting (starter code)

To start the example, click **Run**.

{% render docs/implicit-animations/shape-shifting-starter-code.md %}

### Animate color, borderRadius, and margin with AnimatedContainer

This section contains a list of steps you can use to add an
implicit animation to the [shape-shifting starter code][].
After completing each step, you can also run the
[complete shape-shifting example][] with the changes already made.

The [shape-shifting starter code][] assigns
each property in the `Container` widget a random value.
Associated functions generate the relevant values:

- The `randomColor()` function generates a
  `Color` for the `color` property
- The `randomBorderRadius()` function generates a
  `double` for the `borderRadius` property.
- The `randomMargin()` function generates a
  `double` for the `margin` property.

The following steps use the `AnimatedContainer` widget to:

- Transition to new values for `color`, `borderRadius`,
  and `margin` whenever the user clicks **Change**.
- Animate the transition to the new values for `color`,
  `borderRadius`, and `margin` whenever they are set.

#### 1. Add an implicit animation

Change the `Container` widget to an `AnimatedContainer` widget:

```diff2html
--- container1/lib/main.dart
+++ container2/lib/main.dart
@@ -47,7 +47,7 @@
             SizedBox(
               width: 128,
               height: 128,
-              child: Container(
+              child: AnimatedContainer(
                 margin: EdgeInsets.all(margin),
                 decoration: BoxDecoration(
                   color: color,
```

:::note
You can reference the line numbers in the example code to help track where to
make these changes in the [shape-shifting starter code][].
:::

#### 2. Set starting values for animated properties

The `AnimatedContainer` widget transitions between
old and new values of its properties when they change.
To contain the behavior triggered when the user clicks **Change**,
create a `change()` method.
The `change()` method can use the `setState()` method to set new values
for the `color`, `borderRadius`, and `margin` state variables:

```diff2html
--- container2/lib/main.dart
+++ container3/lib/main.dart
@@ -38,6 +38,14 @@
     margin = randomMargin();
   }

+  void change() {
+    setState(() {
+      color = randomColor();
+      borderRadius = randomBorderRadius();
+      margin = randomMargin();
+    });
+  }
+
   @override
   Widget build(BuildContext context) {
     return Scaffold(
```

#### 3. Set up a trigger for the animation

To set the animation to trigger whenever the user presses **Change**,
invoke the `change()` method in the `onPressed()` handler:

```diff2html
--- container3/lib/main.dart
+++ container4/lib/main.dart
@@ -65,7 +65,7 @@
             ),
             ElevatedButton(
               child: const Text('Change'),
-              onPressed: () => {},
+              onPressed: () => change(),
             ),
           ],
         ),
```

#### 4. Set duration

Set the `duration` of the animation that powers the transition
between the old and new values:

```diff2html
--- container4/lib/main.dart
+++ container5/lib/main.dart
@@ -6,6 +6,8 @@

 import 'package:flutter/material.dart';

+const _duration = Duration(milliseconds: 400);
+
 double randomBorderRadius() {
   return Random().nextDouble() * 64;
 }
@@ -61,6 +63,7 @@
                   color: color,
                   borderRadius: BorderRadius.circular(borderRadius),
                 ),
+                duration: _duration,
               ),
             ),
             ElevatedButton(
```

### Shape-shifting (complete)

Here's the example with the completed changes you've made.
Run the code and click **Change** to trigger the animation.
Each time you click **Change**, the shape animates to its new values
for `margin`, `borderRadius`, and `color`.

{% render docs/implicit-animations/shape-shifting-complete.md %}

### Using animation curves

The preceding examples show how:

- Implicit animations allow you to animate the transition between
  values for specific widget properties.
- The `duration` parameter allows you to set how long the animation
  takes to complete.

Implicit animations also allow you to control changes to **the rate**
of an animation that occurs during the set `duration`.
To define this change in rate,
set the value of the `curve` parameter to
a [`Curve`][], such as one declared in the [`Curves`][] class.

The preceding examples did not specify a value for the `curve` parameter.
Without a specified curve value,
the implicit animations apply a [linear animation curve][].

Specify a value for the `curve` parameter in
the [complete shape-shifting example][].
The animation changes when you pass the
[`easeInOutBack`][] constant for `curve`,

```diff2html
--- container5/lib/main.dart
+++ container6/lib/main.dart
@@ -64,6 +64,7 @@
                   borderRadius: BorderRadius.circular(borderRadius),
                 ),
                 duration: _duration,
+                curve: Curves.easeInOutBack,
               ),
             ),
             ElevatedButton(
```

When you pass the `Curves.easeInOutBack` constant to the `curve` property
of the `AnimatedContainer` widget, watch how
the rates of change for `margin`, `borderRadius`, and `color`
follow the curve that constant defined.

<div id="animation_1_play_button_"></div>
<video id="animation_1" style="width:464px; height:192px;" loop="">
  <source src="{{site.flutter-assets}}/animation/curve_ease_in_out_back.mp4" type="video/mp4">
</video>

### Putting it all together

The [complete shape-shifting example][] animates transitions between
values for `margin`, `borderRadius`, and `color` properties.
The `AnimatedContainer` widget animates changes to any of its properties.
These include those you didn't use such as `padding`, `transform`,
and even `child` and `alignment`!
By showing additional capabilities of implicit animations,
the [complete shape-shifting example][] builds upon
[fade-in complete][] example.

To summarize implicit animations:

- Some implicit animations, like the `AnimatedOpacity` widget,
  only animate one property.
  Others, like the `AnimatedContainer` widget, can animate many properties.
- Implicit animations animate the transition between the
  old and new value of a property when it
  changes using the provided `curve` and `duration`.
- If you do not specify a `curve`,
  implicit animations default to a [linear curve][].

## What's next?

Congratulations, you've finished the codelab!
To learn more, check out these suggestions:

- Try the [animations tutorial][].
- Learn about [hero animations][] and [staggered animations][].
- Checkout the [animation library][].
- Try another [codelab][].

[`AnimatedContainer`]: {{site.api}}/flutter/widgets/AnimatedContainer-class.html
[AnimatedOpacity]: {{site.api}}/flutter/widgets/AnimatedOpacity-class.html
[animation library]: {{site.api}}/flutter/animation/animation-library.html
[animations tutorial]: /ui/animations/tutorial
[codelab]: /codelabs
[`Curve`]: {{site.api}}/flutter/animation/Curve-class.html
[`Curves`]: {{site.api}}/flutter/animation/Curves-class.html
[duration]: {{site.api}}/flutter/widgets/ImplicitlyAnimatedWidget/duration.html
[`easeInOutBack`]: {{site.api}}/flutter/animation/Curves/easeInOutBack-constant.html
[fade-in complete]: #fade-in-complete
[fade-in starter code]: #fade-in-starter-code
[Fade-in text effect]: #example-fade-in-text-effect
[hero animations]: /ui/animations/hero-animations
[ImplicitlyAnimatedWidget]: {{site.api}}/flutter/widgets/ImplicitlyAnimatedWidget-class.html
[linear animation curve]: {{site.api}}/flutter/animation/Curves/linear-constant.html
[linear curve]: {{site.api}}/flutter/animation/Curves/linear-constant.html
[make a Flutter app]: {{site.codelabs}}/codelabs/flutter-codelab-first
[Material App]: {{site.api}}/flutter/material/MaterialApp-class.html
[complete shape-shifting example]: #shape-shifting-complete
[shape-shifting starter code]: #shape-shifting-starter-code
[staggered animations]: /ui/animations/staggered-animations
[stateful widgets]: /ui/interactivity#stateful-and-stateless-widgets
