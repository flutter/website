---
title: Deprecate `CurvedAnimation.reverseCurve` in favor of `AsymmetricCurvedAnimation`
description: >-
  CurvedAnimation is becoming a single-curve animation.
  Use AsymmetricCurvedAnimation for different curves in
  the forward and reverse directions.
---

{% render "docs/breaking-changes.md" %}

## Summary

[`CurvedAnimation`][]'s [`reverseCurve`][] field has been deprecated.

To use distinct curves for forward and reverse directions,
switch from [`CurvedAnimation`][] to [`AsymmetricCurvedAnimation`][].

## Background

To support its [`reverseCurve`][] functionality,
`CurvedAnimation` had to add listeners to its [`parent`][]
to keep track of its direction.
If you forget to call the [`dispose`][] method when you're done,
those listeners would stick around in memory and prevent Dart from
freeing up unneeded resources.

But the most common use case of `CurvedAnimation` is with a single curve,
meaning these listeners aren't even needed most of the time.

For this reason, [`reverseCurve`][] is being removed from [`CurvedAnimation`][]
and moved to [`AsymmetricCurvedAnimation`][].

After a migration period,
it will be removed from `CurvedAnimation` alongside its listeners.
This means more memory safety with [`CurvedAnimation`][] and
less code to write, since you won't need to dispose it.

:::note
Until the migration period is over,
remember to still call [`dispose`] when you're done.

If you use [`AsymmetricCurvedAnimation`][],
you still need to call its [`dispose`][] method regardless.
:::

## Migration guide

If you need [`CurvedAnimation`][]'s [`reverseCurve`][] field,
switch from [`CurvedAnimation`][] to [`AsymmetricCurvedAnimation`][].

Code before migration:

```dart
// This doesn't use `reverseCurve` so it stays as `CurvedAnimation`:
final oneCurve = CurvedAnimation(
  parent: _animationController,
  curve: Curves.easeIn,
);

// This uses `reverseCurve` so migrate to `AsymmetricCurvedAnimation`:
final twoCurves = CurvedAnimation(
  parent: _animationController,
  curve: Curves.easeIn,
  reverseCurve: Curves.easeOut,
);
```

Code after migration:

```dart
// This doesn't use `reverseCurve` so it stays as `CurvedAnimation`:
final oneCurve = CurvedAnimation(
  parent: _animationController,
  curve: Curves.easeIn,
);

// This uses `reverseCurve` so migrate to `AsymmetricCurvedAnimation`:
final twoCurves = AsymmetricCurvedAnimation(
  parent: _animationController,
  curve: Curves.easeIn,
  reverseCurve: Curves.easeOut,
);
```

## Timeline

Landed in version: Not yet<br>
In stable release: Not yet

## References

{% render "docs/main-api.md", site: site %}

API documentation:

* [`CurvedAnimation`][]
* [`AsymmetricCurvedAnimation`][]

Relevant issues:

* [Disambiguate CurvedAnimation and CurveTween][]
* [Docs should instruct user to dispose `CurvedAnimation`][]

Relevant PRs:

* [Deprecate `CurvedAnimation.reverseCurve` for `AsymmetricCurvedAnimation`][]

[`AsymmetricCurvedAnimation`]: {{site.main-api}}/flutter/animation/AsymmetricCurvedAnimation-class.html
[`CurvedAnimation`]: {{site.main-api}}/flutter/animation/CurvedAnimation-class.html
[`dispose`]: {{site.main-api}}/flutter/animation/AsymmetricCurvedAnimation/dispose.html
[`parent`]: {{site.main-api}}/flutter/animation/CurvedAnimation/parent.html
[`reverseCurve`]: {{site.main-api}}/flutter/animation/AsymmetricCurvedAnimation/reverseCurve.html

[Disambiguate CurvedAnimation and CurveTween]: {{site.repo.flutter}}/issues/185468
[Docs should instruct user to dispose `CurvedAnimation`]: {{site.repo.flutter}}/issues/183292
[Deprecate `CurvedAnimation.reverseCurve` for `AsymmetricCurvedAnimation`]: {{site.repo.flutter}}/pull/185797
