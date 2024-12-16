---
title: Updated Material 3 progress indicators
description: >-
  The `LinearProgressIndicator` and `CircularProgressIndicator` widgets
  have been updated to match the Material 3 Design specifications.
---

## Summary

The `LinearProgressIndicator` and `CircularProgressIndicator` have
been updated to match the Material 3 Design specifications.

The `LinearProgressIndicator`changes include a gap between
the active and inactive tracks, a stop indicator, and rounded corners.
The `CircularProgressIndicator` changes include a gap between
the active and inactive tracks, and rounded stroke cap.

## Context

The Material 3 Design specifications for the `LinearProgressIndicator` and
`CircularProgressIndicator` were updated in December 2023.

To opt into the 2024 design specifications,
set the `LinearProgressIndicator.year2023` and
`CircularProgressIndicator.year2023` flags to `false`.
This is done to ensure that existing apps aren't affected by
the updated design spec.

## Description of change

The `LinearProgressIndicator` and `CircularProgressIndicator` widgets each
have a `year2023` flag that can be set to `false` to
opt in to the updated design specification.
The default value for the `year2023` flag is `true`, which means that
the progress indicators use the 2023 design spec.

When [`LinearProgressIndicator.year2023`][] is set to `false`,
the progress indicator have gaps between active and inactive tracks,
a stop indicator, and rounded corners.
If the `LinearProgressIndicator` is indeterminate,
the stop indicator isn't shown.

When [`CircularProgressIndicator.year2023`][] is set to `false`,
the progress indicator has a track gap and rounded stroke cap.

## Migration guide

To opt into the updated design spec for the `LinearProgressIndicator`,
set the `year2023` flag to `false`:

```dart highlightLines=2
LinearProgressIndicator(
  year2023: false,
  value: 0.5,
),
```

To opt into the updated design spec for the `CircularProgressIndicator`,
set the `year2023` flag to `false`:

```dart highlightLines=2
CircularProgressIndicator(
  year2023: false,
  value: 0.5,
),
```

## Timeline

Landed in version: 3.28.0-0.1.pre<br>
In stable release: Not yet

## References

API documentation:

- [`LinearProgressIndicator`][]
- [`CircularProgressIndicator`][]
- [`LinearProgressIndicator.year2023`][]
- [`CircularProgressIndicator.year2023`][]

Relevant issues:

- [Update both `ProgressIndicator` for Material 3 redesign][]

Relevant PRs:

- [Update Material 3 `LinearProgressIndicator` for new visual style][]
- [Update Material 3 `CircularProgressIndicator` for new visual style][]

[`LinearProgressIndicator`]: {{site.main-api}}/flutter/material/LinearProgressIndicator-class.html
[`CircularProgressIndicator`]: {{site.main-api}}/flutter/material/CircularProgressIndicator-class.html
[`LinearProgressIndicator.year2023`]: {{site.main-api}}/flutter/material/LinearProgressIndicator/year2023.html
[`CircularProgressIndicator.year2023`]: {{site.main-api}}/flutter/material/CircularProgressIndicator/year2023.html
[Update both `ProgressIndicator` for Material 3 redesign]: {{site.repo.flutter}}/issues/141340
[Update Material 3 `LinearProgressIndicator` for new visual style]: {{site.repo.flutter}}/pull/154817
[Update Material 3 `CircularProgressIndicator` for new visual style]: {{site.repo.flutter}}/pull/158104
