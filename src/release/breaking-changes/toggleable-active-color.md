---
title: ThemeData's toggleableActiveColor property has been deprecated
description: Material Widgets that use toggleableActiveColor property are migrated to use Material ColorScheme.
---

## Summary

The Material widgets `Switch`, `SwitchListTile`, `Checkbox`, `CheckboxListTile`, `Radio`, `RadioListTile` now use `ColorScheme.secondary` color for their toggleable widget. `ThemeData.toggleableActiveColor` is deprecated and will eventually be removed.

## Context

Migration of widget that depends on `ThemeData.toggleableActiveColor` to `ColorScheme.secondary` rendered toggleableActiveColor unused which caused the deprecationn of this theme property.

## Description of change

The widgets using `ThemeData.toggleableActiveColor` color for selected state now uses `ColorScheme.secondary`.

## Migration guide

In order to customize toggleable widgets selected color, remove `ThemeData.toggleableActiveColor` and customize `ColorScheme.secondary` instead.

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
