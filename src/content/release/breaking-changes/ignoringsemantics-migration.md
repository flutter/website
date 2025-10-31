---
title: Migration guide for ignoringSemantics in IgnorePointer and related classes
description: Removal of ignoringSemantics in IgnorePointer and related classes.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `IgnoringPointer` widget allows you to designate an area of the UI
where you don't want to accept pointer events, for example, when
you don't want to allow the user to enter text in a text field.

Previously, the `IgnorePointer` not only blocked pointer events but also
dropped its subtree from the semantics tree. The `ignoreSemantics` parameter
was introduced as a workaround to preserve the semantics tree when using
`IgnorePointer`s.

The `IgnorePointer` behavior has changed in that it no longer drops
the entire semantics subtree but merely blocks semantics actions in the
subtree. The `ignoringSemantics` workaround is no longer needed and is
deprecated.

This change also applies to the `AbsorbPointer` and
`SliverIgnorePointer` widgets.

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

If you are previously using `IgnorePointer`s with `ignoringSemantics` set to `false`,
you can achieve the same behavior by copying the follow widgets directly into your
code and use.

```dart
/// A widget ignores pointer events without modifying the semantics tree.
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
In stable release: 3.13.0

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
