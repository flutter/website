---
title: ThemeData's accent properties have been deprecated
description: The ThemeData accentColor, accentColorBrightness, accentIconTheme, and accentTextTheme properties have been deprecated.
---

## Summary

The ThemeData [accentColor][], [accentColorBrightness][], [accentIconTheme][] and
[accentTextTheme][] properties have been deprecated.

The [Material Design spec][] no longer specifies or uses an "accent"
color for the Material components. The default values for component
colors are derived from the overall theme's [color scheme][]. The
`ColorScheme`'s [secondary color][] is now typically used instead of
`accentColor` and the [onSecondary color][] is used when a contrasting
color is needed.

## Context

This was a small part of the [Material Theme System Updates][] project.

As of Flutter 1.17, the ThemeData accent properties - accentColor,
accentColorBrightness, accentIconTheme, and accentTextTheme - were no
longer used by the Material library. They had been replaced by
dependencies on the theme's [`colorScheme`][] and [`textTheme`][] properties as
part of the long-term goal of making the default configurations of the
material components depend almost exclusively on these two
properties.

The motivation for these changes is to make the theme system easier to
understand and use. The default colors for all components are to be
defined by the components themselves and based on the color
scheme. The defaults for specific component types can be overridden
with component-specific themes like [`FloatingActionButtonTheme`][] or
[`CheckBoxTheme`][]. Previously, properties like accentColor were used by a
handful of component types and only in some situations, which made it
difficult to understand the implications of overriding them.

## Description of change

The ThemeData accentColor, accentColorBrightness, accentIconTheme and
accentTextTheme properties have been deprecated because the Material
library no longer uses them.

## Migration guide


### Application theme

[`ThemeData`][] values no long need to specify accentColor,
accentColorBrightness, accentIconTheme, or accentTextTheme.

To configure the appearance of the material components in about the
same way as before, specify the color scheme's secondary color
instead of accentColor.

Code before migration:

<!-- skip -->
```dart
MaterialApp(
  theme: ThemeData(accentColor: myColor),
  // ...
);
```

Code after migration:

<!-- skip -->
```dart
final ThemeData theme = ThemeData();
MaterialApp(
  theme: theme.copyWith(
    colorScheme: theme.colorScheme.copyWith(secondary: myColor),
  ),
  //...
)
```

### `accentColor`

The closest backwards compatible [`ColorScheme`][] color is
[`ColorScheme.secondary`][]. To hew most closely to the latest Material
Design guidelines one can substitute ColorScheme.primary instead.
If a contrasting color is needed then use [`ColorScheme.onSecondary`][].

Custom components that used to look up the theme's accentColor, can look up
the `ColorScheme.secondary` instead.

Code before migration:

<!-- skip -->
```dart
Color myColor = Theme.of(context).accentColor;
```

Code after migration:

<!-- skip -->
```dart
Color myColor = Theme.of(context).colorScheme.secondary;
```

### `accentColorBrightness`

The static [`ThemeData.estimateBrightnessForColor()`][] method can be used
to compute the brightness of any color.


### `accentTextTheme`

This was white [`TextStyle`]s for dark themes, black
TextStyles for light themes. In most cases textTheme can be used
instead. A common idiom was to refer to one TextStyle from
accentTextTheme, since the text style's color was guaranteed to contrast
well with the accent color (now `ColorScheme.secondaryColor`).  To get
the same result now, specify the text style's color as
`ColorScheme.onSecondary`:

Code before migration:

<!-- skip -->
```dart
TextStyle style = Theme.of(context).accentTextTheme.headline1;
```

Code after migration:

<!-- skip -->
```dart
final ThemeData theme = Theme.of(context);
TextStyle style = theme.textTheme.headline1.copyWith(
  color: theme.colorScheme.onSecondary,
)
```

### `accentIconTheme`

This property had only been used to configure the color of icons
within a [`FloatingActionButton`][]. It's now possible to configure the icon
color directly or with the [`FloatingActionButtonTheme`][]. See
[FloatingActionButton and ThemeData's accent properties][].

## Timeline

Landed in version: 2.3.0-0.1.pre<br>
In stable release: not yet

## References

API documentation:
* [`ColorScheme`][]
* [`FloatingActionButton`][]
* [`FloatingActionButtonTheme`][]
* [`TextStyle`][]
* [`TextTheme`][]
* [`Theme`][]
* [`ThemeData`][]

Relevant issues:
* [Issue #56918][]

Relevant PRs:
* [PR #81336][]

Other:
* [Material Theme System Updates][]


[accentColor]: {{site.api}}/flutter/material/ThemeData/accentColor.html
[accentColorBrightness]: {{site.api}}/flutter/material/ThemeData/accentColorBrightness.html
[accentIconTheme]: {{site.api}}/flutter/material/ThemeData/accentIconTheme.html
[accentTextTheme]: {{site.api}}/flutter/material/ThemeData/accentTextTheme.html
[`CheckboxTheme`]: {{site.api}}/flutter/material/CheckboxTheme-class.html
[color scheme]: {{site.api}}/flutter/material/ThemeData/colorScheme.html
[`colorScheme`]: {{site.api}}/flutter/material/ThemeData/colorScheme.html
[`colorScheme.onSecondary`]: {{site.api}}/flutter/material/ColorScheme/onSecondary.html
[`colorScheme.secondary`]: {{site.api}}/flutter/material/ColorScheme/secondary.html
[`ColorScheme`]: {{site.api}}/flutter/material/ColorScheme-class.html
[Issue #56918]: {{site.github}}/flutter/flutter/issues/56918
[FloatingActionButton and ThemeData's accent properties]: /docs/release/breaking-changes/fab-theme-data-accent-properties
[`FloatingActionButton`]: {{site.api}}/flutter/material/FloatingActionButton-class.html
[`FloatingActionButtonTheme`]: {{site.api}}/flutter/material/FloatingActionButtonTheme-class.html
[`FloatingActionButtonThemeData`]: {{site.api}}/flutter/material/FloatingActionButtonThemeData-class.html
[Material Design spec]: {{site.material}}/design/color
[Material Theme System Updates]: /go/material-theme-system-updates
[secondary color]: {{site.api}}/flutter/material/ColorScheme/secondary.html
[onSecondary color]: {{site.api}}/flutter/material/ColorScheme/onSecondary.html
[PR #81336]: {{site.github}}/flutter/flutter/pull/81336
[`TextStyle`]: {{site.api}}/flutter/painting/TextStyle-class.html
[`textTheme`]: {{site.api}}/flutter/material/ThemeData/textTheme.html
[`TextTheme`]: {{site.api}}/flutter/material/TextTheme-class.html
[`Theme`]: {{site.api}}/flutter/material/Theme-class.html
[`ThemeData`]: {{site.api}}/flutter/material/ThemeData-class.html
[`ThemeData.estimateBrightnessForColor()`]: {{site.api}}/flutter/material/ThemeData/estimateBrightnessForColor.html
