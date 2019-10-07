---
title: "Implicit Animations"
description: "A codelab that uses interactive examples and exercises to teach concepts and use of Flutter's implicitly animated widgets."
toc: true
diff2html: true
---


<?code-excerpt path-base="animation/implicit"?>

Welcome to the implicit animations codelab, where you learn how to use Flutter
widgets that make it easy to create animations for a specific set of properties.

To get the most out of this codelab, you should have basic knowledge about
how to [make a Flutter app][].

This codelab covers the following material:
- `AnimatedOpacity`
- `AnimatedContainer`
- `AnimatedIcon`

**Estimated time to complete this codelab: 20-30 minutes.**

{{site.alert.important}}
  This page uses an embedded version of [DartPad] to display examples and exercises.
  If you see empty boxes instead of DartPads, go to the
  [DartPad troubleshooting page].
{{site.alert.end}}

## What are implicit animations?

With Flutter's animation library, you can create motion and visual effects for
widgets in your UI. One part of the library is a collection of widgets that manage
animations for you – these widgets are collectively referred to as _implicit
animations_, or _implicitly animated widgets_, deriving their name from the
[ImplicitlyAnimatedWidget] class that they implement. Implicit animations trade
control for convenience: they implement animation effects so that you don't have to. 

### Example: AnimatedOpacity

The following example demonstrates how to add a fade-in effect to existing UI
using an implicitly animated widget called [AnimatedOpacity]. The example begins
with no animation – it consists of a [Material App] home screen containing:
- a photograph of an owl.
- one "show details" button that does nothing when clicked.
- description text of the owl in the photograph.

Run the example and render the following code:

<!-- https://gist.github.com/d7b09149ffee2f0535bb0c04d96987f5 -->
<iframe 
  src="https://dartpad.dev/experimental/embed-new-flutter.html?id=d7b09149ffee2f0535bb0c04d96987f5"
  style="border: 1px solid lightgrey; margin-top: 10px; margin-bottom: 25px" 
  frameborder="no" height="500" width="100%"
></iframe>

Using the `AnimatedOpacity` widget, you can add the following functionality to this 
example:
- the owl's description text is hidden until the user clicks the
"show details"button.
- when the user clicks the "show details" button, the description text fades in.

**1.** First, refactor the `FadeIn` from a `StatelessWidget` to a `StatefulWidget`, 
and add an accompanying `_FadeInDemoState` widget. 

<?code-excerpt "opacity{0,1}/lib/main.dart"?>
```diff
--- opacity0/lib/main.dart
+++ opacity1/lib/main.dart
@@ -5,7 +5,11 @@
 const owl_url =
     'https://raw.githubusercontent.com/flutter/website/master/src/images/owl.jpg';

-class FadeInDemo extends StatelessWidget {
+class FadeInDemo extends StatefulWidget {
+  _FadeInDemoState createState() => _FadeInDemoState();
+}
+
+class _FadeInDemoState extends State<FadeInDemo> {
   Widget build(BuildContext context) {
     return Column(children: <Widget>[
       Image.network(owl_url),
```


**2.** Change the `Container` widget to an `AnimatedOpacity` widget:

<?code-excerpt "opacity{1,2}/lib/main.dart"?>
```diff
--- opacity1/lib/main.dart
+++ opacity2/lib/main.dart
@@ -19,7 +19,7 @@
             style: TextStyle(color: Colors.blueAccent),
           ),
           onPressed: () => null),
-      Container(
+      AnimatedOpacity(
           child: Column(
             children: <Widget>[
               Text('Type: Owl'),
```

**3.** Create a state variable for the property that `AnimatedOpacity` is
on. As the name implies, `AnimatedOpacity` listens for changes in the `opacity`
property, and since you want the text to be hidden until clicked, you can set
the starting opacity value to zero:

<?code-excerpt "opacity{2,3}/lib/main.dart"?>
```diff
--- opacity2/lib/main.dart
+++ opacity3/lib/main.dart
@@ -10,6 +10,7 @@
 }

 class _FadeInDemoState extends State<FadeInDemo> {
+  double opacityLevel = 0.0;
   Widget build(BuildContext context) {
     return Column(children: <Widget>[
       Image.network(owl_url),
@@ -20,6 +21,7 @@
           ),
           onPressed: () => null),
       AnimatedOpacity(
+          opacity: opacity,
           child: Column(
             children: <Widget>[
               Text('Type: Owl'),
```

**4.** In addition to an opacity parameter, `AnimatedOpacity` requires a
duration to use for its animation. For this example, you can start with 2 seconds:

<?code-excerpt "opacity{3,4}/lib/main.dart"?>
```diff
--- opacity3/lib/main.dart
+++ opacity4/lib/main.dart
@@ -21,6 +21,7 @@
           ),
           onPressed: () => null),
       AnimatedOpacity(
+          duration: Duration(seconds: 2),
           opacity: opacity,
           child: Column(
             children: <Widget>[
```

