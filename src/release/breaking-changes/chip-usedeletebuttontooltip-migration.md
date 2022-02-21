---
title: Migrate useDeleteButtonTooltip to deleteButtonTooltipMessage of Chips
description: Deprecated useDeleteButtonTooltip of chips that have a delete button in favor of deleteButtonTooltipMessage.
---

## Summary

Using `useDeleteButtonTooltip` of any chip that has a delete button gives a
deprecation warning, or no longer exists when referenced. This includes the
`Chip`, `InputChip`, and `RawChip` widgets.

## Context

The `useDeleteButtonTooltip` of `Chip`, `InputChip`, and `RawChip` widgets is
deprecated in favor of `deleteButtonTooltipMessage`, as the latter can be used
to disable the tooltip of the chip's delete button.

## Description of change

The `deleteButtonTooltipMessage` property provides a message to the
tooltip on the delete button of the chip widgets.
Subsequently, a change was made such that providing an empty string to this
property disables the tooltip.

To avoid redundancy of the API, this change deprecated `useDeleteButtonTooltip`,
which was introduced for this exact functionality. A [Flutter fix][] is
available to help you migrate existing code from `useDeleteButtonTooltip` to
`deleteButtonTooltipMessage`, if you explicity disabled the tooltip.

## Migration guide

By default, the tooltip of the delete button is always enabled.
To explicitly disable the tooltip, provide an empty string to the
`deleteButtonTooltipMessage` property.
The following code snippets show the migration changes, which are applicable for
`Chip`, `InputChip`, and `RawChip` widgets:

Code before migration:

<!-- skip -->
```dart
Chip(
  label: const Text('Disabled delete button tooltip'),
  onDeleted: _handleDeleteChip,
  useDeleteButtonTooltip: false,
);

RawChip(
  label: const Text('Enabled delete button tooltip'),
  onDeleted: _handleDeleteChip,
  useDeleteButtonTooltip: true,
);
```

Code after migration:

<!-- skip -->
```dart
Chip(
  label: const Text('Disabled delete button tooltip'),
  onDeleted: _handleDeleteChip,
  deleteButtonTooltipMessage: '',
);

RawChip(
  label: const Text('Enabled delete button tooltip'),
  onDeleted: _handleDeleteChip,
);
```

## Timeline

Landed in version: 2.11.0-0.1.pre<br>
In stable release: not yet

## References

{% include docs/master-api.md %}

API documentation:

* [`Chip`][]
* [`InputChip`][]
* [`RawChip`][]

Relevant PRs:

* [Deprecate `useDeleteButtonTooltip` for Chips][]

[`Chip`]: {{site.master-api}}/flutter/material/Chip-class.html
[`InputChip`]: {{site.master-api}}/flutter/material/InputChip-class.html
[`RawChip`]: {{site.master-api}}/flutter/material/RawChip-class.html

[Deprecate `useDeleteButtonTooltip` for Chips]: {{site.repo.flutter}}/pull/96174
[Flutter fix]: {{site.url}}/development/tools/flutter-fix
