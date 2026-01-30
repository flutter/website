---
title: Deprecate onReorder callback
description: >-
  The `onReorder` callback has been deprecated
  in favor of a new callback, called `onReorderItem`.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `onReorder` callback in the `ReorderableListView`,
`ReorderableListView.builder`, `ReorderableList` and `SliverReorderableList`
widgets has been replaced by a new callback, `onReorderItem`
to fix the confusing behavior of the second callback parameter, `newIndex`.

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
        // removing the item at oldIndex will shorten the list by 1.
        newIndex -= 1;
    }

    // handle the actual reorder behavior...
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

First, rename the `onReorder` callback parameter in any `ReorderableListView`,
`ReorderableListView.builder`, `ReorderableList` and `SliverReorderableList`
widget constructors, to `onReorderItem`.

Then, in the callback that is passed to `onReorderItem`,
remove the if-case that corrects the second function parameter,
if it is larger than the first function parameter,
since it is no longer needed.

This migration is not supported by `dart fix`,
due to the change in meaning for the second callback parameter.

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

```dart
ReorderableListView.builder(
    onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
            newIndex -= 1;
        }

        // Handle reorder ...
    }
)
```

```dart
ReorderableList(
    onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
            newIndex -= 1;
        }

        // Handle reorder ...
    }
)
```

```dart
SliverReorderableList(
    onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
            newIndex -= 1;
        }

        // Handle reorder ...
    }
)
```

Code after migration:

```dart
ReorderableListView(
    onReorderItem: (int oldIndex, int newIndex) {
        // Handle reorder ...
    }
)
```

```dart
ReorderableListView.builder(
    onReorderItem: (int oldIndex, int newIndex) {
        // Handle reorder ...
    }
)
```

```dart
ReorderableList(
    onReorderItem: (int oldIndex, int newIndex) {
        // Handle reorder ...
    }
)
```

```dart
SliverReorderableList(
    onReorderItem: (int oldIndex, int newIndex) {
        // Handle reorder ...
    }
)
```

## Timeline

Landed in version: 3.41.0-1.0.pre-364<br>
In stable release: Not yet

## References

{% render "docs/main-api.md", site: site %}

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

{% render "docs/main-api.md", site: site %}

[`ReorderCallback`]: {{site.main-api}}/flutter/widgets/ReorderCallback.html
[`ReorderableList`]: {{site.main-api}}/flutter/widgets/ReorderableList-class.html
[`ReorderableListView`]: {{site.main-api}}/flutter/material/ReorderableListView-class.html
[`SliverReorderableList`]: {{site.main-api}}/flutter/widgets/SliverReorderableList-class.html

[Issue 127901]: {{site.repo.flutter}}/issues/127901
[Issue 169878]: {{site.repo.flutter}}/issues/169878
[Deprecate onReorder callback]: {{site.repo.flutter}}/pull/178242