---
title: "Flutter animation basics with implicit animations"
description: "In this series of posts, we’re going to introduce you to animations in Flutter, and show you how to build both simple and complex…"
publishDate: 2019-12-04
author: theaflowers
image: images/08lW_z0nxESDIBO9R.gif
category: tutorial
layout: blog
---

In this series of posts, we’re going to introduce you to animations in Flutter, and show you how to build both simple and complex animations for your Flutter app.

*This post is also available as a [video](https://www.youtube.com/watch?v=IVTjpW3W33s), if you prefer.*

In this first post, we’re going to focus on the most straightforward way to add animations to your app. You don’t have to be an expert on animations or animation terminology to add animations to your app. Along the way, we’ll introduce some widgets and terminology that will help you get started with animations right away and give you some background for the rest of the posts in the series.

## Implicitly animated widgets

Flutter includes a series of widgets that are animated versions of existing widgets that you probably already used in your app, such as the [AnimatedContainer](https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html) version of the [Container](https://api.flutter.dev/flutter/widgets/Container-class.html) widget and the [AnimatedPositioned](https://api.flutter.dev/flutter/widgets/AnimatedPositioned-class.html) version of the [Positioned](https://api.flutter.dev/flutter/widgets/Positioned-class.html) widget.

These widgets automatically animate changes to their properties. When you rebuild the widget with new property values, such as with a [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)’s `setState`, the widget handles driving the animation from the previous value to the new value.

<DashImage figure src="images/08lW_z0nxESDIBO9R.gif" alt="A screen recording where the code for an app is modified and the application animates the size of a star widget." caption="A screen recording where the code for an app is modified and the application animates the size of a star widget." />


These widgets are called [Implicitly Animated Widgets](https://api.flutter.dev/flutter/widgets/ImplicitlyAnimatedWidget-class.html). They are typically the first thing you reach for when you need to add animations to your app. They provide a way to add animations without adding additional complexity.

## The AnimatedContainer widget

Let’s look a little closer at how you can use one of these implicitly animated widgets to add some animation to your app.

In this app, there is a container and a button. When the button is pressed, `setState` is called, and the container is rebuilt with a new value for `width`. Notice that the container changes its width immediately, without any animation.

<DashImage figure src="images/0TRpN2WHDqNJtk7vI.gif" alt="The star gets bigger instantly, with no animation between its states." caption="The star gets bigger instantly, with no animation between its states." />


```dart
@override
Widget build(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: _bigger ? 100 : 500,
        child: Image.asset('assets/star.png'),
      ),
      RaisedButton(
        onPressed: () => setState(() {
          _bigger = !_bigger;
        }),
        child: Icon(Icons.star),
      ),
    ],
  );
}
```


We can add some animation to this app by switching the Container widget for an AnimatedContainer widget and specifying an animation duration.

```dart
AnimatedContainer(
  width: _bigger ? 100 : 500,
  child: Image.asset('assets/star.png'),
  duration: Duration(seconds: 1),
),
```


Now, when the button is pressed, the container gradually animates from the previous width value to the new value.

<DashImage figure src="images/0VdFcZ_eCsnJnJXb-.webp" alt="The star now animates between its states" caption="The star now animates between its states" />


The process of animating through the values between the old and new value is called [interpolation](https://en.wikipedia.org/wiki/Interpolation). The AnimatedContainer handles interpolating its properties between the old and the new values whenever they change.

This applies to all of the AnimatedContainer’s properties, including, for example, the [decoration](https://api.flutter.dev/flutter/widgets/AnimatedContainer/decoration.html). We can modify the gradient within a decoration and the AnimatedContainer handles interpolating between the old and new gradient:

```dart
AnimatedContainer(
  decoration: BoxDecoration(
    gradient: RadialGradient(
      colors: [Colors.purple, Colors.transparent],
      stops: [ _bigger ? 0.2 : 0.5, 1.0])
  ),
),
```


<DashImage figure src="images/0k-sSbKs-rCvbxB1a.webp" alt="The star now has an animated gradient" caption="The star now has an animated gradient" />


## Controlling the animation with duration and curves

Implicitly animated widgets like AnimatedContainer have two properties that you can use to control the animation’s behavior. You can control how long it takes to interpolate to the new value by setting the [duration](https://api.flutter.dev/flutter/widgets/ImplicitlyAnimatedWidget/duration.html) property.

```dart
AnimatedContainer(
  width: _bigger ? 100 : 500,
  child: Image.asset('assets/star.png'),
  duration: Duration(seconds: 5),
),
```


<DashImage figure src="images/0wGVszwaj9kdJlOsS.webp" />


<DashImage figure src="images/01g6d0g2ruUw0ZNBb.webp" alt="Faster on the left, slower on the right" caption="Faster on the left, slower on the right" />


In this example, we made the animation take a much longer amount of time.

You can also control the way the widget interpolates from the old to the new value by using a [Curve](https://api.flutter.dev/flutter/animation/Curve-class.html). Curves control the rate of change over time and can help your animations feel more realistic. In this example, we changed the curve from the default linear curve to a more exaggerated quintic curve:

```dart
AnimatedContainer(
  width: _bigger ? 100 : 500,
  child: Image.asset('assets/star.png'),
  duration: Duration(seconds: 1),
  curve: Curves.easeInOutQuint,
),
```


<DashImage figure src="images/0UySYHB5By2kX9P_6.webp" />


<DashImage figure src="images/0_8Ynon8NQu4zB3B7.webp" alt="Linear on the left, quintic on the right" caption="Linear on the left, quintic on the right" />


There are many different [built-in Curves](https://api.flutter.dev/flutter/animation/Curves-class.html) available to give your animations a bit of character, and you can also define your own custom curves. Curves can even be discontinuous, like the [SawTooth](https://api.flutter.dev/flutter/animation/SawTooth-class.html) curve.

Here’s an example of a custom curve called SineCurve that uses the sine function to make a curve that bounces:

```dart
class SineCurve extends Curve {
  final double count;

  SineCurve({this.count = 1});

  @override
  double transformInternal(double t) {
    return sin(count * 2 * pi * t) * 0.5 + 0.5;
  }
}
```


Here, SineCurve makes the star bounce up and down:

<DashImage figure src="images/0eouqer3J3CQE-fO4.webp" alt="Now that is a happy star" caption="Now that is a happy star" />


## To recap

Flutter provides implicitly animated widgets that are animated versions of common widgets. You can control the way these widgets animate using durations and curves.

AnimatedContainer is one notably powerful implicitly animated widget because it has many properties that affect its appearance, and all of them are automatically interpolated.

All of the other implicitly animated widgets are also powerful, easy-to-use options for adding animations without adding a lot of complexity.

Also, you don’t necessarily need to place these widgets into a StatefulWidget and use setState, you can use [StreamBuilder](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html) and [FutureBuilder](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html) to trigger animations like in [this example](https://gist.github.com/theacodes/98255cd57845731449582e12b132ed6d).

## Digging deeper into animations

Implicitly animated widgets are your first choice for adding animations, however, this isn’t all that Flutter’s animation system has to offer. In the rest of this series, we explore the lower layers of the Flutter animation system, and show you how you can build advanced animations by using the animation system directly.

For everything else, visit [flutter.dev](https://flutter.dev).

Articles in this series:

* [How to Choose Which Flutter Animation Widget is Right for You?](https://medium.com/p/79ecfb7e72b5/edit)

* [Flutter animation basics with implicit animations](https://medium.com/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916) (this article)

* [Custom Implicit Animations in Flutter…with TweenAnimationBuilder](https://medium.com/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185)

* [Directional animations with built-in explicit animations](https://medium.com/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7)

* [When should I useAnimatedBuilder or AnimatedWidget?](https://medium.com/flutter/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8)

* [Animation deep dive](https://medium.com/flutter/animation-deep-dive-39d3ffea111f)
