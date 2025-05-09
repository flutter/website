---
title: Component theme normalization updates
description: >-
  `AppBarTheme`, `BottomAppBarTheme`, and `InputDecorationTheme` have been normalized to follow
  Flutter's convention for component themes in the Material library.
---

## Summary

`AppBarTheme`, `BottomAppBarTheme`, and `InputDecorationTheme` were refactored to 
conform to Flutter's conventions for component themes. 
`AppBarThemeData`,`BottomAppBarThemeData`, and `InputDecorationThemeData` were added to
define overrides for the defaults of the component visual properties.
Releases of Flutter continue to normalize component themes like these for
a more consistent theming experience in the material library.

## Migration guide

In `ThemeData`:

- The type of `appBarTheme` property has been
  changed from `AppBarTheme` to `AppBarThemeData`.
- The type of `bottomAppBarTheme` property has been
  changed from `BottomAppBarTheme` to `BottomAppBarThemeData`.
- The type of `inputDecorationTheme` property has been
  changed from `InputDecorationTheme` to `InputDecorationThemeData`.

The return type of the component theme `xTheme.of()` methods and
`Theme.of().xTheme` have also changed to `xThemeData` accordingly.

Code before migration:

```dart
final AppBarTheme appBarTheme = Theme.of(context).appBarTheme;
final AppBarTheme appBarTheme = AppBarTheme.of(context);

final BottomAppBarTheme bottomAppBarTheme = Theme.of(context).bottomAppBarTheme;
final BottomAppBarTheme bottomAppBarTheme = BottomAppBarTheme.of(context);

final InputDecorationTheme inputDecorationTheme = Theme.of(context).inputDecorationTheme;
final InputDecorationTheme inputDecorationTheme = InputDecorationTheme.of(context);
```

Code after migration:

```dart
final AppBarThemeData appBarTheme = Theme.of(context).appBarTheme;
final AppBarThemeData appBarTheme = AppBarTheme.of(context);

final BottomAppBarThemeData bottomAppBarTheme = Theme.of(context).bottomAppBarTheme;
final BottomAppBarThemeData bottomAppBarTheme = BottomAppBarTheme.of(context);

final InputDecorationThemeData inputDecorationTheme = Theme.of(context).inputDecorationTheme;
final InputDecorationThemeData inputDecorationTheme = InputDecorationTheme.of(context);
```

## Timeline

Landed in version: 3.33.0-1.0.pre<br>
Stable release: 3.33

## References

API documentation:

* [`AppBarTheme`][]
* [`BottomAppBarTheme`][]
* [`InputDecorationTheme`][]

Relevant PRs:

* [Normalize ThemeData.appBarTheme][]

[`AppBarTheme`]: {{site.api}}/flutter/material/AppBarTheme-class.html
[Normalize ThemeData.appBarTheme]: {{site.repo.flutter}}/pull/169130

* [Normalize ThemeData.bottomAppBarTheme][]

[`BottomAppBarTheme`]: {{site.api}}/flutter/material/BottomAppBarTheme-class.html
[Normalize ThemeData.bottomAppBarTheme]: {{site.repo.flutter}}/pull/168586

* [Normalize ThemeData.inputDecorationTheme][]

[`InputDecorationTheme`]: {{site.api}}/flutter/material/InputDecorationTheme-class.html
[Normalize ThemeData.inputDecorationTheme]: {{site.repo.flutter}}/pull/168981
