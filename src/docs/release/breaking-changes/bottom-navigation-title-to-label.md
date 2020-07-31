---
title: Bottom Navigation Title To Label
description: Deprecated BottomNavigationBarItem’s title (a Widget) in favor of label (a String). 
---

## Summary

{% comment %}
A one-line summary that should give context as to what changed
so that someone can find it when browsing through an index of
breaking changes, ideally using keywords from the symptoms you
would see if you had not yet migrated (i.e. when you get broken).
{% endcomment %}

`BottomNavigationBarItem.title` gives a deprecation warning, or no longer exists when referenced in 
code.

## Context

{% comment %}
High-level description of what API changed and why.
Should be clear enough to be understandable to someone
who has no context about this breaking change,
such as someone who doesn't know the underlying API.
This section should also answer the question
"what is the problem that led to considering making
a breaking change?"
{% endcomment %}

`BottomNavigationBarItem`s `title` parameter was deprecated in favor of `label`. This change was 
necessary to improve the user experience of `BottomNavigationBar`s when the text scale factor is 
increased. Items in a `BottomNavigationBar` now show tooltips on long press. Accomplishing this 
requires a `String` parameter on `BottomNavigationBarItem`s.


## Description of change

{% comment %}
A technical description of the actual change,
with code samples showing how the API changed.
{% endcomment %}

The `BottomNavigationBarItem` class has a `title` parameter, which is a `Widget`. This made it 
impossible for the `BottomNavigationBar` to show `Tooltip` widgets, a change which was necessary to 
improve the accessibility experience. Now, instead of taking `BottomNavigationBarItem.title` widget 
and building it, `BottomNavigationBar` will take `BottomNavigationBarItem.label`, wrap it in a 
`Text` widget, and build that.

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

Landed in version: 
In stable release: not yet

{% comment %}
The version # of the SDK where this change was
introduced.  If there is a deprecation window,
the version # to which we guarantee to maintain the old API.
{% endcomment %}

## References

API documentation:
* [`BottomNavigationBarItem`][]

Relevant PR:
* [Clean up hero controller scope][]

Breaking change proposal:
* [Breaking Change: Bottom Navigation Item Title][]

[Update BottomNavigationBar to show tooltips on long press.]: {{site.github}}/flutter/flutter/pull/59127

Stable channel link:
[`BottomNavigationBarItem`]: {{site.api}}/flutter/widgets/BottomNavigationBarItem-class.html

Master channel link:
[`BottomNavigationBarItem`]: https://master-api.flutter.dev/flutter/widgets/BottomNavigationBarItem-class.html

[Breaking Change: Bottom Navigation Item Title]: https://flutter.dev/go/bottom-navigation-bar-title-deprecation
