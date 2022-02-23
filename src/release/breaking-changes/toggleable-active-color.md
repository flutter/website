---
title: ThemeData's toggleableActiveColor property has been deprecated
description: Material Widgets that use toggleableActiveColor property are migrated to use Material ColorScheme.
---

## Summary

The Material widgets `Switch`, `SwitchListTile`, `Checkbox`,
`CheckboxListTile`, `Radio`, `RadioListTile` now use
`ColorScheme.secondary` color for their toggleable widget.
`ThemeData.toggleableActiveColor` is deprecated and will eventually be removed.

## Context

The migration of widgets that depend on `ThemeData.toggleableActiveColor`
to `ColorScheme.secondary` caused  the `toggleableActiveColor` property
to be unnecessary. This property will eventually be removed, as per Flutter's
[deprecation policy]({{site.url}}/resources/compatibility#deprecation-policy).

## Description of change

The widgets using `ThemeData.toggleableActiveColor` color for the
active/selected state now use `ColorScheme.secondary`.

## Migration guide

Toggleable widgets' active/selected color can generally be customized in 3 ways
1. Using ThemeData's `ColorScheme.secondary`.
2. Using components themes `SwitchThemeData`, `ListTileThemeData`, `CheckboxThemeData`,
and `RadioThemeData`.
3. By customizing the widget's color properties.

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
[`ThemeData.toggleableActiveColor`]: {{site.api}}/flutter/material/ThemeData/toggleableActiveColor.html
[`ColorScheme.secondary`]: {{site.api}}/flutter/material/ColorScheme/secondary.html

[`Switch` widget color doesn't use `ColorScheme`]: {{site.repo.flutter}}/issues/93709

[Deprecate `toggleableActiveColor`]: {{site.repo.flutter}}/pull/95870