**5.** Finally, you can set the animation to trigger when the user clicks the 
"show details" button. To do this, trigger a state change in opacity within  
the button's `onPressed` handler:

<?code-excerpt "opacity{4,5}/lib/main.dart"?>
```diff
--- opacity4/lib/main.dart
+++ opacity5/lib/main.dart
@@ -19,10 +19,12 @@
             'Show Details',
             style: TextStyle(color: Colors.blueAccent),
           ),
-          onPressed: () => null),
+          onPressed: () => setState((){
+            opacityLevel = 1;
+          })),
       AnimatedOpacity(
           duration: Duration(seconds: 2),
-          opacity: opacity,
+          opacity: opacityLevel,
           child: Column(
             children: <Widget>[
               Text('Type: Owl'),
```

Notice that you only need to set the beginning and ending value of `opacity` – 
`AnimatedOpacity` widget takes care of everything in between.

Here's the example with the completed changes you've just made -- run this 
example and click on the "Show Details" button to trigger the animation.

<!-- https://gist.github.com/4207fea3975b2d329e81d9c9ba84d271 -->
<iframe 
  src="https://dartpad.dev/experimental/embed-new-flutter.html?id=4207fea3975b2d329e81d9c9ba84d271"
  style="border: 1px solid lightgrey; margin-top: 10px; margin-bottom: 25px" 
  frameborder="no" height="500" width="100%"
></iframe>

<!-- <?code-excerpt "opacity{9,10}/lib/main.dart"?>
```diff
--- opacity9/lib/main.dart
+++ opacity10/lib/main.dart
@@ -1,9 +1,16 @@
 import 'package:flutter_web/material.dart';
 import 'package:flutter_web_test/flutter_web_test.dart';
 import 'package:flutter_web_ui/ui.dart' as ui;
+
 const owl_url = 'https://raw.githubusercontent.com/flutter/website/master/src/images/owl.jpg';

-class FadeInDemo extends StatelessWidget {
+class FadeInDemo extends StatefulWidget {
+  _FadeInDemoState createState() => _FadeInDemoState();
+}
+
+class _FadeInDemoState extends State<FadeInDemo> {
+  double opacityLevel = 0.0;
+
   Widget build(BuildContext context) {
     return Column(children: <Widget>[
       Image.network(owl_url),
@@ -12,15 +19,19 @@
             'Show Details',
             style: TextStyle(color: Colors.blueAccent),
           ),
-          onPressed: () => null),
-      Container(
+          onPressed: () => setState(() {
+                opacityLevel = 1.0;
+              })),
+      AnimatedOpacity(
+          duration: Duration(seconds: 3),
+          opacity: opacityLevel,
           child: Column(
-        children: <Widget>[
-          Text('Type: Owl'),
-          Text('Age: 39'),
-          Text('Employment: None'),
-        ],
-      ))
+            children: <Widget>[
+              Text('Type: Owl'),
+              Text('Age: 39'),
+              Text('Employment: None'),
+            ],
+          ))
     ]);
   }
 }
``` -->



<!-- https://gist.github.com/4207fea3975b2d329e81d9c9ba84d271 -->
<!-- <iframe 
  src="https://dartpad.dev/experimental/embed-new-flutter.html?id=4207fea3975b2d329e81d9c9ba84d271"
  style="border: 1px solid lightgrey; margin-top: 10px; margin-bottom: 25px" 
  frameborder="no" height="1000" width="100%"
></iframe> -->


## Example: AnimatedContainer

<!-- <iframe 
  src="https://dartpad.dev/experimental/embed-new-flutter.html?id=8501583cb789504d75317a5ba1ca6930"
  style="border: 1px solid lightgrey; margin-top: 10px; margin-bottom: 25px" 
  frameborder="no" height="2000" width="100%"
></iframe> -->


## Example: AnimatedIcon

<!-- <iframe 
  src="https://dartpad.dev/experimental/embed-new-flutter.html?id=be69484e17c26ab9298aecdfa51b11eb"
  style="border: 1px solid lightgrey; margin-top: 10px; margin-bottom: 25px" 
  frameborder="no" height="2000" width="100%"
></iframe> -->


[DartPad]: {{site.dartpad}}
[DartPad troubleshooting page]: {{site.dart-site}}/tools/dartpad/troubleshoot
[make a Flutter app]: {{site.codelabs}}/codelabs/first-flutter-app-pt1/
[codelab]: {{site.codelabs}}/codelabs/flutter-firebase
[AnimatedOpacity]: {{site.api}}/flutter/widgets/AnimatedOpacity-class.html
[Material App]: {{site.api}}/flutter/material/MaterialApp-class.html
[ImplicitlyAnimatedWidget]: {{site.api}}/flutter/widgets/ImplicitlyAnimatedWidget-class.html