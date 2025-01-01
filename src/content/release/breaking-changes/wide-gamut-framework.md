---
title: Migration guide for wide gamut Color
description: >-
  Changes to support wide gamut color and migration instructions.
---

## Summary

The API for the [`Color`][] class in `dart:ui` is changing to
support [wide gamut color spaces][].

## Context

The Flutter engine [already supports wide gamut color][] with [Impeller][], and
the support is now being added [to the framework][].

The iOS devices that Flutter supports render to a larger array of colors,
specifically in the [DisplayP3][] color space.
After this change, the Flutter framework can
render all of those colors on iOS Impeller, and
the `Color` class is better prepared for future color spaces or
changes to color component bit depth.

## Description of change

Changes to [`Color`][]:

 1. Adds an enum field that specifies its [`ColorSpace`][].
 1. Adds API to use normalized floating-point color components.
 1. Removes API that uses 8-bit unsigned integer color components that can
    lead to data loss.

Changes to [`ColorSpace`][]:

 1. Adds a `displayP3` property.

## Migration guide

### 8-bit unsigned integer constructors

Constructors like `Color.fromARGB` remain unchanged and have continued support.
To take advantage of Display P3 colors, you must use the new
`Color.from` constructor that takes normalized floating-point color components.

```dart
// Before: Constructing an sRGB color from the lower 8 bits of four integers.
final magenta = Color.fromARGB(0xff, 0xff, 0x0, 0xff);

// After: Constructing a color with normalized floating-point components.
final magenta = Color.from(alpha: 1.0, red: 1.0, green: 0.0, blue: 1.0);
```

### Implementors of `Color`

There are new methods being added to `Color` so
any class that `implements Color` will break and have to
implement the new methods, such as `Color.a` and `Color.b`.

Ultimately, implementors should migrate to take advantage of the new API.
In the short-term, these methods can easily be implemented without
changing the underlying structure of your class.

For example:

```dart
class Foo implements Color {
  int _red;

  @override
  double get r => _red / 255.0;
}
```

:::note
Flutter plans to eventually lock the `Color` class down and make it `sealed`.

Now might be a good opportunity to switch from [inheritance to composition][]
and stop reimplementing `Color`.
:::

### Color space support

Clients that use `Color` and perform any sort of calculation on
the color components should now first check the
color space component before performing calculations.
To help with that, you can use the new `Color.withValues` method to
perform color space conversions.

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

Performing calculations with color components without
aligning color spaces can lead to subtle unexpected results.
In the preceding example, the `redRatio` would have the difference of `0.09`
when calculated with differing color spaces versus aligned color spaces.

### Access color components

If your app ever accesses a `Color` component, consider
taking advantage of the floating-point components.
In the short term, you can scale the components themselves.

```dart
extension IntColorComponents on Color {
  int get intAlpha => _floatToInt8(this.a);
  int get intRed => _floatToInt8(this.r);
  int get intGreen => _floatToInt8(this.g);
  int get intBlue => _floatToInt8(this.b);

  int _floatToInt8(double x) {
    return (x * 255.0).round() & 0xff;
  }
}
```

### Opacity

Previously, Color had the concept of "opacity" which
showed up in the methods `opacity` and `withOpacity()`.
Opacity was introduced as a way to communicate with `Color` about
its alpha channel with floating point values.
Now that alpha is a floating-point value, opacity is redundant
and `opacity` and `withOpacity` are deprecated and slated to be removed.

<a id="opacity-migration" aria-hidden="true"></a>
#### Migrate `opacity`

```dart
// Before: Access the alpha channel as a (converted) floating-point value.
final x = color.opacity;

// After: Access the alpha channel directly.
final x = color.a;
```

<a id="withopacity-migration" aria-hidden="true"></a>
#### Migrate `withOpacity`

```dart
// Before: Create a new color with the specified opacity.
final x = color.withOpacity(0.0);

// After: Create a new color with the specified alpha channel value,
// accounting for the current or specified color space.
final x = color.withValues(alpha: 0.0);
```

### Equality

Once `Color` stores its color components as floating-point numbers,
equality works slightly differently.
When calculating colors, there might be a
tiny difference in values that could be considered equal.
To accommodate this use the [`closeTo`][] or [`isColorSameAs`][] matchers.

```dart
// Before: Check exact equality of int-based color.
expect(calculateColor(), const Color(0xffff00ff));

// After: Check rough equality of floating-point-based color.
expect(calculateColor(), isSameColorAs(const Color(0xffff00ff)));
```

## Timeline

### Phase 1 - New API introduction, old API deprecation

Landed in version: 3.26.0-0.1.pre<br>
In stable release: 3.27.0

### Phase 2 - Old API removal

Landed in version: Not yet<br>
In stable release: Not yet

## References

Relevant issue:

* [issue 127855][]: Implement wide gamut color support in the Framework

Relevant PRs:

* [PR 54737][]: Framework wide color

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
