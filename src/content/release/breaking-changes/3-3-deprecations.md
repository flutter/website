---
title: Deprecated API removed after v3.3
description: >
  After reaching end of life, the following deprecated APIs
  were removed from Flutter.
---

## Summary

In accordance with Flutter's [Deprecation Policy][],
deprecated APIs that reached end of life after the
3.3 stable release have been removed.

All affected APIs have been compiled into this
primary source to aid in migration. A
[quick reference sheet][] is available as well.

[Deprecation Policy]: {{site.repo.flutter}}/blob/master/docs/contributing/Tree-hygiene.md#deprecations
[quick reference sheet]: /go/deprecations-removed-after-3-3

## Changes

This section lists the deprecations, listed by the affected class.

### `RenderUnconstrainedBox`

Supported by Flutter Fix: no

`RenderUnconstrainedBox` was deprecated in v2.1.
Use `RenderConstraintsTransformBox` instead.

Where unconstrained in both axes, provide `ConstraintsTransformBox.unconstrained`
to `constraintsTransform`.

If `RenderUnconstrainedBox.constrainedAxis` was previously set,
replace respectively:

- Where `constrainedAxis` was previously `Axis.horizontal`, set
  `constraintsTransform` to `ConstraintsTransformBox.widthUnconstrained`.
- Where `constrainedAxis` was previously `Axis.vertical`, set
  `constraintsTransform` to `ConstraintsTransformBox.heightUnconstrained`.

This change allowed for the introduction of several more types of constraint
transformations through `ConstraintsTransformBox`. Other parameters of the old
API are compatible with the new API.

**Migration guide**

Code before migration:

```dart
// Unconstrained
final RenderUnconstrainedBox unconstrained = RenderUnconstrainedBox(
  textDirection: TextDirection.ltr,
  child: RenderConstrainedBox(
    additionalConstraints: const BoxConstraints.tightFor(height: 200.0),
  ),
  alignment: Alignment.center,
);

// Constrained in horizontal axis
final RenderUnconstrainedBox unconstrained = RenderUnconstrainedBox(
  constrainedAxis: Axis.horizontal,
  textDirection: TextDirection.ltr,
  child: RenderConstrainedBox(
    additionalConstraints: const BoxConstraints.tightFor(width: 200.0, height: 200.0),
  ),
  alignment: Alignment.center,
);

// Constrained in vertical axis
final RenderUnconstrainedBox unconstrained = RenderUnconstrainedBox(
  constrainedAxis: Axis.vertical,
  textDirection: TextDirection.ltr,
  child: RenderFlex(
    direction: Axis.vertical,
    textDirection: TextDirection.ltr,
    children: <RenderBox>[flexible],
  ),
  alignment: Alignment.center,
);
```

Code after migration:

```dart
// Unconstrained
final RenderConstraintsTransformBox unconstrained = RenderConstraintsTransformBox(
  constraintsTransform: ConstraintsTransformBox.unconstrained,
  textDirection: TextDirection.ltr,
  child: RenderConstrainedBox(
    additionalConstraints: const BoxConstraints.tightFor(height: 200.0),
  ),
  alignment: Alignment.center,
);

// Constrained in horizontal axis
final RenderConstraintsTransformBox unconstrained = RenderConstraintsTransformBox(
  constraintsTransform: ConstraintsTransformBox.widthUnconstrained,
  textDirection: TextDirection.ltr,
  child: RenderConstrainedBox(
    additionalConstraints: const BoxConstraints.tightFor(width: 200.0, height: 200.0),
  ),
  alignment: Alignment.center,
);

// Constrained in vertical axis
final RenderConstraintsTransformBox unconstrained = RenderConstraintsTransformBox(
  constraintsTransform: ConstraintsTransformBox.widthUnconstrained,
  textDirection: TextDirection.ltr,
  child: RenderFlex(
    direction: Axis.vertical,
    textDirection: TextDirection.ltr,
    children: <RenderBox>[flexible],
  ),
  alignment: Alignment.center,
);
```

**References**

API documentation:

* [`RenderConstraintsTransformBox`][]
* [`ConstraintsTransformBox`][]

Relevant PRs:

