---
title: "Implicit animations"
description: "A codelab that uses interactive examples and exercises to teach  how to use Flutter's implicitly animated widgets."
toc: true
diff2html: true
js:
  - defer: true
    url: https://dartpad.dev/inject_embed.dart.js
  - defer: true
    url: /assets/codelabs/js/animations_examples.js
---

<?code-excerpt path-base="../null_safety_examples/animation/implicit"?>

Welcome to the implicit animations codelab, where you learn how to use Flutter
widgets that make it easy to create animations for a specific set of properties.

To get the most out of this codelab, you should have basic knowledge about:

* How to [make a Flutter app].
* How to use [stateful widgets].

This codelab covers the following material:

* Using `AnimatedOpacity` to create a fade-in effect.
* Using `AnimatedContainer` to animate transitions in size, color, and margin.
* Overview of implicit animations and techniques for using them.

**Estimated time to complete this codelab: 15-30 minutes.**

## What are implicit animations?

With Flutter's [animation library],
you can add motion and create visual effects
for the widgets in your UI.
One widget set in the library manages animations for you.
These widgets are collectively referred to as _implicit animations_,
or _implicitly animated widgets_, deriving their name from the
[ImplicitlyAnimatedWidget] class that they implement.
With implicit animations,
you can animate a widget property by setting a target value;
whenever that target value changes,
the widget animates the property from the old value to the new one.
In this way, implicit animations trade control for convenience&mdash;they
manage animation effects so that you don't have to.

## Example: Fade-in text effect

The following example shows how to add a fade-in effect to existing UI
using an implicitly animated widget called [AnimatedOpacity].
**The example begins with no animation code**&mdash;it
consists of a [Material App] home screen containing:

* A photograph of an owl.
* One **Show details** button that does nothing when clicked.
* Description text of the owl in the photograph.

### Fade-in (starter code)

Click the **Run** button to run the example:

{% include implicit-animations/fade-in-starter-code.md %}

{{site.alert.important}}
  This page uses an embedded version of [DartPad] to display
  examples and exercises.
  If you see empty boxes instead of DartPads, go to the
  [DartPad troubleshooting page].
{{site.alert.end}}

### Animate opacity with AnimatedOpacity widget

  This section contains a list of steps you can use to add an
  implicit animation to the
  [fade-in starter code]. After the steps, you can also run the
  [fade-in complete] code with the the changes already made.
  The steps outline how to use the `AnimatedOpacity`
  widget to add the following animation feature:

  * The owl's description text remains hidden until the user clicks the
    **Show details** button.
  * When the user clicks the **Show details** button,
    the owl's description text fades in.

#### 1. Pick a widget property to animate

To create a fade-in effect, you can animate the `opacity` property using the
`AnimatedOpacity` widget. Change the `Container` widget to an
`AnimatedOpacity` widget:

<?code-excerpt "opacity{1,2}/lib/main.dart"?>
```diff
--- opacity1/lib/main.dart
+++ opacity2/lib/main.dart
@@ -21,7 +21,7 @@
             style: TextStyle(color: Colors.blueAccent),
           ),
           onPressed: () => null),
-      Container(
+      AnimatedOpacity(
         child: Column(
           children: <Widget>[
             Text('Type: Owl'),
```

{{site.alert.info}}
  You can reference the line numbers in the example code to help track
  where to make these changes.
{{site.alert.end}}

#### 2. Initialize a state variable for the animated property

To hide the text before the user clicks **Show details**, set
the starting value for `opacity` to zero:

<?code-excerpt "opacity{2,3}/lib/main.dart"?>
```diff
--- opacity2/lib/main.dart
+++ opacity3/lib/main.dart
@@ -11,6 +11,8 @@
 }

 class _FadeInDemoState extends State<FadeInDemo> {
+  double opacity = 0.0;
+
   @override
   Widget build(BuildContext context) {
     return Column(children: <Widget>[
@@ -22,6 +24,8 @@
           ),
           onPressed: () => null),
       AnimatedOpacity(
+        duration: Duration(seconds: 3),
+        opacity: opacity,
         child: Column(
           children: <Widget>[
             Text('Type: Owl'),
```

