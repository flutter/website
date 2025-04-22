---
title: RenderConstrainedLayoutBuilder renamed RenderAbstractLayoutBuilderMixin
description: >
  `RenderConstrainedLayoutBuilder` is replaced by
  `RenderAbstractLayoutBuilderMixin` with a new `layoutInfo` getter to implement.
---

## Summary

`RenderConstrainedLayoutBuilder` is renamed `RenderAbstractLayoutBuilderMixin`. The same functionality can be
achieved by using the new mixin, while a new getter `layoutInfo` will also be required of implementors.

## Background

`RenderObject`'s standard layout mechanism, optimized with re-layout boundaries, generally restricts a
`RenderObject`'s ability to access layout information, like size or constraints, to only its direct
children, not other descendants. This standard behavior simplified dependencies but complicated some common
UI patterns.

The change that includes these updates overcomes that limitation by making this information more available. For example,
it permits an `OverlayPortal.overlayChild`'s widget tree to use layout data from another `Overlay` child subtree,
provided that subtree lays out first.

## Migration guide

To migrate, replace references to the `RenderConstrainedLayoutBuilder` with `RenderAbstractLayoutBuilderMixin`, and implement `layoutInfo`. In most `RenderObject`s, the `layoutInfo` should be implemented to return the `RenderObject.constraints`.

Code before migration:

```dart
class SliverLayoutBuilder extends ConstrainedLayoutBuilder<SliverConstraints> {
  const SliverLayoutBuilder({super.key, required super.builder});

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderSliverLayoutBuilder();

  // The updateRenderObject method may be implemented as well in your own code.
}

class _RenderSliverLayoutBuilder extends RenderSliver
    with RenderObjectWithChildMixin<RenderSliver>,
         RenderConstrainedLayoutBuilder<SliverConstraints, RenderSliver> {

  // Irrelevant implementation details not shown.
}
```

Code after migration:

```dart
class SliverLayoutBuilder extends ConstrainedLayoutBuilder<SliverConstraints> {
  const SliverLayoutBuilder({super.key, required super.builder});

  // Updated return type to reflect the new mixin.
  @override
  RenderAbstractLayoutBuilderMixin<SliverConstraints, RenderSliver> createRenderObject(BuildContext context) => _RenderSliverLayoutBuilder();

  // Change of return type name also applies if updateRenderObject is implemented.
}

class _RenderSliverLayoutBuilder extends RenderSliver
    with RenderObjectWithChildMixin<RenderSliver>,
         // Updated mixin name.
         RenderAbstractLayoutBuilderMixin<SliverConstraints, RenderSliver> {

  // Add implementation of layoutInfo getter.
  @protected
  @override
  SliverConstraints get layoutInfo => constraints;

  // Irrelevant implementation details not shown.
}
```

## Timeline

Landed in version: 3.32.0-0.0.pre<br>
In stable release: not yet

## References

API documentation:

* [`RenderAbstractLayoutBuilderMixin`][]
* [`RenderObject`][]
* [`Overlay`][]
* [`OverlayPortal`][]

Relevant PRs:

* [OverlayPortal.overlayChildLayoutBuilder][]

[`RenderAbstractLayoutBuilderMixin`]: {{site.api}}/flutter/widgets/RenderAbstractLayoutBuilderMixin-mixin.html
[`RenderObject`]: {{site.api}}/flutter/rendering/RenderObject-class.html
[`Overlay`]: {{site.api}}/flutter/widgets/Overlay-class.html
[`OverlayPortal`]: {{site.api}}/flutter/widgets/OverlayPortal-class.html

[OverlayPortal.overlayChildLayoutBuilder]: {{site.repo.flutter}}/issues/164034
