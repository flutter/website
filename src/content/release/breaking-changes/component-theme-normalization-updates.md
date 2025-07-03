---
title: Component theme normalization updates
description: >-
  `AppBarTheme` and `BottomAppBarTheme` have been normalized to follow Flutter's convention for component themes 
  in the Material library.
---

## Summary

`AppBarTheme` and `BottomAppBarTheme` were refactored to conform to Flutter's conventions for component themes. 
`AppBarThemeData` and `BottomAppBarThemeData` were added to define overrides for the defaults of the component visual 
properties.
Releases of Flutter continue to normalize component themes like these for
a more consistent theming experience in the material library.

## Migration guide

In `ThemeData`:
- The type of the `appBarTheme` property has been
  changed from `AppBarTheme` to `AppBarThemeData`.
- The type of `bottomAppBarTheme` property has been
  changed from `BottomAppBarTheme` to `BottomAppBarThemeData`.

The return type of the component theme `xTheme.of()` methods and
`Theme.of().xTheme` have also changed to `xThemeData`.

Code before migration:

```dart
final AppBarTheme appBarTheme = Theme.of(context).appBarTheme;
final AppBarTheme appBarTheme = AppBarTheme.of(context);

final BottomAppBarTheme bottomAppBarTheme = Theme.of(context).bottomAppBarTheme;
final BottomAppBarTheme bottomAppBarTheme = BottomAppBarTheme.of(context);
```

```dart
final ThemeData theme = ThemeData(
  appBarTheme: AppBarTheme(),
  bottomAppBarTheme: BottomAppBarTheme(),
);

final ThemeData theme = ThemeData().copyWith(
  appBarTheme: AppBarTheme(),
  bottomAppBarTheme: BottomAppBarTheme(),
);
```

Code after migration:

```dart
final AppBarThemeData appBarTheme = Theme.of(context).appBarTheme;
final AppBarThemeData appBarTheme = AppBarTheme.of(context);

final BottomAppBarThemeData bottomAppBarTheme = Theme.of(context).bottomAppBarTheme;
final BottomAppBarThemeData bottomAppBarTheme = BottomAppBarTheme.of(context);
```

```dart
final ThemeData theme = ThemeData(
  appBarTheme: AppBarThemeData(),
  bottomAppBarTheme: BottomAppBarThemeData(),
);

final ThemeData theme = ThemeData().copyWith(
  appBarTheme: AppBarThemeData(),
  bottomAppBarTheme: BottomAppBarThemeData(),
);
```

## Timeline

Landed in version: Not yet<br>
Stable release: Not yet

## References

API documentation:

* [`AppBarTheme`][]
* [`BottomAppBarTheme`][]

Relevant PRs:

* [Normalize ThemeData.appBarTheme][]
* [Normalize ThemeData.bottomAppBarTheme][]

[`AppBarTheme`]: {{site.api}}/flutter/material/AppBarTheme-class.html
[Normalize ThemeData.appBarTheme]: {{site.repo.flutter}}/pull/169130
[`BottomAppBarTheme`]: {{site.api}}/flutter/material/BottomAppBarTheme-class.html
[Normalize ThemeData.bottomAppBarTheme]: {{site.repo.flutter}}/pull/168586

