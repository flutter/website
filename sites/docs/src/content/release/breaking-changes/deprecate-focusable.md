---
title: Deprecate `SemanticsProperties.focusable` and `SemanticsConfiguration.isFocusable`
description: >
  The `focusable` parameter has been replaced by `isFocused`.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `SemanticsProperties.focusable` and `SemanticsConfiguration.isFocusable`
parameters were deprecated in favor of the `SemanticsProperties.focused` and
`SemanticsConfiguration.isFocused` parameters.

The `focused` parameter is now nullable.
Setting it to `true` or `false` automatically
sets `isFocusable` to `true`, while
setting it to `null` sets `isFocusable` to `false`.

## Context

The `SemanticsConfiguration.isFocusable` property is a boolean that
indicates whether the semantics node can have input focus.
`SemanticsConfiguration.isFocused` is a boolean that indicates if the
semantics node has input focus.

This change also applies to
`SemanticsProperties.focusable` and `SemanticsProperties.focused`.

We deprecated `isFocusable` because its functionality is covered by `isFocused`.
The `isFocused` property is now stored as a tristate flag in the engine,
and this change makes the framework consistent with the engine.

## Description of change

The `SemanticsConfiguration.isFocusable` property is
deprecated in favor of `SemanticsConfiguration.isFocused`.
This property is a nullable boolean; setting it to `true` or `false`
automatically sets `isFocusable` to `true`, and
setting it to `null` sets `isFocusable` to `false`.

## Migration guide

Replace `SemanticsConfiguration.isFocusable` with
`SemanticsConfiguration.isFocused`.

### Example 1: Setting `isFocused` to `true` automatically sets `isFocusable` to `true`

Code before migration:

```dart
void describeSemanticsConfiguration(SemanticsConfiguration config) {
  config.isFocusable = true;
  config.isFocused = true;
}
```

Code after migration:

```dart
void describeSemanticsConfiguration(SemanticsConfiguration config) {
  config.isFocused = true;
}
```

### Example 2: Setting `isFocused` to `null` automatically sets `isFocusable` to `false`

Code before migration:

```dart
void describeSemanticsConfiguration(SemanticsConfiguration config) {
  config.isFocusable = false;
  config.isFocused = false;
}
```

Code after migration:

```dart
void describeSemanticsConfiguration(SemanticsConfiguration config) {
  config.isFocused = null;
}
```


## Timeline

Landed in version: 3.37.0-0.0.pre<br>
In stable release: 3.38


## References

API documentation:

* [`SemanticsConfiguration`][]
* [`SemanticsProperties`][]
* [`SemanticsNode`][]

Relevant issue:

* [Issue 166092][]

Relevant PR:

* [PR 170935][]

[`SemanticsConfiguration`]: {{site.api}}/flutter/semantics/SemanticsConfiguration-class.html
[`SemanticsProperties`]: {{site.api}}/flutter/semantics/SemanticsProperties-class.html
[`SemanticsNode`]: {{site.api}}/flutter/semantics/SemanticsNode-class.html
[Issue 166092]: {{site.repo.flutter}}/issues/166092
[PR 170935]: {{site.repo.flutter}}/pull/170935
