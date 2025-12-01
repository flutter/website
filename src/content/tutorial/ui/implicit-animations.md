---
title: Simple animations
description: Learn the simplest way to implement animations in Flutter.
layout: tutorial
sitemap: false
---

Flutter provides a rich set of animation APIs, and the simplest way to
start using them is with **implicit animations**.
"Implicit animations" refers to a group of widgets that
automatically animate changes to their properties without you
needing to manage any intermediate behavior.

In this lesson, you'll learn about one of the most common and
versatile implicit animation widgets: [`AnimatedContainer`][].
With just two additional lines of code, the background color of each `Tile`
animates to a new color in about half a second.

[`AnimatedContainer`]: {{site.api}}/flutter/widgets/AnimatedContainer-class.html

## Convert `Container` to `AnimatedContainer`

Currently, the `Tile.build` method returns a `Container` to display a letter.
When the `hitType` changes, like from `HitType.none` to `HitType.hit`,
the background color of the tile changes instantly.
For example, from white to green in the case of `HitType.none` to `HitType.hit`.

For reference, here's the current implementation of the `Tile` widget:

```dart
class Tile extends StatelessWidget {
  const Tile(required this.letter, required hitType, {super.key});

  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: switch (type) {
          HitType.hit => Colors.green,
          HitType.partial => Colors.yellow,
          HitType.miss => Colors.grey,
          _ => Colors.white,
        },
      ),
      child: Center(
        child: Text(
          letter.char.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
```

To make the color change animate smoothly,
replace the `Container` widget with an `AnimatedContainer`.

An `AnimatedContainer` is like a `Container`, but it
automatically animates changes to its properties over a specified `duration`.
When properties such as
`color`, `height`, `width`, `decoration`, or `alignment` change,
`AnimatedContainer` interpolates between the old and new values,
creating a smooth transition.

Modify your `Tile` widget as follows:

```dart
class Tile extends StatelessWidget {
  const Tile(required this.letter, required hitType, {super.key});

  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: switch (hitType) {
          HitType.hit => Colors.green,
          HitType.partial => Colors.yellow,
          HitType.miss => Colors.grey,
          _ => Colors.white,
        },
      ),
      child: Center(
        child: Text(
          letter.char.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
```

**`duration`** is a required property that
specifies how long the animation should take.
In this example, passing `Duration(milliseconds: 500)` means
the color transition will take half a second.
You can also specify seconds, minutes, and many other units of time.

Now, when the `hitType` changes and the `Tile` widget rebuilds
(because `setState` was called in `GamePage`),
the color of the tile smoothly animates from its old color to
the new one over the specified duration.

## Adjust the animation curve

To add a bit of customization to an implicit animation,
you can pass it a different [`Curve`][].
Different curves change the speed of the animation
at different points throughout the animation.

{%- comment %} TODO(ewindmill) diagram {%- endcomment %}

To change the `Curve` of this animation, update the code to the following:

```dart
class Tile extends StatelessWidget {
  const Tile(required this.letter, required hitType, {super.key});

  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
	    curve: Curves.decelerate, // NEW
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: switch (hitType) {
          LetterType.hit => Colors.green,
          LetterType.partial => Colors.yellow,
          LetterType.miss => Colors.grey,
          _ => Colors.white,
        },
      ),
      child: Center(
        child: Text(
          letter.char.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
```

There are many different curves provided by the Flutter SDK, so
feel free to try them out by passing different types to the `curve` parameter.

Implicit animations like `AnimatedContainer` are powerful because
you just tell the widget what the new state should be, and
it handles the "how" of the animation.

For complex, custom animations, you can write your own animated widgets.
If you're curious, try it out in the [animations tutorial][].

[`Curve`]: {{site.api}}/flutter/animation/Curves-class.html
[animations tutorial]: /ui/animations/tutorial
