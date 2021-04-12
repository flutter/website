---
title: Bottom Navigation Title To Label
description: Deprecated BottomNavigationBarItem’s title (a Widget) in favor of label (a String). 
---

## Summary

`BottomNavigationBarItem.title` gives a deprecation warning,
or no longer exists when referenced in code.

## Context

`BottomNavigationBarItem`s `title` parameter was deprecated
in favor of `label`. This change was necessary to improve
the user experience of `BottomNavigationBar`s when the text
scale factor is increased. Items in a `BottomNavigationBar`
now show tooltips on long press. Accomplishing this 
requires a `String` parameter on `BottomNavigationBarItem`s.


## Description of change

The `BottomNavigationBarItem` class has a `title` parameter,
which is a `Widget`. This made it impossible for the
`BottomNavigationBar` to show `Tooltip` widgets,
a change that was necessary to improve the accessibility experience. Now, instead of building the BottomNavigationBarItem.title 
widget, the BottomNavigationBar wraps the
`BottomNavigationBarItem.label` in a Text widget and builds that.

## Migration guide

Code before migration:

<!-- skip -->
```dart
BottomNavigationBarItem(
  icon: Icons.add,
  title: Text('add'),
)
```

Code after migration:

<!-- skip -->
```dart
BottomNavigationBarItem(
  icon: Icons.add,
  label: 'add',
)
```

## Timeline

Landed in version: 1.22.0
In stable release: 2.0.0

## References

API documentation:
* [`BottomNavigationBarItem`][]

Relevant PRs:
* [PR 60655][]: Clean up hero controller scope
* [PR 59127][]: Update BottomNavigationBar to show tooltips
  on long press][].

Breaking change proposal:
* [Breaking Change: Bottom Navigation Item Title][]


[`BottomNavigationBarItem`]: {{site.api}}/flutter/widgets/BottomNavigationBarItem-class.html
[Breaking Change: Bottom Navigation Item Title]: /go/bottom-navigation-bar-title-deprecation
[PR 59127]: {{site.github}}/flutter/flutter/pull/59127
[PR 60655]: {{site.github}}/flutter/flutter/pull/60655
