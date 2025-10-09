---
title: GestureRecognizer cleanup
description: >
  OneSequenceGestureRecognizer subclasses should
  override `addAllowedPointer` to take a `PointerDownEvent`
---

{% render docs/docs/breaking-changes.md %}

## Summary

`OneSequenceGestureRecognizer.addAllowedPointer()` was changed to take a
`PointerDownEvent`, like its superclass. Previously, it accepted the more
general `PointerEvent` type, which was incorrect.

## Context

The framework only ever passes `PointerDownEvent` objects to
`addAllowedPointer()`. Declaring
`OneSequenceGestureRecognizer.addAllowedPointer()` to take the more general
type was confusing, and caused `OneSequenceGestureRecognizer` subclasses to
have to cast their argument to the right class.

## Description of change

The previous declaration forced `OneSequenceGestureRecognizer` descendants to
override `addAllowedPointer()` like so:

```dart
class CustomGestureRecognizer extends ScaleGestureRecognizer {
  @override
  void addAllowedPointer(PointerEvent event) {
    // insert custom handling of event here...
    super.addAllowedPointer(event);
  }
}
```

The new method declaration will cause this code to fail with the following
error message:

```plaintext
super.addAllowedPointer(event); The argument type 'PointerEvent' can't be assigned to the parameter type 'PointerDownEvent'.
                                #argument_type_not_assignable

```

## Migration guide

Code before migration:

```dart
class CustomGestureRecognizer extends ScaleGestureRecognizer {
  @override
  void addAllowedPointer(PointerEvent event) {
    // insert custom handling of event here...
    super.addAllowedPointer(event);
  }
}
```

Code after migration:

```dart
class CustomGestureRecognizer extends ScaleGestureRecognizer {
  @override
  void addAllowedPointer(PointerDownEvent event) {
    // insert custom handling of event here...
    super.addAllowedPointer(event);
  }
}
```

## Timeline

Landed in version: 2.3.0-13.0.pre<br>
In stable release: 2.5

## References

API documentation:

* [`OneSequenceGestureRecognizer`][]

Relevant PR:

* [Fix addAllowedPointer() overrides][]

[`OneSequenceGestureRecognizer`]: {{site.api}}/flutter/gestures/OneSequenceGestureRecognizer-class.html
[Fix addAllowedPointer() overrides]: {{site.repo.flutter}}/pull/82834
