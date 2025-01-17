---
title: ImageFilter.blur default tile mode automatic selection.
description: >-
  If a tile mode wasn't specified in the constructor, ImageFilter.blur will
  select one based on the rendering context.
---

## Summary

The `ui.ImageFilter.blur`'s default tile mode is
now automatically selected by the backend.
Previously `TileMode.clamp` was used unless a different tile mode was specified.
Now, the default is `null` and specifies automatic selection unless
a specific tile mode is specified.

## Background

`ImageFilter.blur`'s _tile mode_ specifies what happens to
edge pixels for the applied filter.
There are four options:

- `TileMode.clamp` (the previous default)
- `Tilemode.repeated`
- `TileMode.mirror`
- `TileMode.decal`

Previously, if the behavior wasn't specified,
`ImageFilter` defaulted to `clamp` mode.
This sometimes surprised developers as it didn't always match expectations.

As of this change, the filter automatically selects the
following tile modes based on context:

* `decal` with save layers and when applied to individual shape draws
          (such as with `drawRect` and `drawPath`).
* `mirror` with backdrop filters.
* `clamp` for `drawImage`.

## Migration guide

Only blur image filters that don't specify an explicit tile mode are
impacted by this change.

We believe that the new defaults are generally
better and would recommend removing any specified blur tile modes.

Code before migration:

```dart
final filter = ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4, tileMode: TileMode.decal);
```

Code after migration:

```dart
final filter = ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4);
```

## Timeline

Landed in version: 3.28.0-0.1.pre<br>
In stable release: Not yet

## References

API documentation:

* [`ImageFilter`][]
* [`TileMode`][]

Relevant issues:

* [Issue #154935][]
* [Issue #110318][]
* [Issue #157693][]

Relevant PRs:

* [Change default TileMode for blur ImageFilter objects to null][]

[`ImageFilter`]: {{site.api}}/flutter/dart-ui/ImageFilter-class.html
[`ImageFilter.blur`]: {{site.api}}/flutter/dart-ui/ImageFilter/ImageFilter.blur.html
[`TileMode`]: {{site.api}}/flutter/dart-ui/TileMode.html
[Issue #154935]: {{site.repo.flutter}}/issues/154935
[Issue #110318]: {{site.repo.flutter}}/issues/110318
[Issue #157693]: {{site.repo.flutter}}/issues/157693
[Change default TileMode for blur ImageFilter objects to null]: {{site.repo.engine}}/pull/55552
