---
title: Deprecate `SemanticsProperties.focusable` and `SemanticsConfiguration.isFocusable`
description: >
  The `focusable` parameter has been replaced by `isFocused`.
---

## Summary

The `SemanticsProperties.focusable` and `SemanticsConfiguration.isFocusable`
parameters were deprecated in favor of the `SemanticsProperties.focused` and
`SemanticsConfiguration.isFocused` parameters.

## Context

The `SemanticsConfiguration.isFocusable` is a boolean to describe
whether the semantics node can have input focus, and
`SemanticsConfiguration.isFocused` is a boolean to describe if the
semantics node has input focus.

The fix is the same with `SemanticsProperties.focusable` and `SemanticsProperties.focused`.

## Description of change

The `SemanticsConfiguration.isFocusable` is deprecated in
favor of `SemanticsConfiguration.isFocused`, which is a nullable boolean;
setting it to true/false automatically sets `isFocusable` to `true`,
and setting it to null sets `isFocusable` to `false`.

## Migration guide

Replace `SemanticsConfiguration.isFocusable` with `SemanticsConfiguration.isFocused`.

### Example 1: setting `isFocused` to `true` automatically sets `isFocusable` to `true`.

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

### Example 2: setting `isFocused` to null automatically sets `isFocusable` to `false`.

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

Landed in version: Not yet<br>
In stable release: Not yet


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
[Issue 166101]: {{site.repo.flutter}}/issues/166101
[PR 168703]: {{site.repo.flutter}}/pull/170935
