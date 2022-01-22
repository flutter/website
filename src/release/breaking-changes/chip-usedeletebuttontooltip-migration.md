---
title: Migrate useDeleteButtonTooltip to deleteButtonTooltipMessage of Chips
description: Deprecated useDeleteButtonTooltip of chips that have a delete button in favor of deleteButtonTooltipMessage.
---

## Summary

Using `useDeleteButtonTooltip` of any chip that has a delete button gives a
deprecation warning, or no longer exists when referenced. This includes the
`Chip`, `InputChip` and `RawChip` widget.

## Context

`useDeleteButtonTooltip` of `Chip`, `InputChip` and `RawChip` widget was
deprecated in favor of `deleteButtonTooltipMessage`, as the latter can be used
to disable the tooltip of the chip's delete button.

## Description of change

For displaying a tooltip for its delete button the chip widgets use the
`Tooltip` widget, which has the ability to disable itself when an empty string
is provided as the message to show on the tooltip window.

This means that users can disable delete button tooltip of chips by providing an
empty string to `deleteButtonTooltipMessage`.

To avoid redundancy of the API, this change deprecated `useDeleteButtonTooltip`
that was specifically introduced for this exact functionality. A flutter fix is
available to help users migrate existing code from `useDeleteButtonTooltip` to
`deleteButtonTooltipMessage`, depending on whether they explicity disabled the
tooltip.

## Migration guide

By default, the tooltip of the delete button is always enabled. If you want to
explicitly disable the tooltip, provide an empty string to
`deleteButtonTooltipMessage`. The following code snippets show the migration
changes, which are applicable for `Chip`, `InputChip` and `RawChip` widget.

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
