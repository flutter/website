---
title: Material 3 Tokens Update in Flutter
description: >-
  The latest Material Design 3 tokens(v6.1) have been applied to the Flutter
  Material library.
---

## Summary

The Material Design tokens updated the mapping of 4 color roles (only in Light
mode) to be more visually appealing while retaining accessible contrast. Testing
identified this change as [non-breaking] in Flutter, but some customers might
notice this small change. The update affected the following color properties:

* On-primary-container (Primary10 to Primary30)
* On-secondary-container (Secondary10 to Secondary30)
* On-tertiary-container (Tertiary10 to Tertiary30)
* On-error-container (Error10 to Error30)

Widgets that have been using these roles with their default value might look
different.

Additionally, the Material 3 tokens updated the border color of Chips from
`ColorScheme.outline` to `ColorScheme.outlineVariant` to improve visual
hierarchy between chips and buttons. Chips (`Chip`, `ActionChip`, `ChoiceChip`,
`FilterChip`, and `InputChip`) that have been using the chip border tokens may
look different.

## Migration guide

The differences in the mappings of the color roles are small. Use
`ColorScheme.copyWith` to revert to the original default colors:

Code before migration:

```dart
final ColorScheme colors = ThemeData().colorScheme;
```

Code after migration:

```dart
final ColorScheme colors = ThemeData().colorScheme.copyWith(
  onPrimaryContainer: const Color(0xFF21005D),
  onSecondaryContainer: const Color(0xFF1D192B),
  onTertiaryContainer: const Color(0xFF31111D),
  onErrorContainer: const Color(0xFF410E0B),
);
```

After applying the token update, the default border color of M3 chips looks
lighter. Take `ActionChip` as an example:

Code before migration:

```dart
final Widget chip = ActionChip(
  label: const Text('action chip'),
  onPressed: () {},
);
```

Code after migration:

```dart
final Widget chip = ChipTheme(
  data: ChipThemeData(
    side: BorderSide(
      color: Theme.of(context).colorScheme.outline
    ),
  ),
  child: ActionChip(
    label: const Text('action chip'), 
    onPressed: () {}
  )
);
```

## Timeline

Landed in version: 3.26.0-0.0.pre<br>
In stable release: not yet

## References

API documentation:

* [`ColorScheme`][]
* [`ThemeData`][]
* [`Chip`][]

Relevant PRs:

* [Update tokens to v5.0.0][]
* [Update tokens to v6.1.0][]

[`ColorScheme`]: {{site.api}}/flutter/material/ColorScheme-class.html
[`ThemeData`]: {{site.api}}/flutter/material/ThemeData-class.html
[`Chip`]: {{site.api}}/flutter/material/Chip-class.html
[Update tokens to v5.0.0]: {{site.repo.flutter}}/pull/153385
[Update tokens to v6.1.0]: {{site.repo.flutter}}/pull/153722
[non-breaking]: {{site.repo.flutter}}/flutter/blob/master/docs/contributing/Tree-hygiene.md#1-determine-if-your-change-is-a-breaking-change
