---
title: Deprecate `OverlayPortal.targetsRootOverlay`
description: >-
  Learn about changes to the OverlayPortal in Flutter.
---

## Summary

The `OverlayPortal.targetsRootOverlay` property was deprecated and
replaced with `overlayLocation`.

## Context

A parameter `overlayLocation` was added to the OverlayPortal default constructor to
control where the overlay child renders. As the result, the constructor
`OverlayPortal.targetsRootOverlay` was no longer useful.

## Description of change

The `OverlayPortal.targetsRootOverlay` was deprecated.

## Migration guide

If you are using `OverlayPortal.targetsRootOverlay`, you can use `OverlayPortal` with
`overlayLocation` instead.

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

```dart
Widget build(BuildContext context) {
  return OverlayPortal(
    overlayLocation: OverlayChildLocation.rootOverlay,
    controller: myController,
    overlayChildBuilder: _myBuilder,
    child: myChild,
  );
}
```

## Timeline

Landed in version: 3.35.0-0.0.pre<br>
In stable release: TBD

## References

API documentation:

* [`OverlayPortal`][]

Relevant issue:

* [Issue 168785][]

Relevant PR:

* [PR 174239][]

[`OverlayPortal`]: {{site.api}}/flutter/widgets/OverlayPortal-class.html
[Issue 168785]: {{site.repo.flutter}}/issues/168785
[PR 174239]: {{site.repo.flutter}}/pull/174239
