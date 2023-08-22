---
title: Updated `Checkbox.fillColor` behavior
description: >
  Improved `Checkbox.fillColor` behavior applies the fill color to the
  checkbox's background when it is unchecked.
---

## Summary

The `Checkbox.fillColor` is now applied to the checkbox's background when
it is unchecked.

## Context

Previously, the `Checkbox.fillColor` was applied to the checkbox's border
when it is unchecked and the background was transparent. With this change,
the `Checkbox.fillColor` is applied to the checkbox's background and the
border uses the `Checkbox.side` color when it is unchecked.

## Description of change

The `Checkbox.fillColor` is now applied to the checkbox's background when
it is unchecked instead of the border.

## Migration guide

Updated `Checkbox.fillColor` behavior applies the fill color to the
checkbox's background in the unchecked state. To get the previous behavior,
set `Checbox.fillColor` to `Colors.transparent` in the unchecked state and
set `Checkbox.side` to the desired color.

If you use the `Checkbox.fillColor` property to customize the checkbox.

Code before migration:

```dart
Checkbox(
  fillColor: MaterialStateProperty.resolveWith((states) {
    // Disabled and unchecked state.
    if (states.contains(MaterialState.disabled)) {
      if (!states.contains(MaterialState.selected)) {
        return Colors.red;
      }
    }
    // Enabled and unchecked state.
    if (!states.contains(MaterialState.selected)) {
      return Colors.red;
    }
    return null;
  }),
  value: _checked,
  onChanged: _enabled
    ? (bool? value) {
        setState(() {
          _checked = value!;
        });
      }
    : null,
),
```

Code after migration:

```dart
Checkbox(
  fillColor: MaterialStateProperty.resolveWith((states) {
    // Disabled and unchecked state.
    if (states.contains(MaterialState.disabled)) {
      if (!states.contains(MaterialState.selected)) {
        return Colors.transparent;
      }
    }
    // Enabled and unchecked state.
    if (!states.contains(MaterialState.selected)) {
      return Colors.transparent;
    }
    return null;
  }),
  side: const BorderSide(color: Colors.red, width: 2),
  value: _checked,
  onChanged: _enabled
    ? (bool? value) {
        setState(() {
          _checked = value!;
        });
      }
    : null,
),
```

If you use the `CheckboxThemeData.fillColor` property to customize the checkbox.

Code before migration:

```dart
checkboxTheme: CheckboxThemeData(
  fillColor: MaterialStateProperty.resolveWith((states) {
    // Disabled and unchecked state.
    if (states.contains(MaterialState.disabled)) {
      if (!states.contains(MaterialState.selected)) {
        return Colors.red;
      }
    }
    // Enabled and unchecked state.
    if (!states.contains(MaterialState.selected)) {
      return Colors.red;
    }
    return null;
  }),
),
```

Code after migration:

```dart
checkboxTheme: CheckboxThemeData(
  fillColor: MaterialStateProperty.resolveWith((states) {
    // Disabled and unchecked state.
    if (states.contains(MaterialState.disabled)) {
      if (!states.contains(MaterialState.selected)) {
        return Colors.transparent;
      }
    }
    // Enabled and unchecked state.
    if (!states.contains(MaterialState.selected)) {
      return Colors.transparent;
    }
    return null;
  }),
  side: const BorderSide(color: Colors.red, width: 2),
),
```

## Timeline

Landed in version: 3.10.0-17.0.pre<br>
In stable release: 3.13.0

## References

API documentation:

* [`Checkbox.fillColor`][]

Relevant issues:

* [Add `backgroundColor` to `Checkbox` and `CheckboxThemeData`][]

Relevant PRs:

* [`Checkbox.fillColor` should be applied to checkbox's background color when it is unchecked.][]

[`Checkbox.fillColor`]: {{site.api}}/flutter/material/Checkbox/fillColor.html

[Add `backgroundColor` to `Checkbox` and `CheckboxThemeData`]: {{site.repo.flutter}}/issues/123386
[`Checkbox.fillColor` should be applied to checkbox's background color when it is unchecked.]: {{site.repo.flutter}}/pull/125643
