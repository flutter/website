---
title: Introduce new ColorScheme roles for Material 3
description: >-
  ColorScheme introduces new colors roles to better align with Material Design
  3. ColorScheme.fromSeed method is also updated to support the newly added
  colors.
---

## Summary

New color roles in ColorScheme include seven tone-based surfaces and containers, alongside twelve accent color add-ons. This update deprecates three existing color roles: background, onBackground, and surfaceVariant. The ColorScheme constructed by the updated ColorScheme.fromSeed method now generates different values compared to the previous version, adapting to Material Design 3's guidelines.

## Background

The tone-based surface colors include: `surfaceBright`, `surfaceDim`,
`surfaceContainer`, `surfaceContainerLow`, `surfaceContainerLowest`,
`surfaceContainerHigh`, and `surfaceContainerHighest`. These changes helps 
deprecate the use of widgets' `surfaceTintColor`, and replace the old 
opacity-based model which applied a tinted overlay on top of surfaces based 
on their elevation.  

The `surfaceTintColor` of widgets has been set to null and their background
color are replaced by the new tone-based surface colors.

`ColorScheme.fromSeed` has also been updated to use the latest algorithm in
Material color utilities package. This change prevent the constructed 
`ColorSchem` from being too bright, even if the source color looks bright and
has a high chroma.

## Migration guide

The difference caused by the updated `ColorScheme.fromSeed` and the new color
roles should be small and acceptable. However, when we provide a brighter
source color to `ColorScheme.fromSeed`, it may constructs a relatively
darker version of `ColorScheme`. To force the output to still be bright, 
set `schemeVariant: FromSeedVariant.fidelity` in `ColorScheme.fromSeed`.

Code before migration:

```dart
ColorScheme.fromSeed(
    seedColor: Color(0xFF0000FF), // Bright blue
)
```

Code after migration:

```dart
ColorScheme.fromSeed(
    seedColor: Color(0xFF0000FF), // Bright blue
    schemeVariant: FromSeedVariant.fidelity,
)
```

## Timeline

Landed in version: 3.21.0-4.0.pre <br>
In stable release: not yet

## References

Relevant issues:

* [Support tone-based surface and surface container ColorScheme roles][]
* [Support fidelity variant for ColorScheme.fromSeed][]

Relevant PRs:

* [Introduce tone-based surfaces and accent color add-ons - Part 1][]
* [Introduce tone-based surfaces and accent color add-ons - Part 2][]
* [Enhance ColorScheme.fromSeed with a new variant parameter][]

[`ClassName`]: {{site.main-api}}/flutter/[link_to_relevant_page].html

[Support tone-based surface and surface container ColorScheme roles]: {{site.repo.flutter}}/issues/115912
[Support fidelity variant for ColorScheme.fromSeed]: {{site.repo.flutter}}/issues/[144649]
[Introduce tone-based surfaces and accent color add-ons - Part 1]: {{site.repo.flutter}}/pull/[142654]
[Introduce tone-based surfaces and accent color add-ons - Part 2]: {{site.repo.flutter}}/pull/[144273]
[Enhance ColorScheme.fromSeed with a new variant parameter]: {{site.repo.flutter}}/pull/[144805]
