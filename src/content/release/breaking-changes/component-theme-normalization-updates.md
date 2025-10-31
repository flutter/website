---
title: Component theme normalization updates
description: >-
  `AppBarTheme`, `BottomAppBarTheme` and `InputDecorationTheme` have been
  normalized to follow Flutter's convention for component themes in the
  Material library.
---

{% render "docs/breaking-changes.md" %}

## Summary

`AppBarTheme`, `BottomAppBarTheme` and `InputDecorationTheme` were refactored
to conform to Flutter's conventions for component themes.
`AppBarThemeData`, `BottomAppBarThemeData` and `InputDecorationThemeData` were
added to define overrides for the defaults of the component visual properties.
Releases of Flutter continue to normalize component themes like these for
a more consistent theming experience in the material library.

## Migration guide

In `ThemeData`:
- The type of the `appBarTheme` property has been
  changed from `AppBarTheme` to `AppBarThemeData`.
- The type of `bottomAppBarTheme` property has been
  changed from `BottomAppBarTheme` to `BottomAppBarThemeData`.
- The type of `inputDecorationTheme` property has been
  changed from `InputDecorationTheme` to `InputDecorationThemeData`.

The return type of the component theme `xTheme.of()` methods and
`Theme.of().xTheme` have also changed to `xThemeData`.

In `DatePickerThemeData` and `TimePickerThemeData`, the type of the
`inputDecorationTheme` property has been changed from `InputDecorationTheme`
to `InputDecorationThemeData`.

Code before migration:

```dart
final AppBarTheme appBarTheme = Theme.of(context).appBarTheme;
final AppBarTheme appBarTheme = AppBarTheme.of(context);

final BottomAppBarTheme bottomAppBarTheme = Theme.of(context).bottomAppBarTheme;
final BottomAppBarTheme bottomAppBarTheme = BottomAppBarTheme.of(context);

final InputDecorationTheme inputDecorationTheme = Theme.of(context).inputDecorationTheme;
final InputDecorationTheme inputDecorationTheme = InputDecorationTheme.of(context);
final InputDecorationTheme inputDecorationTheme = Theme.of(context).datePickerTheme.inputDecorationTheme;
final InputDecorationTheme inputDecorationTheme = Theme.of(context).timePickerTheme.inputDecorationTheme;
```

```dart
final ThemeData theme = ThemeData(
  appBarTheme: AppBarTheme(),
  bottomAppBarTheme: BottomAppBarTheme(),
  inputDecorationTheme: InputDecorationTheme(),
);

final ThemeData theme = ThemeData().copyWith(
  appBarTheme: AppBarTheme(),
  bottomAppBarTheme: BottomAppBarTheme(),
  inputDecorationTheme: InputDecorationTheme(),
);

const DatePickerThemeData datePickerTheme = DatePickerThemeData(inputDecorationTheme: InputDecorationTheme());
const TimePickerThemeData timePickerTheme = TimePickerThemeData(inputDecorationTheme: InputDecorationTheme());
```

Code after migration:

```dart
final AppBarThemeData appBarTheme = Theme.of(context).appBarTheme;
final AppBarThemeData appBarTheme = AppBarTheme.of(context);

final BottomAppBarThemeData bottomAppBarTheme = Theme.of(context).bottomAppBarTheme;
final BottomAppBarThemeData bottomAppBarTheme = BottomAppBarTheme.of(context);

final InputDecorationThemeData inputDecorationTheme = Theme.of(context).inputDecorationTheme;
final InputDecorationThemeData inputDecorationTheme = InputDecorationTheme.of(context);
final InputDecorationThemeData inputDecorationTheme = Theme.of(context).datePickerTheme.inputDecorationTheme;
final InputDecorationThemeData inputDecorationTheme = Theme.of(context).timePickerTheme.inputDecorationTheme;
```

```dart
final ThemeData theme = ThemeData(
  appBarTheme: AppBarThemeData(),
  bottomAppBarTheme: BottomAppBarThemeData(),
  inputDecorationTheme: InputDecorationThemeData(),
);

final ThemeData theme = ThemeData().copyWith(
  appBarTheme: AppBarThemeData(),
  bottomAppBarTheme: BottomAppBarThemeData(),
  inputDecorationTheme: InputDecorationThemeData(),
);

const DatePickerThemeData datePickerTheme = DatePickerThemeData(inputDecorationTheme: InputDecorationThemeData());
const TimePickerThemeData timePickerTheme = TimePickerThemeData(inputDecorationTheme: InputDecorationThemeData());
```

## Timeline

Landed in version: 3.33.0-1.0.pre through 3.35.0-0.0.pre<br>
Stable release: 3.35

## References

API documentation:

* [`AppBarTheme`][]
* [`BottomAppBarTheme`][]
* [`InputDecorationTheme`][]

Relevant PRs:

* [Normalize ThemeData.appBarTheme][]
* [Normalize ThemeData.bottomAppBarTheme][]
* [Normalize InputDecorationTheme][]
* [Apply normalization to TimePickerThemeData.inputDecorationTheme][]

[`AppBarTheme`]: {{site.api}}/flutter/material/AppBarTheme-class.html
[Normalize ThemeData.appBarTheme]: {{site.repo.flutter}}/pull/169130
[`BottomAppBarTheme`]: {{site.api}}/flutter/material/BottomAppBarTheme-class.html
[Normalize ThemeData.bottomAppBarTheme]: {{site.repo.flutter}}/pull/168586
[`InputDecorationTheme`]: {{site.api}}/flutter/material/InputDecorationTheme-class.html
[Normalize InputDecorationTheme]: {{site.repo.flutter}}/pull/168981
[Apply normalization to TimePickerThemeData.inputDecorationTheme]: {{site.repo.flutter}}/pull/171584
