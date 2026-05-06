---
title: Deprecate `OverlayPortal.targetsRootOverlay` and enforce `LookupBoundary` in `Overlay.of`
description: >-
  Learn about changes to the OverlayPortal and Overlay in Flutter.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `OverlayPortal.targetsRootOverlay` property was deprecated and
replaced with `overlayLocation`.

The `Overlay.of` and `Overlay.maybeOf` now respect `LookupBoundary`.

## Context

A `overlayLocation` parameter was added to
the `OverlayPortal` default constructor to
control where the overlay child renders.
As a result, the `OverlayPortal.targetsRootOverlay` constructor is
no longer useful.

To prevent an `OverlayEntry` from being inserted across multi-view boundaries
by mistake, `Overlay.of` now respects `LookupBoundary`.

## Description of change

The `OverlayPortal.targetsRootOverlay` constructor is deprecated.

The `Overlay.of` and `Overlay.maybeOf` will not lookup past `LookupBoundary`.

## Migration guide

If you are using `OverlayPortal.targetsRootOverlay`,
use `OverlayPortal` with `overlayLocation` instead.

### Case 1: trivial case

Code before migration:

```dart
Widget build(BuildContext context) {
  return OverlayPortal.targetsRootOverlay(
    controller: myController,
    overlayChildBuilder: _myBuilder,
    child: myChild,
  );
}
```

Code after migration:

```dart highlightLines=3
Widget build(BuildContext context) {
  return OverlayPortal(
    overlayLocation: OverlayChildLocation.rootOverlay,
    controller: myController,
    overlayChildBuilder: _myBuilder,
    child: myChild,
  );
}
```

If you expect `Overlay.of` and `Overlay.maybeOf` to lookup past `LookupBoundary`,
use `findAncestorStateOfType` instead.

Code before migration:

```dart
Widget build(BuildContext context) {
  Overlay.of(context);
  // ...
}
```

Code after migration:

```dart
Widget build(BuildContext context) {
  context.findAncestorStateOfType<OverlayState>();
  // ...
}
```

## Timeline

Landed in version: 3.38.0-0.1.pre<br>
In stable release: 3.38

## References

API documentation:

* [`OverlayPortal`][]
* [`Overlay.of`][]
* [`Overlay.maybeOf`][]
* [`LookupBoundary`][]

Relevant issue:

* [Issue 168785][]

Relevant PR:

* [PR 174239][]

[`OverlayPortal`]: {{site.api}}/flutter/widgets/OverlayPortal-class.html
[`Overlay.of`]: {{site.api}}/flutter/widgets/Overlay/of.html
[`Overlay.maybeOf`]: {{site.api}}/flutter/widgets/Overlay/maybeOf.html
[`LookupBoundary`]: {{site.api}}/flutter/widgets/LookupBoundary-class.html
[Issue 168785]: {{site.repo.flutter}}/issues/168785
[PR 174239]: {{site.repo.flutter}}/pull/174239
