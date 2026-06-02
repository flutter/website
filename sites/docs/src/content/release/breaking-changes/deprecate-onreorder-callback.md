---
title: Deprecate onReorder callback
description: >-
  The onReorder callback has been deprecated
  in favor of a new callback, called onReorderItem.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `onReorder` callback in the
`ReorderableListView`, `ReorderableListView.builder`,
`ReorderableList`, and `SliverReorderableList` widgets
has been replaced by a new callback, `onReorderItem`,
which provides more intuitive behavior for `newIndex`.

## Background

The `onReorder` callback in the
`ReorderableListView`, `ReorderableListView.builder`,
`ReorderableList`, and `SliverReorderableList` widgets required
a manual correction for the second parameter, `newIndex`,
in case the `oldIndex` is before the `newIndex` because
the list of items would be shortened by one element.

```dart
void handleReorder(int oldIndex, int newIndex) {
  if (oldIndex < newIndex) {
    // Removing the item at oldIndex shortens the list by 1.
    newIndex -= 1;
  }

  // Handle the actual reorder behavior...
}

ReorderableListView(
  onReorder: handleReorder,
)
```

The new callback, `onReorderItem`, solves this problem
by doing the correction automatically.

```dart
void handleReorder(int oldIndex, int newIndex) {
  // Handle the actual reorder behavior...
}

ReorderableListView(
  onReorderItem: handleReorder,
)
```

## Migration guide

The `ReorderableListView`, `ReorderableListView.builder`,
`ReorderableList`, and `SliverReorderableList` widgets
share the same reordering logic.
The same migration steps apply to each of these widgets.

This migration guide uses `ReorderableListView` as an example.

### Case 1: Simple callbacks {: #case-1-simple-callbacks }

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

### Case 2: Opt out for complex `onReorder` implementations {: #case-2-opt-out }

In some cases, such as when the provided callback is complex,
the migration to the new `onReorderItem` callback might not be obvious.

In these cases, to opt out of the new behavior,
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
This migration isn't supported by `dart fix`,
due to the change in meaning for the second callback parameter.
:::

## Timeline

Landed in version: 3.41.0-1.0.pre-364<br>
In stable release: 3.44

## References

API documentation:

* [`ReorderCallback`][]
* [`ReorderableList`][]
* [`ReorderableListView`][]
* [`SliverReorderableList`][]

Relevant issues:

* [The index parameter for ReorderableListView's onReorderCallback is confusing][issue-127901]
* [SliverReorderableList newIndex arg off by one on drag down list][issue-169878]

Relevant PRs:

* [Deprecate onReorder callback][]

[`ReorderCallback`]: {{site.api}}/flutter/widgets/ReorderCallback.html
[`ReorderableList`]: {{site.api}}/flutter/widgets/ReorderableList-class.html
[`ReorderableListView`]: {{site.api}}/flutter/material/ReorderableListView-class.html
[`SliverReorderableList`]: {{site.api}}/flutter/widgets/SliverReorderableList-class.html

[issue-127901]: {{site.repo.flutter}}/issues/127901
[issue-169878]: {{site.repo.flutter}}/issues/169878
[Deprecate onReorder callback]: {{site.repo.flutter}}/pull/178242
