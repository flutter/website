---
title: Navigator's page APIs breaking change
description: >-
  Replace Navigator's 'onPopPage' property with the 'onDidRemovePage' property.
---

## Summary

The [`Navigator`][] page APIs are refactored so that
they can integrate with Flutter's other pop mechanisms.

## Context

The `onPopPage` property was added for cleaning up pages after
a page is about to be popped.
To veto pop, you'd return `false` in the callback.
This did not work well with other popping mechanisms in the framework,
such as [`PopScope`][] and iOS back gestures.

To integrate the framework's pop mechanisms together,
the page APIs needed to be refactored.

## Description of change

The `onDidRemovePage` property replaces the `onPopPage` property.
You can no longer veto a pop in the `onDidRemovePage` property.
Instead, you are only responsible for updating the [`pages`][].

The veto mechanism is now managed with the
`Page.canPop` and `Page.onPopInvoked` properties.
These function similar to how you use the `PopScope` widget.

[`pages`]: {{site.api}}/flutter/widgets/Navigator/pages.html

## Migration guide

Code before migration:

```dart
import 'package:flutter/material.dart';

final MaterialPage<void> page1 = MaterialPage<void>(child: Placeholder());
final MaterialPage<void> page2 = MaterialPage<void>(child: Placeholder());
final MaterialPage<void> page3 = MaterialPage<void>(child: Placeholder());

void main() {
  final List<Page<void>> pages = <Page<void>>[page1, page2, page3];
  runApp(
    MaterialApp(
      home: Navigator(
        pages: pages,
        onPopPage: (Route<Object?> route, Object? result) {
          if (route.settings == page2) {
            return false;
          }
          if (route.didPop) {
            pages.remove(route.settings);
            return true;
          }
          return false;
        },
      ),
    ),
  );
}
```

Code after migration:

```dart
import 'package:flutter/material.dart';

final MaterialPage<void> page1 = MaterialPage<void>(child: Placeholder());
final MaterialPage<void> page2 = MaterialPage<void>(canPop: false, child: Placeholder());
final MaterialPage<void> page3 = MaterialPage<void>(child: Placeholder());

void main() {
  final List<Page<void>> pages = <Page<void>>[page1, page2, page3];
  runApp(
    MaterialApp(
      home: Navigator(
        pages: pages,
        onDidRemovePage: (Page<Object?> page) {
          pages.remove(page);
        },
      ),
    ),
  );
}
```

## Timeline

Landed in version: 3.22.0-32.0.pre<br>
In stable release: 3.24.0

## References

API documentation:

* [`Navigator`][]
* [`PopScope`][]

Relevant issue:

* [Issue 137458][]

Relevant PR:

* [Refactors page API][]

[Refactors page API]: {{site.repo.flutter}}/pull/137792
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`PopScope`]: {{site.api}}/flutter/widgets/PopScope-class.html
[Issue 137458]: {{site.repo.flutter}}/issues/137458
