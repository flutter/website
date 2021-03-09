---
title: Dry layout support for RenderBox
description: The method "computeDryLayout" was added to the RenderBox protocol to correctly calculate its intrinsic size in certain situations.
---

## Summary

A new method named `computeDryLayout` was added to the `RenderBox` protocol.
Subclasses of `RenderBox` are expected to implement it to correctly report
their desired size given a set of `BoxConstraints` during intrinsic
calculations. Subclasses that implement `computeDryLayout` no longer need to
override `performResize`.

## Context

A new method, `computeDryLayout`, was added to the `RenderBox` protocol to
correctly calculate the intrinsic sizes of a `RenderParagraph` with `WidgetSpan`
children and a `RenderWrap`. The method receives a set of `BoxConstraints` and
is expected to calculate the resulting size of the `RenderBox` without changing
any internal state. It's essentially a dry run of `performLayout` that only
calculates the resulting size and doesn't place the children. The
`computeDryLayout` method is part of the intrinsics protocol (see also
[`RenderBox.computeMinIntrinsicWidth`][] and friends).

## Description of change

Subclasses of `RenderBox` need to override the new `computeDryLayout` method
if they are used as a descendant of a `RenderObject` that may query the intrinsic
size of its children. Examples of widgets that do this are `IntrinsicHeight`
and `IntrinsicWidth`.

The default implementation of `RenderBox.performResize` also uses the size
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

If the subclass doesn't override `performResize`, the implementation of
`computeDryLayout` has to be extracted from the `performLayout` method.
Basically, `computeDryLayout` needs to do all the work `performLayout` is doing
to figure out the size of the `RenderBox`. However, instead of assigning it
to the `size` setter, it returns the computed size. If `computeDryLayout`
needs to know the size of its children, it must obtain that size by calling
`getDryLayout` on the child instead of calling `layout`.

If for some reason it is impossible to calculate the dry layout, `computeDryLayout`
must call `debugCannotComputeDryLayout` from within an assert and return a dummy
size of `const Size(0, 0)`. Calculating a dry layout is, for example, impossible
if the size of a `RenderBox` depends on the baseline metrics of its children.

<!-- skip -->
```dart
  @override
  Size computeDryLayout(BoxConstraints constraints) {
    assert(debugCannotComputeDryLayout(
      reason: 'Layout requires baseline metrics, which are only available after a full layout.'
    ));
    return const Size(0, 0);
  }
```

## Timeline

Landed in version: 1.25.0-4.0.pre<br>
In stable release: 2.0.0

## References

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

[`RenderBox`]: {{site.api}}/flutter/rendering/RenderBox-class.html
[`RenderBox.computeMinIntrinsicWidth`]: {{site.api}}/flutter/rendering/RenderBox/computeMinIntrinsicWidth.html
[`computeMinInstrinsicWidth`]: {{site.api}}/flutter/rendering/RenderBox/computeMinIntrinsicWidth.html
[`computeDryLayout`]: {{site.api}}/flutter/rendering/RenderBox/computeDryLayout.html
[`getDryLayout`]: {{site.api}}/flutter/rendering/RenderBox/getDryLayout.html
[`performResize`]: {{site.api}}/flutter/rendering/RenderBox/performResize.html
[`RenderWrap`]: {{site.api}}/flutter/rendering/RenderWrap-class.html
[`RenderParagraph`]: {{site.api}}/flutter/rendering/RenderParagraph-class.html

[Issue 48679]: {{site.github}}/flutter/flutter/issues/48679
[Fixes Intrinsics for RenderParagraph and RenderWrap]: {{site.github}}/flutter/flutter/pull/70656
