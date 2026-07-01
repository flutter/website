---
title: ListTile reports an error in debug when wrapped in a colored widget
description: >-
  ListTile now reports an error in debug mode when it is wrapped in
  an intermediate widget with a non-transparent background color.
---

{% render "docs/breaking-changes.md" %}

## Summary

When a widget with a non-transparent background color,
such as a `Container` or `ColoredBox` that sets `color`,
sits between a `ListTile` and its nearest `Material` ancestor,
the framework now reports an error.

## Background

`ListTile` paints its background color and ink splashes
on the nearest `Material` ancestor.
When a widget with an opaque background color is
placed between the `ListTile` and its `Material` ancestor,
it obscures these visual effects,
making them invisible to the user.

To prevent you from accidentally introducing this bug and
wondering why the background or ink splash effects on
the `ListTile` aren't displaying,
the framework now reports an assertion error during development.

If your code has an intermediate colored widget
between a `ListTile` and a `Material` widget,
you will now see an error similar to this:

```text
ListTile background color or ink splashes may be invisible.
The ListTile is wrapped in a Container that has a background color.
Because ListTile paints its background and ink splashes on
the nearest Material ancestor, this Container will hide those effects.
To fix this, wrap the ListTile in its own Material widget, or
remove the background color from the intermediate Container.
```

## Migration guide

To fix the error,
remove the background color from the intermediate widget or
wrap the `ListTile` in its own `Material` widget.

Code before migration:

```dart
// The colored Container hides the ink splashes from the ListTile.
Material(
  child: Container(
    color: Colors.pink,
    child: ListTile(
      title: const Text('Title'),
      onTap: () {},
    ),
  ),
)
```

Code after migration:

```dart
// Use a Material widget directly for the background color.
Material(
  color: Colors.pink,
  child: Container(
    child: ListTile(
      title: const Text('Title'),
      onTap: () {},
    ),
  ),
)
```

Alternatively,
wrap the `ListTile` in its own `Material` widget:

```dart
Container(
  color: Colors.blue,
  child: Material(
    type: MaterialType.transparency,
    child: ListTile(
      title: const Text('Title'),
      onTap: () {},
    ),
  ),
)
```

## Timeline

Landed in version: 3.43.0-0.1.pre<br>
In stable release: 3.44

## References

API documentation:

* [`ListTile`][]
* [`Material`][]

Relevant issues:

* [`ListTile.selectedTileColor` not visible when parent `Container` has explicit background color][issue-174366]

Relevant PRs:

* [Add warning when there is a widget with color between `Material` and `ListTile`][pr-181402]

[`ListTile`]: {{site.api}}/flutter/material/ListTile-class.html
[`Material`]: {{site.api}}/flutter/material/Material-class.html
[issue-174366]: {{site.repo.flutter}}/issues/174366
[pr-181402]: {{site.repo.flutter}}/pull/181402
