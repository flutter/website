---
title: Generic types in PopScope
description: >
  Added a generic type in PopScope class and updated the onPopInvoked
  function signature.
---

## Summary

Added a `Route`'s generic type to the [`PopScope`][] class
and updated the [`onPopInvoked`][] function signature
to take this type as a positional parameter.

## Context

Previously, the `onPopInvoked` method in `PopScope`
didn't have a type-safe way to access the
`Route`'s pop result. This change addresses that issue.

## Description of change

Added a generic type in the `PopScope` class and updated
the `onPopInvoked` method to take the type as a positional parameter.

## Migration guide

Code before migration

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      navigatorKey: nav,
      home: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          launchConfirmationDialog();
        },
        child: MyWidget(),
      ),
    ),
  );
}
```

Code after migration
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      navigatorKey: nav,
      home: PopScope<Object?>(
        canPop: false,
        onPopInvoked: (bool didPop, Object? result) {
          if (didPop) {
            return;
          }
          launchConfirmationDialog();
        },
        child: MyWidget(),
      ),
    ),
  );
}
```

The generic type should match the generic type of the [`Route`] the `PopScope` is in.
If the route uses `int` as its generic type, consider using `PopScope<int>`.

If widgets are shared across multiple routes with different types,
use `PopScope<Object?>` to catch all possible types.

## Timeline

Landed in version: TBD
In stable release: TBD

## References

API documentation:

* [`PopScope`][]
* [`onPopInvoked`][]
* [`Route`][]

Relevant issue:

* [Issue 137458][]

Relevant PR:

* [Add generic type for result in PopScope][]

[Add generic type for result in PopScope]: {{site.repo.flutter}}/pull/139164
[`PopScope`]: {{site.api}}/flutter/widgets/PopScope-class.html
[`Route`]: {{site.api}}/flutter/widgets/Route-class.html
[`onPopInvoked`]: {{site.api}}/flutter/widgets/PopScope/onPopInvoked.html
[Issue 137458]: {{site.repo.flutter}}/issues/137458
