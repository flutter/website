---
title: Implicit animations
description: Where to find more information on using implicit animations in Flutter.
---

<?code-excerpt path-base="animation"?>

With Flutter's [animation library][],
you can add motion and create visual effects
for the widgets in your UI.
One part of the library is an assortment of widgets
that manage animations for you.
These widgets are collectively referred to as _implicit animations_,
or _implicitly animated widgets_, deriving their name from the
[`ImplicitlyAnimatedWidget`][] class that they implement.

With implicit animations, you don't need to manage an `AnimationController`
or `Ticker`. Instead, you pass a `duration` (and an optional `curve`)
to an `AnimatedFoo` widget, and whenever a target property changes in
`setState()`, the widget automatically interpolates from the old value
to the new value:

<?code-excerpt "implicit/lib/main.dart (FadeBoxDemo)"?>
```dart
import 'package:material_ui/material_ui.dart';

class FadeBoxDemo extends StatefulWidget {
  const FadeBoxDemo({super.key});

  @override
  State<FadeBoxDemo> createState() => _FadeBoxDemoState();
}

class _FadeBoxDemoState extends State<FadeBoxDemo> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: const FlutterLogo(size: 100),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => setState(() => _visible = !_visible),
          child: const Text('Toggle opacity'),
        ),
      ],
    );
  }
}
```

When no built-in `AnimatedFoo` widget covers the property you want to
animate, you can build a custom implicit animation with
[`TweenAnimationBuilder`][].

The following set of resources provides many ways to learn
about implicit animations in Flutter.

[animation library]: {{site.api}}/flutter/animation/animation-library.html

## Documentation

[Animations in Flutter codelab][]
: Learn about implicit and explicit animations
  and get hands-on experience adding implicit animations
  to a complete Flutter app.

[`AnimatedContainer` sample][]
: A step-by-step recipe for using the
  [`AnimatedContainer`][] implicitly animated widget.

[Fade a widget in and out][]
: A cookbook recipe showing how to fade a widget using [`AnimatedOpacity`][].

[`TweenAnimationBuilder`][] API page
: Create custom implicit animations for any property using a `Tween`
  and a `builder` callback.

[`ImplicitlyAnimatedWidget`][] API page
: All implicit animations extend the `ImplicitlyAnimatedWidget` class.

[Animations in Flutter codelab]: {{site.codelabs}}/advanced-flutter-animations
[`AnimatedContainer` sample]: /cookbook/animation/animated-container
[`AnimatedContainer`]: {{site.api}}/flutter/widgets/AnimatedContainer-class.html
[`AnimatedOpacity`]: {{site.api}}/flutter/widgets/AnimatedOpacity-class.html
[Fade a widget in and out]: /cookbook/animation/opacity-animation
[`ImplicitlyAnimatedWidget`]: {{site.api}}/flutter/widgets/ImplicitlyAnimatedWidget-class.html
[`TweenAnimationBuilder`]: {{site.api}}/flutter/widgets/TweenAnimationBuilder-class.html

## Flutter in Focus videos

Flutter in Focus videos feature 5-10 minute tutorials
with real code that cover techniques
that every Flutter dev needs to know from top to bottom.
The following videos cover topics
that are relevant to implicit animations.

<YouTubeEmbed id="IVTjpW3W33s" title="Flutter implicit animation basics"></YouTubeEmbed>

<YouTubeEmbed id="6KiPEqzJIKQ" title="Create custom implicit animations with TweenAnimationBuilder"></YouTubeEmbed>

## The Boring Show

Watch the Boring Show to follow Google engineers building apps
from scratch in Flutter. The following episode covers
using implicit animations in a news aggregator app.

<YouTubeEmbed id="8ehlWchLVlQ" title="Adding implicit animations to a news application"></YouTubeEmbed>

## Widget of the Week videos

A weekly series of short animated videos each showing
the important features of one particular widget.
In about 60 seconds, you'll see real code for each
widget with a demo about how it works.
The following Widget of the Week videos cover
implicitly animated widgets:

<div class="card-grid wide">
  <div class="card wrapped-card outlined-card">
    <div class="card-content">
      <YouTubeEmbed id="QZAvjqOqiLY" title="AnimatedOpacity - Flutter widget of the week"></YouTubeEmbed>
    </div>
  </div>
  <div class="card wrapped-card outlined-card">
    <div class="card-content">
      <YouTubeEmbed id="PY2m0fhGNz4" title="AnimatedPadding - Flutter widget of the week"></YouTubeEmbed>
    </div>
  </div>
  <div class="card wrapped-card outlined-card">
    <div class="card-content">
      <YouTubeEmbed id="hC3s2YdtWt8" title="AnimatedPositioned - Flutter widget of the week"></YouTubeEmbed>
    </div>
  </div>
  <div class="card wrapped-card outlined-card">
    <div class="card-content">
      <YouTubeEmbed id="2W7POjFb88g" title="AnimatedSwitcher - Flutter widget of the week"></YouTubeEmbed>
    </div>
  </div>
</div>
