---
title: ThemeData's toggleableActiveColor property has been deprecated
description: Material Widgets that use toggleableActiveColor property are migrated to use Material ColorScheme.
---

## Summary

The Material widgets `Switch`, `SwitchListTile`, `Checkbox`, `CheckboxListTile`, `Radio`, `RadioListTile` now use `ColorScheme.secondary` color for their toggleable widget. `ThemeData.toggleableActiveColor` is deprecated and will eventually be removed.

## Context

Migration of widgets that depends on `ThemeData.toggleableActiveColor` to `ColorScheme.secondary` rendered toggleableActiveColor unuse, hence the deprecationn of this theme property.

## Description of change

The widgets using `ThemeData.toggleableActiveColor` color for the active/selected state now use `ColorScheme.secondary`.

## Migration guide

Toggleable widgets' active/selected color can generally customized in 3 ways at the widget-level using components themes `SwitchThemeData`, `ListTileThemeData`, `CheckboxThemeData`, and `RadioThemeData` using `ColorScheme.secondary`.

Code before migration:

<!-- skip -->
```dart
MaterialApp(
  theme: ThemeData(toggleableActiveColor: myColor),
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

## Timeline

Landed in version: 2.9.0-1.0.pre.209<br>
In stable release: not yet

## References

API documentation:

* [`ThemeData.toggleableActiveColor`][]
* [`ColorScheme.secondary`][]

Relevant issues:

* [`Switch` widget color doesn't use `ColorScheme`][]

Relevant PRs:

* [Deprecate `toggleableActiveColor`][].

<!-- Stable channel link: -->
[`ThemeData.toggleableActiveColor`]: {{site.master-api}}/flutter/material/ThemeData/toggleableActiveColor.html
[`ColorScheme.secondary`]: {{site.master-api}}/flutter/material/ColorScheme/secondary.html

[`Switch` widget color doesn't use `ColorScheme`]: {{site.repo.flutter}}/issues/93709

[Deprecate `toggleableActiveColor`]: {{site.repo.flutter}}/pull/95870
