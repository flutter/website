---
title: Added enabled property and made onChanged optional for DropdownButton
description: >-
  DropdownButton and DropdownButtonFormField now support an explicit enabled
  property, and their onChanged callbacks are no longer required.
---

{% render "docs/breaking-changes.md" %}

## Summary

`DropdownButton` and `DropdownButtonFormField` now include
an `enabled` property to explicitly manage their interactive state,
and the `onChanged` callback is no longer marked as `required`.

## Background

Previously, `DropdownButton` and `DropdownButtonFormField` didn't
have an `enabled` parameter.
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
Making it mandatory introduces a massive breaking change that
breaks nearly every existing `DropdownButton` implementation in
the Flutter ecosystem.
Instead, to preserve backward compatibility,
if the `enabled` argument isn't explicitly provided,
the button determines its state by falling back to whether
`onChanged` is provided (that is, it's enabled if `onChanged != null`,
and disabled if `onChanged == null`).

The minor breaking change here is structural:
while the old conditional `onChanged` pattern technically
still works due to the fallback logic,
developers are encouraged to migrate to the clearer API by
explicitly using the `enabled` property.

## Migration guide

If you previously disabled your `DropdownButton` by
conditionally passing `null` to `onChanged`,
migrate to the new `enabled` property.
This cleanly separates the state of the widget (enabled/disabled) from
its behavior (the callback).

To automatically migrate your code for simple cases
(such as statically passing `null`), run the following command:

```console
$ dart fix --apply
```

:::important
Note that `dart fix` will not automatically migrate cases where `onChanged`
is set using conditional logic. For those, you must update your code manually.
:::

### Case 1: Statically disabled dropdown {: #case-1-statically-disabled }

For simple cases where a dropdown is permanently disabled,
you can now simply omit `onChanged` and use `enabled: false`.

Code before migration:

```dart
final disabledDropdown = DropdownButton<String>(
  value: 'Option 1',
  items: const [
    DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
  ],
  onChanged: null, // This was the only way to disable it
);
```

Code after migration:

```dart diff
  final disabledDropdown = DropdownButton<String>(
    value: 'Option 1',
    items: const [
      DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
    ],
-   onChanged: null, // This was the only way to disable it
+   enabled: false,
  );
```

### Case 2: Conditionally disabled dropdown {: #case-2-conditionally-disabled }

The recommended best practice is to separate the callback from
the interactive state by using the `enabled` property directly.

Code before migration:

```dart
final conditionalDropdown = DropdownButton<String>(
  value: 'Option 1',
  items: const [
    DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
  ],
  onChanged: condition ? (value) { ... } : null,
);
```

Code after migration:

```dart diff
  final conditionalDropdown = DropdownButton<String>(
    value: 'Option 1',
    items: const [
      DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
    ],
-   onChanged: condition ? (value) { ... } : null,
+   onChanged: (value) { ... },
+   enabled: condition,
  );
```

## Timeline

Landed in version: 3.44.0-1.0.pre-629<br>
In stable release: Not yet

## References

API documentation:

* [`DropdownButton`][]
* [`DropdownButtonFormField`][]

Relevant issues:

* [Why is DropdownButtonFormField's onChanged required?][issue-57953]

Relevant PRs:

* [Update DropdownButton enabled property logic][]

[`DropdownButton`]: {{site.api}}/flutter/material/DropdownButton-class.html
[`DropdownButtonFormField`]: {{site.api}}/flutter/material/DropdownButtonFormField-class.html
[issue-57953]: {{site.repo.flutter}}/issues/57953
[Update DropdownButton enabled property logic]: {{site.repo.flutter}}/pull/182419
