---
title: Remove invalid parameters for `InputDecoration.collapsed`
description: >
  `InputDecoration.collapsed` constructor parameters `floatingLabelBehavior`
  and`floatingLabelAlignment` are deprecated without replacement because they
  have no effect.
---

## Summary

`InputDecoration.collapsed` invalid parameters `floatingLabelBehavior` and
`floatingLabelAlignment` are deprecated.

## Background

`InputDecoration.collapsed` constructor is used to create a minimal decoration
without label.

The parameters `floatingLabelAlignment` and `floatingLabelBehavior` have
no effect because an input decoration created using `InputDecoration.collapsed`
has no label.

## Migration guide

To migrate, remove usage of `floatingLabelBehavior` and `floatingLabelAlignment`
parameters when calling `InputDecoration.collapsed` constructor.
Those parameters had no effect.

Code before migration:

```dart
InputDecoration.collapsed(
  hintText: 'Hint',
  floatingLabelAlignment: FloatingLabelAlignment.center,
  floatingLabelBehavior: FloatingLabelBehavior.auto,
),
```

Code after migration:

```dart
InputDecoration.collapsed(
  hintText: 'Hint',
),
```

## Timeline

Landed in version: v3.24.0-0.1.pre<br>
In stable release: Not yet

## References

API documentation:

* [`InputDecoration.collapsed`][]
* [`InputDecoration.floatingLabelAlignment`][]
* [`InputDecoration.floatingLabelBehavior`][]

Relevant issues:

* [Add prefixIcon and suffixIcon parameters to InputDecoration.collapsed][]

Relevant PRs:

* [Deprecate invalid InputDecoration.collapsed parameters][]
* [Cleanup InputDecoration.collapsed constructor][]

[`InputDecoration.collapsed`]: {{site.api}}/flutter/material/InputDecoration/InputDecoration.collapsed.html
[`InputDecoration.floatingLabelAlignment`]: {{site.api}}/flutter/material/InputDecoration/floatingLabelAlignment.html
[`InputDecoration.floatingLabelBehavior`]: {{site.api}}/flutter/material/InputDecoration/floatingLabelBehavior.html

[Add prefixIcon and suffixIcon parameters to InputDecoration.collapsed]: {{site.repo.flutter}}/issues/61331
[Deprecate invalid InputDecoration.collapsed parameters]: {{site.repo.flutter}}/pull/152486
[Cleanup InputDecoration.collapsed constructor]: {{site.repo.flutter}}/pull/152165