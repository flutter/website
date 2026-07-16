---
title: "Custom Implicit Animations in Flutter…with TweenAnimationBuilder"
description: "To make animations in Flutter, there are many different options available. How do you choose the right animation widget? This article…"
publishDate: 2019-12-15
author: efortuna
image: images/1ZiMTAgg11y3BHH24bTt6Mg.gif
category: tutorial
layout: blog
---

To make animations in Flutter, there are many different options available. How do you choose the right animation widget? This article, [part](https://medium.com/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916) of [our](https://medium.com/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7) animation series, delves into the best use cases for `TweenAnimationBuilder` versus when a different widget is best for the job. The previous article in this series explains just how powerful all the built-in implicit animation widgets are and how much you can accomplish with them.

<DashImage figure src="images/11wJWHHPYfOYUCDBAcmIpjg.webp" alt="A flow chart for understanding what animation to use in any scenario. This article focuses on the second-from-the-right “end state”, TweenAnimationBuilder." caption="A flow chart for understanding what animation to use in any scenario. This article focuses on the second-from-the-right “end state”, TweenAnimationBuilder." />


Why use `TweenAnimationBuilder`? Suppose you want to create a *basic* animation: an animation that *doesn’t* repeat forever and is just one widget or widget tree. Flutter has a convention of naming its implicitly animated widgets `AnimatedFoo`, where `Foo` is the name of the property that animates. Don’t believe me? Here’s a sample of built-in, implicitly animated widgets: `AnimatedContainer`, `AnimatedCrossFade`, `AnimatedDefaultTextStyle`, `AnimatedModalBarrier`, `AnimatedOpacity`, `AnimatedPadding`, `AnimatedPhysicalModel`, `AnimatedPositioned`, `AnimatedPositionedDirectional`, `AnimatedSwitcher`. This set of widgets is impressively powerful, and you can accomplish a lot of your needs just using those. `AnimatedContainer` can even let you animate gradients and rotate widgets, all without needing to worry about an `AnimationController`!

However, if you need to create a basic animation and none of those built-in implicit animations are what you’re looking for, you can still create that animation with `TweenAnimationBuilder`!

## The basics

To use `TweenAnimationBuilder`, I set the length of time that I want my animation to take with the duration parameter, and the range of values that I want it to animate between with the…`Tween` parameter. As the name suggests, a `Tween` object enables you to specify a range of values that you want to animate *be**tween***.

The last thing I need to specify is the builder parameter, which returns what my animated widget will look like at a given moment in time. This builder function takes a parameter that is the same type as your `Tween` values, which basically tells Flutter what the current animation value is at a given moment.

```dart
/// This is an EXTREMELY bare-bones illustration of using TweenAnimationBuilder.
/// See the rest of the article for optimizations. 
/// Also note that this example is for illusration use only -- an implicit rotation
/// animation can be accomplished with AnimatedContainer.
class SuperBasic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        starsBackground,
        Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 2 * math.pi),
            duration: Duration(seconds: 2),
            builder: (BuildContext context, double angle, Widget child) {
              return Transform.rotate(
                angle: angle,
                child: Image.asset('assets/Earth.png'),
              );
            },
          ),
        ),
      ],
    );
  }
}
```

## TweenAnimationBuilder in depth

The example code above showed the bare-minimum set of arguments necessary to use `TweenAnimationBuilder`, but there is a lot more this widget has to offer! For illustration purposes, I created an app for an extremely common use case: illustration of the Doppler effect in space. Okay, it’s a silly use case, but you might want to apply a color filter to an image and animate the changing colors…which is exactly what we’ll be doing in this scenario.

In the Doppler effect, when a star moves away from you in space, the waves of light elongate, making the light shift closer to the red end of the spectrum. This effect is very subtle and not visible to the naked eye, but astronomers use it to determine the velocity of stars and galaxies relative to us.

<DashImage figure src="images/11-TXNn5MMPC7MDr4OZd-EA.webp" alt="Consult your local astrophysicist for more details." caption="Consult your local astrophysicist for more details." />


In our app we’re going to make this a little less subtle. I have a nice image of a star, and to change its color, I’m going to use the `ColorFiltered` widget. I apply a blend mode, and tell it to blend orange into the image to make it a little more reddish.

```dart
ColorFiltered(
  child: Image.asset('assets/sun.png'),
  colorFilter: ColorFilter.mode(color, BlendMode.modulate),
)
```


Next step…animation! There isn’t a built-in widget that applies an arbitrary color filter to a widget, but we can build one ourselves with `TweenAnimationBuilder`. To change the color over time, we want to modify the color that we’re applying to the filter. So that’s the value that we’ll animate. We’ll put the `ColorFiltered` widget inside the builder function of the `TweenAnimationBuilder`. As I mentioned before, a `Tween` is just the range of values that we are animating between. In this case, we’ll use a `ColorTween` to animate between white, which is as if we had no filter, and orange. And there you have it! A nicely animated color filter in 10 lines of code.

```dart
TweenAnimationBuilder(
  tween: ColorTween(begin: Colors.white, end: Colors.red),
  duration: Duration(seconds: 2),
  builder: (_, Color color, __) {
    return ColorFiltered(
      child: Image.asset('assets/sun.png'),
      colorFilter: ColorFilter.mode(color, BlendMode.modulate),
    );
  },
)
```


<DashImage figure src="images/1_JRebndf4uwMwxVzyNunYg.webp" />


Depending on *what* you want to animate though, your `Tween` can specify ranges between things other than colors or numbers. You can have a `Tween` with `Offset` objects to animate the change of a widget’s position, or you can even animate how the border of a widget changes! The point is you have a ton of options.

Tweens are mutable, so if you know that you’re always going to animate between the same set of values, it’s best to declare your `Tween` as a static final variable in your class. That way, you don’t create a new object every time you rebuild.

```dart
class ColorAnimationWithStaticFinal extends StatelessWidget {
  static final colorTween = ColorTween(begin: Colors.white, end: Colors.red);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        starsBackground,
        Center(
          child: TweenAnimationBuilder<Color>(
            tween: colorTween,
            duration: Duration(seconds: 2),
            builder: (_, Color color, __) {
              return ColorFiltered(
                child: Image.asset('assets/sun.png'),
                colorFilter: ColorFilter.mode(color, BlendMode.modulate),
              );
            },
          ),
        ),
      ],
    );
  }
}
```

## Dynamically modifying Tween values

The previous example showed a really simple way to animate from one value to another without using `setState` or anything. But, you can do more with `TweenAnimationBuilder` by *dynamically modifying* your `Tween` value.

```dart
class OngoingAnimationByModifyingEndTweenValue extends StatefulWidget {
  @override
  _OngoingAnimationState createState() => _OngoingAnimationState();
}

class _OngoingAnimationState extends State<OngoingAnimationByModifyingEndTweenValue> {
  double _newValue = .4;
  Color _newColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        starsBackground,
        Column(
          children: <Widget>[
            Center(
              child: TweenAnimationBuilder(
                tween: ColorTween(begin: Colors.white, end: _newColor),
                duration: Duration(seconds: 2),
                builder: (_, Color color, __) {
                  return ColorFiltered(
                    child: Image.asset('assets/sun.png'),
                    colorFilter: ColorFilter.mode(color, BlendMode.modulate),
                  );
                },
              ),
            ),
            Slider.adaptive(
              value: _newValue,
              onChanged: (double value) {
                setState(() {
                  _newValue = value;
                  _newColor = Color.lerp(Colors.white, Colors.red, value);
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
```

I changed the code to also include a `Slider` widget. Then I declared a local variable called `_newColor` that takes the slider value and converts it to a color. `_newColor` is also used as the end value in my `Tween`. Now the animation updates every time I drag the slider.

<DashImage figure src="images/1ZiMTAgg11y3BHH24bTt6Mg.gif" />


One thing to keep in mind is that `TweenAnimationBuilder` always moves from the current value to the new end value. That means as I drag the slider, I see the color change relative to its previous color, rather than always animating from white at the very beginning. Just by setting a new end value to my `Tween`, I can reverse my animation or move to any point in between. `TweenAnimationBuilder` always smoothly animates between its current value and the new end point. As you can perhaps infer, this means dynamically changing the *start* of your `Tween` has no effect.

```dart
// DON'T DO THIS! YOU WON'T SEE AN ANIMATION IF YOU JUST UPDATE THE START VALUE!  
class NopeNopeNope extends StatefulWidget {
  @override
  _NopeNopeNopeState createState() => _NopeNopeNopeState();
}

class _NopeNopeNopeState extends State<NopeNopeNope> {
  double _newValue = .4;
  Color _newColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        starsBackground,
        Column(
          children: <Widget>[
            Center(
              child: TweenAnimationBuilder(
                tween: ColorTween(begin: _newColor, end: Colors.red),
                duration: Duration(seconds: 2),
                builder: (_, Color color, __) {
                  return ColorFiltered(
                    child: Image.asset('assets/sun.png'),
                    colorFilter: ColorFilter.mode(color, BlendMode.modulate),
                  );
                },
              ),
            ),
            Slider.adaptive(
              value: _newValue,
              onChanged: (double value) {
                setState(() {
                  _newValue = value;
                  _newColor = Color.lerp(Colors.white, Colors.red, value);
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
```

## onEnd and child

There are a few other parameters that I haven’t talked about yet. The first one is the curve, to describe how we should transition between the beginning and end values in our `Tween` range. In the [previous article](https://medium.com/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916) we talked about how you can even create a custom curve, but there are a lot of great predefined options too.

The second one is a callback you can specify, so you can do something when the animation completes. Perhaps you want to make another widget appear after this animation finishes. You can also use this callback as a way to reverse your animation back and forth. I recommend that you think carefully before doing this though. The callback makes the type of animation you’re trying to do less clear because the value setting is distributed through your code. Because the values are discontinuous (jumping back to the start again), if you want a repeating animation you’ll need some sort of explicit animation: either a built-in explicit animated widget or extending `AnimatedWidget`.

```dart
class BackAndForth extends StatefulWidget {
  @override
  _BackAndForthState createState() => _BackAndForthState();
}

class _BackAndForthState extends State<MyHomePage> {
  Color _newColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        starsBackground,
        Center(
          child: TweenAnimationBuilder(
            tween: ColorTween(begin: Colors.white, end: _newColor),
            duration: Duration(seconds: 2),
            onEnd: () {
              setState(() {
                _newColor = _newColor == Colors.red ? Colors.white : Colors.red;
              });
            },
            builder: (_, Color color, __) {
              return ColorFiltered(
                child: Image.asset('assets/sun.png'),
                colorFilter: ColorFilter.mode(color, BlendMode.modulate),
              );
            },
          ),
        )
      ],
    );
  }
}
```

<DashImage figure src="images/17xwzsHM8FSwtXlWP_3q9qA.webp" />


There’s one last parameter we haven’t discussed yet: the child parameter. Setting the child parameter is a potential performance optimization. Even though the color changes, the star image widget itself stays the same. As it’s currently written though, that image widget gets reconstructed every time that builder method gets called. We can build that star image ahead of time by passing it in as a child parameter. This way, Flutter knows the only widget that it needs to rebuild from frame to frame is the new color filter, not the star image itself. This example is simple so there’s really no noticeable difference. But, if we were animating a much more complex component, you can imagine performance optimization might become more important.

```dart
class ChildParameter extends StatelessWidget {
  static final colorTween = ColorTween(begin: Colors.white, end: Colors.red);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        starsBackground,
        Center(
          child: TweenAnimationBuilder<Color>(
            tween: colorTween,
            child: Image.asset('assets/sun.png'),
            duration: Duration(seconds: 2),
            builder: (_, Color color, Widget myChild) {
              return ColorFiltered(
                child: myChild,
                colorFilter: ColorFilter.mode(color, BlendMode.modulate),
              );
            },
          ),
        ),
      ],
    );
  }
}
```

## Summary

That’s all you need to know to write your own cool implicit animations with `TweenAnimationBuilder`! To recap, `TweenAnimationBuilder` is a great way to create “set-it-and-forget-it” implicit animations if you can’t find a built-in `AnimatedFoo` type widget. You can accomplish simple animations using `TweenAnimationBuilder` without needing to use a `StatefulWidget`. You can change that end value in the `Tween` to smoothly animate to a new value. There are also potential performance optimizations by passing in a child ahead of time or setting a static final `Tween` when appropriate. To learn more about which animation widget you should use when, check out the other articles in this series.

This is the article version of the following video content. If you prefer videos, watch away:

<YoutubeEmbed id="6KiPEqzJIKQ" title="Creating your own Custom Implicit Animations with TweenAnimationBuilder" fullwidth="true"/>


Articles in this series:

* [How to Choose Which Flutter Animation Widget is Right for You?](https://medium.com/p/79ecfb7e72b5/edit)

* [Flutter animation basics with implicit animations](https://medium.com/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916)

* [Custom Implicit Animations in Flutter…with TweenAnimationBuilder](https://medium.com/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185) (this article)

* [Directional animations with built-in explicit animations](https://medium.com/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7)

* [When should I useAnimatedBuilder or AnimatedWidget?](https://medium.com/flutter/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8)

* [Animation deep dive](https://medium.com/flutter/animation-deep-dive-39d3ffea111f)
