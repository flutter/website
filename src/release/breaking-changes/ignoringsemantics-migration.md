---
title: Migration guide for ignoringSemantics in IgnorePointer and related classes
description: Removal of ignoringSemantics in IgnorePointer and related classes.
---

## Summary

The `ignoringSemantics` properties are removed in [`IgnorePointer`][],
[`AbsorbPointer`][], [`SliverIgnorePointer`][], [`RenderSliverIgnorePointer`][],
[`RenderIgnorePointer`][], and [`RenderAbsorbPointer`][].

## Context

The `ignoreSemantics` was introduced as a workaround to mitigate the result of
`IgnorePointer` and its related widgets dropping entire semantics subtrees.
Setting `ignoreSemantics` to false was the only way to preserve the semantics
subtree while using the `IgnorePointer` widget.

After v3.10.0-2.0.pre, the `IgnorePointer` widget no longer drops the entire semantics
subtree but only removes the pointer-related semantics actions. Therefore, this
workaround is no longer needed.

## Description of change

`ignoringSemantics` was removed.

## Migration guide

If you set this parameter to true in these widgets, consider using
`ExcludeSemantics` instead.

Code before migration:

```dart
IgnorePointer(
  ignoringSemantics: true,
  child: const PlaceHolder(),
);

AbsorbPointer(
  ignoringSemantics: true,
  child: const PlaceHolder(),
);

SliverIgnorePointer(
  ignoringSemantics: true,
  child: const PlaceHolder(),
);
```

Code after migration:

```dart
ExcludeSemantics(
  child: IgnorePointer(
    child: const PlaceHolder(),
  ),
);

ExcludeSemantics(
  child: AbsorbPointer(
    child: const PlaceHolder(),
  ),
);

SliverIgnorePointer(
  child: ExcludeSemantics(
    child: const PlaceHolder(),
  ),
);
```

Setting `ignoringSemantics` to false is no longer supported.
Consider creating your own custom widgets.

```dart
/// A widget ignores pointer event without modifying the semantics tree.
class _IgnorePointerWithSemantics extends SingleChildRenderObjectWidget {
  const _IgnorePointerWithSemantics({
    super.child,
  });

  @override
  _RenderIgnorePointerWithSemantics createRenderObject(BuildContext context) {
    return _RenderIgnorePointerWithSemantics();
  }
}

class _RenderIgnorePointerWithSemantics extends RenderProxyBox {
  _RenderIgnorePointerWithSemantics();

  @override
  bool hitTest(BoxHitTestResult result, { required Offset position }) => false;
}

/// A widget absorbs pointer events without modifying the semantics tree.
class _AbsorbPointerWithSemantics extends SingleChildRenderObjectWidget {
  const _AbsorbPointerWithSemantics({
    super.child,
  });

  @override
  _RenderAbsorbPointerWithSemantics createRenderObject(BuildContext context) {
    return _RenderAbsorbPointerWithSemantics();
  }
}

class _RenderAbsorbPointerWithSemantics extends RenderProxyBox {
  _RenderAbsorbPointerWithSemantics();

  @override
  bool hitTest(BoxHitTestResult result, { required Offset position }) {
    return size.contains(position);
  }
}

/// A sliver ignores pointer events without modifying the semantics tree.
class _SliverIgnorePointerWithSemantics extends SingleChildRenderObjectWidget {
  const _SliverIgnorePointerWithSemantics({
    super.child,
  });

  @override
  _RenderSliverIgnorePointerWithSemantics createRenderObject(BuildContext context) {
    return _RenderSliverIgnorePointerWithSemantics();
  }
}

class _RenderSliverIgnorePointerWithSemantics extends RenderProxySliver {
  _RenderSliverIgnorePointerWithSemantics();

  @override
  bool hitTest(BoxHitTestResult result, { required Offset position }) => false;
}
```

## Timeline

Landed in version: 3.10.0-2.0.pre<br>
In stable release: TBD

## References

Relevant PRs:

* [PR 120619][]: Fixes IgnorePointer and AbsorbPointer to only block user
  interactions in a11y.

[PR 120619]: {{site.repo.flutter}}/pull/120619
[`IgnorePointer`]: {{site.api}}/flutter/widgets/IgnorePointer-class.html
[`AbsorbPointer`]: {{site.api}}/flutter/widgets/AbsorbPointer-class.html
[`SliverIgnorePointer`]: {{site.api}}/flutter/widgets/SliverIgnorePointer-class.html
[`RenderSliverIgnorePointer`]: {{site.api}}/flutter/rendering/RenderSliverIgnorePointer-class.html
[`RenderIgnorePointer`]: {{site.api}}/flutter/rendering/RenderIgnorePointer-class.html
[`RenderAbsorbPointer`]: {{site.api}}/flutter/rendering/RenderAbsorbPointer-class.html
