---
title: ImageFilter default tile mode automatic selection.
description: >-
  ImageFilter will now selected a tile mode based on rendering context if one
  was not specified in the constructor.
---

## Summary

  The `ui.ImageFilter`'s default tile mode is now automatically selected by the
  backend. Previously `TileMode.clamp` was used unless a different tile mode
  was specified. A value of `null` when passed to the filter's constructor
  specifies automatic selection.

## Background

  The tile mode of a `ImageFilter` declares what happens to edge pixels of
  the applied filter. There are four options, `TileMode.clamp`,
  `Tilemode.repeated`, `TileMode.mirror`, and `TileMode.decal`. The default for
  ui.ImageFilter is `TileMode.clamp`. We've observed that the behavior of clamp
  does not match most developer's expections about filter operations. Instead,
  decal better matches the intuition for saveLayers, as edge pixels are left
  as transparent black. For backdrop filters, `mirror` is used which prevents
  falloff on blurs.

## Migration guide

  Only image filters that do not specify an explicit tile mode will be
  impacted. Developers can specify an explicit tile mode in these cases
  to retain the prior behavior. However, we believe the automatic
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
[`TileMode`]: https://api.flutter.dev/flutter/dart-ui/TileMode.html
[Issue #154935]: https://github.com/flutter/flutter/issues/154935
[Issue #110318]: https://github.com/flutter/flutter/issues/110318
[Issue #157693]: https://github.com/flutter/flutter/issues/157693
[Change default TileMode for blur ImageFilter objects to null]: https://github.com/flutter/engine/pull/55552
