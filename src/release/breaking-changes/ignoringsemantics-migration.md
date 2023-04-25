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
Therefore, this workaround is no longer needed.

## Description of change

`ignoringSemantics` was removed.

## Migration guide

If you set this parameter to true in these widgets, consider using
`ExcludeSemantics` instead.

Code before migration:

```dart
IgnorePointer(``
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
```

The behavior of setting `ignoringSemantics` to false is no longer supported.
Consider creating your own custom widget.

```dart
/// A widget ignores pointer event but still keeps semantics actions.
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
```


## Timeline

Landed in version: TBD  <br>
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