#### 3. Set up a trigger for the animation, and choose an end value

Configure the animation to trigger when the user clicks the **Show details**
button. To do this, change `opacity` state using the `onPressed()` handler for
`TextlButton`. To make the `FadeInDemo` widget become fully visible when
the user clicks the **Show details** button, use the `onPressed()` handler
to set `opacity` to 1:

<?code-excerpt "opacity{4,5}/lib/main.dart"?>
```diff
--- opacity4/lib/main.dart
+++ opacity5/lib/main.dart
@@ -18,11 +18,14 @@
     return Column(children: <Widget>[
       Image.network(owl_url),
       TextButton(
-          child: Text(
-            'Show Details',
-            style: TextStyle(color: Colors.blueAccent),
-          ),
-          onPressed: () => null),
+        child: Text(
+          'Show Details',
+          style: TextStyle(color: Colors.blueAccent),
+        ),
+        onPressed: () => setState(() {
+          opacity = 1;
+        }),
+      ),
       AnimatedOpacity(
         duration: Duration(seconds: 2),
         opacity: opacity,
```

{{site.alert.secondary}}
  Notice that you only need to set the start and end values of `opacity`.
  The `AnimatedOpacity` widget manages everything in between.
{{site.alert.end}}

#### 4. Set the duration of the animation

In addition to an `opacity` parameter, `AnimatedOpacity` requires a
[duration] to use for its animation. For this example,
you can start with 2 seconds:

<?code-excerpt "opacity{3,4}/lib/main.dart"?>
```diff
--- opacity3/lib/main.dart
+++ opacity4/lib/main.dart
@@ -24,7 +24,7 @@
           ),
           onPressed: () => null),
       AnimatedOpacity(
-        duration: Duration(seconds: 3),
+        duration: Duration(seconds: 2),
         opacity: opacity,
         child: Column(
           children: <Widget>[
```

### Fade-in (complete)

Here's the example with the completed changes you've made&mdash;run this
example and click the **Show details** button to trigger the animation.

{% include implicit-animations/fade-in-complete.md %}

### Putting it all together

The [Fade-in text effect] example demonstrates the following features
of `AnimatedOpacity`:

* `AnimatedOpacity` listens for state changes in its `opacity` property.
* Whenever `opacity` changes, `AnimatedOpacity` automatically animates the
  widget's transition to the new value for `opacity`.
* `AnimatedOpacity` requires a `duration` parameter to define the time it takes
  to animate the transition between an old `opacity` value and a new one.

{{site.alert.secondary}}
  Note that Implicit animations can only animate properties of a parent
  `StatefulWidget`, so this example begins with the `FadeInDemo` widget that
  extends `StatefulWidget`.

  Notice also that `AnimatedOpacity` animates a single property: `opacity`.
  Some implicitly animated widgets can animate many properties, as the following
  example illustrates.
{{site.alert.end}}

## Example: Shape-shifting effect

The following example shows how to use the [AnimatedContainer] widget to
animate multiple properties (`margin`, `borderRadius`, and `color`) with
different types (`double` and `Color`).
**The example begins with no animation code**&mdash;it starts with a
[Material App] home screen that contains:

* A `Container` with `borderRadius`, `margin`, and `color` properties that are
  different each time you run the example.
* A **Change** button that does nothing when clicked.

### Shape-shifting (starter code)

Click the **Run** button to run the example:

{% include implicit-animations/shape-shifting-starter-code.md %}


### Animate color, borderRadius, and margin with AnimatedContainer

  This section contains a list of steps you can use to add an
  implicit animation to the [shape-shifting starter code].
  After the steps, you can also run the
  [shape-shifting complete] example with the changes already made.

