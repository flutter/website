---
title: Material Theme System Updates
description: >-
  `CardTheme`, `DialogTheme`, and `TabBarTheme` have been normalized to follow
  Flutter's convention for component themes in the Material library. In 
  `ThemeData`, the type of these properties have also changed accordingly.
---

## Summary

`CardTheme`, `DialogTheme` and `TabBarTheme` were refactored to 
conform to Flutter's conventions for component themes. `CardThemeData`, 
`DialogThemeData` and `TabBarThemeData` were added to define overrides for the
defaults of the component visual properties.

During card theme normalization, the type of `ThemeData.cardTheme` is changed
to `Object?` to accept both `CardTheme` and `CardThemeData`, in order to have
a soft land for breaking changes. Similar for `dialogTheme` and `tabBarTheme`.

To finish the last step and follow the convention of `ThemeData`, the type of
`ThemeData.cardTheme` is changed to `CardThemeData?`; the type of
`ThemeData.dialogTheme` is changed to `DialogThemeData?`; the type of
`ThemeData.tabBarTheme` is changed to `TabBarThemeData?`.

## Migration guide

Previously, the type of `ThemeData.cardTheme` was `Object?` to accpet both
`CardTheme` and `CardThemeData`. Now the type has been changed to
`CardThemeData`. Similarly, the type of `ThemeData.dialogTheme` and
`ThemeData.tabBarTheme` should be migrated to `DialogThemeData` and
`TabBarThemeData`.

Code before migration:

```dart
final ThemeData theme = ThemeData(
    cardTheme: CardTheme(),
    dialogTheme: DialogTheme(),
    tabBarTheme: TabBarTheme(),
);
```

Code after migration:

```dart
final ThemeData theme = ThemeData(
    cardTheme: CardThemeData(),
    dialogTheme: DialogThemeData(),
    tabBarTheme: TabBarThemeData(),
);
```

## Timeline

Landed in version: TBD
Stable release: TBD

## References

API documentation:

* [`ThemeData`][]
* [`CardTheme`][]
* [`DialogTheme`][]
* [`TabBarTheme`][]

Relevant PRs:

* [Change cardTheme, dialogTheme, and tabBarTheme type to xxxThemeData][]

[`ThemeData`]: {{site.api}}/flutter/material/ThemeData-class.html
[`CardTheme`]: {{site.api}}/flutter/material/CardTheme-class.html
[`DialogTheme`]: {{site.api}}/flutter/material/DialogTheme-class.html
[`TabBarTheme`]: {{site.api}}/flutter/material/TabBarTheme-class.html
