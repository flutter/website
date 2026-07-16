---
title: "Animation deep dive"
description: "Last year, I got to record one of the episodes in the Flutter Animations series, and I thought I’d publish the same content for those who…"
publishDate: 2020-04-17
author: filiph
image: images/14bIqmJ8DQLSnlFtkN6bjaA.webp
category: tutorial
layout: blog
---

Last year, I got to record one of the episodes in the Flutter Animations series, and I thought I’d publish the same content for those who prefer text over video.

<YoutubeEmbed id="PbcILiN8rbo" title="Animation deep dive - Flutter in Focus" fullwidth="true"/>

In the other episodes of the series, my colleagues talk about all the practical ways to build animations in Flutter. Not so in my episode. Here, you’ll learn how to implement animations in the *least* pragmatic way imaginable. (But, you’ll also learn some things along the way.)

Let’s start with something simple and lighthearted:

### What *is* motion, really?

You see, motion is an illusion. Look at this:

<DashImage figure src="images/14bIqmJ8DQLSnlFtkN6bjaA.webp" alt="A video of Filip waving his hand." caption="A video of Filip waving his hand." />

It’s a lie. What you’re actually seeing are many still images shown in quick succession. This is how movies work. The individual pictures are called frames in cinema— and because digital screens work similarly— they’re called frames here too. Cinema normally shows 24 frames per second. Modern digital devices show 60 to 120 frames per second.

So, if motion is a lie, what are all these `AnimationFoo` and `FooTransition` widgets really doing? Surely, because the frames need to be constructed up to 120 times per second, the UI cannot be *rebuilt* every time.

### Or, can it?

In fact, animations in Flutter are just a way to rebuild parts of your widget tree on every frame. There is no special case. Flutter is fast enough to do that.

Let’s look at one of the building blocks of Flutter animations: `AnimatedBuilder`. This widget is an `AnimatedWidget`, which is backed by `_AnimatedState`. In the State’s `initState()` method, we are listening on the `Animation` (or `Listenable`, as it is called here), and when it changes its value, we … call `setState()`.

<DashImage figure src="images/1-T1fn-7fK2OU-z711XG_8A.gif" alt="This confusing screencast is just showing that I am telling the truth in the previous paragraph. Animated Builder really does call `setState()` on every frame." caption="This confusing screencast is just showing that I am telling the truth in the previous paragraph. Animated Builder really does call `setState()` on every frame." />

There you go. Animations in Flutter are just a quick succession of changing the state of some widget, 60 to 120 times per second.

I can prove it. Here’s an animation that “animates” from zero to the speed of light. Although it’s changing the text on every frame, from Flutter’s perspective, it’s just another animation.

<DashImage figure src="images/1y4Pbt8ehWTAEfL9_M8Aoog.webp" />

Let’s use Flutter’s animation framework to build that animation from first principles.

Normally, we would use the `TweenAnimationBuilder` widget or something similar, but in this article, we’ll ignore all that, and go with a ticker, a controller, and `setState`.

## Ticker

Let’s talk about Ticker first. 99% of the time, you won’t use a ticker directly. But, I think it’s still helpful to talk about it — even if only to demystify it.

A ticker is an object that calls a function for every frame.

```dart
var ticker = Ticker((elapsed) => print('hello'));
ticker.start();
```

In this case, we’re printing ‘hello’ every frame. Admittedly, that’s not very useful.

Also, we forgot to call `ticker.dispose()`, so now our ticker will go on forever, until we kill the app.

That’s why Flutter gives you `SingleTickerProviderStateMixin`, the aptly named mixin you’ve seen in some of the previous videos.

This mixin takes care of the hassle of managing a ticker. Just slap it onto your widget’s state and now your state is secretly a `TickerProvider`.

```dart
class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin<MyWidget> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

What this means is that the Flutter framework can ask your state for a ticker. Most important, `AnimationController` can ask the state for a ticker.

```dart
class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin<MyWidget> {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

`AnimationController` *needs* a ticker for it to function. If you use `SingleTickerProviderStateMixin` or its cousin `TickerProviderStateMixin`, you can just give `this` to the `AnimationController`, and you’re done.

## AnimationController

`AnimationController` is what you normally use to play, pause, reverse, and stop animations. Instead of pure “tick” events, `AnimationController` tells us at which *point* of the animation we are, at any time. For example, are we halfway there? Are we 99% there? Have we completed the animation?

<DashImage figure src="images/1nKjFR7DVd-2r7_sSgBprfA.webp" />

Normally, you take the `AnimationController`, maybe transform it with a `Curve`, put it through a `Tween`, and use it in one of the handy widgets like `FadeTransition` or `TweenAnimationBuilder`. But, for educational purposes, let’s not do that. Instead, we will directly call `setState`.

## setState

After we initialize the `AnimationController`, we can add a listener to it. And, in that listener, we call `setState`.

```dart
class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin<MyWidget> {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(_update);
  }

  void _update() {
    setState(() {
      // TODO
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

Now, we should probably have a state to set. Let’s keep it simple with an integer. And let’s not forget to actually use the state in our build method, and to change the state in our listener according to the current value of the controller.

```dart
class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin<MyWidget> {
  AnimationController _controller;

  int i = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(_update);
  }

  void _update() {
    setState(() {
      i = (_controller.value * 299792458).round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('$i m/s');
  }
}
```

This code assigns a value from zero to the speed of light depending on the animation’s progress.

## Running the animation

Now, we just need to tell the animation how long it should take to complete, and start the animation.

```dart
class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin<MyWidget> {
  AnimationController _controller;

  int i = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.addListener(_update);
    _controller.forward();
  }

  void _update() {
    setState(() {
      i = (_controller.value * 299792458).round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('$i m/s');
  }
}
```

The widget animates as soon as it’s added to the screen. And it “animates” from zero to the speed of light in a second.

<DashImage figure src="images/1uuyMl4qHr_bFZJENdMDimQ.webp" />

## Disposing of the controller

Oh, and don’t forget to dispose of the `AnimationController`. Otherwise you have a memory leak in your app.

```dart
class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin<MyWidget> {
  AnimationController _controller;

  int i = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.addListener(_update);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _update() {
    setState(() {
      i = (_controller.value * 299792458).round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('$i m/s');
  }
}
```

## Just use a built-in widget, maybe?

As you can see, doing it all by yourself is not great. The same functionality can be achieved with the `TweenAnimationBuilder` in much fewer lines of code, and without having to juggle an `AnimationController` and calling `setState`.

```dart
class MyPragmaticWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: IntTween(begin: 0, end: 299792458),
      duration: const Duration(seconds: 1),
      builder: (BuildContext context, int i, Widget child) {
        return Text('$i m/s');
      },
    );
  }
}
```

## Summary

We saw what `Ticker` really is. We saw how to manually listen to an `AnimationController`. And, we saw that, at the basic level, animations are just fast, consecutive rebuilds of a widget. You can do whatever you want on any frame.

Articles in this series:

* [How to Choose Which Flutter Animation Widget is Right for You?](https://medium.com/p/79ecfb7e72b5/edit)

* [Flutter animation basics with implicit animations](https://medium.com/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916)

* [Custom Implicit Animations in Flutter…with TweenAnimationBuilder](https://medium.com/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185)

* [Directional animations with built-in explicit animations](https://medium.com/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7)

* [When should I useAnimatedBuilder or AnimatedWidget?](https://medium.com/flutter/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8)

* [Animation deep dive](https://medium.com/flutter/animation-deep-dive-39d3ffea111f) (this article)
