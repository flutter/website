---
title: Deprecate `ThemeData.dialogBackgroundColor` in favor of
  `DialogThemeData.backgroundColor`
description: >-
  The `ThemeData.dialogBackgroundColor` parameter has been replaced by
  `DialogThemeData.backgroundColor`.
---

{% render "docs/breaking-changes.md" %}

## Summary

The [`ThemeData.dialogBackgroundColor`][] parameter was deprecated in favor of
the [`DialogThemeData.backgroundColor`][] parameter.

## Context

The defaults for the [`Dialog`][] and [`AlertDialog`][] widgets can be
overridden with a component-specific theme like [`DialogThemeData`][].
Previously, the `ThemeData.dialogBackgroundColor` parameter was used to
override the default dialog background color,
which was made redundant by [`DialogThemeData`][].

## Description of change

The [`ThemeData.dialogBackgroundColor`][] is deprecated in
favor of a component-specific theme.
Use [`DialogThemeData`][] to override the default background color.

## Migration guide

Replace [`ThemeData.dialogBackgroundColor`][] with
[`DialogThemeData.backgroundColor`][] to override the
default dialog background color.

Code before migration:

```dart
theme: ThemeData(
  dialogBackgroundColor: Colors.orange,
),
```

Code after migration:

```dart
theme: ThemeData(
  dialogTheme: const DialogThemeData(backgroundColor: Colors.orange),
),
```

## Timeline

Landed in version: 3.28.0-0.1.pre<br>
In stable release: 3.29

## References

API documentation:

- [`ThemeData.dialogBackgroundColor`][]
- [`DialogThemeData.backgroundColor`][]
- [`DialogThemeData`][]
- [`Dialog`][]
- [`AlertDialog`][]

Relevant issues:

- [Issue #91772][]

Relevant PRs:

- [Deprecate `ThemeData.dialogBackgroundColor` in favor of `DialogTheme.backgroundColor`][]

[`ThemeData.dialogBackgroundColor`]: {{site.api}}/flutter/material/ThemeData/dialogBackgroundColor.html
[`DialogThemeData.backgroundColor`]: {{site.api}}/flutter/material/DialogThemeData/backgroundColor.html
[`DialogThemeData`]: {{site.api}}/flutter/material/DialogThemeData-class.html
[`Dialog`]: {{site.api}}/flutter/material/Dialog-class.html
[`AlertDialog`]: {{site.api}}/flutter/material/AlertDialog-class.html
[Issue #91772]: {{site.repo.flutter}}/issues/91772
[Deprecate `ThemeData.dialogBackgroundColor` in favor of `DialogTheme.backgroundColor`]: {{site.repo.flutter}}/pull/155072
