---
title: Page transitions replaced by ZoomPageTransitionsBuilder
description: Using the latest page transition instead of the old one.
---

## Summary

In order to keep libraries follow the latest OEM behavior,
we've replaced the default page transition builders from
`FadeUpwardsPageTransitionsBuilder` to
`ZoomPageTransitionsBuilder` on all platforms excluding iOS and macOS.

## Context

`FadeUpwardsPageTransitionsBuilder` came with the first
Flutter release, which defines a page transition that's
similar to the one provided by Android O.

`ZoomPageTransitionsBuilder` defines a page transition that's
similar to the one provided by Android Q and R.

According to the [Style guide for Flutter repo][],
the framework will follow the latest OEM behavior.
Page transition builders using `FadeUpwardsPageTransitionsBuilder`
are all switched to the `ZoomPageTransitionsBuilder`.
When the current `TargetPlatform` doesn't have
`PageTransitionsBuilder` defined in the `ThemeData.pageTransitionsTheme`,
`ZoomPageTransitionsBuilder` will be use as default.

[Style guide for Flutter repo]: {{site.repo.flutter}}/wiki/Style-guide-for-Flutter-repo

## Description of change

`PageTransitionsBuilder`s defined in
`PageTransitionsTheme._defaultBuilders` have changed from
`FadeUpwardsPageTransitionsBuilder` to
`ZoomPageTransitionsBuilder` for `TargetPlatform.android`,
`TargetPlatform.linux` and `TargetPlatform.windows`.

## Migration guide

If you want to switch back to the previous page transition builder
(`FadeUpwardsPageTransitionsBuilder`), you should define builders
explicitly for the target platforms.

Code before migration:

<!-- skip -->
```dart
MaterialApp(
  theme: ThemeData(primarySwatch: Colors.blue),
)
```

Code after migration:

<!-- skip -->
```dart
MaterialApp(
  theme: ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(), // Apply this to every platforms you need.
      },
    ),
  ),
)
```

If you want to apply the same page transition builder to all platforms:

<!-- skip -->
```dart
MaterialApp(
  theme: ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
        TargetPlatform.values,
        value: (dynamic _) => const ZoomPageTransitionsBuilder(),
      ),
    ),
  ),
)

```

## Timeline

Landed in version: v2.9.0-1.0.pre<br>
In stable release: Not yet

## References

API documentation:
* [`ZoomPageTransitionsBuilder`][]
* [`FadeUpwardsPageTransitionsBuilder`][]
* [`PageTransitionsTheme`][]

Relevant issues:
* [Issue 43277][]

Relevant PR:
* [PR 96375][]

[`ZoomPageTransitionsBuilder`]: {{site.api}}/flutter/material/ZoomPageTransitionsBuilder-class.html
[`FadeUpwardsPageTransitionsBuilder`]: {{site.api}}/flutter/material/FadeUpwardsPageTransitionsBuilder-class.html
[`PageTransitionsTheme`]: {{site.api}}/flutter/material/PageTransitionsTheme-class.html
[Issue 43277]: {{site.repo.flutter}}/issues/43277
[PR 96375]: {{site.repo.flutter}}/pull/96375
