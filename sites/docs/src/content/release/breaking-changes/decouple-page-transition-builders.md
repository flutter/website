---
title: Page transition builders reorganization
description: >-
  CupertinoPageTransitionsBuilder has been moved from the
  Material library to the Cupertino library where it belongs.
---

{% render "docs/breaking-changes.md" %}

## Summary

`CupertinoPageTransitionsBuilder` has been relocated from
`package:flutter/material.dart` to `package:flutter/cupertino.dart`.

## Background

Flutter provides several page transition builders that control
how routes animate when navigating between pages. These builders
are used with `PageTransitionsTheme` to customize transitions
per platform.

The available page transition builders are:

| Builder | Library | Description |
|---------|---------|-------------|
| `FadeUpwardsPageTransitionsBuilder` | Material | Default pre-Material 3 transition |
| `OpenUpwardsPageTransitionsBuilder` | Material | Vertical slide transition |
| `ZoomPageTransitionsBuilder` | Material | Zoom transition (Material 3 default) |
| `PredictiveBackPageTransitionsBuilder` | Material | Android predictive back gesture support |
| `CupertinoPageTransitionsBuilder` | **Cupertino** | iOS-style horizontal slide transition |

Previously, `CupertinoPageTransitionsBuilder` was defined in the
Material library alongside the other builders. However, this class
is semantically a Cupertino component—its implementation uses
Cupertino transition mixins and provides iOS-style navigation
animations.

This move improves code organization and allows Cupertino apps to use this
builder without depending on the Material library.

## Migration guide

If you use `CupertinoPageTransitionsBuilder` and only import
`package:flutter/material.dart`, add an import for
`package:flutter/cupertino.dart`.

Code before migration:

```dart
import 'package:flutter/material.dart';

final pageTransitionsTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  },
);
```

Code after migration:

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final pageTransitionsTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  },
);
```

If your app already imports both packages, no changes are needed.

## Timeline

Landed in version: Not yet released<br>
In stable release: Not yet released

## References

Relevant PRs:

* [Decouple CupertinoPageTransitionsBuilder from Material][]

[Decouple CupertinoPageTransitionsBuilder from Material]: {{site.repo.flutter}}/pull/179776
