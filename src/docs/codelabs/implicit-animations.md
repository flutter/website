---
title: "Implicit animations"
description: "A codelab that uses interactive examples and exercises to teach  how to use Flutter's implicitly animated widgets."
toc: true
diff2html: true
js:
- url: /assets/codelabs/js/animations_examples.js
  defer: true
---

<?code-excerpt path-base="animation/implicit"?>

Welcome to the implicit animations codelab, where you learn how to use Flutter
widgets that make it easy to create animations for a specific set of properties.

To get the most out of this codelab, you should have basic knowledge about:
- How to [make a Flutter app].
- How to use [stateful widgets].

This codelab covers the following material:
- Using `AnimatedOpacity` to create a fade-in effect.
- Using `AnimatedContainer` to animate transitions in size, color, and margin.
- Overview of implicit animations and techniques for using them.

**Estimated time to complete this codelab: 15-30 minutes.**

## What are implicit animations?

With Flutter's animation library, you can add motion and create visual effects
for the widgets in your UI. One part of the library is an assortment of widgets
that manage animations for you. These widgets are collectively referred to as _implicit
animations_, or _implicitly animated widgets_, deriving their name from the
[ImplicitlyAnimatedWidget] class that they implement. With implicit animations,
you can animate a widget property by setting a target value; whenever that target
value changes, the widget animates the property from the old value to the new one.
In this way, implicit animations trade control for convenience&mdash;they
manage animation effects so that you don't have to.

## Example: Add a fade-in effect to text

The following example shows how to add a fade-in effect to existing UI
using an implicitly animated widget called [AnimatedOpacity]. **The example begins
with no animation code**&mdash;it consists of a [Material App] home screen containing:
- A photograph of an owl.
- One **Show details** button that does nothing when clicked.
- Description text of the owl in the photograph.

Click the **Run** button to run the example:

<!-- Vanilla AnimatedOpacity https://gist.github.com/d7b09149ffee2f0535bb0c04d96987f5 -->
<iframe
  src="{{site.custom.dartpadx.embed-flutter-prefix}}?id=d7b09149ffee2f0535bb0c04d96987f5"
  style="border: 1px solid lightgrey; margin-top: 10px; margin-bottom: 25px"
  frameborder="no" height="500" width="100%"
></iframe>
{{site.alert.important}}
  This page uses an embedded version of [DartPad] to display examples and exercises.
  If you see empty boxes instead of DartPads, go to the
  [DartPad troubleshooting page].
{{site.alert.end}}

### Animate opacity with AnimatedOpacity widget

{{site.alert.secondary}}
  This section contains a list of steps you can use to add an implicit animation to the
  preceding example code. After the steps, you can also run an example with the
  the changes already made. The steps outline how to use the `AnimatedOpacity`
  widget to add the following animation feature:
  - The owl's description text remains hidden until the user clicks the
  **Show details** button.
  - When the user clicks the **Show details** button, the owl's description text fades in.
{{site.alert.end}}

**1.** First, refactor the `FadeInDemo` widget from a `StatelessWidget` to a `StatefulWidget`,
and add an accompanying `_FadeInDemoState` widget.

<?code-excerpt "opacity{0,1}/lib/main.dart"?>
```diff
--- opacity0/lib/main.dart
+++ opacity1/lib/main.dart
@@ -8,7 +8,11 @@

 const owl_url = 'https://raw.githubusercontent.com/flutter/website/master/src/images/owl.jpg';

-class FadeInDemo extends StatelessWidget {
+class FadeInDemo extends StatefulWidget {
+  _FadeInDemoState createState() => _FadeInDemoState();
+}
+
+class _FadeInDemoState extends State<FadeInDemo> {
   @override
   Widget build(BuildContext context) {
     return Column(children: <Widget>[
```

**2.** Change the `Container` widget to an `AnimatedOpacity` widget:

<?code-excerpt "opacity{1,2}/lib/main.dart"?>
```diff
--- opacity1/lib/main.dart
+++ opacity2/lib/main.dart
@@ -23,7 +23,7 @@
             style: TextStyle(color: Colors.blueAccent),
           ),
           onPressed: () => null),
-      Container(
+      AnimatedOpacity(
         child: Column(
           children: <Widget>[
             Text('Type: Owl'),
```

