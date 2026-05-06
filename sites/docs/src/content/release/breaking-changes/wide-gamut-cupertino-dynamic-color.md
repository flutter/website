---
title: Migration guide for wide gamut CupertinoDynamicColor
description: >-
  Addressing previously missed deprecations in CupertinoDynamicColor to
  align with wide gamut Color API.
---

{% render "docs/breaking-changes.md" %}

## Summary

Certain properties and methods in [`CupertinoDynamicColor`][] were deprecated
to align with the [`Color`][] class due to [wide gamut color spaces][] support
added in [Flutter 3.27][Migration guide for wide gamut Color].

## Context

The `Color` class was updated to support wide gamut color spaces,
but some corresponding deprecations were not initially applied to
`CupertinoDynamicColor` due to its implementation rather than
due to the extension of `Color`.

## Description of change

1.  The [`CupertinoDynamicColor.red`][] field is deprecated in
    favor of [`CupertinoDynamicColor.r`].
1.  The [`CupertinoDynamicColor.green`][] is deprecated in
    favor of [`CupertinoDynamicColor.g`].
1.  The [`CupertinoDynamicColor.blue`][] is deprecated in
    favor of [`CupertinoDynamicColor.b`].
1.  The [`CupertinoDynamicColor.opacity`][] is deprecated in
    favor of [`CupertinoDynamicColor.a`].
1.  The [`CupertinoDynamicColor.withOpacity()`][] is deprecated in
    favor of [`CupertinoDynamicColor.withValues()`].


## Migration guide

### Access color components

If your app accesses a single color component, consider
taking advantage of the floating-point components.
In the short term, you can scale the components themselves.

```dart
int _floatToInt8(double x) {
  return (x * 255.0).round().clamp(0, 255);
}

const CupertinoDynamicColor color = CupertinoColors.systemBlue;
final intRed = _floatToInt8(color.r);
final intGreen = _floatToInt8(color.g);
final intBlue = _floatToInt8(color.b);
```

### Opacity

Before Flutter 3.27, `Color` had the concept of "opacity", which
showed up in the methods `opacity` and `withOpacity()`.
Since Flutter 3.27, the alpha channel has been stored as a floating-point value.
Using `.a` and `.withValues()` will give the full expression of
a floating-point value and won't be quantized (restricted to a limited range).
That means "alpha" expresses the intent of "opacity" more correctly.

#### Migrate `opacity`

```dart
// Before: Access the alpha channel as a (converted) floating-point value.
final x = color.opacity;

// After: Access the alpha channel directly.
final x = color.a;
```

#### Migrate `withOpacity`

```dart
// Before: Create a new color with the specified opacity.
final x = color.withOpacity(0.5);

// After: Create a new color with the specified alpha channel value,
// accounting for the current or specified color space.
final x = color.withValues(alpha: 0.5);
```

## Timeline

Landed in version: 3.36.0-0.1.pre<br>
Stable release: 3.38

## References

Relevant guides:

* [Migration guide for wide gamut Color][]

Relevant issues:

* [Implement wide gamut color support in the Framework][]
* [CupertinoDynamicColor is missing deprecation notices][]

Relevant PRs:

* [Add missing deprecations to CupertinoDynamicColor][]

[`Color`]: {{site.api}}/flutter/dart-ui/Color-class.html
[`CupertinoDynamicColor`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor-class.html
[wide gamut color spaces]: https://en.wikipedia.org/wiki/RGB_color_spaces
[`CupertinoDynamicColor.red`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/red.html
[`CupertinoDynamicColor.r`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/r.html
[`CupertinoDynamicColor.green`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/green.html
[`CupertinoDynamicColor.g`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/g.html
[`CupertinoDynamicColor.blue`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/blue.html
[`CupertinoDynamicColor.b`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/b.html
[`CupertinoDynamicColor.opacity`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/opacity.html
[`CupertinoDynamicColor.a`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/a.html
[`CupertinoDynamicColor.withOpacity()`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/withOpacity.html
[`CupertinoDynamicColor.withValues()`]: {{site.api}}/flutter/cupertino/CupertinoDynamicColor/withValues.html
[Migration guide for wide gamut Color]: /release/breaking-changes/wide-gamut-framework
[Implement wide gamut color support in the Framework]: {{site.repo.flutter}}/issues/127855
[CupertinoDynamicColor is missing deprecation notices]: {{site.repo.flutter}}/issues/171059
[Add missing deprecations to CupertinoDynamicColor]: {{site.repo.flutter}}/pull/171160
