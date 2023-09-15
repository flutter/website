---
title: Added missed `dispose()` for some disposable objects in Flutter
description: >
  'dispose()' may fail because of double disposal.
---

## Summary

Missed 'dispose()' are added for some disposable objects.
If some other code also invokes 'dispose()' for the objects,
and the object is protected from double disposal,
the second 'dispose()' fails with the following error message:

`Once you have called dispose() on a <class name>, it can no longer be used.` 

## Background

The convention is that the owner of an object should dispose of it.

This rule was broken in some places in Flutter Framework: owners were not disposing the disposable objects.
The issue was fixed by adding `dispose()`. The added `dispose()` can cause failures in debug mode,
if there is another `dispose()`, and the object is protected from double disposal.

## Migration guide

If you got error like `Once you have called dispose() on a <class name>, it can no longer be used.`,
and the error is raised for your code, 
update the code to call `dispose()' only in cases when your code created the object.

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

If the error is for Flutter code, this means wrong `dispose()` happened first, and the error was raised
for correct `dispose()` that happened second.

You can locate the wrong `dispose()` by temporary adding `print(StackTrace.current)`
to the body of the failed method `dispose`.

## Timeline

See the progress and status [in the tracking issue](https://github.com/flutter/flutter/issues/134787).
