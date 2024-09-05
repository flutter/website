---
title: Default multitouch scrolling
description: >
  ScrollBehaviors will now configure how Scrollables respond to
  multitouch gestures.
---

## Summary

`ScrollBehavior`s now allow or disallow scrolling speeds to be affected by the 
number of pointers on the screen. `ScrollBehavior.multitouchDragStrategy`, by
default, prevents multiple pointers interacting wih the scrollable at the same
time from affecting the speed of scrolling.

## Context

Prior to this change, for each pointer dragging a `Scrollable` widget, the
scroll speed would increase. This did not match platform expectations when
interacting with Flutter applications.

Now, the inherited `ScrollBehavior` manages how multiple pointers affect
scrolling widgets as specified by `ScrollBehavior.multitouchDragStrategy`. This
enum, `MultitouchDragStrategy`, can also be configured for the prior behavior.

## Description of change

This change fixed the unexpected ability to increase scroll speeds by dragging
with more than one finger.

If you have relied on the previous behavior in your application, there are
several ways to control and configure this feature.

- Extend `ScrollBehavior`, `MaterialScrollBehavior`, or `CupertinoScrollBehavior`
  to modify the default behavior, overriding
  `ScrollBehavior.multitouchDragStrategy`.

    - With your own `ScrollBehavior`, you can apply it app-wide by setting
      `MaterialApp.scrollBehavior` or `CupertinoApp.scrollBehavior`.
    - Or, if you wish to only apply it to specific widgets, add a
      `ScrollConfiguration` above the widget in question with your
      custom `ScrollBehavior`.

Your scrollable widgets then inherit and reflect this behavior.

- Instead of creating your own `ScrollBehavior`, another option for changing
  the default behavior is to copy the existing `ScrollBehavior`, and set different
  `multitouchDragStrategy`.
    - Create a `ScrollConfiguration` in your widget tree, and provide a modified copy
      of the existing `ScrollBehavior` in the current context using `copyWith`.

To accommodate the new configuration
`DragGestureRecognizer` was updated to support `MultitouchDragStrategy` as well
in other dragging contexts.

## Migration guide

### Setting a custom `ScrollBehavior` for your application

Code before migration:

```dart
MaterialApp(
  // ...
);
```

Code after migration:

```dart
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like multitouchDragStrategy
  @override
  MultitouchDragStrategy getMultitouchDragStrategy(BuildContext context) => MultitouchDragStrategy.sumAllPointers;
}

// Set ScrollBehavior for an entire application.
MaterialApp(
  scrollBehavior: MyCustomScrollBehavior(),
  // ...
);
```

### Setting a custom `ScrollBehavior` for a specific widget

Code before migration:

```dart
final ScrollController controller = ScrollController();
ListView.builder(
  controller: controller,
  itemBuilder: (BuildContext context, int index) {
    return Text('Item $index');
  },
);
```

Code after migration:

```dart
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like multitouchDragStrategy
  @override
  MultitouchDragStrategy getMultitouchDragStrategy(BuildContext context) => MultitouchDragStrategy.sumAllPointers;
}

// ScrollBehavior can be set for a specific widget.
final ScrollController controller = ScrollController();
ScrollConfiguration(
  behavior: MyCustomScrollBehavior(),
  child: ListView.builder(
    controller: controller,
    itemBuilder: (BuildContext context, int index) {
      return Text('Item $index');
    },
  ),
);
```

### Copy and modify existing `ScrollBehavior`

Code before migration:

```dart
final ScrollController controller = ScrollController();
ListView.builder(
  controller: controller,
  itemBuilder: (BuildContext context, int index) {
    return Text('Item $index');
  },
);
```

Code after migration:

```dart
// ScrollBehavior can be copied and adjusted.
final ScrollController controller = ScrollController();
ScrollConfiguration(
  behavior: ScrollConfiguration.of(context).copyWith(
    multitouchDragStrategy: MultitouchDragStrategy.sumAllPointers,
  ),
  child: ListView.builder(
    controller: controller,
    itemBuilder: (BuildContext context, int index) {
      return Text('Item $index');
    },
  ),
);
```

## Timeline

Landed in version: 3.18.0-4.0.pre<br>
In stable release: 3.19.0

## References

API documentation:

* [`ScrollConfiguration`][]
* [`ScrollBehavior`][]
* [`MaterialScrollBehavior`][]
* [`CupertinoScrollBehavior`][]
* [`MultitouchDragStrategy`][]
* [`DragGestureRecognizer`][]

Relevant issue:

* [Issue #11884][]

Relevant PRs:

* [Introduce multi-touch drag strategies for DragGestureRecognizer][]


[`ScrollConfiguration`]: {{site.api}}/flutter/widgets/ScrollConfiguration-class.html
[`ScrollBehavior`]: {{site.api}}/flutter/widgets/ScrollBehavior-class.html
[`MaterialScrollBehavior`]: {{site.api}}/flutter/material/MaterialScrollBehavior-class.html
[`CupertinoScrollBehavior`]: {{site.api}}/flutter/cupertino/CupertinoScrollBehavior-class.html
[`MultitouchDragStrategy`]: {{site.api}}/flutter/gestures/MultitouchDragStrategy.html
[`DragGestureRecognizer`]: {{site.api}}/flutter/gestures/DragGestureRecognizer-class.html
[Issue #11884]: {{site.repo.flutter}}/issues/11884
[Introduce multi-touch drag strategies for DragGestureRecognizer]: {{site.repo.flutter}}/pull/136708
