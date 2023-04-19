---
title: At least one clipboard data variant must be provided
description: In preparation for supporting multiple clipboard data variants, at least one clipboard data variant must be provided.
---

## Summary

The [`ClipboardData constructor`][]'s `text` argument is no longer nullable.
Code that provides `null` to the `text` argument must be migrated to provide
an empty string `''`.

## Context

In preparation for supporting multiple clipboard data variants, the
`ClipboardData` constructor now requires that at least one data variant is
provided.

## Description of change

The [`ClipboardData constructor`][]'s `text` argument is no longer nullable.

## Migration guide

To reset the text clipboard, use an empty string `''` instead of `null`.

Code before migration:

```dart
void resetClipboard() {
  Clipboard.setData(ClipboardData(text: null));
}
```

Code after migration:

```dart
void resetClipboard() {
  Clipboard.setData(ClipboardData(text: ''));
}
```

## Timeline

Landed in version: 3.10.0-9.0.pre<br>
In stable release: not yet

## References

API documentation:

* [`Clipboard.setData`][]
* [`ClipboardData constructor`][]

Relevant PRs:

* [Assert at least one clipboard data variant is provided][]

{% include docs/master-api.md %}

[`Clipboard.setData`]: {{site.api}}/flutter/services/Clipboard/setData.html
[`ClipboardData constructor`]: {{site.master-api}}/flutter/services/ClipboardData/ClipboardData.html
[Assert at least one clipboard data variant is provided]: {{site.repo.flutter}}/pull/122446