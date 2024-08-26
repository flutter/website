---
title: Migration guide for wide gamut Color
description: Description on Color changes for wide gamut support and migration
             instructions.
---

## Summary

The API for the [`Color`][] class in `dart:ui` is changing to support wide gamut
colors.

## Context

Wide gamut color support was [added to the renderer][] previously. That support
is now being plumbed up [to the Flutter Framework][] so those colors can be used
by UIs.

## Description of change

Changes to [`Color`][]:

 1. Adds a enum field which will specify its [`ColorSpace`][].
 1. Adds API to use normalized floating-point color components.
 1. Removes API that uses 8-bit unsigned integer color components that can lead
    to data loss.

Changes to [`ColorSpace`][]:

 1. `displayP3` will be added.

## Migration guide

### 8-bit unsigned integer constructors

Constructors like `Color.fromARGB` will remain unchanged and have continued
support. If one wants to take advantage of Display P3 colors they will have to
use the new `Color.from` constructor that takes normalized floating-point
color components.

### Implementors of `Color`

There are new methods being added to `Color` so any class that `implements`
Color will break and have to implement the new methods like `Color.a`, and
`Color.b`. Ultimately implementors should be migrated to take advantage of the
new API. In the short-term, these methods can easily be implemented without
changing the underlying structure of your class.

For example:

```dart
class Foo implements Color {
  int _red;

  @override
  double get r => _red * 255.0;
}
```

### Color space support

Clients that use `Color` and perform any sort of calculation on the color
components should now be checking the color space component before doing any
such calculation. `Color` has a new method `Color.withValues` that can be used
to perform color space conversions to help with that.

For example:

```dart
// Before
double redRatio(Color x, Color y) => x.red / y.red;

// After
double redRatio(Color x, Color y) {
  final xPrime = x.withValues(colorSpace: ColorSpace.extendedSRGB);
  final yPrime = y.withValues(colorSpace: ColorSpace.extendedSRGB);
  return xPrime.r / yPrime.r;
}
```

### Color component accessors

For users of `Color`, if the components are ever accessed the code should be
migrated to take advantage of the floating-point components. In the short term
one can easily scale the components themselves.

```dart
extension IntColorComponents on Color {
  int get intAlpha => this.a ~/ 255;
  int get intRed => this.r ~/ 255;
  int get intGreen => this.g ~/ 255;
  int get intBlue => this.b ~/ 255;
}
```

## Timeline

### Phase 1 - New API introduction, old API deprecation

**Release to stable:** TBD
**PR:**: [PR 54737][]

### Phase 2 - Old API removal

**Release to stable:** TBD

## References

Relevant PRs:

* [issue 127855][]: Implement wide gamut color support in the Framework

[`Color`]: {{site.api}}/flutter/dart-ui/Color-class.html
[added to the renderer]: {{site.repo.flutter}}/issues/55092
[to the Flutter Framework]: {{site.repo.flutter}}/issues/127855
[issue 127855]: {{site.repo.flutter}}/issues/127855
[`ColorSpace`]: {{site.api}}/flutter/dart-ui/ColorSpace.html
[PR 54737]: {{site.repo.engine}}/pull/54737
