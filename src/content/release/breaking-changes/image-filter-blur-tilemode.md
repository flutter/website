---
title: ImageFilter.blur default tile mode automatic selection.
description: >-
  If a tile mode wasn't specified in the constructor, ImageFilter.blur will
  select one based on the rendering context.
---

## Summary

  The `ui.ImageFilter.blur`'s default tile mode is now automatically selected
  by the backend. Previously `TileMode.clamp` was used unless a different tile
  mode was specified. Passing a value of `null` to the filter's constructor
  specifies automatic selection.

## Background

  `ImageFilter`'s _tile mode_ specifies what happens to edge pixels for the
  applied filter. There are four options, `TileMode.clamp` (the previous
  default), `Tilemode.repeated`, `TileMode.mirror`, and `TileMode.decal`.
  Previously, `ImageFilter` defaulted to `clamp` mode if the
  behavior wasn't specified, which sometimes surprised developers
  as it didn't always match expectations.

  As of this change, the filter automatically selects the following tile modes
  based on context:

  * `decal` with save layers and when applied to individual draws.
  * `mirror` with backdrop filters.
  * `clamp` for drawImage.

## Migration guide

  Only image filters that don't specify an explicit tile mode are
  impacted by this change. In these cases, you can specify an explicit tile
  mode to retain the prior behavior. However, we believe the automatic
  selection of behavior will be a superior choice in most cases.

Code before migration:

```dart
var filter = ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4);
```

Code after migration:

```dart
// Set tile mode to old default.
var filter = ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4, tileMode: TileMode.clamp);
```

## Timeline

Landed in version: xxx<br>
In stable release: Not yet

## References

{% include docs/main-api.md %}

API documentation:

* [`ImageFilter`][]
* [`TileMode`][]

Relevant issues:

* [Issue #154935][]
* [Issue #110318][]
* [Issue #157693][]

Relevant PRs:

* [Change default TileMode for blur ImageFilter objects to null][]


[`ImageFilter`]: https://api.flutter.dev/flutter/dart-ui/ImageFilter-class.html
[`ImageFilter.blur`]: https://api.flutter.dev/flutter/dart-ui/ImageFilter/ImageFilter.blur.html
[`TileMode`]: https://api.flutter.dev/flutter/dart-ui/TileMode.html
[Issue #154935]: https://github.com/flutter/flutter/issues/154935
[Issue #110318]: https://github.com/flutter/flutter/issues/110318
[Issue #157693]: https://github.com/flutter/flutter/issues/157693
[Change default TileMode for blur ImageFilter objects to null]: https://github.com/flutter/engine/pull/55552
