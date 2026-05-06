---
title: Added missing `dispose()` for some disposable objects in Flutter
description: >
  'dispose()' might fail because of double disposal.
---

{% render "docs/breaking-changes.md" %}

## Summary

Missing calls to 'dispose()' are added for some disposable objects.
For example, ContextMenuController did not dispose OverlayEntry,
and EditableTextState did not dispose TextSelectionOverlay.

If some other code also invokes 'dispose()' for the object,
and the object is protected from double disposal,
the second 'dispose()' fails with the following error message:

`Once you have called dispose() on a <class name>, it can no longer be used.`

## Background

The convention is that the owner of an object should dispose of it.

This convention was broken in some places:
owners were not disposing the disposable objects.
The issue was fixed by adding a call to `dispose()`.
However, if the object is protected from double disposal,
this can cause failures when running in debug mode
and `dispose()` is called elsewhere on the object.

## Migration guide

If you encounter the following error, update your code to
call `dispose()` only in cases when your code created the object.

```plaintext
Once you have called dispose() on a <class name>, it can no longer be used.
```

Code before migration:

```dart
x.dispose();
```

Code after migration:

```dart
if (xIsCreatedByMe) {
  x.dispose();
}
```

To locate the incorrect disposal, check the call stack of the error. If the call stack points to `dispose`
in your code, this disposal is incorrect and should be fixed.

If the error occurs in Flutter code, `dispose()` was
called incorrectly the first time.

You can locate the incorrect call by temporary calling `print(StackTrace.current)`
in the body of the failed method `dispose`.

## Timeline

See the progress and status [in the tracking issue]({{site.repo.flutter}}/issues/134787).
