---
title: "When should I useAnimatedBuilder or AnimatedWidget?"
description: >-
  We know you have many choices when you fly, I mean animate, in Flutter,
  so thank you for choosing AnimatedBuilder and AnimatedWidget.
publishDate: 2020-01-19
author: efortuna
image: images/1BdRzZMnfFtwe0Wn1dxWp4g.gif
category: tutorial
layout: blog
---

We know you have many choices when you fly, I mean animate, in Flutter, so thank you for choosing `AnimatedBuilder` and `AnimatedWidget`. Wait, what? No! Flutter has many different animation widgets, but unlike commercial airlines, each type of widget is right for a different type of job. Sure, you can accomplish the same animation in a couple of different ways, but using the right animation widget for the job will make your life much easier.

This article covers why you might want to use `AnimatedBuilder` or `AnimatedWidget` versus other animation widgets, and how to use them. Suppose you want to add an animation to your app. This article is [part](https://medium.com/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916) [of](https://medium.com/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185) [a](https://medium.com/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7) series, walking through why you might want to use each type of animation widget. The particular animation you want to do repeats a couple of times or needs to be able to pause and resume in response to something, like a finger tap. Because your animation needs to repeat, or stop and start, you’ll need to use an *explicit* animation.

As a reminder, we have two broad categories of animations in Flutter: explicit and implicit. For explicit animations, you need an animation controller. For implicit animations, you don’t. We introduced animation controllers in the previous article about built-in explicit animations. If you’d like to learn more about those, please check that out first.

So, if you’ve determined that you need an explicit animation, there are a whole host of explicit animation classes for you to choose from. Those are the classes generally named `FooTransition`, where *Foo* is the name of the property you are trying to animate. I recommend seeing if you can use one of those widgets to accomplish your needs first, *before* diving into the deep world of `AnimatedWidget` and `AnimatedBuilder`. There’s an amazing selection of widgets for pretty much anything you can think of — rotation, position, alignment, fading, text style, and many more. Plus, you can compose these widgets, so that you can rotate *and* fade. But, if none of those built-in widgets can do what you’re looking for, it’s time to build your own using `AnimatedWidget` or `AnimatedBuilder`.

<DashImage figure src="images/1nXKMdHu2YNqZmrGClWlDZw.webp" alt="A flow chart for understanding what animation to use in any scenario. This article focuses on the two bottom blue end-states, AnimatedBuilder and AnimatedWidget." caption="A flow chart for understanding what animation to use in any scenario. This article focuses on the two bottom blue end-states, AnimatedBuilder and AnimatedWidget." />

## Specific Example

To make this more concrete, let’s walk through a specific scenario: I want to write an app with an alien spaceship and have a spaceship beam animation.

<DashImage figure src="images/1BdRzZMnfFtwe0Wn1dxWp4g.gif" alt="Maybe something exactly like this." caption="Maybe something exactly like this." />

I drew a spaceship beam with a gradient that fades from yellow to transparent, beginning the fade at the very center of the gradient. Then, I created the “beam” shape from that gradient with a path clipper.

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: MyHomePage(),
    ));
  }
}

class MyHomePage extends StatelessWidget {
  final Image starsBackground = Image.asset(
    'assets/milky-way.jpg',
  );
  final Image ufo = Image.asset('assets/ufo.png');
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        starsBackground,
        ClipPath(
          clipper: const BeamClipper(),
          child: Container(
            height: 1000,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 1.5,
                colors: [
                  Colors.yellow,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        ufo,
      ],
    );
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}

```

I want to create a “beam down” animation, starting from the center of that gradient, and I want to make it repeat. That means I’ll need to create an explicit animation. Unfortunately there’s no built-in explicit animation to animate funnel-shaped gradients, but you know what we do have… `AnimatedWidget` and `AnimatedBuilder` to do the trick!

## AnimatedBuilder

To make the beam animate, I am going to wrap this gradient code in an `AnimatedBuilder` widget. The gradient code goes in the builder function, which gets called when the `AnimatedBuilder` builds.

Next I need to add a controller to drive this animation. The controller provides the values that `AnimatedBuilder` uses to draw new versions of the animation frame by frame. As you saw in the previous article, I mix in the `SingleTickerProviderStateMixin` class and instantiate the controller in the `initState` function so that it only gets created once. I create the controller in `initState`, rather than the `build` method, because I don’t want to create this controller multiple times — I want it to provide new values to animate with for each frame! Because I created a new object in `initState`, I add a dispose method and tell Flutter that it can get rid of that controller when the parent widget is no longer on the screen.

Then, I pass that controller to the `AnimatedBuilder`, and my animation runs as expected!

```dart
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final Image starsBackground = Image.asset(
    'assets/milky-way.jpg',
  );
  final Image ufo = Image.asset('assets/ufo.png');
  AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        starsBackground,
        AnimatedBuilder(
          animation: _animation,
          builder: (_, __) {
            return ClipPath(
              clipper: const BeamClipper(),
              child: Container(
                height: 1000,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 1.5,
                    colors: [
                      Colors.yellow,
                      Colors.transparent,
                    ],
                    stops: [0, _animation.value],
                  ),
                ),
              ),
            );
          },
        ),
        ufo,
      ],
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

