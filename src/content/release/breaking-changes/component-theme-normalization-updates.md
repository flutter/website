---
title: Component theme normalization updates
description: >-
  `BottomAppBarTheme` has been normalized to follow Flutter's convention for component themes 
  in the Material library.
---

## Summary

`BottomAppBarTheme` was refactored to conform to Flutter's conventions for component themes. 
`BottomAppBarThemeData` was added to define overrides for the defaults of the component visual 
properties.
Releases of Flutter continue to normalize component themes like these for
a more consistent theming experience in the material library.

## Migration guide

In `ThemeData`:

- The type of `bottomAppBarTheme` property has been
  changed from `BottomAppBarTheme` to `BottomAppBarThemeData`.

The return type of the component theme `xTheme.of()` methods and
`Theme.of().xTheme` have also changed to `xThemeData`.

Code before migration:

```dart
final BottomAppBarTheme bottomAppBarTheme = Theme.of(context).bottomAppBarTheme;
final BottomAppBarTheme bottomAppBarTheme = BottomAppBarTheme.of(context);
```

```dart
final ThemeData theme = ThemeData(
  bottomAppBarTheme: BottomAppBarTheme(),
);

final ThemeData theme = ThemeData().copyWith(
  bottomAppBarTheme: BottomAppBarTheme(),
);
```

Code after migration:

```dart
final BottomAppBarThemeData bottomAppBarTheme = Theme.of(context).bottomAppBarTheme;
final BottomAppBarThemeData bottomAppBarTheme = BottomAppBarTheme.of(context);
```

```dart
final ThemeData theme = ThemeData(
  bottomAppBarTheme: BottomAppBarThemeData(),
);

final ThemeData theme = ThemeData().copyWith(
  bottomAppBarTheme: BottomAppBarThemeData(),
);
```

## Timeline

Landed in version: Not yet<br>
Stable release: Not yet

## References

API documentation:

* [`BottomAppBarTheme`][]

Relevant PRs:

* [Normalize ThemeData.bottomAppBarTheme][]

[`BottomAppBarTheme`]: {{site.api}}/flutter/material/BottomAppBarTheme-class.html
[Normalize ThemeData.bottomAppBarTheme]: {{site.repo.flutter}}/pull/168586