**3.** Create a state variable for the property that `AnimatedOpacity` listens
on. As the name implies, `AnimatedOpacity` listens for changes in the `opacity`
property. To hide the text before the user clicks **Show details**, set
the starting `opacity` value to zero:

<?code-excerpt "opacity{2,3}/lib/main.dart"?>
```diff
--- opacity2/lib/main.dart
+++ opacity3/lib/main.dart
@@ -13,6 +13,8 @@
 }

 class _FadeInDemoState extends State<FadeInDemo> {
+  double opacity = 0.0;
+
   @override
   Widget build(BuildContext context) {
     return Column(children: <Widget>[
@@ -24,6 +26,7 @@
           ),
           onPressed: () => null),
       AnimatedOpacity(
+        opacity: opacity,
         child: Column(
           children: <Widget>[
             Text('Type: Owl'),
```

**4.** In addition to an `opacity` parameter, `AnimatedOpacity` requires a
`duration` to use for its animation. For this example, you can start with 2 seconds:

<?code-excerpt "opacity{3,4}/lib/main.dart"?>
```diff
--- opacity3/lib/main.dart
+++ opacity4/lib/main.dart
@@ -26,6 +26,7 @@
           ),
           onPressed: () => null),
       AnimatedOpacity(
+        duration: Duration(seconds: 2),
         opacity: opacity,
         child: Column(
           children: <Widget>[
```

**5.** Finally, configure the animation to trigger when the user clicks the
**Show details** button. To do this, change `opacity` state using
the `onPressed()` handler for `MaterialButton`. To make the `FadeInDemo` widget become fully
visible when the user clicks the **Show details** button, set `opacity`
to 1:

<?code-excerpt "opacity{4,5}/lib/main.dart"?>
```diff
--- opacity4/lib/main.dart
+++ opacity5/lib/main.dart
@@ -20,11 +20,14 @@
     return Column(children: <Widget>[
       Image.network(owl_url),
       MaterialButton(
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
  Notice that you only need to set the beginning and ending values of `opacity`.
  The `AnimatedOpacity` widget manages everything in between.
{{site.alert.end}}

Here's the example with the completed changes you've made&mdash;run this
example and click the **Show details** button to trigger the animation.

<!-- AnimatedOpacity https://gist.github.com/4207fea3975b2d329e81d9c9ba84d271 -->
<iframe
  src="{{site.custom.dartpadx.embed-flutter-prefix}}?id=4207fea3975b2d329e81d9c9ba84d271"
  style="border: 1px solid lightgrey; margin-top: 10px; margin-bottom: 25px"
  frameborder="no" height="500" width="100%"
></iframe>

### Putting it all together

The previous example demonstrates the following features of `AnimatedOpacity`:
- `AnimatedOpacity` listens for state changes in its `opacity` property.
- Whenever `opacity` changes, `AnimatedOpacity` automatically animates the
widget's transition to the new value for `opacity`.
- `AnimatedOpacity` requires a `duration` parameter to define the time it takes
to animate the transition between an old `opacity` value and a new one.

The previous example also uses a common workflow for using implicit animations:
- First, pick a widget property to animate.
- Next, choose an implicit animation that can animate that property.
- Choose the start and end values for the property that you're animating.
- Set the `duration` of the animation.
- Trigger the animation by creating a state change in the animated property.

{{site.alert.secondary}}
  Notice that `AnimatedOpacity` animates a single property: `opacity`.
  Some implicitly animated widgets can animate many properties, as the following
  example illustrates.
{{site.alert.end}}

## Example: Animate the properties of a shape

The following example shows how to use the [AnimatedContainer] widget to
animate multiple properties (`margin`, `borderRadius`, and `color`) with
different types (`double` and `Color`).
**The example begins with no animation code**&mdash;it starts with a [Material App]
home screen that contains:

- A shape with size, margin, and color that are different each time you run the
example.
- A **Change** button that does nothing when clicked.

Click the **Run** button to run the example:

<!-- Vanilla Animated Container: https://gist.github.com/8501583cb789504d75317a5ba1ca6930 -->
<iframe
  src="{{site.custom.dartpadx.embed-flutter-prefix}}?id=8501583cb789504d75317a5ba1ca6930"
  style="border: 1px solid lightgrey; margin-top: 10px; margin-bottom: 25px"
  frameborder="no" height="500" width="100%"
></iframe>

### Animate color, borderRadius, and margin with AnimatedContainer
{{site.alert.secondary}}
  This section contains a list of steps you can use to add an implicit animation to the
  preceding example code. After the steps, you can also run an example with the
  changes already made.
{{site.alert.end}}

In the preceding example, each property in the `Container` widget (`color`,
`borderRadius`, and `margin`) is assigned a value by an associated function (`randomColor()`,
`randomBorderRadius()`, and `randomMargin()` respectively). By using an `AniamtedContainer` widget, you can
refactor this code to do the following:

- Generate new values for `color`, `borderRadius`, and `margin` whenever the
user clicks the **Change** button.
- Animate the transition to the new values for `color`, `borderRadius`, and
`margin` whenever they are set.

**1.** First, refactor the `AnimatedContainerDemo` widget from a `StatelessWidget`
to a `StatefulWidget`, and add an accompanying `_AnimatedContainerDemoState` widget.
As part of the refactor, you can move assigning values for `color`, `borderRadius`,
and `margin` into the `State<AnimatedContainer>` widget's `initState()` method.

<?code-excerpt "container{0,1}/lib/main.dart"?>
```diff
--- container0/lib/main.dart
+++ container1/lib/main.dart
@@ -20,10 +20,21 @@
   return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
 }

