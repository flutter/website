---
title: Removed semantics elevation and thickness
description: >-
  Removed elevation and thickness from semantics properties.
---

{% render "docs/breaking-changes.md" %}

## Summary

Both elevation and thickness semantics properties and their related APIs were removed.

## Context

Both elevation and thickness semantics properties were created for Fuchsia's 3D rendering.
They were never implemented and thus remained unused. There was also no other known usage
for these properties. These properties added unnecessary code complexity and have been removed.

## Description of change

The following properties are removed `SemanticsConfiguration.elevation`,
`SemanticsConfiguration.thickness`,
`SemanticsNode.thickness`, `SemanticsNode.elevation`, and `SemanticsNode.elevationAdjustment`.

## Migration guide

If you previously assigned these properties, remove the assignments.

Code before migration:

```dart
void describeSemanticsConfiguration(SemanticsConfiguration config) {
  config.label = 'my label';
  config.elevation = 1;
  config.thickness = 1;
}
```

Code after migration:

```dart
void describeSemanticsConfiguration(SemanticsConfiguration config) {
  config.label = 'my label';
}
```

## Timeline

Landed in version: 3.34.0-0.0.pre<br>
In stable release: 3.35

## References

API documentation:

* [`SemanticsConfiguration`][]
* [`SemanticsNode`][]

Relevant issue:

* [Issue 166092][]

Relevant PR:

* [PR 169382][]

[`SemanticsConfiguration`]: {{site.api}}/flutter/semantics/SemanticsConfiguration-class.html
[`SemanticsNode`]: {{site.api}}/flutter/semantics/SemanticsNode-class.html
[Issue 166092]: {{site.repo.flutter}}/issues/166092
[PR 169382]: {{site.repo.flutter}}/pull/169382
