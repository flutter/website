---
title: Deprecate `ThemeData.indicatorColor` in favor of
  `TabBarThemeData.indicatorColor`
description: >-
  The `ThemeData.indicatorColor` parameter has been replaced by
  `TabBarThemeData.indicatorColor`.
---

## Summary

The [`ThemeData.indicatorColor`][] parameter was deprecated in favor of
the [`TabBarThemeData.indicatorColor`][] parameter.

## Context

The defaults for the [`TabBar`][] widget can be overridden with a
component-specific theme like [`TabBarThemeData`][]. Previously, the
`ThemeData.indicatorColor` parameter was used to override the default tab bar
indicator color in Material Design 2, which was made redundant by
[`TabBarThemeData`][].

## Description of change

The [`ThemeData.indicatorColor`][] is deprecated in favor of a
component-specific theme. Use [`TabBarThemeData`][] to override the default
indicator color.

## Migration guide

Replace [`ThemeData.indicatorColor`][] with
[`TabBarThemeData.indicatorColor`][] to override the default tab bar indicator
color when [`ThemeData.useMaterial3`][] flag is set to `false`.

Code before migration:

```dart
theme: ThemeData(
  indicatorColor: Colors.red,
  useMaterial3: false,
),
```

Code after migration:

```dart
theme: ThemeData(
  tabBarTheme: const TabBarThemeData(indicatorColor: Colors.red),
  useMaterial3: false,
),
```

## Timeline

Landed in version: v3.27.0-0.2.pre.<br>
In stable release: TBD

## References

API documentation:

- [`ThemeData.indicatorColor`][]
- [`ThemeData.useMaterial3`][]
- [`TabBarThemeData.indicatorColor`][]
- [`TabBarThemeData`][]
- [`TabBar`][]

Relevant issues:

- [Issue #91772][]

Relevant PRs:

- [Deprecate `ThemeData.indicatorColor` in favor of `TabBarThemeData.indicatorColor`][]

[`ThemeData.indicatorColor`]: {{site.api}}/flutter/material/ThemeData/indicatorColor.html
[`ThemeData.useMaterial3`]: {{site.api}}/flutter/material/ThemeData/useMaterial3.html
[`TabBarThemeData.indicatorColor`]: {{site.api}}/flutter/material/TabBarThemeData/indicatorColor.html
[`TabBarThemeData`]: {{site.api}}/flutter/material/TabBarThemeData-class.html
[`TabBar`]: {{site.api}}/flutter/material/TabBar-class.html
[Issue #91772]: {{site.repo.flutter}}/issues/91772
[Deprecate `ThemeData.indicatorColor` in favor of `TabBarThemeData.indicatorColor`]: {{site.repo.flutter}}/pull/160024
