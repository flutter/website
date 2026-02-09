---
title: The Visibility widget is no longer focusable by default when maintainState is enabled
description: >-
  The Visibility widget by default no longer implicitly retains focusability
  for its child when maintainState is enabled.
---

{% render "docs/breaking-changes.md" %}

## Summary
This change was introduced to fix an issue
where an `IndexedStack`s hidden children would be focusable with keyboard events
(see [issue](https://github.com/flutter/flutter/issues/114213))
due to the underlying `Visibility` widgets default behavior.

## Description of change
The core change is the `Visibility` widget is no longer focusable by default
when `maintainState` is enabled.
A new flag, `maintainFocusability`, must be set to true with `maintainState`
for a hidden widget to remain focusable.

## Migration guide
If your app has a `Visibility` widget that does not set `maintainState` to true,
then no changes are required.

If your app has a `Visibility` widget that sets `maintainState` to true
and you relied on the previous default behavior
that allowed you to focus your hidden widget,
you will need to set `maintainFocusability` to true.

Code before migration:

```dart
child: Visibility(
    maintainState: true,
    child: SomeWidget(),
)
```

Code after migration:

```dart
child: Visibility(
    maintainState: true,
    maintainFocusability: true,
    child: SomeWidget(),
)
```

## Timeline

Landed in version: 3.34.0-pre<br>
In stable release: 3.35

## References

API documentation:

* [`Visibility`]({{site.api}}/flutter/widgets/Visibility-class.html)

Relevant issues:

* [Issue 114213]({{site.repo.flutter}}/issues/114213)

Relevant PRs:

* [PR 159133: Add flag to exclude focus for hidden children in Visibility, maintainFocusability. Set maintainFocusability to false in IndexedStack]({{site.repo.flutter}}/pull/159133)