-class AnimatedContainerDemo extends StatelessWidget {
-  Color color = randomColor();
-  double borderRadius = randomBorderRadius();
-  double margin = randomMargin();
+class AnimatedContainerDemo extends StatefulWidget {
+  _AnimatedContainerDemoState createState() => _AnimatedContainerDemoState();
+}
+
+class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
+  Color color;
+  double borderRadius;
+  double margin;
+
+  @override
+  initState() {
+    color = randomColor();
+    borderRadius = randomBorderRadius();
+    margin = randomMargin();
+  }

   @override
   Widget build(BuildContext context) {
```

**2.** Introduce an implicit animation by changing the `Container` widget to
an `AnimatedContainer` widget:

<?code-excerpt "container{1,2}/lib/main.dart"?>
```diff
--- container1/lib/main.dart
+++ container2/lib/main.dart
@@ -45,7 +45,7 @@
             SizedBox(
               width: 128,
               height: 128,
-              child: Container(
+              child: AnimatedContainer(
                 margin: EdgeInsets.all(margin),
                 decoration: BoxDecoration(
                   color: color,
```

**3.** `AnimatedContainer` automatically animates between old and new values of
its properties when they change. Create a `change()` method that defines the
behavior triggered when the user clicks the **Change** button. The `change()` method
can use `setState()` to set new values for the `color`, `borderRadius`, and
`margin` state variables:

<?code-excerpt "container{2,3}/lib/main.dart"?>
```diff
--- container2/lib/main.dart
+++ container3/lib/main.dart
@@ -36,6 +36,14 @@
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

**4.** Now invoke the `change()` method in the `onPressed()` handler:

<?code-excerpt "container{3,4}/lib/main.dart"?>
```diff
--- container3/lib/main.dart
+++ container4/lib/main.dart
@@ -67,7 +67,7 @@
                 'change',
                 style: TextStyle(color: Colors.white),
               ),
-              onPressed: () => null,
+              onPressed: () => change(),
             ),
           ],
         ),
```

**5.** Finally, set the duration of the animation that powers the transition
between the old and new values:
<?code-excerpt "container{4,5}/lib/main.dart"?>
```diff
--- container4/lib/main.dart
+++ container5/lib/main.dart
@@ -8,6 +8,8 @@
 import 'package:flutter_web_test/flutter_web_test.dart';
 import 'package:flutter_web_ui/ui.dart' as ui;

+const _duration = Duration(milliseconds: 400);
+
 double randomBorderRadius() {
   return Random().nextDouble() * 64;
 }
@@ -60,6 +62,7 @@
                   borderRadius: BorderRadius.circular(borderRadius),
                 ),
               ),
+              duration: _duration,
             ),
             MaterialButton(
               color: Theme.of(context).primaryColor,
```

Here’s the example with the completed changes you’ve made&mdash;run the code
and click the **Change** button to trigger the animation. Notice that, as you
subsequently click the **Change** button, the shape animates to its new values
for `margin`, `borderRadius`, and `color`.

<!-- Animated Container: https://gist.github.com/ddfbc68ec9dc28a48703d29248f5366f -->
<iframe
  src="{{site.custom.dartpadx.embed-flutter-prefix}}?id=ddfbc68ec9dc28a48703d29248f5366f"
  style="border: 1px solid lightgrey; margin-top: 10px; margin-bottom: 25px"
  frameborder="no" height="500" width="100%"
></iframe>

### Using animation curves

The preceding examples show how implicit animations allow you to set start and
end values for multiple animated properties, and how the `duration` parameter
allows you to set the amount of time the animation takes to complete. Implicit
animations also allow you to change __the rate__ of an animation within the
specified `duration`. The parameter you use to define this change in rate is [curve].

The preceding examples do not specify a `curve`, so the implicit animations
apply a [linear animation curve] by default. Add a `curve` parameter to the
preceding example and watch how the animation changes when you pass the
[easeInOutBack] constant for `curve`:

<?code-excerpt "container{5,6}/lib/main.dart"?>
```diff
--- container5/lib/main.dart
+++ container6/lib/main.dart
@@ -63,6 +63,7 @@
                 ),
               ),
               duration: _duration,
+              curve: Curves.easeInOutBack,
             ),
             MaterialButton(
               color: Theme.of(context).primaryColor,
```

Now that you have passed `easeInOutBack` as the value for `curve` to
`AnimatedContainer`, notice that the rates of change for `margin`, `borderRadius`,
and `color` follow the curve defined by the `easeInOutBack` curve:

![PlayButton](/images/play_button.svg){:#animation_1_play_button_}

<video id="animation_1" style="width:464px; height:192px;" onclick="if (this.paused) {
this.play();
animation_1_play_button_.style.display = 'none';
} else {
this.pause();
animation_1_play_button_.style.display = 'block';
}" loop="">
  <source src="https://flutter.github.io/assets-for-api-docs/assets/animation/curve_ease_in_out_back.mp4" type="video/mp4">
</video>

The `easeInOutBack` constant is only one of many that you can pass for the
`curve` parameter. Explore the [list of curve constants] to discover more ways
to use `curve` to modify the look and feel of your animations.

### Putting it all together

The preceding example animates transitions between values for
the container's `margin`, `borderRadius`, and `color` properties. Note that
`AnimatedContainer` animates changes to any of its properties, including those
you didn't use such as `padding`, `transform`, and even `child` and `alignment`!
The example builds upon the one before it by introducing some new
capabilities of implicit animations:

- Some implicit animations (for example, `AnimatedOpacity`) only animate a single
property, while others (like `AnimatedContainer`) can animate many properties.
- Implicit animations automatically animate between the old and new values of
properties when they change using the provided `curve` and `duration`.
- If you do not specify a `curve`, implicit animations default to a [linear curve].

## What's Next?

Congratulations, you've finished the codelab! If you'd like to learn more,
here are some suggestions for where to go next:
- Try the [animations tutorial]
- Learn about [hero animations] and [staggered animations]
- Checkout the [animations api docs]
- Try another [codelab]

[ImplicitlyAnimatedWidget]: {{site.api}}/flutter/widgets/ImplicitlyAnimatedWidget-class.html
[linear animation curve]: {{site.api}}/flutter/animation/Curves/linear-constant.html
[linear curve]: {{site.api}}/flutter/animation/Curves/linear-constant.html
[animations api docs]: {{site.master-api}}/flutter/animation/animation-library.html
[stateful widgets]: /docs/development/ui/interactive#stateful-and-stateless-widgets
[easeInOutBack]: {{site.api}}/flutter/animation/Curves/easeInOutBack-constant.html
[AnimatedContainer]: {{site.api}}/flutter/widgets/AnimatedContainer-class.html
[DartPad troubleshooting page]: {{site.dart-site}}/tools/dartpad/troubleshoot
[staggered animations]: /docs/development/ui/animations/staggered-animations
[list of curve constants]: {{site.api}}/flutter/animation/Curves-class.html
[AnimatedOpacity]: {{site.api}}/flutter/widgets/AnimatedOpacity-class.html
[make a Flutter app]: {{site.codelabs}}/codelabs/first-flutter-app-pt1/
[Material App]: {{site.api}}/flutter/material/MaterialApp-class.html
[hero animations]: /docs/development/ui/animations/hero-animations
[animations tutorial]: /docs/development/ui/animations/tutorial
[curve]: {{site.api}}/flutter/animation/Curve-class.html
[DartPad]: {{site.dartpad}}
[codelab]: /docs/codelabs
