---
title: Added enabled to DropdownButtonFormField and made onChanged optional
description: >-
  DropdownButtonFormField in material_ui now supports an explicit enabled
  parameter, and its onChanged callback is no longer required.
---

{% render "docs/breaking-changes.md" %}

## Summary

In `package:material_ui`, `DropdownButtonFormField` now includes
an `enabled` parameter to explicitly manage its interactive state,
and the `onChanged` callback is no longer marked as `required`.
This change is backward compatible, so existing code continues to work.

:::note
The change is only available in `package:material_ui`.
The `DropdownButtonFormField` in `package:flutter/material.dart`
doesn't have an `enabled` parameter, and its `onChanged` is still required.
:::

## Background

Previously, `DropdownButtonFormField` didn't have an `enabled` parameter.
The only way to disable the dropdown
(graying it out and making it non-interactive) was to
pass `null` to the `required` `onChanged` callback.
This led to unintuitive code when trying to
dynamically enable or disable the field,
forcing developers to write conditional expressions for the callback itself,
such as `onChanged: condition ? (value) { ... } : null`.

To improve this API, a dedicated `enabled` parameter was introduced,
and `onChanged` was made optional.

The `enabled` parameter is optional and
determines the field's interactive state as follows:

* If `enabled` is `true`, the field is interactive,
  even if `onChanged` is `null`.
* If `enabled` is `false`, the field isn't interactive,
  even if `onChanged` is provided.
* If `enabled` isn't provided, the field is interactive only if
  `onChanged` isn't `null`, which preserves backward compatibility.

In all of these cases,
the field isn't interactive if `items` is empty or `null`.

## Migration guide

:::tip
The `enabled` parameter is only available in `package:material_ui`.
If your project still imports `package:flutter/material.dart`,
first [migrate to the standalone packages][].
:::

If you previously disabled your `DropdownButtonFormField` by
conditionally passing `null` to `onChanged`,
you can migrate to the new `enabled` parameter.
This cleanly separates the state of the widget (enabled/disabled) from
its behavior (the callback).

:::important
Unlike `onChanged: null`, `enabled: false` turns off the field's own
`always`, `onUserInteraction`, and `onUserInteractionIfError` autovalidation.
`FormState.validate` and the parent `Form`'s `autovalidateMode`
still validate the field.
If you rely on `AutovalidateMode.always` to show errors on a disabled field,
keep using `onChanged: null` and omit `enabled`.
:::

[migrate to the standalone packages]: /release/breaking-changes/material-ui-and-cupertino-ui

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
the interactive state by using the `enabled` parameter directly.
Remove the condition from `onChanged` when you add `enabled`.
If `enabled` is `true` and `onChanged` is `null`,
users can still change the selection.
The field stores the selected value in its form state and
the parent `Form`'s `onChanged` callback runs,
but the field has no callback of its own to run.

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

* [`DropdownButtonFormField`][]

Relevant issues:

* [Why is DropdownButtonFormField's onChanged required?][issue-57953]

Relevant PRs:

* [Add enabled parameter to DropdownButtonFormField][]
* [Original SDK proposal][] (closed without merging)

[`DropdownButtonFormField`]: {{site.material_ui}}/DropdownButtonFormField-class.html
[issue-57953]: {{site.repo.flutter}}/issues/57953
[Add enabled parameter to DropdownButtonFormField]: {{site.repo.packages}}/pull/12610
[Original SDK proposal]: {{site.repo.flutter}}/pull/182419
