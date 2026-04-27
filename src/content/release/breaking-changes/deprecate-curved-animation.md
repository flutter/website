---
title: Deprecate `CurvedAnimation` in favor of `CurveTween` or `ReversibleCurvedAnimation`
description: >-
  CurvedAnimation has been renamed to ReversibleCurvedAnimation,
  but you are encouraged to use CurveTween instead where possible.
---

{% render "docs/breaking-changes.md" %}

## Summary

The [`CurvedAnimation`][] class has been deprecated.

It has been renamed to [`ReversibleCurvedAnimation`][] to reflect its ability to
use different curves depending on whether it's going forwards and backwards.
Like before, please remember to [dispose][CurvedAnimation.dispose] your
`ReversibleCurvedAnimation` when you're done.

If you don't need different forward and backward curves,
consider switching to [`CurveTween`][] instead for efficiency.
As a bonus, you won't need to remember to call a dispose method.

## Background

If you want to apply a curve to an animation
(for example, from an [`AnimationController`][]),
the docs presented these two options as equivalent:
```dart
Animation<double> curved;

// First method with CurvedAnimation
curved = CurvedAnimation(parent: animationController, curve: Curves.easeOut);

// Second method with CurveTween
curved = animationController.drive(CurveTween(curve: Curves.easeOut));
// ...or equivalently...
curved = CurveTween(curve: Curves.easeOut).animate(animationController);
```

As similar as they might look, they actually operate differently under the hood:
- The first method holds its own state.
  It adds listeners to its parent to know whether it's going forwards/backwards
  and it must be disposed to remove those listeners.
- The second method proxies everything to its parent,
  meaning it doesn't hold any resources that need to be disposed.
  (Also, it doesn't even have a dispose method defined.)

This difference makes it important to make them easier to distinguish.
Conflating the two makes it too easy to introduce memory leaks into your app
(even Flutter itself had several cases of this issue).

## Migration guide

You can either migrate to `CurveTween` or `ReversibleCurvedAnimation`.

`ReversibleCurvedAnimation` is functionally equivalent to the old
`CurvedAnimation`, while `CurveTween` is used slightly differently.

As a general rule of thumb, prefer using `CurveTween` unless you need the
`reverseCurve` functionality of `ReversibleCurvedAnimation`.

### Option 1: Migrating from `CurvedAnimation` to `CurveTween`

This migration can be summed up as this one-line change:

```patch
-curved = CurvedAnimation(parent: animationController, curve: Curves.easeOut);
+curved = animationController.drive(CurveTween(curve: Curves.easeOut));
```

But real code can be more complex, so here are two code samples
and their migrated counterparts.

#### Typical initState, build, and dispose lifecycle

The typical pattern with `CurvedAnimation` is to create it in `initState`,
use it in `build`, and dispose it in `dispose`.

There is no need to be so vigilant with `CurveTween`: it can be created and
used directly in the build method, with no need to be disposed.

Code before migration:

```dart
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curved;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)..forward();
    _curved = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _curved.dispose();
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _curved,
      child: const Text('Hello world!'),
    );
  }
}
```

Code after migration:

The animation has been moved inside the `build` method.
There is no need for the boilerplate of storing and disposing it.

```dart
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // Migrated animation here:
    final Animation<double> opacity = _controller.drive(
      CurveTween(curve: Curves.easeOut),
    );

    return FadeTransition(
      opacity: opacity,
      child: const Text('Hello world!'),
    );
  }
}
```

#### Chained with other [`Tween`][]s

When using other Tweens like `ColorTween`, they can be used with `CurveTween`
by [`chain`][Animatable.chain]ing the tweens together.

Code before migration:
```dart
// BAD: DO NOT DO THIS
// This is leak-prone since CurvedAnimation is never disposed.

final Animation<Color> color = ColorTween(
  begin: Colors.white,
  end: Colors.black,
).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

final Animation<Offset> position = Tween<Offset>(
  begin: const Offset(-10, -10),
  end: Offset.zero
).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
```

Code after migration:
```dart
final Animation<Color> color = ColorTween(
  begin: Colors.white,
  end: Colors.black,
).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);

final Animation<Offset> position = Tween<Offset>(
  begin: const Offset(-10, -10),
  end: Offset.zero
).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);
```

### Option 2: Migrating from `CurvedAnimation` to `ReversibleCurvedAnimation`

`CurvedAnimation` was renamed to `ReversibleCurvedAnimation` so there are no
behavior changes between the two.

`ReversibleCurvedAnimation` now requires the `reverseCurve` parameter in its
constructor: set it to `null` to use the same curve as the forwards direction.

Code before migration:
```dart
final twoCurves = CurvedAnimation(
  parent: animationController,
  curve: Curves.easeOut,
  reverseCurve: Curves.easeIn,
);
final oneCurve = CurvedAnimation(
  parent: animationController,
  curve: Curves.ease,
);
```

Code after migration:
```dart
final twoCurves = ReversibleCurvedAnimation(
  parent: animationController,
  curve: Curves.easeOut,
  reverseCurve: Curves.easeIn,
);
final oneCurve = ReversibleCurvedAnimation(
  parent: animationController,
  curve: Curves.ease,
  reverseCurve: null,
);
```

{% comment %}
  Make sure you have looked for old tutorials online that
  use the old API. Contact their authors and point out how
  they should be updated. Leave a comment pointing out that
  the API has changed and linking to this guide.
{% endcomment %}

## Timeline

Landed in version: Not yet<br>
In stable release: Not yet

## References

{% render "docs/main-api.md", site: site %}

API documentation:

* [`CurveTween`][]
* [`ReversibleCurvedAnimation`][]

Relevant issues:

* [Disambiguate CurvedAnimation and CurveTween][]
* [Docs should instruct user to dispose CurvedAnimation][]

Relevant PRs:

* [Rename CurvedAnimation to ReversibleCurvedAnimation for disambiguation][]
* [Migrate internal uses of CurvedAnimation][]

[Animatable.chain]: {{site.api}}/flutter/animation/Animatable/chain.html
[`AnimationController`]: {{site.api}}/flutter/animation/AnimationController-class.html
[`CurvedAnimation`]: {{site.api}}/flutter/animation/CurvedAnimation-class.html
[CurvedAnimation.dispose]: {{site.api}}/flutter/animation/CurvedAnimation/dispose.html
[`CurveTween`]: {{site.api}}/flutter/animation/CurveTween-class.html
[`ReversibleCurvedAnimation`]: {{site.main-api}}/flutter/animation/ReversibleCurvedAnimation-class.html
[`Tween`]: {{site.api}}/flutter/animation/Tween-class.html

[Disambiguate CurvedAnimation and CurveTween]: {{site.repo.flutter}}/issues/185468
[Docs should instruct user to dispose CurvedAnimation]: {{site.repo.flutter}}/issues/183292
[Rename CurvedAnimation to ReversibleCurvedAnimation for disambiguation]: {{site.repo.flutter}}/pull/185501
[Migrate internal uses of CurvedAnimation]: {{site.repo.flutter}}/pull/185576
