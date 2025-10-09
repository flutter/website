---
title: MouseTracker no longer attaches annotations
description: >
  MouseTracker no longer relies on annotation attachment to
  perform the mounted-exit check; therefore, 
  all three related methods are removed.
---

{% render docs/docs/breaking-changes.md %}

## Summary

Removed `MouseTracker`'s methods `attachAnnotation`,
`detachAnnotation`, and `isAnnotationAttached`.

## Context

Mouse events, such as when a mouse pointer has entered a region,
exited, or is hovering over a region, are detected with the help of
`MouseTrackerAnnotation`s that are placed on interested regions
during the render phase. Upon each update (a new frame or a new event),
`MouseTracker` compares the annotations hovered by the mouse
pointer before and after the update, then dispatches
callbacks accordingly.

The `MouseTracker` class, which manages the state of mouse pointers,
used to require `MouseRegion` to attach annotations when mounted,
and detach annotations when unmounted.
This was used by `MouseTracker` to perform the
_mounted-exit check_ (for example, `MouseRegion.onExit`
must not be called if the exit was caused by the unmounting
of the widget), in order to prevent calling `setState`
of an unmounted widget and throwing exceptions (explained
in detail in [Issue #44631][]).

This mechanism has been replaced by making `MouseRegion`
a stateful widget, so that it can perform the mounted-exit
check by itself by blocking the callback when unmounted.
Therefore, these methods have been removed, and `MouseTracker`
no longer tracks all annotations on the screen.

## Description of change

The `MouseTracker` class has removed three methods related
to attaching annotations:

```dart diff
  class MouseTracker extends ChangeNotifier {
    // ...
-   void attachAnnotation(MouseTrackerAnnotation annotation) {/* ... */}

-   void detachAnnotation(MouseTrackerAnnotation annotation) {/* ... */}

-   @visibleForTesting
-   bool isAnnotationAttached(MouseTrackerAnnotation annotation) {/* ... */}
  }
```

`RenderMouseRegion` and `MouseTrackerAnnotation` no longer perform the
mounted-exit check, while `MouseRegion` still does.

## Migration guide

Calls to `MouseTracker.attachAnnotation` and
`detachAnnotation` should be removed with little to no impact:

* Uses of `MouseRegion` should not be affected at all.
* If your code directly uses `RenderMouseRegion` or
  `MouseTrackerAnnotation`, be aware that `onExit`
  is now called when the exit is caused by events that used
  to call `MouseTracker.detachAnnotation`.
  This should not be a problem if no states are involved,
  otherwise you might want to add the mounted-exit check,
  especially if the callback is leaked so that outer
  widgets might call `setState` in it. For example:

Code before migration:

```dart
class MyMouseRegion extends SingleChildRenderObjectWidget {
  const MyMouseRegion({this.onHoverChange});

  final ValueChanged<bool> onHoverChange;

  @override
  RenderMouseRegion createRenderObject(BuildContext context) {
    return RenderMouseRegion(
      onEnter: (_) { onHoverChange(true); },
      onExit: (_) { onHoverChange(false); },
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderMouseRegion renderObject) {
    renderObject
      ..onEnter = (_) { onHoverChange(true); }
      ..onExit = (_) { onHoverChange(false); };
  }
}
```

Code after migration:

```dart
class MyMouseRegion extends SingleChildRenderObjectWidget {
  const MyMouseRegion({this.onHoverChange});

  final ValueChanged<bool> onHoverChange;

  @override
  RenderMouseRegion createRenderObject(BuildContext context) {
    return RenderMouseRegion(
      onEnter: (_) { onHoverChange(true); },
      onExit: (_) { onHoverChange(false); },
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderMouseRegion renderObject) {
    renderObject
      ..onEnter = (_) { onHoverChange(true); }
      ..onExit = (_) { onHoverChange(false); };
  }

  @override
  void didUnmountRenderObject(RenderMouseRegion renderObject) {
    renderObject
      ..onExit = onHoverChange == null ? null : (_) {};
  }
}
```

Calls to `MouseTracker.isAnnotationAttached` must be removed.
This feature is no longer technically possible,
since annotations are no longer tracked.
If you somehow need this feature, please submit an issue.

## Timeline

Landed in version: 1.15.4<br>
In stable release: 1.17

## References

API documentation:

* [`MouseRegion`][]
* [`MouseTracker`][]
* [`MouseTrackerAnnotation`][]
* [`RenderMouseRegion`][]

Relevant PRs:

* [MouseTracker no longer requires annotations attached][],
  which made the change
* [Improve MouseTracker lifecycle: Move checks to post-frame][],
  which first introduced the mounted-exit change,
  explained at _The change to onExit_.


[Improve MouseTracker lifecycle: Move checks to post-frame]: {{site.repo.flutter}}/issues/44631
[Issue #44631]: {{site.repo.flutter}}/pull/44631
[`MouseRegion`]: {{site.api}}/flutter/widgets/MouseRegion-class.html
[`MouseTracker`]: {{site.api}}/flutter/gestures/MouseTracker-class.html
[MouseTracker no longer requires annotations attached]: {{site.repo.flutter}}/issues/48453
[`MouseTrackerAnnotation`]: {{site.api}}/flutter/gestures/MouseTrackerAnnotation-class.html
[`RenderMouseRegion`]: {{site.api}}/flutter/rendering/RenderMouseRegion-class.html
