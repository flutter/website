---
title: Deprecate MemoryAllocations in favor of FlutterMemoryAllocations
description: >-
  MemoryAllocations is renamed to FlutterMemoryAllocations
---

## Summary

Disposables in pure Dart projects cannot use MemoryAllocations in Flutter. 
So, to be leak trackable they need a Dart-only class.
MemoryAllocations in Flutter is renamed to release the name
for Dart-only class.

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

Landed in version: 3.19.0-2.0.pre

## References

Relevant issues:

* [Rename MemoryAllocations to FlutterMemoryAllocations (Issue 140622)][]

[Rename MemoryAllocations to FlutterMemoryAllocations (Issue 140622)]: {{site.repo.flutter}}/issues/140622
