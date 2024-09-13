---
title: Migration guide for wide gamut Color
description: >-
  Changes to support wide gamut color and migration instructions.
---

## Summary

The API for the [`Color`][] class in `dart:ui` is changing to support [wide
gamut color spaces][].

## Context

The Flutter engine [already supports wide gamut color][] with [Impeller][], and
the support is now being added [to the framework][].

The iOS devices that Flutter supports render to a larger array of colors,
specifically in the [DisplayP3][] color space. After this change, the Flutter
framework can render all of those colors on iOS Impeller, and the `Color` class
will be better prepared for future color spaces or changes to
color component bit depth.

## Description of change

Changes to [`Color`][]:

 1. Adds an enum field that specifies its [`ColorSpace`][].
 1. Adds API to use normalized floating-point color components.
 1. Removes API that uses 8-bit unsigned integer color components that can lead
    to data loss.

Changes to [`ColorSpace`][]:

 1. Adds a `displayP3` property.

## Migration guide

### 8-bit unsigned integer constructors

Constructors like `Color.fromARGB` remain unchanged and have continued
support. To take advantage of Display P3 colors, you must
use the new `Color.from` constructor that takes normalized floating-point
color components.

```dart
// Before
final magenta = Color.fromARGB(0xff, 0xff, 0x0, 0xff);
// After
final magenta = Color.from(alpha: 1.0, red: 1.0, green: 0.0, blue: 1.0)
```

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

:::note
We plan to eventually lock the `Color` class down and make it `sealed`. Now
might be a good opportunity to switch from [inheritance to composition][] and
stop reimplementing `Color`.
:::

### Color space support

Clients that use `Color` and perform any sort of calculation on the color
components should now first check the color space component before performing
calculations. To help with that, you can use the new `Color.withValues` method
to perform color space conversions.

Example migration:

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

Performing calculations with color components without aligning color spaces can
lead to subtle unexpected results. In the example above the `redRatio` would
have the difference of 0.09 when calculated with differing color spaces versus
aligned color spaces.

### Access color components

If your app ever accesses a `Color` component, consider taking advantage of the
floating-point components. In the short term, you can easily scale the
components themselves.

```dart
extension IntColorComponents on Color {
  int get intAlpha => this.a ~/ 255;
  int get intRed => this.r ~/ 255;
  int get intGreen => this.g ~/ 255;
  int get intBlue => this.b ~/ 255;
}
```

### Opacity

Previously, Color had the concept of "opacity" which showed up in the methods
`opacity` and `withOpacity()`. Opacity was introduced as a way to communicate
with `Color` about its alpha channel with floating point values. Now that alpha
is a floating-point value, opacity is redundant and `opacity` and `withOpacity`
are deprecated and slated to be removed.

#### `opacity` migration

```dart
// Before
final x = color.opacity;
// After
final x = color.a;
```

#### `withOpacity` migration

```dart
// Before
final x = color.withOpacity(0.0);
// After
final x = color.withValues(alpha: 0.0);
```

### Equality

Once `Color` stores its color components as floating-point numbers,
equality works slightly differently.
When calculating colors there might be tiny
difference in values that could be considered equal.
To accommodate this use the [`closeTo`][] matcher or the [`isColorSameAs`][] matcher.

```dart
// Before
expect(calculateColor(), const Color(0xffff00ff));
// After
expect(calculateColor(), isSameColorAs(const Color(0xffff00ff)));
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
[already supports wide gamut color]: {{site.repo.flutter}}/issues/55092
[to the framework]: {{site.repo.flutter}}/issues/127855
[issue 127855]: {{site.repo.flutter}}/issues/127855
[`ColorSpace`]: {{site.api}}/flutter/dart-ui/ColorSpace.html
[PR 54737]: {{site.repo.engine}}/pull/54737
[DisplayP3]: https://en.wikipedia.org/wiki/DCI-P3
[Impeller]: {{site.api}}/perf/impeller
[wide gamut color spaces]: https://en.wikipedia.org/wiki/RGB_color_spaces
[inheritance to composition]: https://en.wikipedia.org/wiki/Composition_over_inheritance
[`closeTo`]: {{site.api}}/documentation/matcher/latest/matcher/closeTo.html
[`isColorSameAs`]: {{site.api}}/flutter/flutter_test/isSameColorAs.html
