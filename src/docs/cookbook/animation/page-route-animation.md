---
title: Animate a page route transition
next:
  title: Animate the properties of a container
  path: /docs/cookbook/animation/animated-container
---

# Animate a page route transition

A design language, such as Material, defines standard behaviors when
transitioning between routes (or screens). Sometimes, though, a custom
transition between screens can make an app more unique. To help,
[PageRouteBuilder]({{site.api}}/flutter/widgets/PageRouteBuilder-class.html)
provides an
[Animation]({{site.api}}/flutter/animation/Animation-class.html)
object. This `Animation` can be used with
[Tween]({{site.api}}/flutter/animation/Tween-class.html) and
[Curve]({{site.api}}/flutter/animation/Curve-class.html) objects to
customize the transition animation. This recipe shows how to transition between
routes by animating the new route into view from the bottom of the screen.

To create a custom page route transition, this recipe uses the following steps:

1. Set up a PageRouteBuilder
2. Create a `Tween`
3. Add an `AnimatedWidget`
4. Use a `CurveTween`
5. Combine the two `Tween`s

# 1. Set up a PageRouteBuilder

To start, use a
[PageRouteBuilder]({{site.api}}/flutter/widgets/PageRouteBuilder-class.html)
to create a [Route]({{site.api}}/flutter/widgets/Route-class.html).
`PageRouteBuilder` has two callbacks, one to build the content of the route
(`pageBuilder`), and one to build the route's transition (`transitionsBuilder`).

{{site.alert.note}}
The `child` parameter in transitionsBuilder is the widget returned from
pageBuilder. The `pageBuilder` function is only called the first time the route
is built. The framework can avoid extra work because `child` stays the same
throughout the transition.
{{site.alert.end}}

The following example creates two routes: a home route with a "Go!" button, and
a second route titled "Page 2".

```dart
import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    home: Page1(),
  ));
}

class Page1 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          child: Text('Go!'),
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class Page2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Page 2'),
      ),
    );
  }
}
```

# 2. Create a Tween

To make the new page animate in from the bottom, it should animate from
`Offset(0,1)` to `Offset(0, 0)` (usually defined using the `Offset.zero`
constructor). In this case, the Offset is a 2D vector for the
[FractionalTranslation]({{site.api}}/flutter/widgets/FractionalTranslation-class.html)
widget. Setting the `dy` argument to 1 represents a vertical translation one
full height of the page.

The `transitionsBuilder` callback has an `animation` parameter. It's an
`Animation<double>` that produces values between 0 and 1. Convert the
Animation<double> into an Animation<Offset> using a Tween:

```dart
transitionsBuilder: (context, animation, secondaryAnimation, child) {
  var begin = Offset(0.0, 1.0);
  var end = Offset.zero;
  var tween = Tween(begin: begin, end: end);
  var offsetAnimation = animation.drive(tween);
  return child;
},
```

# 3. Use an AnimatedWidget

Flutter has a set of widgets extending
[AnimatedWidget]({{site.api}}/flutter/widgets/AnimatedWidget-class.html)
that rebuild themselves when the value of the animation changes. For instance,
SlideTransition takes an `Animation<Offset>` and translates its child (using a
FractionalTranslation widget) whenever the value of the animation changes.

AnimatedWidget Return a
[SlideTransition]({{site.api}}/flutter/widgets/SlideTransition-class.html)
with the `Animation<Offset>` and the child widget:

```dart
transitionsBuilder: (context, animation, secondaryAnimation, child) {
  var begin = Offset(0.0, 1.0);
  var end = Offset.zero;
  var tween = Tween(begin: begin, end: end);
  var offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
},
```

# 4. Use a CurveTween

Flutter provides a selection of easing curves that adjust the rate of the
animation over time. The
[Curves]({{site.api}}/flutter/animation/Curves-class.html) class
provides a predefined set of commonly used curves. For example, `Curves.easeOut`
will make the animation start quickly and end slowly.

To use a Curve, create a new
[CurveTween]({{site.api}}/flutter/animation/CurveTween-class.html)
and pass it a Curve:

```dart
var curve = Curves.ease;
var curveTween = CurveTween(curve: curve);
```

This new Tween still produces values from 0 to 1. In the next step, it will be
combined the `Tween<Offset>` from step 2.

# 5. Combine the two Tweens

To combine the tweens, use
[chain()]({{site.api}}/flutter/animation/Animatable/chain.html):

```dart
var begin = Offset(0.0, 1.0);
var end = Offset.zero;
var curve = Curves.ease;

var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
```

Then use this tween by passing it to `animation.drive()`. This creates a new
`Animation<Offset>` that can be given to the `SlideTransition` widget:

```dart
return SlideTransition(
  position: animation.drive(tween),
  child: child,
);
```

This new Tween (or Animatable) produces `Offset` values by first evaluating the
`CurveTween`, then evaluating the `Tween<Offset>.` When the animation runs, the
values are computed in this order:

1. The animation (provided to the transitionsBuilder callback) produces values
   from 0 to 1.
2. The CurveTween maps those values to new values between 0 and 1 based on its
   curve.
3. The `Tween<Offset>` maps the `double` values to `Offset` values.

Another way to create an `Animation<Offset>` with an easing curve is to use a
`CurvedAnimation`:

```dart
transitionsBuilder: (context, animation, secondaryAnimation, child) {
  var begin = Offset(0.0, 1.0); 
  var end = Offset.zero;
  var curve = Curves.ease;
  
  var tween = Tween(begin: begin, end: end);
  var curvedAnimation = CurvedAnimation(
   parent: animation,
   curve: curve,
  );

  return SlideTransition(
   position: tween.animate(curvedAnimation),
   child: child,
  );
}
```

# Complete Example

```dart
import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    home: Page1(),
  ));
}

class Page1 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          child: Text('Go!'),
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class Page2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Page 2'),
      ),
    );
  }
}
```

![Demo showing a custom page route transition animating up from the bottom of the screen](/images/cookbook/page-route-animation.gif){:.site-mobile-screenshot}