In the [shape-shifting starter code],
each property in the `Container` widget (`color`,
`borderRadius`, and `margin`)
is assigned a value by an associated function (`randomColor()`,
`randomBorderRadius()`, and `randomMargin()` respectively).
By using an `AnimatedContainer` widget,
you can refactor this code to do the following:

* Generate new values for `color`, `borderRadius`,
  and `margin` whenever the user clicks the **Change** button.
* Animate the transition to the new values for `color`,
  `borderRadius`, and `margin` whenever they are set.

#### 1. Add an implicit animation

Change the `Container` widget to an `AnimatedContainer` widget:

<?code-excerpt "container{1,2}/lib/main.dart"?>
```diff
--- container1/lib/main.dart
+++ container2/lib/main.dart
@@ -44,7 +44,7 @@
             SizedBox(
               width: 128,
               height: 128,
-              child: Container(
+              child: AnimatedContainer(
                 margin: EdgeInsets.all(margin),
                 decoration: BoxDecoration(
                   color: color,
```
{{site.alert.info}}
  You can reference the line numbers in the example code to help track where to
  make these changes in [shape-shifting starter code]
{{site.alert.end}}

#### 2. Set starting values for animated properties

`AnimatedContainer` automatically animates between old and new values of
its properties when they change. Create a `change()` method that defines the
behavior triggered when the user clicks the **Change** button.
The `change()` method can use `setState()` to set new values
for the `color`, `borderRadius`, and `margin` state variables:

<?code-excerpt "container{2,3}/lib/main.dart"?>
```diff
--- container2/lib/main.dart
+++ container3/lib/main.dart
@@ -35,6 +35,14 @@
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
To set the animation to trigger whenever the user presses the **Change** button,
invoke the `change()` method in the `onPressed()` handler:

<?code-excerpt "container{3,4}/lib/main.dart"?>
```diff
--- container3/lib/main.dart
+++ container4/lib/main.dart
@@ -62,7 +62,7 @@
             ),
             ElevatedButton(
               child: Text('change'),
-              onPressed: () => null,
+              onPressed: () => change(),
             ),
           ],
         ),
```

#### 4. Set duration
Finally, set the `duration` of the animation that powers the transition
between the old and new values:
<?code-excerpt "container{4,5}/lib/main.dart"?>
```diff
--- container4/lib/main.dart
+++ container5/lib/main.dart
@@ -6,6 +6,8 @@

 import 'package:flutter/material.dart';

+const _duration = Duration(milliseconds: 400);
+
 double randomBorderRadius() {
   return Random().nextDouble() * 64;
 }
@@ -58,6 +60,7 @@
                   color: color,
                   borderRadius: BorderRadius.circular(borderRadius),
                 ),
+                duration: _duration,
               ),
             ),
             ElevatedButton(
```

### Shape-shifting (complete)

Here’s the example with the completed changes you’ve made&mdash;run the code
and click the **Change** button to trigger the animation. Notice that each time
you click the **Change** button, the shape animates to its new values
for `margin`, `borderRadius`, and `color`.

{% include implicit-animations/shape-shifting-complete.md %}

### Using animation curves

The preceding examples show how implicit animations allow you to animate
changes in values for specific widget properties, and how the
`duration` parameter allows you to set the amount of time an
animation takes to complete. Implicit animations also allow you to
control changes to __the rate__ of an animation within the `duration`.
The parameter you use to define this change in rate is [curve].

The preceding examples do not specify a `curve`,
so the implicit animations apply a [linear animation curve] by default.
Add a `curve` parameter to the [shape-shifting complete]
and watch how the animation changes when you pass the
[easeInOutBack] constant for `curve`:

<?code-excerpt "container{5,6}/lib/main.dart"?>
```diff
--- container5/lib/main.dart
+++ container6/lib/main.dart
@@ -61,6 +61,7 @@
                   borderRadius: BorderRadius.circular(borderRadius),
                 ),
                 duration: _duration,
