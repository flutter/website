---
title: Changing RawMenuAnchor close order
description: >-
  Closing a `RawMenuAnchor` now triggers `onClose` and `onCloseRequested` callbacks
  for all descendant `RawMenuAnchor`s in a coordinated sequence.
---

{% render "docs/breaking-changes.md" %}

## Summary

Closing a `RawMenuAnchor` now triggers the `onCloseRequested`
and `onClose` callbacks for all descendant `RawMenuAnchor`s.
The `onCloseRequested` callback is triggered top-down,
starting from the triggering `RawMenuAnchor` and moving to its descendants,
while the `onClose` callback is triggered bottom-up.
If a `RawMenuAnchor` is already closed,
calls to `MenuController.close` and `MenuController.closeChildren`
will not trigger the `onCloseRequested` callback.

## Background

`RawMenuAnchor` is a low-level widget used to build custom menu systems.
Previously, a `RawMenuAnchor` did not automatically notify its descendants
when it was closed.
Developers were required to manually call `controller.closeChildren()`
within the `onCloseRequested` callback to trigger closure
in descendant `RawMenuAnchor`s.

Furthermore, the `onClose` callback timing was inconsistent.
A parent `RawMenuAnchor`'s `onClose` could be executed
before its descendants had finished closing.

The updated behavior ensures that when a parent `RawMenuAnchor` begins to close,
it subsequently triggers `onCloseRequested` for all of its
descendant `RawMenuAnchor`s in a top-down manner.

When `hideOverlay` is called from within `onCloseRequested` to close the menu,
all descendant `RawMenuAnchor`s will have their `onClose` callbacks executed
in a bottom-up order.
This means that the most recently opened `RawMenuAnchor`
will have its `onClose` callback executed first,
followed by its parent, and so on up the hierarchy.

This design allows for a coordinated closing sequence
where child `RawMenuAnchor`s can perform necessary cleanup
before their parents finalize the closing process.

Finally, if a `RawMenuAnchor` is already closed,
calls to `MenuController.close` and `MenuController.closeChildren`
will not trigger the `onCloseRequested` callback,
preventing unnecessary callback executions.

## Migration guide

If your code does not override the default implementation of
`RawMenuAnchor.onCloseRequested` or your `RawMenuAnchor`
does not contain submenus, no changes are required.

If you have a custom implementation of `onCloseRequested`
in a `RawMenuAnchor` containing submenus,
`controller.closeChildren()` is now called automatically
when the parent menu closes.
You should ensure that your implementation of `onCloseRequested`
still behaves correctly in this context.
Immediate calls to `controller.closeChildren()` within your
`onCloseRequested` callback are no longer necessary and should be removed.

Additionally, if your logic relied on the parent's `onClose` callback
firing before its descendants,
you may need to refactor your code to account for the new
bottom-up execution order.

Code before migration:

```dart
RawMenuAnchor(
  controller: menuController,
  onCloseRequested: (hideOverlay) {
    if (!animationController.isForwardOrCompleted) {
      return;
    }

    // Descendant submenus must be closed before the parent menu. This is now
    // handled automatically, so this call is no longer necessary.
    menuController.closeChildren();
    animationController.reverse().whenComplete(hideOverlay);
  },
  onClose: () {
    // This might have executed before descendants called onClose().
    _handleMenuClosed();
  },
  // ...
)
```

Code after migration:

```dart
RawMenuAnchor(
  controller: menuController,
  onCloseRequested: (hideOverlay) {
    if (!animationController.isForwardOrCompleted) {
      return;
    }

    // menuController.closeChildren() is now called automatically.
    animationController.reverse().whenComplete(hideOverlay);
  },
  onClose: () {
    // This now executes only after all descendant submenus have called onClose().
    _handleMenuClosed();
  },
  // ...
)
```

:::important
This migration is not supported by `dart fix`
:::

## Timeline

Landed in version: 3.44.0-0.1.pre<br>
In stable release: TBD

## References

API documentation:

* [`RawMenuAnchor`]({{site.api}}/flutter/widgets/RawMenuAnchor-class.html)
* [`RawMenuAnchor.onCloseRequested`]({{site.api}}/flutter/widgets/RawMenuAnchor/onCloseRequested.html)

Relevant issues:

* [[widgets/raw_menu_anchor.dart] onClose should be called by descendant menus
  before parent]({{site.repo.flutter}}/issues/182355)

Relevant PRs:

* [[widgets/raw_menu_anchor.dart] Always onClose and onCloseRequested on
  descendants before parent.]({{site.repo.flutter}}/pull/182357)
