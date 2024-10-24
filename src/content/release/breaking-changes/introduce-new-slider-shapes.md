---
title: Introduce new Material 3 `Slider` shapes
description: >-
  Adds new Material 3 `Slider` shapes which were introduced in the Material 3
  specification.
---

## Summary

The `Slider` widget now supports the updated Material 3 visual style. This affects
the default `Slider` shapes, such as the track, thumb, and value indicator shapes.

## Background

The Material 3 specification introduces updated `Slider` shapes. The new track
shape includes an updated height, a gap between the active and inactive tracks,
and stop indicators to show the end value of the inactive track.
Pressing the thumb adjusts its width and the track adjusts its shape. The
new value indicator shape is a rounded rectangle. New color mappings are also
introduced for some of the `Slider` shapes.

## Migration guide

You automatically get the new `Slider` shapes and color mappings.
To use the previous `Slider` shapes and color mappings, set the following
properties in the `SliderThemeData`:

* `SliderThemeData.trackShape` to `RoundedRectSliderTrackShape()`
* `SliderThemeData.trackHeight` to `4`
* `SliderThemeData.thumbShape` to `RoundSliderThumbShape()`
* `SliderThemeData.valueIndicatorShape` to `DropSliderValueIndicatorShape()`
* `SliderThemeData.inactiveTrackColor` to `Theme.of(context).colorScheme.surfaceContainerHighest`
* `SliderThemeData.activeTickMarkColor` to `Theme.of(context).colorScheme.onPrimary.withOpacity(0.38)`
* `SliderThemeData.inactiveTickMarkColor` to `Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.38)`
* `SliderThemeData.disabledActiveTrackColor` to `Theme.of(context).colorScheme.onSurface.withOpacity(0.38)`
* `SliderThemeData.disabledInactiveTrackColor` to `Theme.of(context).colorScheme.onSurface.withOpacity(0.38)`
* `SliderThemeData.disabledThumbColor` to `Theme.of(context).colorScheme.onSurface.withOpacity(0.38)`
* `SliderThemeData.valueIndicatorColor` to `Theme.of(context).colorScheme.primary`
* `SliderThemeData.valueIndicatorTextStyle` to `Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onPrimary)`

The following code snippets show how to use `SliderThemeData` to get the
previous `Slider` shapes and color mappings:

### Code before migration

```dart
sliderTheme: SliderThemeData(
  // ...
),
```

### Code after migration

```dart
sliderTheme: SliderThemeData(
  // Track shape.
  trackShape: const RoundedRectSliderTrackShape(),
  trackHeight: 4,
  // Thumb shape.
  thumbShape: const RoundSliderThumbShape(),
  // Value indicator shape.
  valueIndicatorShape: const DropSliderValueIndicatorShape(),
  // Tick mark shape.
  tickMarkShape: const RoundSliderTickMarkShape(),
  // Color mappings.
  inactiveTrackColor: Theme.of(context).colorScheme.surfaceContainerHighest,
  activeTickMarkColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.38),
  inactiveTickMarkColor: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.38),
  disabledActiveTrackColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
  disabledInactiveTrackColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
  disabledThumbColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.38),
  valueIndicatorColor: Theme.of(context).colorScheme.primary,
  valueIndicatorTextStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
    color: Theme.of(context).colorScheme.onPrimary,
  ),
),
```

## Timeline

Landed in version: TBA<br>
In stable release: Not yet

## References

API documentation:

* [`Slider`][]
* [`SliderTheme`][]
* [`ThemeData.useMaterial3`][]

Relevant issues:

* [Update `Slider` for Material 3 redesign][]

Relevant PRs:

* [Introduce new Material 3 `Slider` shapes][]

[`Slider`]: {{site.api}}/flutter/material/Slider-class.html
[`SliderTheme`]: {{site.api}}/flutter/material/SliderTheme-class.html
[`ThemeData.useMaterial3`]: {{site.api}}/flutter/material/ThemeData/useMaterial3.html
[Update `Slider` for Material 3 redesign]: {{site.repo.flutter}}/issues/141842
[Introduce new Material 3 `Slider` shapes]: {{site.repo.flutter}}/pull/152237
