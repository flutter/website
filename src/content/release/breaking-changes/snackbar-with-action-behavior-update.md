---
title: SnackBar with action no longer auto-dismisses
description: >-
  SnackBars with an action button now default to not auto-dismissing unless
  manually dismissed by the user.
---

{% render "docs/breaking-changes.md" %}

## Summary

The default behavior of a [`SnackBar`][] with an action has changed.
Previously, a `SnackBar` with an action wouldn't
auto-dismiss if talkback was enabled.
Now, all `SnackBar` widgets with an action default to
a non-dismissible state until the user interacts with the action button.

## Context

A `SnackBar` with an action button is now treated as
a more persistent notification that requires user interaction.
This change improves accessibility and user experience by ensuring that
critical notifications remain on the screen until they are acknowledged.

## Description of change

This change aligns with the Material 3 design specification for
the `SnackBar` component:

* Old behavior: A `SnackBar` with an action button would auto-dismiss after a
  duration unless talkback was enabled.
* New behavior: A `SnackBar` with an action button won't auto-dismiss;
  it remains on screen until dismissed by the user.

To override this behavior, an optional `persist` property has
been added to `SnackBar`.
When `persist` is `true`, the `SnackBar` won't auto-dismiss and
remains on screen until manually dismissed by the user.
When `false`, the `SnackBar` auto-dismisses after its standard duration,
regardless of the presence of an action.
When `null`, the `SnackBar` follows the default behavior,
which won't auto-dismiss if an action is present.

## Migration guide

To restore the old auto-dismiss behavior for a SnackBar with an action, set
`persist` to `false`.

Code before migration:

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text('This is a snackbar with an action.'),
    action: SnackBarAction(
      label: 'Action',
      onPressed: () {
        // Perform some action
      },
    ),
  ),
);
```

Code after migration:

```dart highlightLines=4
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text('This is a snackbar with an action.'),
    persist: false, // Add this line to restore auto-dismiss behavior
    action: SnackBarAction(
      label: 'Action',
      onPressed: () {
        // Perform some action
      },
    ),
  ),
);
```

## Timeline

Landed in version: 3.37.0-0.0.pre
In stable release: 3.38

## References

API documentation:

* [`SnackBar`][]

Relevant PRs:

* [SnackBar with action no longer auto-dismisses][]

[`SnackBar`]: {{site.api}}/flutter/material/SnackBar-class.html

[SnackBar with action no longer auto-dismisses]: {{site.repo.flutter}}/pull/173084
