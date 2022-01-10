---
title: Page transitions replaced by ZoomPageTransitionsBuilder
description: Using the latest page transition instead of the old one.
---

## Summary

In order to keep libraries follow the latest OEM behavior,
we've replaced the default page transition builders from
`FadeUpwardsPageTransitionsBuilder` to
`ZoomPageTransitionsBuilder` on `TargetPlatform.android` and
`TargetPlatform.fuchsia`.

## Context

`FadeUpwardsPageTransitionsBuilder` came with the first
Flutter release, which defines a page transition that's
similar to the one provided by Android O.

`ZoomPageTransitionsBuilder` defines a page transition that's
similar to the one provided by Android Q and R.

According to the [Style guide for Flutter repo][], we've switched
the default page transitions which mainly for the Android platform.
Since the Fuchsia is a pure new OS, we also switched the page transition.

[Style guide for Flutter repo]: {{site.github}}/flutter/flutter/wiki/Style-guide-for-Flutter-repo

## Description of change

`PageTransitionsBuilder`s that defined in
`PageTransitionsTheme._defaultBuilders` have changed from
`FadeUpwardsPageTransitionsBuilder` to
`ZoomPageTransitionsBuilder` for `TargetPlatform.android` and
`TargetPlatform.fuchsia`.

## Migration guide

If you want to switch back to the previous page transition builder
(`FadeUpwardsPageTransitionsBuilder`), you should define builders
explicitly to the target platforms.

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
    primarySwatch: Colors.blue,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(), // Apply this to every platforms you need.
      },
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
* [PR 82670][]

[`ZoomPageTransitionsBuilder`]: {{site.api}}/flutter/material/ZoomPageTransitionsBuilder-class.html
[`FadeUpwardsPageTransitionsBuilder`]: {{site.api}}/flutter/material/FadeUpwardsPageTransitionsBuilder-class.html
[`PageTransitionsTheme`]: {{site.api}}/flutter/material/PageTransitionsTheme-class.html
[Issue 43277]: {{site.github}}/flutter/flutter/issues/43277
[PR 82670]: {{site.github}}/flutter/flutter/pull/82670
