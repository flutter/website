---
title: Deprecate `InputDecoration.maintainHintHeight` in favor of
  `InputDecoration.maintainHintSize`
description: >-
  The `InputDecoration.maintainHintHeight` parameter has been replaced by
  `InputDecoration.maintainHintSize`.
---

{% render "docs/breaking-changes.md" %}

## Summary

The [`InputDecoration.maintainHintHeight`][] parameter was deprecated
in favor of the [`InputDecoration.maintainHintSize`][] parameter.

## Context

The default intrinsic size of an input decorator depends on the hint size.
The [`InputDecoration.maintainHintSize`][] parameter can be set to `false` to
make the intrinsic size ignores the hint size when the hint isn't visible.
Previously, the `InputDecoration.maintainHintHeight` parameter was
used to override the default intrinsic height and had no impact on the
intrinsic width.

## Description of change

The [`InputDecoration.maintainHintHeight`][] is deprecated in
favor of [`InputDecoration.maintainHintSize`][] which makes both the intrinsic
width and height depend on the hint dimensions.

## Migration guide

Replace [`InputDecoration.maintainHintHeight`][] with
[`InputDecoration.maintainHintSize`][] to override the default intrinsic size
computation.

Code before migration:

```dart highlightLines=3
TextField(
  indicator: InputDecoration(
    maintainHintHeight: false,
  ),
),
```

Code after migration:

```dart highlightLines=3
TextField(
  indicator: InputDecoration(
    maintainHintSize: false,
  ),
),
```

## Timeline

Landed in version: 3.30.0-0.0.pre<br>
In stable release: 3.32

## References

API documentation:

- [`InputDecoration.maintainHintHeight`][]
- [`InputDecoration.maintainHintSize`][]

Relevant issues:

- [Issue #93337][]

Relevant PRs:

- [Fix TextField intrinsic width when hint is not visible][]

[`InputDecoration.maintainHintHeight`]: {{site.api}}/flutter/material/InputDecoration/maintainHintHeight.html
[`InputDecoration.maintainHintSize`]: {{site.main-api}}/flutter/material/InputDecoration/maintainHintSize.html
[Issue #93337]: {{site.repo.flutter}}/issues/93337
[Fix TextField intrinsic width when hint is not visible]: {{site.repo.flutter}}/pull/161235
