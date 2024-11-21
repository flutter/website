---
title: Updated Material 3 `Slider`
description: >-
  The `Slider` widget has been updated to match the Material 3 Design
  specifications.
---

## Summary

The `Slider` has been updated to match the Material 3 Design specifications.
The `Slider` changes include an updated height, a gap between the active and
inactive track, and a stop indicator to show the end value of the inactive
track. Pressing the thumb adjusts its width, and the track adjusts its shape.
The new value indicator shape is a rounded rectangle. New color mappings have
also been introduced for some of the `Slider` shapes.

## Context

The Material 3 Design specs for the `Slider` were updated in December, 2023.
To opt into the 2024 design spec, set the `Slider.year2023` flag to `false`.
This is done to ensure that existing apps are not affected by the updated
design specifications.

## Description of change

The `Slider` widget has a `year2023` flag that can be set to `false` to opt
into the updated design spec. The default value for the `year2023` flag is
`true`, which means that the `Slider` uses the 2023 design specifications.

When [`Slider.year2023`][] is set to `false`, the slider will use the updated
design specifications.

## Migration guide

To opt into the updated design spec for the `Slider`, set the `year2023` flag
to `false`:

```dart
Slider(
  year2023: false,
  value: _value,
  onChanged: (value) {
    setState(() {
      _value = value;
    });
  },
),
```

## Timeline

Landed in version: v3.27.0-0.2.pre.<br>
In stable release: Not yet

## References

API documentation:

* [`Slider`][]
* [`Slider.year2023`][]

Relevant issues:

* [Update `Slider` for Material 3 redesign][]

Relevant PRs:

* [Introduce new Material 3 `Slider` shapes][]

[`Slider`]: {{site.api}}/flutter/material/Slider-class.html
[`Slider.year2023`]: {{site.api}}/flutter/material/Slider/year2023.html
[Update `Slider` for Material 3 redesign]: {{site.repo.flutter}}/issues/141842
[Introduce new Material 3 `Slider` shapes]: {{site.repo.flutter}}/pull/152237
