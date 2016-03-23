---
layout: page
title: Build Flutter apps with animations
nav_title: Build Flutter apps with animations
permalink: /animations/
---

You can use animations to make the user experience on your mobile app feel more
intuitive, dynamic, and polished. Animations are especially useful when the
screen changes state, such as when content loads or when new actions become
available. This how-to guide shows some common ways you can add animation
effects to your apps using Flutter’s animation system.

* [Overview of the Flutter animation system](#overview-of-the-flutter-animation-system)
* [Rendering your animation](#rendering-your-animation)
* [Disposing your animation](#disposing-your-animation)

## Overview of the Flutter animation system

Flutter has two separate animation libraries:

  * <code>[flutter/animation](http://docs.flutter.io/flutter/animation/animation-library.html)</code>:
  Provides APIs to create animation effects in user interfaces (UIs) that are
built on the <code>[StatelessWidget](http://docs.flutter.io/flutter/material/StatelessWidget-class.html)</code>
and <code>[StatefulWidget](http://docs.flutter.io/flutter/widgets/StatefulWidget-class.html)</code>
classes.
  * <code>[flutter\_sprites/flutter\_sprites](http://docs.flutter.io/flutter_sprites/flutter_sprites/flutter_sprites-library.html)</code>:
  Provides APIs for game development.

The rest of this documentation covers how to use the APIs from the
<code>[flutter/animation](http://docs.flutter.io/flutter/animation/animation-library.html)</code>
library.

Animations in Flutter are encapsulated as
<code>[Animation](http://docs.flutter.io/flutter/animation/Animation-class.html)</code>
objects that contain these key properties:

  * <strong>Value</strong>: The animation object’s typed value represents a data point within a
  range (also called an <em>interpolation</em>). You can define an animation class to generate
  values based on a given functional mapping, such as a linear, curve, or step-wise function.
  * <strong>Status</strong>: The animation object’s current status (such as <em>forward</em>,
  <em>backward</em>, <em>completed</em>, and <em>dismissed</em>), as listed by the constants of
  the
  <code>[AnimationStatus](http://docs.flutter.io/flutter/material/AnimationStatus-class.html)</code>
  class.

Typically, the animation’s value and status changes over time as it runs. You
can attach an animation object to a widget or listen for changes to the
animation object. Based on changes to the animation object’s properties, the
framework can modify the way your widget appears and rebuild the widget tree to
produce visual transitions such as sliding, scaling, rotation, height or width
changes, and fading.

This flexible model allows you to define interpolations for spatial
positioning, color gradients, image scaling, and others. You can define your
own subclass of
<code>[Animation](http://docs.flutter.io/flutter/animation/Animation-class.html)</code>
or use an animation subclass that the framework provides.

### Controlling how animations run

This section briefly describes some of the common APIs you will use for
creating animation effects and controlling how they run.

#### [AnimationController](http://docs.flutter.io/flutter/material/AnimationController-class.html)

Use this class to specify how the animation should run. The
<code>[AnimationController](http://docs.flutter.io/flutter/material/AnimationController-class.html)</code>
class lets you define important characteristics of the animation, such as its
duration and playback direction (forward or reverse).

The following snippet shows how you might create an animation that runs for 500 milliseconds:


<pre class=prettyprint>
final AnimationController controller =
    new AnimationController(duration: const Duration(milliseconds: 500));
</pre>

#### [CurvedAnimation](http://docs.flutter.io/flutter/material/CurvedAnimation-class.html)

Use this class to apply a non-linear curve to an animation object it wraps. By
applying different curve types, you can visually modify the spatial movement
pattern for the wrapped animation object. The
<code>[Curves](http://docs.flutter.io/flutter/animation/Curves-class.html)</code> class lists the
available curve types, such as
<code>[bounceIn](http://docs.flutter.io/flutter/animation/Curves/bounceIn-constant.html)</code>,
<code>[easeOut](http://docs.flutter.io/flutter/animation/Curves/easeOut-constant.html)</code>, and
others.

The following snippet shows how you might create a curved animation object that
wraps a linear animation produced by an animation controller and applies the
<code>[easeIn](http://docs.flutter.io/flutter/animation/Curves/easeIn-constant.html)</code> curve
type to it.


<pre class=prettyprint>
final AnimationController controller =
    new AnimationController(duration: const Duration(milliseconds: 500));
final curve = new CurvedAnimation(
    parent: controller,
    curve: Curves.easeIn
);
</pre>

#### [Tween](http://docs.flutter.io/flutter/material/Tween-class.html)

This class represents a changing value between a range with a
<code>[begin](http://docs.flutter.io/flutter/material/Tween/begin.html)</code> and
<code>[end](http://docs.flutter.io/flutter/material/Tween/end.html)</code> value. To get the
interpolated value for a given animation, call the
<code>[evaluate()](http://docs.flutter.io/flutter/animation/Tween/evaluate.html)</code> method
on the <code>[Tween](http://docs.flutter.io/flutter/material/Tween-class.html)</code> object. You
can override the <code>[lerp()](http://docs.flutter.io/flutter/material/Tween/lerp.html)</code>
(or <em>linear interpolation</em>) method for the
<code>[Tween](http://docs.flutter.io/flutter/material/Tween-class.html)</code> object, which
returns a value based on a given animation clock time.

Use the subclasses of <code>[Tween](http://docs.flutter.io/flutter/material/Tween-class.html)</code>
to apply various types of interpolations to your animations (for example,
<code>[ColorTween](http://docs.flutter.io/flutter/material/ColorTween-class.html)</code> for
interpolation between colors,
<code>[SizeTween](http://docs.flutter.io/flutter/material/SizeTween-class.html)</code> for
interpolation between rectangle sizes, or
<code>[ThemeDataTween](http://docs.flutter.io/flutter/material/ThemeDataTween-class.html)</code>
for interpolation between
<code>[ThemeData](http://docs.flutter.io/flutter/material/ThemeData-class.html)</code> objects).

The following snippet shows how you might create a
<code>[Tween](http://docs.flutter.io/flutter/material/Tween-class.html)</code> object that
interpolates between the double values of -200.0 to 0.0.


<pre class=prettyprint>
final Tween doubleTween = new Tween&lt;double>(begin: -200.0, end: 0.0);
</pre>

You can also specify a progression between two colors. For example:


<pre class=prettyprint>
final Tween colorTween =
    new ColorTween(begin: Colors.transparent, end: Colors.black54);
</pre>

To apply a <code>[Tween](http://docs.flutter.io/flutter/material/Tween-class.html)</code> to a
given animation object, use the
<code>[animate()](http://docs.flutter.io/flutter/animation/Animatable/animate.html)</code> method
which returns a new
<code>[Animation](http://docs.flutter.io/flutter/animation/Animation-class.html)</code> instance.
For example, the following code snippet shows how you might create
an animation represented by integral values from 0 to 255, over a duration of
500 milliseconds, using linear interpolation.


<pre class=prettyprint>
final AnimationController animation =
    new AnimationController(duration: const Duration(milliseconds: 500));
Animation&lt;int> alpha = new IntTween(
  begin: 0,
  end: 255)
.animate(animation);
</pre>

## Rendering your animation

To render your widget with an animation, set one or more of the widget’s
members to the animation object, then use the animation’s value to decide how
to draw your object.

If you are animating a stateful widget, you can notify your widget of changes
to the animation’s values by using the
<code>[addListener()](http://docs.flutter.io/flutter/animation/Animation/addListener.html)</code>
method. The framework invokes the listener callback whenever the value of the
animation changes. Typically, you’ll want to call the
<code>[setState()](http://docs.flutter.io/flutter/material/State/setState.html)</code> method when
the animation value change occurs, to trigger the framework to
rebuild the widget tree.

The following code snippet shows how you might create a simple animation effect
to make an logo image appear to expand.


<pre class=prettyprint>
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
class LogoApp extends StatefulWidget {
  LogoAppState createState() => new LogoAppState();
}
class LogoAppState extends State&lt;LogoApp> {
  Animation&lt;double> animation;
  initState() {
    AnimationController controller = new AnimationController(
      duration: const Duration(milliseconds: 5000)
    );
    animation = new Tween(begin: 0.0, end: 200.0).animate(controller);
    animation.addListener(() {
      setState(() {
      // the state that has changed here is the animation object’s value
      });
    });
    controller.forward();
    super.initState();
  }
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new AssetImage(
          name: 'assets/flutter_logo.png',
          fit: ImageFit.contain
        )
      )
    );
  }
}
void main() {
  runApp(
    new MaterialApp(
      title: 'My Animation Test',
      routes: &lt;String, WidgetBuilder> {
        '/': (BuildContext context) => new LogoApp()
      }
    )
  );
}
</pre>

You can simplify the code snippet above further by using the
<code>[AnimatedWidget](http://docs.flutter.io/flutter/material/AnimatedWidget-class.html)</code>
class. This class hides the state object and listener you previously had to
implement to run the animation.


<pre class=prettyprint>
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
class LogoApp extends AnimatedWidget {
  LogoApp({Key key, Animation&lt;double> animation})
      : super(key: key, animation: animation);
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new AssetImage(
           name: 'assets/flutter_logo.png',
           fit: ImageFit.contain
        )
      )
    );
  }
}
void main() {
  final AnimationController controller = new AnimationController(
    duration: const Duration(milliseconds: 5000)
  );
  final animation = new Tween(
    begin: 0.0,
    end: 200.0)
  .animate(controller);
  runApp(
    new MaterialApp(
      title: 'My Animation Test',
      routes: &lt;String, WidgetBuilder> {
        '/': (BuildContext context) => new LogoApp(
          animation: animation
        )
      }
    )
  );
  controller.forward();
}
</pre>

For more complex animations involving additional state, consider using the
<code>[AnimatedBuilder](http://docs.flutter.io/flutter/material/AnimatedBuilder-class.html)</code>
class.

### Rendering animations that run simultaneously

The following example shows how you can apply two simultaneous animation
effects: one that controls the size of the widget and another that controls the
opacity to fade the widget in and out.

You can use
<code>[addStatusListener()](http://docs.flutter.io/flutter/animation/Animation/addStatusListener.html)</code>
method to notify your widget when the current status of an animation changes.
In this example, we use the status listener to switch the animation’s playback
between going forward or reverse.


<pre class=prettyprint>
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
class LogoApp extends AnimatedWidget {
  // Declare the Tween objects as static because we don't change them.
  static final _opacityTween = new Tween&lt;double>(begin: 1.0, end: 0.3);
  static final _sizeTween = new Tween&lt;double>(begin: 0.0, end: 300.0);
  LogoApp({Key key, Animation&lt;double> animation})
      : super(key: key, animation: animation);
  Widget build(BuildContext context) {
    return new Center(
      child: new Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: new Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: new AssetImage(
            name: 'assets/flutter_logo.png',
            fit: ImageFit.contain
          )
        )
      )
    );
  }
}
void main() {
  final AnimationController controller = new AnimationController(
    duration: const Duration(milliseconds: 5000)
  );
  final Animation&lt;double> animation =
      new CurvedAnimation(parent: controller, curve: Curves.bounceIn);
  animation.addStatusListener((status) {
    if (status == AnimationStatus.completed)
      controller.reverse();
    else if (status == AnimationStatus.dismissed)
      controller.forward();
  });
  runApp(
    new MaterialApp(
      title: 'My Animation Test',
      routes: &lt;String, WidgetBuilder> {
        '/': (BuildContext context) => new LogoApp(
          animation: animation
        )
      }
    )
  );
  controller.forward();
}
</pre>

## Disposing your animation

It’s good practice to dispose your animation controller and free up your
resources when they are no longer needed. To do so, call the
<code>[dispose()](http://docs.flutter.io/flutter/material/AnimationController/dispose.html)</code>
method on the <code>[AnimationController](http://docs.flutter.io/flutter/material/AnimationController-class.html)
</code>object for the animation object you want to free. This stops the animation from
running.

The following snippet shows how to call the animation controller’s
<code>[dispose()](http://docs.flutter.io/flutter/material/AnimationController/dispose.html)</code>
method from within a <code>[State](http://docs.flutter.io/flutter/material/State-class.html)</code>
object’s <code>[dispose()](http://docs.flutter.io/flutter/material/State/dispose.html)</code>
method implementation. The framework typically invokes the
<code>[State](http://docs.flutter.io/flutter/material/State-class.html)</code> object’s
<code>[dispose()](http://docs.flutter.io/flutter/material/State/dispose.html)</code> method when
switching between screens, as directed by the
<code>[routes](http://docs.flutter.io/flutter/material/MaterialApp/routes.html)</code> property.


<pre class=prettyprint>
class LogoAppState extends State&lt;LogoApp> {
  // Implementation code omitted for brevity.
  @override
  void dispose() {
     controller.dispose();
     super.dispose();
  }
}
</pre>