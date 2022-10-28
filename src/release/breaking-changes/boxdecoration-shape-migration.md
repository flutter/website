---
title: Migration guide for BoxDecoration.circle
description: Removal of BoxDecoration.circle and how to migrate
---

## Summary

The `shape` parameter of `BoxDecoration` has been deprecated. Existing uses
of `BoxDecoration(shape: BoxShape.circle)` should use
`ShapeDecoration(shape: CircleBorder())` instead.

## Context

The enum property `BoxShape shape` from `BoxDecoration` has been deprecated,
as increasing the number of supported shapes through enums created
unnecessary complexity and performance costs.
Users should migrate to use `ShapeDecoration` in conjunction with
`ShapeBorder`, the replacement for `BoxShape`.

## Description of change

Remove `BoxDecoration(shape: BoxShape.circle)` and `BoxDecoration.shape`.

- Replace `BoxDecoration(shape: BoxShape.circle)` with
`ShapeDecoration(shape: CircleBorder())`.
- Remove the `BoxDecoration.shape` property from
`BoxDecoration(shape: BoxShape.rectangle)`.

## Migration guide

When you use `Border`,
`CircleBorder(width: ..., color: ..., strokeAlign: ...)` inherits
the `Border.all(width: ..., color: ..., strokeAlign: ...)` values.

Code before migration:

<!-- skip -->
```dart
BoxDecoration(
  shape: BoxShape.circle,
)

BoxDecoration(
  shape: BoxShape.circle,
  border: Border.all(width: 20, color: Colors.red),
  boxShadow: [],
)

BoxDecoration(
  shape: BoxShape.rectangle,
)
```

Code after migration:

<!-- skip -->
```dart
ShapeDecoration(
  border: CircleBorder(),
)

ShapeDecoration(
  border: CircleBorder(width: 20, color: Colors.red),
  shadows: [],
)

BoxDecoration()
```

## Timeline

Landed in version: TBD<br>
In stable release: not yet

## References

{% include docs/master-api.md %}

API documentation:

* [`BoxDecoration` stable][]
* [`BoxDecoration` main][]

Relevant issues:

* [Deprecate `BoxDecoration.shape` issue][]

Relevant PRs:

* [Deprecate `BoxDecoration.shape` PR][]

<!-- Stable channel link: -->
[`BoxDecoration` stable]: {{site.api}}/flutter/lib/src/painting/BoxDecoration-class.html

<!-- Master channel link: -->
{% include docs/master-api.md %}

[`BoxDecoration` main]: {{site.master-api}}/flutter/lib/src/painting/BoxDecoration-class.html

[Deprecate `BoxDecoration.shape` issue]: {{site.repo.flutter}}/issues/108051
[Deprecate `BoxDecoration.shape` PR]: {{site.repo.flutter}}/pull/108052
