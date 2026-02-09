---
title: Deprecate MemoryAllocations in favor of FlutterMemoryAllocations
description: >-
  MemoryAllocations is renamed to FlutterMemoryAllocations.
---

{% render "docs/breaking-changes.md" %}

## Summary

Disposables in pure Dart projects can't use `MemoryAllocations` in Flutter.
So, to be leak-trackable they need a Dart-only class.
`MemoryAllocations` in Flutter is renamed to make the name
available to a non-Flutter, Dart project.

## Migration guide

Before:

```dart
if (kFlutterMemoryAllocationsEnabled) {
  MemoryAllocations.instance.dispatchObjectCreated(
    library: 'package:flutter/gestures.dart',
    className: '$MultiDragPointerState',
    object: this,
  );
}
```

After:

```dart
if (kFlutterMemoryAllocationsEnabled) {
  FlutterMemoryAllocations.instance.dispatchObjectCreated(
    library: 'package:flutter/gestures.dart',
    className: '$MultiDragPointerState',
    object: this,
  );
}
```

## Timeline

Landed in version: 3.19.0-2.0.pre<br>
Landed in stable: 3.22.0

## References

Relevant issues:

* [Rename MemoryAllocations to FlutterMemoryAllocations (Issue 140622)][]

[Rename MemoryAllocations to FlutterMemoryAllocations (Issue 140622)]: {{site.repo.flutter}}/issues/140622