* Deprecated in [#78673][]
* Removed in [#111711][]

[`RenderConstraintsTransformBox`]: {{site.api}}/flutter/rendering/RenderConstraintsTransformBox-class.html
[`ConstraintsTransformBox`]: {{site.api}}/flutter/widgets/ConstraintsTransformBox-class.html
[#78673]: {{site.repo.flutter}}/pull/78673
[#111711]: {{site.repo.flutter}}/pull/111711

---

### `DragAnchor`, `Draggable.dragAnchor` & `LongPressDraggable.dragAnchor`

Supported by Flutter Fix: yes

The enum `DragAnchor`, and its uses in `Draggable.dragAnchor` &
`LongPressDraggable.dragAnchor` were deprecated in v2.1.
Use `dragAnchorStrategy` instead.

This change allowed for more accurate feedback of the draggable widget when used
in conjunction with other widgets like `Stack` and `InteractiveViewer`.

**Migration guide**

Code before migration:

```dart
Draggable draggable = Draggable();
draggable = Draggable(dragAnchor: DragAnchor.child);
draggable = Draggable(dragAnchor: DragAnchor.pointer);

LongPressDraggable longPressDraggable = LongPressDraggable();
longPressDraggable = LongPressDraggable(dragAnchor: DragAnchor.child);
longPressDraggable = LongPressDraggable(dragAnchor: DragAnchor.pointer);
```

Code after migration:

```dart
Draggable draggable = Draggable();
draggable = Draggable(dragAnchorStrategy: childDragAnchorStrategy);
draggable = Draggable(dragAnchorStrategy: pointerDragAnchorStrategy);

LongPressDraggable longPressDraggable = LongPressDraggable();
longPressDraggable = LongPressDraggable(dragAnchorStrategy: childDragAnchorStrategy);
longPressDraggable = LongPressDraggable(dragAnchorStrategy: pointerDragAnchorStrategy);
```

**References**

API documentation:

* [`Draggable`][]
* [`LongPressDraggable`][]
* [`DragAnchorStrategy`][]

Relevant issues:

* [#73143][]

Relevant PRs:

* Deprecated in [#79160][]
* Removed in [#111713][]

[`Draggable`]: {{site.api}}/flutter/widgets/Draggable-class.html
[`LongPressDraggable`]: {{site.api}}/flutter/widgets/LongPressDraggable-class.html
[`DragAnchorStrategy`]: {{site.api}}/flutter/widgets/DragAnchorStrategy.html
[#73143]: {{site.repo.flutter}}/pull/73143
[#79160]: {{site.repo.flutter}}/pull/79160
[#111713]: {{site.repo.flutter}}/pull/111713

---

### `ScrollBehavior.buildViewportChrome`

Supported by Flutter Fix: yes

The method `ScrollBehavior.buildViewportChrome` was deprecated in v2.1.

This method was used by the `Scrollable` widget to apply an overscroll
indicator, like `GlowingOverscrollIndicator`, by default on the appropriate
platforms. As more default decorators have been added, like `Scrollbar`s, each
has instead been split into individual methods to replace `buildViewportChrome`.

This allows extending classes to only override the specific decorator, through
`buildScrollbar` or `buildOverscrollIndicator`, rather than needing to rewrite
code in order to maintain one or the other.

**Migration guide**

[In-depth migration guide available][]

Code before migration:

```dart
final ScrollBehavior scrollBehavior = ScrollBehavior();
scrollBehavior.buildViewportChrome(context, child, axisDirection);
```

Code after migration:

```dart
final ScrollBehavior scrollBehavior = ScrollBehavior();
scrollBehavior.buildOverscrollIndicator(context, child, axisDirection);
```

**References**

Design document:

* [Exposing & Updating ScrollBehaviors][]

API documentation:

* [`ScrollBehavior`][]

Relevant issues:

* [Scrollbars should be always visible and instantiated by default on web and desktop][]

Relevant PRs:

* [#76739][]
* Deprecated in [#78588][]
* Removed in [#111715][]

[In-depth migration guide available]: /release/breaking-changes/default-desktop-scrollbars
[Exposing & Updating ScrollBehaviors]: /go/exposing-scroll-behaviors
[`ScrollBehavior`]: {{site.api}}/flutter/widgets/ScrollBehavior-class.html
[Scrollbars should be always visible and instantiated by default on web and desktop]: {{site.repo.flutter}}/issues/40107
[#76739]: {{site.repo.flutter}}/pull/76739
[#78588]: {{site.repo.flutter}}/pull/78588
[#111715]: {{site.repo.flutter}}/pull/111715

---

## Timeline

In stable release: 3.7
