---
title: Deprecate `ButtonBar` in favor of `OverflowBar`
description: >-
  The ButtonBar widget has been replaced by
  a more efficient widget, OverflowBar.
---

## Summary

The `ButtonBar` widget was deprecated in favor of
the more efficient `OverflowBar` widget.
As a result, `ThemeData.buttonBarTheme` and
`ButtonBarTheme` were also deprecated.

## Context

The `ButtonBar` widget lays out its children in a row and
in a column if there is not enough horizontal space.
The `OverflowBar` widget does the same, but it's
not tied to the Material library and is part of the core `widgets.dart` library.

## Description of change

- Replace `ButtonBar` widget with `OverflowBar` widget.
- By default, `ButtonBar` aligns its children to the end of the layout, while
  `OverflowBar` aligns its children to the start.
  To align the `OverflowBar` children to the end, set
  the `OverflowBar.alignment` property to `MainAxisAlignment.end`.
- `ButtonBar.buttonPadding` provides spacing
  between buttons and padding around buttons.
  Replace it with `OverflowBar.spacing`, which provides spacing between buttons.
  Wrap the `OverflowBar` widget with `Padding` widget to
  provide padding around the buttons.
- Replace `ButtonBar.overflowButtonSpacing` with `OverflowBar.overflowSpacing`,
  which provides spacing between buttons when the buttons are laid in a column
  when there is not enough horizontal space.
- If it is specified, remove `ButtonBarThemeData` from `ThemeData`.

## Migration guide

Replace `ButtonBar` with `OverflowBar`, override the default alignment if
necessary, replace `ButtonBar.buttonPadding` with `Padding` widget and
`OverflowBar.spacing` for spacing between and around buttons, and replace
`ButtonBar.overflowButtonSpacing` with `OverflowBar.overflowSpacing` for
spacing between buttons when the buttons are laid in a column when there is not
enough horizontal space.

Before:

```dart
ButtonBar(
  buttonPadding: const EdgeInsets.all(8.0),
  overflowButtonSpacing: 8.0,
  children: <Widget>[
    TextButton(child: const Text('Button 1'), onPressed: () {}),
    TextButton(child: const Text('Button 2'), onPressed: () {}),
    TextButton(child: const Text('Button 3'), onPressed: () {}),
  ],
),
```

After:

```dart
Padding(
  padding: const EdgeInsets.all(8.0),
  child: OverflowBar(
    alignment: MainAxisAlignment.end,
    spacing: 8.0,
    overflowSpacing: 8.0,
    children: <Widget>[
      TextButton(child: const Text('Button 1'), onPressed: () {}),
      TextButton(child: const Text('Button 2'), onPressed: () {}),
      TextButton(child: const Text('Button 3'), onPressed: () {}),
    ],
  ),
),
```

If you specify a `ThemeData.buttonBarTheme`, remove it and
use the `OverflowBar` widget properties to customize the `OverflowBar` widget.

Before:

```dart
ThemeData(
  buttonBarTheme: ButtonBarThemeData(
    alignment: MainAxisAlignment.center,
  ),
),
```

After:

```dart
ThemeData(
  // ...
),
```

If you use the `ButtonBarTheme` widget, remove it and
use the `OverflowBar` widget properties to customize the `OverflowBar` widget.

Before:

```dart
ButtonBarTheme(
  data: ButtonBarThemeData(
    alignment: MainAxisAlignment.center,
  ),
  child: ButtonBar(
    children: <Widget>[
      // ...
    ],
  ),
),
```

After:

```dart
OverflowBar(
  alignment: MainAxisAlignment.center,
  children: <Widget>[
    // ...
  ],
),
```

## Timeline

Landed in version: 3.22.0-2.0.pre<br>
In stable release: 3.24.0

## References

API documentation:

- [`OverflowBar`][]
- [`ButtonBar`][]

Relevant issues:

- [Issue #127955][]

Relevant PRs:

- [Deprecate `ButtonBar`, `ButtonBarThemeData`, and `ThemeData.buttonBarTheme`][]

[`OverflowBar`]: {{site.api}}/flutter/widgets/OverflowBar-class.html
[`ButtonBar`]: {{site.api}}/flutter/material/ButtonBar-class.html
[Issue #127955]: {{site.repo.flutter}}/issues/127955
[Deprecate `ButtonBar`, `ButtonBarThemeData`, and `ThemeData.buttonBarTheme`]: {{site.repo.flutter}}/pull/145523
