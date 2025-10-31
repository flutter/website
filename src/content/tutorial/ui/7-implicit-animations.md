---
title: Simple animations
description: Learn the simplest way to implement animations in Flutter.
permalink: /tutorial/animations/
sitemap: false
---

Flutter provides a rich set of animation APIs, and the simplest way to
start using them is with **implicit animations**. "Implicit
animations" refers to a group of widgets that automatically animate
changes to their properties without you needing to manage any
behavior.

In this lesson, you'll learn about one of the most common and
versatile implicit animation widgets: [`AnimatedContainer`][]. With
just two additional lines of code, the background color of each `Tile`
animates to a new color in about half a second.

## Convert `Container` to `AnimatedContainer`

Currently, the `Tile.build`  method returns  a `Container` to display
a letter. When the `hitType` changes, like from `HitType.none`
to `HitType.hit`, the background color of the tile changes
instantly (from white to green, in this example).

Here's the current `Tile` widget code for reference:

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

To make the color change animate smoothly, replace the `Container`
widget with an `AnimatedContainer`.

An `AnimatedContainer` is like a `Container`, but it automatically
animates changes to its properties over a specified `duration`. When
properties like `color`, `height`, `width`, `decoration`, or
`alignment` change, `AnimatedContainer` interpolates between the old
and new values, creating a smooth transition.

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

**`duration`** is a required property that specifies how long the
animation should take. In this example, `Duration(milliseconds: 500)`
means the color transition will take half of one second. You can also
specify seconds, minutes, and many other units of time.

Now, when the `hitType` changes and the `Tile` widget rebuilds
(because `setState` was called in `GamePage`), the color of the tile
will smoothly animate from its old color to the new one over the
specified duration.

## Adjust the curve

You can add a bit of customization to an implicit animation by passing
it a [`Curve`][].  Different curves will change the speed of the animation
at different points throughout the animation.

{%- comment %} TODO(ewindmill) diagram {%- endcomment %}

To change the `Curve` of this animation, update the the code to the following:

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

There are many different curves defined by the Flutter SDK, so feel
free to try them out by passing different types to the
`AnimatedContainer.curve` property.

Implicit animations like `AnimatedContainer` are powerful because you
just tell the widget what the new state should be, and it handles the
"how" of the animation. For complex, custom animations, you can write
your own animated widgets. If you’re curious, read the
[animations tutorial](https://docs.flutter.dev/ui/animations/tutorial).

[`AnimatedContainer`]: {{site.api}}/flutter/widgets/AnimatedContainer-class.html
[`Curve`]: {{site.curve}}/flutter/animation/Curves-class.html
[animations tutorial]: /ui/animations/tutorial.