+                curve: Curves.easeInOutBack,
               ),
             ),
             ElevatedButton(
```

Now that you have passed `easeInOutBack` as the value for `curve` to
`AnimatedContainer`, notice that the rates of change for `margin`,
`borderRadius`, and `color` follow the curve defined by the
`easeInOutBack` curve:

<div id="animation_1_play_button_"></div>
<video id="animation_1" style="width:464px; height:192px;" loop="">
  <source src="{{site.flutter-assets}}/animation/curve_ease_in_out_back.mp4" type="video/mp4">
</video>

{{site.alert.secondary}}
  The `easeInOutBack` constant is only one of many that you can
  pass for the `curve` parameter. Explore the
  [list of curve constants] to discover more ways
  to use `curve` to modify the look and feel of your animations.
{{site.alert.end}}

### Putting it all together

The [shape-shifting complete] example animates transitions between values for
`margin`, `borderRadius`, and `color` properties.
Note that `AnimatedContainer` animates changes to any of its properties,
including those you didn't use such as `padding`, `transform`,
and even `child` and `alignment`!
The [shape-shifting complete] example builds upon [fade-in complete] by showing
additional capabilities of implicit animations:

* Some implicit animations (for example,
  `AnimatedOpacity`) only animate a single
  property, while others (like `AnimatedContainer`)
  can animate many properties.
* Implicit animations automatically animate between the old and
  new values of properties when they change using the provided
  `curve` and `duration`.
* If you do not specify a `curve`,
  implicit animations default to a [linear curve].

## What's next?

Congratulations, you've finished the codelab! If you'd like to learn more,
here are some suggestions for where to go next:

* Try the [animations tutorial].
* Learn about [hero animations] and [staggered animations].
* Checkout the [animation library].
* Try another [codelab].

<iframe src="https://docs.google.com/forms/d/e/1FAIpQLSfTcB884FuPXukPEEewU5pgphZyF2Ue0pOWoIHvRp-4D-xYjw/viewform?embedded=true" width="100%" height="1726" frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>

[AnimatedContainer]: {{site.api}}/flutter/widgets/AnimatedContainer-class.html
[AnimatedOpacity]: {{site.api}}/flutter/widgets/AnimatedOpacity-class.html
[animation library]: {{site.api}}/flutter/animation/animation-library.html
[animations tutorial]: /docs/development/ui/animations/tutorial
[codelab]: /docs/codelabs
[curve]: {{site.api}}/flutter/animation/Curve-class.html
[DartPad troubleshooting page]: {{site.dart-site}}/tools/dartpad/troubleshoot
[DartPad]: {{site.dartpad}}
[duration]: {{site.api}}/flutter/widgets/ImplicitlyAnimatedWidget/duration.html
[easeInOutBack]: {{site.api}}/flutter/animation/Curves/easeInOutBack-constant.html
[fade-in complete]: #fade-in-complete
[fade-in starter code]: #fade-in-starter-code
[Fade-in text effect]: #example-fade-in-text-effect
[hero animations]: /docs/development/ui/animations/hero-animations
[ImplicitlyAnimatedWidget]: {{site.api}}/flutter/widgets/ImplicitlyAnimatedWidget-class.html
[linear animation curve]: {{site.api}}/flutter/animation/Curves/linear-constant.html
[linear curve]: {{site.api}}/flutter/animation/Curves/linear-constant.html
[list of common implicitly animated widgets]: {{site.api}}/flutter/widgets/ImplicitlyAnimatedWidget-class.html
[list of curve constants]: {{site.api}}/flutter/animation/Curves-class.html
[make a Flutter app]: {{site.codelabs}}/codelabs/first-flutter-app-pt1/
[Material App]: {{site.api}}/flutter/material/MaterialApp-class.html
[shape-shifting complete]: #shape-shifting-complete
[Shape-shifting effect]: #example-shape-shifting-effect
[shape-shifting starter code]: #shape-shifting-starter-code
[staggered animations]: /docs/development/ui/animations/staggered-animations
[stateful widgets]: /docs/development/ui/interactive#stateful-and-stateless-widgets
