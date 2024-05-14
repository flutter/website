---
title: Navigator's page APIs breaking change
description: >
  Replace Navigator's `onPopPage` property with `onDidRemovePage` property.
---

## Summary

The [`Navigator`]'s page APIs are refactored so that they can integrate
into Flutter's other pop mechanisms.

## Context

The `onPopPage` was added for cleaning up pages after a page is about to be popped.
To veto pop, return `false` in the callback. This does not work well with other popping
mechanisms in the framework, such as [`PopScope`] and iOS back gestures.

To integrate the other pop mechanisms together, the page APIs need to be refactored.

## Description of change

The `onDidRemovePage` property replaces the `onPopPage` property. You can no longer veto a pop in
the `onDidRemovePage` property. Instead, you are only responsible for updating the [`pages`].

The veto mechanism moves to the `Page.canPop` and `Page.onPopInvoked`.
These function similar to how one uses the `PopScope` widget.

## Migration guide

Code before migration

```dart
import 'package:flutter/material.dart';
const MaterialPage<void> page1 = MaterialPage<void>(child: PlaceHolder());
const MaterialPage<void> page2 = MaterialPage<void>(child: PlaceHolder());
const MaterialPage<void> page3 = MaterialPage<void>(child: PlaceHolder());

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
            pages = pages.toList();
            return true;
          }
          return false;
        }
          
      ),
    ),
  );
}
```

Code after migration

```dart
import 'package:flutter/material.dart';
const MaterialPage<void> page1 = MaterialPage<void>(child: PlaceHolder());
const MaterialPage<void> page2 = MaterialPage<void>(canPop: false, child: PlaceHolder());
const MaterialPage<void> page3 = MaterialPage<void>(child: PlaceHolder());

void main() {
  final List<Page<void>> pages = <Page<void>>[page1, page2, page3];
  runApp(
    MaterialApp(
      home: Navigator(
        pages: pages,
        onDidRemovePage: (Page<Object?> page) {
          pages.remove(page);
          pages = pages.toList();
        }
          
      ),
    ),
  );
}
```

## Timeline

Landed in version: TBD<br>
In stable release: TBD

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
