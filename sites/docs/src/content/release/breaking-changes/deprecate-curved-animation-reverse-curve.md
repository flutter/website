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
those listeners would leak.

However, most animations use the same curve for the forward
and reverse directions.

To make the common case leak-proof, `CurvedAnimation`'s
`reverseCurve` functionality is moving to a separate class:
[`AsymmetricCurvedAnimation`][].

In the future, the `reverseCurve` field will be removed from
`CurvedAnimation`.

:::note
Until the deprecation period is over, you must continue to
call [`dispose`][] on [`CurvedAnimation`].
If you switch to [`AsymmetricCurvedAnimation`][], you must always call its
[`dispose`][AsymmetricCurvedAnimation.dispose] method to clean up its
active direction listeners.
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
[`dispose`]: {{site.main-api}}/flutter/animation/CurvedAnimation/dispose.html
[AsymmetricCurvedAnimation.dispose]: {{site.main-api}}/flutter/animation/AsymmetricCurvedAnimation/dispose.html
[`parent`]: {{site.main-api}}/flutter/animation/CurvedAnimation/parent.html
[`reverseCurve`]: {{site.main-api}}/flutter/animation/CurvedAnimation/reverseCurve.html

[Disambiguate CurvedAnimation and CurveTween]: {{site.repo.flutter}}/issues/185468
[Docs should instruct user to dispose `CurvedAnimation`]: {{site.repo.flutter}}/issues/183292
[Deprecate `CurvedAnimation.reverseCurve` for `AsymmetricCurvedAnimation`]: {{site.repo.flutter}}/pull/185797
