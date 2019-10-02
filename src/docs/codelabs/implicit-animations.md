---
title: "Implicit Animations"
description: "A codelab that uses interactive examples and exercises to teach concepts and use of Flutter's implicitly animated widgets."
toc: true
---

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
  This page uses an embedded version of DartPad to display examples and exercises.
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
<!-- <iframe 
  src="https://dartpad.dev/experimental/embed-new-flutter.html?id=d7b09149ffee2f0535bb0c04d96987f5"
  style="border: 1px solid lightgrey; margin-top: 10px; margin-bottom: 25px" 
  frameborder="no" height="500" width="100%"
></iframe> -->

Using the `AnimatedOpacity` widget, you can add the following functionality to this 
example:
- the owl's description text is hidden until the user clicks the
"show details"button.
- when the user clicks the "show details" button, the description text fades in.

**1.** First, refactor the `FadeIn` from a `StatelessWidget` to a `StatefulWidget`, 
and add an accompanying `_FadeInDemoState` widget. 

{% prettify flutter %}
    const owl_url =
    'https://raw.githubusercontent.com/flutter/website/master/src/images/owl.jpg';

[!class FadeInDemo extends StatefulWidget {
  _FadeInDemoState createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> {!]
  double opacityLevel = 0.0;

  Widget build(BuildContext context) {
    return Column(children: <Widget>[
{% endprettify %}



**2.** Second, change the `Container` widget to an `AnimatedOpacity` widget:

The first step: make a stateful widget.
The second step: track opacity in state.
The third step: set a duration.
Final step: button trigger the animation.

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


[DartPad troubleshooting page]: {{site.dart-site}}/tools/dartpad/troubleshoot
[make a Flutter app]: {{site.codelabs}}/codelabs/first-flutter-app-pt1/
[codelab]: {{site.codelabs}}/codelabs/flutter-firebase
[AnimatedOpacity]: {{site.api}}/flutter/widgets/AnimatedOpacity-class.html
[Material App]: {{site.api}}/flutter/material/MaterialApp-class.html
[ImplicitlyAnimatedWidget]: {{site.api}}/flutter/widgets/ImplicitlyAnimatedWidget-class.html