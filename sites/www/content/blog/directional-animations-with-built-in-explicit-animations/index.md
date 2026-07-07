---
title: "Directional animations with built-in explicit animations"
description: "Hi! In our previous episodes, we learned how to do some awesome animations using Flutter’s implicit animations. AnimatedFoo and…"
publishDate: 2020-01-10
author: fitzface
image: images/01xmX3Sfp_rLOAwwl.png
category: tutorial
layout: blog
---

*To watch this post in video form, check out our YouTube video [here](https://www.youtube.com/watch?v=CunyH6unILQ&t=1s).*

Hi! In our [previous](https://medium.com/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916) [posts](https://medium.com/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185), we learned how to do some awesome animations using Flutter’s implicit animations. `AnimatedFoo` and `TweenAnimationBuilder` gave you the ability to drop some basic animations into your app. These animations typically go in one direction, “tweening” from a start to an end, where they stop. Behind the scenes, Flutter is taking control, assuming intentions and disposing of any need for you to worry about the transition from one thing to the next.

This works perfectly for many animation goals, but sometimes that ever-forward arrow of time leaves us feeling temporally locked. So, as we pause and contemplate the laws of thermodynamics and the inevitable heat death of the universe, wouldn’t it be nice if we could reverse time, and do it all again?

Enter our first foray into Flutter’s explicit animations! We won’t be building any time machines today, but we will be learning how to gain a bit more control over your animations using Transition widgets.

Transition widgets are a set of Flutter widgets whose names all end in — you guessed it —Transition. [`ScaleTransition`](https://api.flutter.dev/flutter/widgets/ScaleTransition-class.html), [`DecoratedBoxTransition`](https://api.flutter.dev/flutter/widgets/DecoratedBoxTransition-class.html), [`SizeTransition`](https://api.flutter.dev/flutter/widgets/SizeTransition-class.html), and more. They look and feel a lot like our `AnimatedBlah` widgets. [`PositionedTransition`](https://api.flutter.dev/flutter/widgets/PositionedTransition-class.html), for example, animates a widget’s transition between different positions. This is much like [`AnimatedPositioned`](https://api.flutter.dev/flutter/widgets/AnimatedPositioned-class.html), but there is one major difference: these Transition widgets are extensions of [`AnimatedWidget`](https://api.flutter.dev/flutter/widgets/AnimatedWidget-class.htmlhttps://api.flutter.dev/flutter/widgets/AnimatedWidget-class.html). This makes them *explicit animations*.

But, what does that really mean for us as app developers? Let’s step through what makes these animations tick.

Here, we’ll be creating an animation of galactic proportions, using this starting image. But, in this initial unanimated state, it doesn’t feel very galactic. Our first quest: to mix in some rotation.

<DashImage figure src="images/01xmX3Sfp_rLOAwwl.png" alt="*An image of Fitz’s galaxy just sitting there, **not** rotating.*" caption="*An image of Fitz’s galaxy just sitting there, **not** rotating.*" />


## `RotationTransition` as an example

The [`RotationTransition`](https://api.flutter.dev/flutter/widgets/RotationTransition-class.html) widget is a handy one that takes care of all of the trigonometry and transformations math to make things spin. Its constructor only takes three things:

```
// [Most of] RotationTransition’s constructor
RotationTransition({
  Widget child,
  Alignment alignment,
  Animation<double> turns,
})
```


First is a child —the widget we want to rotate. The galaxy fits, so we’ll put it there:

```
RotationTransition(
  child: GalaxyFitz(),
  alignment: null, /*TODO*/
  turns: null, /*TODO*/
)
```


Next, we need to give `RotationTransition` the point our galaxy rotates around. Our galaxy’s black hole is roughly in the middle of the image where we’d normally expect. So, we’ll give an `alignment` of center, making all of our rotational math “aligned” to that point.

```
RotationTransition(
  child: GalaxyFitz(),
  alignment: Alignment.center,
  turns: null, /*TODO*/
)
```


Last, what is this mysteriously named turns property? The API docs tell us this is… an `Animation`?!? Weren’t we creating an animation?

<DashImage figure src="images/06d-qda9iAUu26wjA.png" alt="*The* [`RotationTransition`](https://api.flutter.dev/flutter/widgets/RotationTransition-class.html) *docs tell us that turns is of type Animation.*" caption="*The* [`RotationTransition`](https://api.flutter.dev/flutter/widgets/RotationTransition-class.html) *docs tell us that turns is of type Animation.*" />


Not to worry! This is part of what makes `RotationTransition`, and all the other Transition widgets, an explicit animation. We *could* accomplish the same rotation effect with an `AnimatedContainer` and a transform, but then we’d rotate once and then stop. With our explicit animations, we have control of time and can make it so that our galaxy never stops spinning.

<DashImage figure src="images/0WOcQ1I3-ThMzDyld.gif" alt="*Astronomical tip of the day: Most galaxies take **a bit** longer than 5 seconds to complete one rotation.*" caption="*Astronomical tip of the day: Most galaxies take **a bit** longer than 5 seconds to complete one rotation.*" />


The turns property expects something that gives it a value and notifies it when that value changes. An `Animation&lt;double&gt;` is just that. For `RotationTransition`, the value corresponds to how many times we’ve turned, or more specifically, the percentage of one rotation completed.

<DashImage figure src="images/0VO7YjLAkYQsVLIWj.png" alt="*It would take the solar system around 30 million years to complete 12.6% of a rotation around the Milky Way. Our Flutter Galaxy will spin **slightly** faster than that.*" caption="*It would take the solar system around 30 million years to complete 12.6% of a rotation around the Milky Way. Our Flutter Galaxy will spin **slightly** faster than that.*" />


## Creating an AnimationController

One of the easiest ways to get an `Animation&lt;double&gt;` is to create an `AnimationController`, which is a [controller for an animation](https://api.flutter.dev/flutter/animation/AnimationController-class.html). This controller handles listening for ticks¹ and gives us some useful controls over what the animation is doing.

We’ll need to create this in a stateful widget because keeping a handle on the controller will be important in our not-too-distant future. Because `AnimationController` also has its own state to manage, we initialize it in initState, and dispose of it in dispose.

```dart
class _TimeMachineState extends State<TimeMachine> {
  AnimationController _animationController;
 
  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      // ...
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
```

There are two parameters we must give to `AnimationController`’s constructor. The first is a duration, which is how long our ̶t̶i̶m̶e̶ ̶m̶a̶c̶h̶i̶n̶e̶ animation lasts. The whole reason we’re here is that we need an object to tell us how far along we are in a single rotation. By default, `AnimationController` “emits” values from `0.0` to `1.0`. How many and how granular those values are depends on how long we want a single rotation to take. Fortunately, Dart gives us a `Duration` class to use. For the sake of this demo, we should have the galaxy spinning somewhere between 5 seconds and 230 million years per rotation. How about 15 seconds per turn then?

```
_animationController = AnimationController(
  duration: Duration(seconds: 15),
  // TODO: finish constructing me.
);
```


The next required parameter is `vsync`. If you’re here from the future, welcome back! We hope you already know everything about vsync. For those who came here from the past, we’ll just say that this is what gives Flutter a reference to the object to notify about changes. `this` is that thing, and it needs to mix in some ticker provider code. A future post will dive into more detail about vsync and ticker providers.

```dart
class _TimeMachineState extends State<TimeMachine> 
with SingleTickerProviderStateMixin {
  AnimationController _animationController;
 
  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: Duration(seconds: 15),
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
```

If we left things at that, nothing much happens. That’s because we’ve been given a controller, but haven’t pushed any of its buttons! We want our galaxy to spin forever, right? For that, we’ll just ask the controller to continually repeat the animation.

```
_animationController = AnimationController(
  duration: Duration(seconds: 15),
  vsync: this,
)..repeat();
```


Finally, we can go back and replace that null we left lingering around, by passing the animation controller to the `turns` parameter in our `RotationTransition`.

```
RotationTransition(
  child: GalaxyFitz(),
  alignment: Alignment.center,
  turns: _animationController,
)
```


And, although we now have an infinitely rotating galaxy, this still doesn’t quite feel like we have control of time. The galaxy just does its thing now, right? Don’t forget, though, we have a handle on a controller. Let’s make use of it.²

## Making use of an AnimationController

Allowing anyone to control the galaxy seems a bit too permissive though, so I’m going to make it an easter egg. I’ll add a sibling to the galaxy that’s a simple button, hidden off in the corner, and I’ll pass it a reference to our controller, so that within its `onTap` listener, we can stop or restart the animation.

```dart
Stack(
  children: <Widget>[
    Align(
      alignment: Alignment.bottomLeft,
      child: TimeStopper(
        controller: _animationController,
      ),
    ),
    Align(
      alignment: Alignment.center,
      child: RotationTransition(
        child: GalaxyFitz(),        
        alignment: Alignment.center,
        turns: _animationController,
      ),
    ),
  ],
)
```

The controller maintains — among other things — the status of the animation, which we can check and stop if we’re running or restart if we’re not. And, there you go! By using an animation controller, we’re able to control the animation on demand. But that’s not all you can do with the controller.

```dart
class TimeStopper extends StatelessWidget {
  final AnimationController controller;
 
  const TimeStopper({Key key, this.controller}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.isAnimating) {
          controller.stop();
        } else {
          controller.repeat();
        }
      },
      child: InvisibleBox(size: 100),
    );
  }
}
```

With it, you can also animate to (or backwards from) a specific value, fling the animation forward with a given velocity, or control multiple animations with the same controller.

<DashImage figure src="images/0UjrF-d2-BWLQyfEo.gif" alt="*Keeping your galaxy clean of unwanted rockets.*" caption="*Keeping your galaxy clean of unwanted rockets.*" />


This was just our first taste of explicit animations in Flutter. We saw how a Transition widget works with `AnimationController`, to provide some directionality and control over how our animation works. In future posts, we’ll be diving deeper into explicit animations and how to get even more customized.

<DashImage figure src="images/0eSjSmRfA6LMzx_Yc.gif" alt="*When the galaxy stops, everything stops*" caption="*When the galaxy stops, everything stops*" />


1. *Galactic ticks are hard to hear, but AnimationController and TickerProviders help.*

1. *As with all of your time controllers: use responsibly.*

Articles in this series:

* [How to Choose Which Flutter Animation Widget is Right for You?](https://medium.com/p/79ecfb7e72b5/edit)

* [Flutter animation basics with implicit animations](https://medium.com/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916)

* [Custom Implicit Animations in Flutter…with TweenAnimationBuilder](https://medium.com/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185)

* [Directional animations with built-in explicit animations](https://medium.com/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7) (this article)

* [When should I useAnimatedBuilder or AnimatedWidget?](https://medium.com/flutter/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8)

* [Animation deep dive](https://medium.com/flutter/animation-deep-dive-39d3ffea111f)