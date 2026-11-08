---
title: Added enabled property and made onChanged optional for DropdownButtonFormField
description: >-
  DropdownButtonFormField in material_ui now supports an explicit enabled
  parameter, and its onChanged callback is no longer required.
---

{% render "docs/breaking-changes.md" %}

## Summary

In `package:material_ui`, `DropdownButtonFormField` now includes
an `enabled` parameter to explicitly manage its interactive state,
and the `onChanged` callback is no longer marked as `required`.

## Background

Previously, `DropdownButtonFormField` didn't have an `enabled` parameter.
The only way to disable the dropdown
(graying it out and making it non-interactive) was to
pass `null` to the `required` `onChanged` callback.
This led to unintuitive code when trying to
dynamically enable or disable the button,
forcing developers to write conditional expressions for the callback itself,
such as `onChanged: condition ? (value) { ... } : null`.

To improve this API, a dedicated `enabled` property was introduced,
and `onChanged` was made optional.

The `enabled` property is optional.
To preserve backward compatibility,
if the `enabled` argument isn't explicitly provided,
a field with items determines its interactive state by checking whether
`onChanged` is provided (that is, it's enabled if `onChanged != null`,
and disabled if `onChanged == null`).

## Migration guide

If you previously disabled your `DropdownButtonFormField` by
conditionally passing `null` to `onChanged`,
you can migrate to the new `enabled` property.
This cleanly separates the state of the widget (enabled/disabled) from
its behavior (the callback).

### Case 1: Statically disabled dropdown {: #case-1-statically-disabled }

For simple cases where a dropdown is permanently disabled,
you can now simply omit `onChanged` and use `enabled: false`.

Code before migration:

```dart
final disabledDropdown = DropdownButtonFormField<String>(
  initialValue: 'Option 1',
  items: const [
    DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
  ],
  onChanged: null, // This was the only way to disable it.
);
```

Code after migration:

```dart diff
  final disabledDropdown = DropdownButtonFormField<String>(
    initialValue: 'Option 1',
    items: const [
      DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
    ],
-   onChanged: null, // This was the only way to disable it.
+   enabled: false,
  );
```

### Case 2: Conditionally disabled dropdown {: #case-2-conditionally-disabled }

The recommended best practice is to separate the callback from
the interactive state by using the `enabled` property directly.

Code before migration:

```dart
final conditionalDropdown = DropdownButtonFormField<String>(
  initialValue: 'Option 1',
  items: const [
    DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
  ],
  onChanged: condition ? (value) { ... } : null,
);
```

Code after migration:

```dart diff
  final conditionalDropdown = DropdownButtonFormField<String>(
    initialValue: 'Option 1',
    items: const [
      DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
    ],
-   onChanged: condition ? (value) { ... } : null,
+   onChanged: (value) { ... },
+   enabled: condition,
  );
```

## Timeline

Landed in `package:material_ui` version: 1.8.0<br>
Minimum supported Flutter version: 3.47

## References

API documentation:

* [`DropdownButton`][]
* [`DropdownButtonFormField`][]

Relevant issues:

* [Why is DropdownButtonFormField's onChanged required?][issue-57953]

Relevant PRs:

* [Add enabled parameter to DropdownButtonFormField][]
* [Original SDK proposal][] (closed without merging)

[`DropdownButton`]: {{site.material_ui}}/DropdownButton-class.html
[`DropdownButtonFormField`]: {{site.material_ui}}/DropdownButtonFormField-class.html
[issue-57953]: {{site.repo.flutter}}/issues/57953
[Add enabled parameter to DropdownButtonFormField]: {{site.repo.packages}}/pull/12610
[Original SDK proposal]: {{site.repo.flutter}}/pull/182419
