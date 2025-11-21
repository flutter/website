---
title: Material Color Utilities update in Flutter
description: >-
  The latest Material Color Utilities have been applied to the Flutter Material
  library.
---

{% render "docs/breaking-changes.md" %}

## Summary

This release updates `package:material_color_utilities` from
`v0.11.1` to `0.13.0`. This updated package includes algorithm changes that align
with the [Material 3 tokens update](/release/breaking-changes/material-design-3-token-update).

The algorithm changes affect the same properties:

* `onPrimaryContainer`
* `onSecondaryContainer`
* `onTertiaryContainer`
* `onErrorContainer`

The changes will be reflected when generating a scheme using

* `ColorScheme.fromSeed`
* `ColorScheme.fromImageProvider`
* `ThemeData(colorScheme:..)`

## Migration guide

In general, we believe the colors generated will be more legible and visually
appealing, but if you want to maintain the previous colors when upgrading
you will have to manually set those properties to their desired color after
generating.

## Timeline

* Landed in version: `3.39.0-1.0.pre-250`
* In stable release: TBD

## References

* Relevant commit: [Update material_color_utilities to v0.13.0](https://github.com/flutter/flutter/commit/153fd7fc603836d8d57032a9cb93118245dfba8c)
