---
title: AppBar theme color parameter deprecation
description: >-
  The color parameter in AppBarTheme and AppBarThemeData has been
  deprecated in favor of backgroundColor for better API consistency.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `color` parameter in `AppBarTheme` and `AppBarThemeData` constructors
and their `copyWith` methods have been deprecated. Use `backgroundColor`
instead. This change affects how AppBar themes are configured and might
cause deprecation warnings in existing code.

## Background

The AppBar theming system had two parameters that controlled the same
property: `color` and `backgroundColor`. This duplication created confusion
and inconsistency in the API. To improve clarity and consistency, the
`color` parameter has been deprecated in favor of `backgroundColor`.

The deprecation affects the following classes and methods:

- `AppBarTheme` constructor
- `AppBarTheme.copyWith` method
- `AppBarThemeData` constructor
- `AppBarThemeData.copyWith` method

When using the deprecated `color` parameter, you'll see warnings like:

```txt
'color' is deprecated and shouldn't be used. Use backgroundColor instead.
This feature was deprecated after v3.33.0-0.2.pre.
```

The classes also include assertion checks to prevent using both parameters
simultaneously:

```txt
The color and backgroundColor parameters mean the same thing. Only specify one.
```

## Migration guide

Replace all uses of the `color` parameter with `backgroundColor` in
`AppBarTheme` and `AppBarThemeData` constructors and `copyWith` methods.

Code before migration:

```dart
// AppBarTheme constructor
AppBarTheme(
  color: Colors.blue,
  elevation: 4.0,
)

// AppBarTheme copyWith
theme.copyWith(
  color: Colors.red,
  elevation: 2.0,
)

// AppBarThemeData constructor
AppBarThemeData(
  color: Colors.green,
  elevation: 4.0,
)

// AppBarThemeData copyWith
themeData.copyWith(
  color: Colors.purple,
  elevation: 2.0,
)
```

Code after migration:

```dart
// AppBarTheme constructor
AppBarTheme(
  backgroundColor: Colors.blue,
  elevation: 4.0,
)

// AppBarTheme copyWith
theme.copyWith(
  backgroundColor: Colors.red,
  elevation: 2.0,
)

// AppBarThemeData constructor
AppBarThemeData(
  backgroundColor: Colors.green,
  elevation: 4.0,
)

// AppBarThemeData copyWith
themeData.copyWith(
  backgroundColor: Colors.purple,
  elevation: 2.0,
)
```

## Timeline

Landed in version: 3.33.0-0.2.pre<br>
In stable release: 3.35.4

## References

API documentation:

- [`AppBarTheme`](https://main-api.flutter.dev/flutter/material/AppBarTheme-class.html)
- [`AppBarThemeData`](https://main-api.flutter.dev/flutter/material/AppBarThemeData-class.html)

Relevant PRs:

- [AppBar theme color parameter deprecation #170624]({{site.github}}/flutter/flutter/pull/170624)
