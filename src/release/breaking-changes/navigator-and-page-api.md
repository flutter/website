---
title: Navigator's page APIs breaking change
description: >
  Changes to Navigator's page APIs.
---

## Summary

The [`Navigator`]'s page APIs are refactored so that they can integrate
into Flutter's other pop mechanisms.

## Context

The `onPopPage` was added for cleaning up pages after a page is about to be popped.
The developer can veto pop by returning false in the callback. This does not work well
with other popping mechanisms in the framework, such as [`PopScope`] and cupertino back
gestures.

The page APIs needed to be refactored in order to integrate them together.


## Description of change

The `onPopPage` is replaced by `onDidRemovePage` and no longer had the ability to veto
a pop. In the `onDidRemovePage`, one is only responsible for updating the [`pages`].

The veto mechanism is moved to the `Page.canPop` and `Page.onPopInvoked` similar to how
one uses the `PopScope` widget.

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

Landed in version: TBD
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
