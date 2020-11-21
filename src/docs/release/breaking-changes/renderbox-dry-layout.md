---
title: Dry layout support for RenderBox
description: The method "computeDryLayout" was added to the RenderBox protocol to correctly calculate its intrinsic size in certain situations.
---

## Summary

A new method named `computeDryLayout` was added to the `RenderBox` protocol.
Subclasses of `RenderBox` are expected to implement it to correctly report
their desired size given a set of `BoxConstraints` during intrinsics
calculations. Subclasses, that implement `computeDryLayout` no longer need to
override `performResize`.

## Context

To correctly calculate the intrinsic sizes of a `RenderParagraph` with `WidgetSpan`
children and a `RenderWrap` the new method `computeDryLayout` was added to the
`RenderBox` protocol. The method receives a set of `BoxConstraints` and is
expected to calculate the resulting size of the `RenderBox` without changing
any internal state. It's essentially a dry run of `performLayout` that only
calculates the resulting size and doesn't place the children. The
`computeDryLayout` method is part of the intrinsics protocol (see also
`RenderBox.computeMinIntrinsicWidth` and friends).

## Description of change

Subclasses of `RenderBox` need to override the new `computeDryLayout` method
if they are used as a descendant of a RenderObject that may query the intrinsic
size of its children. Examples of widgets that due this are `IntrinsicHeight`
and `IntrinsicWidth`.

The default implementation of `RenderBox.performResize` will also use the size
computed by `computeDryLayout` to perform the resize. Overriding `performResize`
is therefore no longer necessary.

## Migration guide

Subclasses that already override `performResize` can be migrated by simply
changing the function signature from `void performResize()` to
`Size computeDryLayout(BoxConstraints constraints)` and by returning the
calculated size instead of assigning it to the `size` setter. The old
implementation of `performResize` can be removed.

Code before migration:

<!-- skip -->
```dart
  @override
  void performResize() {
     size = constraints.biggest;
  }
```

Code after migration:

<!-- skip -->
```dart
  // This replaces the old performResize method.
  @override
  Size computeDryLayout(BoxConstraints constraints) {
     return constraints.biggest;
  }
```

If the subclass does not override `performResize` the implementation of
`computeDryLayout` has to be extracted from the `performLayout` method.
Basically, `computeDryLayout` needs to do all the work `performLayout` is doing
to figure out the size of the `RenderBox`. However, instead of assigning it
to the `size` setter, it needs to return the computed size. If `computeDryLayout`
needs to know the size of its children, it must obtain that size by calling
`getDryLayout` on the child instead of calling `layout`.

## Timeline

Landed in version: xxx<br>
In stable release: not yet

## References

{% include master-api.md %}

API documentation:
* [`RenderBox`][]
* [`computeMinInstrinsicWidth`][]
* [`computeDryLayout`][]
* [`getDryLayout`][]
* [`performResize`][]
* [`RenderWrap`][]
* [`RenderParagraph`][]

Relevant issues:
* [Issue 48679][]

Relevant PRs:
* [Fixes Intrinsics for RenderParagraph and RenderWrap][]

Master channel link:
[`RenderBox`]: https://master-api.flutter.dev/flutter/rendering/RenderBox-class.html
[`computeMinInstrinsicWidth`]: https://master-api.flutter.dev/flutter/rendering/RenderBox/computeMinIntrinsicWidth.html
[`computeDryLayout`]: https://master-api.flutter.dev/flutter/rendering/RenderBox/computeDryLayout.html
[`getDryLayout`]: https://master-api.flutter.dev/flutter/rendering/RenderBox/getDryLayout.html
[`performResize`]: https://master-api.flutter.dev/flutter/rendering/RenderBox/performResize.html
[`RenderWrap`]: https://master-api.flutter.dev/flutter/rendering/RenderWrap-class.html
[`RenderParagraph`]: https://master-api.flutter.dev/flutter/rendering/RenderParagraph-class.html

[Issue 48679]: {{site.github}}flutter/flutter/issues/48679]
[Fixes Intrinsics for RenderParagraph and RenderWrap]: {{site.github}}/flutter/flutter/pull/70656
