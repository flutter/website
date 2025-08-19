---
title: SnackBar with action no longer auto-dismisses
description: >-
  SnackBars with an action button now default to not auto-dismissing unless
  manually dismissed by the user.
---

## Summary

The default behavior of a [`SnackBar`][] with an action has changed. Previously, a
`SnackBar` with an action would only not auto-dismiss if talkback was enabled. 
Now, all `SnackBar`s with an action default to a non-dismissible state until the
user interacts with the action button.

## Context

A `SnackBar` with an action button is now treated as a more persistent
notification that requires user interaction. This change improves accessibility
and user experience by ensuring that critical notifications remain on the screen
until they are acknowledged.

## Description of change

This change aligns with the Material 3 design specifications for `SnackBar`s:
* Old behavior: A `SnackBar` with an action button would auto-dismiss after a
duration unless talkback was enabled.
* New behavior: A `SnackBar` with an action button will not auto-dismiss. It will 
remain on screen until it is dismissed by the user.

To allow users to override this behavior, an optional `persist` property has 
been added to `SnackBar`. When it is true, the `SnackBar` will not auto-dismiss  
and will remain on screen until manually dismissed by the user. When false, the 
`SnackBar` will auto-dismiss after its standard duration, regardless of the 
presence of an action. When it is null, the `SnackBar` will use the default 
behavior, which is to not auto-dismiss if an action is present.

## Migration guide

To restore the old auto-dismiss behavior for a SnackBar with an action, set
`persist` to false.

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

```dart
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

Landed in version: TBD
In stable release: TBD

## References

API documentation:

* [`SnackBar`][]

Relevant PRs:

* [SnackBar with action no longer auto-dismisses][]

[`SnackBar`]: {{site.api}}/flutter/material/SnackBar-class.html

[SnackBar with action no longer auto-dismisses]: {{site.repo.flutter}}/pull/173084
