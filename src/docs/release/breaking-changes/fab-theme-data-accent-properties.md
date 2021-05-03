---
title: FloatingActionButton and ThemeData's accent properties
description: Remove FloatingActionButton's undocumented use of the ThemeData accentTextTheme property, and its unnecessary use of accentIconTheme.
---

## Summary

Removed Flutter's `FloatingActionButton` (FAB) dependency on
`ThemeData` accent properties.

## Context

This was a small part of the [Material Theme System Updates][] project.

Previously, the `ThemeData accentIconTheme` property was only
used by [`FloatingActionButton`][] to determine the default
color of the text or icons that appeared within the button.

`FloatingActionButton` also used the
`ThemeData accentTextTheme` property,
however this dependency was undocumented and unnecessary.

Both of these dependencies were confusing.
For example if one configured the `Theme`'s `accentIconTheme`
to change the appearance of all floating action buttons,
it was difficult to know what other components would be affected,
or might be affected in the future.

The [Material Design spec][] no longer includes an "accent" color.
The `ColorScheme`'s [secondary color][] is now used instead.

Previously, applications could configure the color of text and icons
within `FloatingActionButtons` with the widget's `foregroundColor`
property, or with the `FloatingActionButtonTheme`'s `foregroundColor`.
If neither `foregroundColor` property was specified, the foreground
color defaulted to the `accentIconTheme`'s color.

With this change, the default behavior uses the color scheme's
`onSecondary` color instead.

## Description of change

Previously, the `accentIconTheme` provided a default for the
`FloatingActionButton`'s `foregroundColor` property:

<!-- skip -->
```dart
    final Color foregroundColor = this.foregroundColor
      ?? floatingActionButtonTheme.foregroundColor
      ?? theme.accentIconTheme.color // To be removed.
      ?? theme.colorScheme.onSecondary;
```

Apps that configure their theme's `accentIconTheme`
to effectively configure the `foregroundColor` of all
floating action buttons, can get the same effect by
configuring the `foregroundColor` of their theme's
`floatingActionButtonTheme`.

The `FloatingActionButton`'s `foregroundColor` is now used
to configure the `textStyle` of the `RawMaterialButton`
created by `FloatingActionButton`. Previously,
this text style was based on the button style of
`ThemeData.accentTextTheme`:

<!-- skip -->
```dart
// theme.accentTextTheme becomes theme.textTheme
final TextStyle textStyle = theme.accentTextTheme.button.copyWith(
  color: foregroundColor,
  letterSpacing: 1.2,
);

```

Except in a case where an app has explicitly configured the
`accentTextTheme` to take advantage of this undocumented dependency,
this use of `accentTextTheme` is unnecessary.
This change replaces this use of `accentTextTheme` with `textTheme`.

## Migration guide

This change occurred in two steps:

1. If the foreground of a `FloatingActionButton` is set
   to a non-default color, a warning is now printed.
2. The `accentIconTheme` dependency was removed.
   If you haven't already done so, migrate your apps
   per the pattern below.

To configure the `FloatingActionButton`'s `foregroundColor`
for all FABs, you can configure the theme's
`floatingActionButtonTheme` instead of its `accentIconTheme`.

Code before migration:

<!-- skip -->
```dart
MaterialApp(
  theme: ThemeData(
    accentIconTheme: IconThemeData(color: Colors.red),
  ),
)
```

Code after migration:

<!-- skip -->
```dart
MaterialApp(
  theme: ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.red,
    ),
  ),
)
```

## Timeline

Landed in version: 1.16.3<br>
In stable release: 1.17

## References

Design doc:

* [Remove FAB Accent Theme Dependency][]

API documentation:

* [`FloatingActionButton`][]
* [`ThemeData`][]
* [`FloatingActionButtonThemeData`][]

Relevant PRs:

* [Step 1 of 2][] Warn about Flutter's
  FloatingActionButton dependency on ThemeData accent properties
* [Step 2 of 2][] Remove Flutter's FloatingActionButton dependency
  on ThemeData accent properties

Other:

* [Material Theme System Updates][]


[`accentIconTheme`]: {{site.api}}/flutter/material/ThemeData/accentIconTheme.html
[`FloatingActionButton`]: {{site.api}}/flutter/material/FloatingActionButton/foregroundColor.html
[`FloatingActionButtonThemeData`]: {{site.api}}/flutter/material/FloatingActionButtonThemeData-class.html
[Material Design spec]: {{site.material}}/design/color
[Material Theme System Updates]: /go/material-theme-system-updates
[Remove FAB Accent Theme Dependency]: /go/remove-fab-accent-theme-dependency
[secondary color]: {{site.material}}/design/color/the-color-system.html#color-theme-creation
[Step 1 of 2]: {{site.github}}/flutter/flutter/pull/48435
[Step 2 of 2]: {{site.github}}/flutter/flutter/pull/46923
[`ThemeData`]: {{site.api}}/flutter/material/ThemeData/floatingActionButtonTheme.html
