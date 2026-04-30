---
title: Rename MaterialState to WidgetState
description: >-
  MaterialState and its related APIs have been moved
  outside of the Material library and renamed to
  WidgetState.
---

{% render "docs/breaking-changes.md" %}

## Summary

`MaterialState`, and its related APIs, have been moved out
of the Material library and renamed to `WidgetState`.

## Background

Previously, `MaterialState` provided logic for
handling multiple different states a widget could have,
like "hovered", "focused", and "disabled".
Because this functionality is useful outside the Material library,
namely for the base Widgets layer and Cupertino,
it was decided to move it outside of Material.
As part of the move, and to avoid future confusion,
the different `MaterialState` classes have been renamed to `WidgetState`.
The behavior of the two are the same.

| Before                          | Now                           |
|---------------------------------|-------------------------------|
| `MaterialState`                 | `WidgetState`                 |
| `MaterialStatePropertyResolver` | `WidgetStatePropertyResolver` |
| `MaterialStateColor`            | `WidgetStateColor`            |
| `MaterialStateMouseCursor`      | `WidgetStateColorMouseCursor` |
| `MaterialStateBorderSide`       | `WidgetStateBorderSide`       |
| `MaterialStateOutlinedBorder`   | `WidgetStateOutlinedBorder`   |
| `MaterialStateTextStyle`        | `WidgetStateTextStyle`        |
| `MaterialStateProperty`         | `WidgetStateProperty`         |
| `MaterialStatePropertyAll`      | `WidgetStatePropertyAll`      |
| `MaterialStatesController`      | `WidgetStatesController`      |

The classes `MaterialStateOutlineInputBorder` and
`MaterialStateUnderlineInputBorder` were left in the
Material library with no `WidgetState` equivalent, as
they are specific to Material design.

## Migration guide

A [Flutter fix][] is available to help migrate the `MaterialState`
classes to `WidgetState`.

To migrate, replace `MaterialState` with `WidgetState`.

Code before migration:

```dart
MaterialState selected = MaterialState.selected;

final MaterialStateProperty<Color> backgroundColor;

class _MouseCursor extends MaterialStateMouseCursor{
  const _MouseCursor(this.resolveCallback);

  final MaterialPropertyResolver<MouseCursor?> resolveCallback;

  @override
  MouseCursor resolve(Set<MaterialState> states) => resolveCallback(states) ?? MouseCursor.uncontrolled;
}

BorderSide side = MaterialStateBorderSide.resolveWith((Set<MaterialState> states) {
  if (states.contains(MaterialState.selected)) {
    return const BorderSide(color: Colors.red);
  }
  return null;
});
```

Code after migration:

```dart
WidgetState selected = WidgetState.selected;

final WidgetStateProperty<Color> backgroundColor;

class _MouseCursor extends WidgetStateMouseCursor{
  const _MouseCursor(this.resolveCallback);

  final WidgetPropertyResolver<MouseCursor?> resolveCallback;

  @override
  MouseCursor resolve(Set<WidgetState> states) => resolveCallback(states) ?? MouseCursor.uncontrolled;
}

BorderSide side = WidgetStateBorderSide.resolveWith((Set<WidgetState> states) {
  if (states.contains(WidgetState.selected)) {
    return const BorderSide(color: Colors.red);
  }
  return null;
});
```

## Timeline

Landed in version: 3.21.0-11.0.pre<br>
In stable release: 3.22.0

## References

Relevant issues:

* [Create widgets level support for State][]

Relevant PRs:

* [Widget State Properties][]

[Create widgets level support for State]: {{site.repo.flutter}}/issues/138270
[Flutter fix]: /tools/flutter-fix
[Widget State Properties]: {{site.repo.flutter}}/pull/142151
