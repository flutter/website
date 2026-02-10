---
title: Deprecate onReorder callback
description: >-
  The onReorder callback has been deprecated
  in favor of a new callback, called onReorderItem.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `onReorder` callback in the `ReorderableListView`,
`ReorderableListView.builder`, `ReorderableList` and `SliverReorderableList`
widgets has been replaced by a new callback, `onReorderItem`,
which provides a more intuitive behavior on index.

## Background

The `onReorder` callback in the `ReorderableListView`,
`ReorderableListView.builder`, `ReorderableList` and `SliverReorderableList`
widgets used to require a manual correction
for the second parameter, `newIndex`,
in case the `oldIndex` is before the `newIndex`,
due to the list of items shortening by one element in this case.

```dart
void handleReorder(int oldIndex, int newIndex) {
  if (oldIndex < newIndex) {
    // Removing the item at oldIndex will shorten the list by 1.
    newIndex -= 1;
  }

  // Handle the actual reorder behavior...
}

ReorderableListView(
  onReorder: handleReorder,
)
```

The new callback, `onReorderItem`, aims to solve this problem,
by doing the correction automatically.

```dart
void handleReorder(int oldIndex, int newIndex) {
  // handle the actual reorder behavior...
}

ReorderableListView(
  onReorderItem: handleReorder,
)
```

## Migration guide

The `ReorderableListView`, `ReorderableListView.builder`,
`ReorderableList` and `SliverReorderableList` widgets
share the same reordering logic, the migration steps
are identical for any of these widgets.

For the purpose of this migration guide,
`ReorderableListView` is chosen as an example.

### Case 1: trivial case

Code before migration:

```dart
ReorderableListView(
  onReorder: (int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    // Handle reorder ...
  }
)
```

Code after migration:

```dart diff
  ReorderableListView(
-   onReorder: (int oldIndex, int newIndex) {
-     if (oldIndex < newIndex) {
-       newIndex -= 1;
-     }
-
+   onReorderItem: (int oldIndex, int newIndex) {
      // Handle reorder ...
    }
  )
```

### Case 2: opting out, for complex onReorder implementations

In some cases, it might not be obvious how to do the migration
to the new `onReorderItem` callback,
particularly if the provided callback is very complex.

In that case, to opt out of the new behavior,
adjust the `newIndex` to match the old behavior.

Code before migration:

```dart
void handleSomeComplexReorder(int oldIndex, int newIndex) {
  // Handle reorder ...
}

ReorderableListView(
  onReorder: (int oldIndex, int newIndex) {
    handleSomeComplexReorder(oldIndex, newIndex);
  }
)
```

Code after migration:

```dart diff
  void handleSomeComplexReorder(int oldIndex, int newIndex) {
    // Handle reorder ...
  }

  ReorderableListView(
-   onReorder: (int oldIndex, int newIndex) {
+   onReorderItem: (int oldIndex, int newIndex) {
+     // To get the equivalent of the old newIndex:
+     if (oldIndex < newIndex) {
+       newIndex += 1;
+     }
+
      return handleSomeComplexReorder(oldIndex, newIndex);
    }
  )
```

:::important
This migration is not supported by `dart fix`,
due to the change in meaning for the second callback parameter.
:::

## Timeline

Landed in version: 3.41.0-1.0.pre-364<br>
In stable release: Not yet

## References

API documentation:

* [`ReorderCallback`][]
* [`ReorderableList`][]
* [`ReorderableListView`][]
* [`SliverReorderableList`][]

Relevant issues:

* [Issue 127901][]
* [Issue 169878][]

Relevant PRs:

* [Deprecate onReorder callback][]

[`ReorderCallback`]: {{site.main-api}}/flutter/widgets/ReorderCallback.html
[`ReorderableList`]: {{site.main-api}}/flutter/widgets/ReorderableList-class.html
[`ReorderableListView`]: {{site.main-api}}/flutter/material/ReorderableListView-class.html
[`SliverReorderableList`]: {{site.main-api}}/flutter/widgets/SliverReorderableList-class.html

[Issue 127901]: {{site.repo.flutter}}/issues/127901
[Issue 169878]: {{site.repo.flutter}}/issues/169878
[Deprecate onReorder callback]: {{site.repo.flutter}}/pull/178242