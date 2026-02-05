---
title: Material Theme System Updates
description: >-
  `CardTheme`, `DialogTheme`, and `TabBarTheme` have been normalized to follow
  Flutter's convention for component themes in the Material library. In
  `ThemeData`, the type of these properties have also changed accordingly.
---

{% render "docs/breaking-changes.md" %}

## Summary

`CardTheme`, `DialogTheme` and `TabBarTheme` were refactored to
conform to Flutter's conventions for component themes. `CardThemeData`,
`DialogThemeData` and `TabBarThemeData` were added to define overrides for the
defaults of the component visual properties.

During card theme normalization, the type of `ThemeData.cardTheme` is changed
to `Object?` to accept both `CardTheme` and `CardThemeData`, in order to have
a smooth transition for the breaking changes. The same approach was used for
`dialogTheme` and `tabBarTheme`.

To complete the transition and fully conform to the `ThemeData` convention, the
type of `ThemeData.cardTheme` has been changed to `CardThemeData?`; the type of
`ThemeData.dialogTheme` has been changed to `DialogThemeData?`; and the type of
`ThemeData.tabBarTheme` has been changed to `TabBarThemeData?`.

## Migration guide

Previously, the type of `ThemeData.cardTheme` was `Object?` to accept both
`CardTheme` and `CardThemeData`. Now that the type has been changed to
`CardThemeData?`, a migration is required if `ThemeData.cardTheme` is used.
Similarly, the types of `ThemeData.dialogTheme` and `ThemeData.tabBarTheme`
should be migrated to `DialogThemeData` and `TabBarThemeData`, respectively.

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

Landed in version: 3.31.0-0.0.pre<br>
In stable release: 3.32

## References

API documentation:

* [`ThemeData`][]
* [`CardTheme`][]
* [`DialogTheme`][]
* [`TabBarTheme`][]

Relevant PRs:

* [Change cardTheme, dialogTheme, and tabBarTheme type to xxxThemeData][]

[Change cardTheme, dialogTheme, and tabBarTheme type to xxxThemeData]: {{site.github}}/flutter/flutter/pull/157292
[`ThemeData`]: {{site.api}}/flutter/material/ThemeData-class.html
[`CardTheme`]: {{site.api}}/flutter/material/CardTheme-class.html
[`DialogTheme`]: {{site.api}}/flutter/material/DialogTheme-class.html
[`TabBarTheme`]: {{site.api}}/flutter/material/TabBarTheme-class.html
