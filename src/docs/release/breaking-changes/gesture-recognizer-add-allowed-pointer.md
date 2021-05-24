---
title: GestureRecognizer Cleanup
description: OneSequenceGestureRecognizer subclasses should override `addAllowedPointer` to take a `PointerDownEvent`
---

## Summary

`OneSequenceGestureRecognizer.addAllowedPointer()` was changed to take a
`PointerDownEvent`, like it superclass. Previously, it accepted the more
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

<!-- skip -->
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

```
super.addAllowedPointer(event); The argument type 'PointerEvent' can't be assigned to the parameter type 'PointerDownEvent'.
                                #argument_type_not_assignable

```

## Migration guide

Code before migration:

<!-- skip -->
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

<!-- skip -->
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
In stable release: not yet

## References

API documentation:
* [`OneSequenceGestureRecognizer`][]

Relevant PRs:
* [Fix addAllowedPointer() overrides][]

[`OneSequenceGestureRecognizer`]: {{site.api}}/flutter/gestures/OneSequenceGestureRecognizer-class.html
[Fix addAllowedPointer() overrides]: {{site.github}}/flutter/flutter/pull/82834
