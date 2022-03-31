---
title: Page transitions replaced by ZoomPageTransitionsBuilder
description: Using the latest page transition instead of the old one.
---

## Summary

In order to ensure that libraries follow the latest OEM behavior,
the default page transition builders now use
`ZoomPageTransitionsBuilder` on all platforms (excluding iOS and macOS)
instead of `FadeUpwardsPageTransitionsBuilder`.

## Context

The `FadeUpwardsPageTransitionsBuilder` (provided with the first
Flutter release), defined a page transition that's
similar to the one provided by Android O. This page transitions builder
will eventually be deprecated on Android, as per Flutter's
[deprecation policy]({{site.url}}/resources/compatibility#deprecation-policy).

`ZoomPageTransitionsBuilder`, the new page transition builder for Android, Linux, and Windows,
defines a page transition that's similar to the one provided by Android Q and R.

According to the [Style guide for Flutter repo][],
the framework will follow the latest OEM behavior.
Page transition builders using `FadeUpwardsPageTransitionsBuilder`
are all switched to the `ZoomPageTransitionsBuilder`.
When the current `TargetPlatform` doesn't have
`PageTransitionsBuilder` defined in the `ThemeData.pageTransitionsTheme`,
`ZoomPageTransitionsBuilder` is used as the default.

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
        value: (dynamic _) => const FadeUpwardsPageTransitionsBuilder(),
      ),
    ),
  ),
)

```

### Tests migration

If you used to try to find widgets but failed with *Too many elements*
using the new transition, and saw errors similar to the following:

```
══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞════════════════════════════════════════════════════
The following StateError was thrown running a test:
Bad state: Too many elements

When the exception was thrown, this was the stack:
#0      Iterable.single (dart:core/iterable.dart:656:24)
#1      WidgetController.widget (package:flutter_test/src/controller.dart:69:30)
#2      main.<anonymous closure> (file:///path/to/your/test.dart:1:2)
```

You should migrate your tests by using the
`descendant` scope for `Finder`s with the specific widget type.
Below is the example of `DataTable`'s test:

Test before migration:
```dart
final Finder finder = find.widgetWithIcon(Transform, Icons.arrow_upward);
```

Test after migration:
```dart
final Finder finder = find.descendant(
  of: find.byType(DataTable),
  matching: find.widgetWithIcon(Transform, Icons.arrow_upward),
);
```

Widgets that typically need to migrate the finder scope are:
`Transform`, `FadeTransition`, `ScaleTransition`, and `ColoredBox`.

## Timeline

Landed in version: v2.13.0-1.0.pre<br>
In stable release: Not yet

## References

API documentation:
* [`ZoomPageTransitionsBuilder`][]
* [`FadeUpwardsPageTransitionsBuilder`][]
* [`PageTransitionsTheme`][]

Relevant issues:
* [Issue 43277][]

Relevant PR:
* [PR 100812][]

[`ZoomPageTransitionsBuilder`]: {{site.api}}/flutter/material/ZoomPageTransitionsBuilder-class.html
[`FadeUpwardsPageTransitionsBuilder`]: {{site.api}}/flutter/material/FadeUpwardsPageTransitionsBuilder-class.html
[`PageTransitionsTheme`]: {{site.api}}/flutter/material/PageTransitionsTheme-class.html
[Issue 43277]: {{site.repo.flutter}}/issues/43277
[PR 100812]: {{site.repo.flutter}}/pull/100812