class BeamClipper extends CustomClipper<Path> {
  const BeamClipper();

  @override
  getClip(Size size) {
    return Path()
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height / 2)
      ..close();
  }

  /// Return false always because we always clip the same area.
  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
```

You may recall in the [`TweenAnimationBuilder` article](https://medium.com/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185) that we used the child parameter as a performance optimization, and we can do that with `AnimatedBuilder` too. Basically, if we have an object that never changes over the course of the animation, we can build it ahead of time, and just pass it to `AnimatedBuilder`.

In this specific case, a *better* way to accomplish the same thing is to give `BeamClipper` a `const` constructor and just make it `const`. It’s less code, and the object is created at compile time, making things even faster. Sometimes, though, you’ll be coding something that doesn’t have a const constructor, and that’s a good case for when to make use of that optional child parameter.

## AnimatedWidget

So, we have our animation, but the build method that contains the `AnimatedBuilder` code is a little large. If your build method is starting to get hard to read, it’s time to refactor your code!

You could pull your `AnimatedBuilder` code out into a separate widget, but then you just have a build method inside a build method, which is a little silly. Instead, you can accomplish the same animation by creating a new widget that extends `AnimatedWidget`. I’ll name my widget `BeamTransition` to be consistent with the *FooTransition* naming convention for explicit animations. I pass in the animation controller to `BeamTransition` and reuse the body of the `AnimatedBuilder's` builder function.

```dart
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final Image starsBackground = Image.asset(
    'assets/milky-way.jpg',
  );
  final Image ufo = Image.asset('assets/ufo.png');
  AnimationController _animation;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        starsBackground,
        BeamTransition(animation: _animation),
        ufo,
      ],
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}

class BeamTransition extends AnimatedWidget {
  BeamTransition({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return ClipPath(
      clipper: const BeamClipper(),
      child: Container(
        height: 1000,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.5,
            colors: [
              Colors.yellow,
              Colors.transparent,
            ],
            stops: [0, animation.value],
          ),
        ),
      ),
    );
  }
}
```

Just like `AnimatedBuilder`, if appropriate, I can add a child parameter to my widget as a performance optimization so that it builds ahead of time, instead of every time I animate. Just a reminder though, in this example, making my `BeamClipper` take a `const` constructor is the best way to go.

## So really, which one should I to use?

We just saw how `AnimatedBuilder` and `AnimatedWidget` can both be used to accomplish the same type of explicit animations when you can’t find a built-in explicit animation to do what you want. So, which one should you use? It’s really a matter of taste. Generally speaking, I recommend making individual widgets, each with a separate job — which in this case is animation.

That’s a vote in favor of using `AnimatedWidget` whenever possible. However, if your parent widget that creates the animation controller is pretty simple, maybe making a separate standalone widget just for your animation is too much extra code. In that case, `AnimatedBuilder` is all that you need.

This is an article version of the video below. If you prefer videos, click below:

<YoutubeEmbed id="fneC7t4R_B0" title="Creating custom explicit animations with AnimatedBuilder & AnimatedWidget - Flutter in Focus" fullwidth="true"/>

Articles in this series:

* [How to Choose Which Flutter Animation Widget is Right for You?](https://medium.com/p/79ecfb7e72b5/edit)

* [Flutter animation basics with implicit animations](https://medium.com/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916)

* [Custom Implicit Animations in Flutter…with TweenAnimationBuilder](https://medium.com/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185)

* [Directional animations with built-in explicit animations](https://medium.com/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7)

* [When should I useAnimatedBuilder or AnimatedWidget?](https://medium.com/flutter/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8) (this article)

* [Animation deep dive](https://medium.com/flutter/animation-deep-dive-39d3ffea111f)
