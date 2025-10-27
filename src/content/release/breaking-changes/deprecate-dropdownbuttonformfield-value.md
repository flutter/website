---
title: >-
  Deprecated the 'value' parameter of
  the 'DropdownButtonFormField' constructor
description: >-
  The `DropdownButtonFormField` constructor parameter `value` has been
  replaced by the parameter `initialValue`.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `value` parameter of the [`DropdownButtonFormField`][] constructor was
deprecated in favor of the `initialValue` parameter.

## Context

The `value` parameter of the [`DropdownButtonFormField`][] constructor was used
to initialize [`DropdownButtonFormField.initialValue`][].
Not using the same name was confusing. For example,
developers falsely assumed that setting `value` would change
the current selected value. This was not the case—it
only set the initial value or when the field is reset.

## Description of change

The `value` parameter of the [`DropdownButtonFormField`][] constructor is
deprecated in favor of the parameter named `initialValue`.

## Migration guide

Replace the `value` parameter of the [`DropdownButtonFormField`][] constructor
with the `initialValue` parameter to initialize
[`DropdownButtonFormField.initialValue`][].

Code before migration:

```dart highlightLines=2
DropdownButtonFormField(
  value: 'Yellow',
),
```

Code after migration:

```dart highlightLines=2
DropdownButtonFormField(
  initialValue: 'Yellow',
),
```

## Timeline

Landed in version: 3.35.0-0.0.pre<br>
In stable release: 3.35

## References

API documentation:

- [`DropdownButtonFormField`][]
- [`DropdownButtonFormField.initialValue`][]

Relevant issues:

- [Issue #169983][]

Relevant PRs:

- [Deprecate `DropdownButtonFormField` `value` parameter in favor of `initialValue`][]

[`DropdownButtonFormField`]: {{site.api}}/flutter/material/DropdownButtonFormField/DropdownButtonFormField.html
[`DropdownButtonFormField.initialValue`]: {{site.main-api}}/flutter/widgets/FormField/initialValue.html
[Issue #169983]: {{site.repo.flutter}}/issues/169983
[Deprecate `DropdownButtonFormField` `value` parameter in favor of `initialValue`]: {{site.repo.flutter}}/pull/170805
