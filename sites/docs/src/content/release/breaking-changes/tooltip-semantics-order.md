---
title: Accessibility traversal order of tooltip changed
description: >-
  The Tooltip widget's message now immediately follows the
  Tooltip widget's child during accessibility traversal.
---

{% render "docs/breaking-changes.md" %}

## Summary

During accessibility focus traversal, `Tooltip.message` is
visited immediately after `Tooltip.child`.

## Background

The `Tooltip` widget usually wraps an interactive UI component such as a button,
and shows a help message when long pressed.
When the message is visible, assistive technologies should announce it after
the button.

The `Tooltip` widget originally put `Tooltip.message` on
an `OverlayEntry` when long pressed.
As a result, `Tooltip.message` was not immediately after
`Tooltip.child` in the semantics tree.

## Migration guide

This change moved the tooltip message in the semantics tree.
You might see accessibility test failures if
your tests expect a tooltip message to appear in a
specific location in the semantics tree, when it is visible.
Update any failing accessibility tests to adopt the new tooltip semantics order.

For example, if you constructed the following widget tree in your test:

```dart
Directionality(
  textDirection: TextDirection.ltr,
  child: Overlay(
    initialEntries: <OverlayEntry>[
      OverlayEntry(
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              const Text('before'),
              Tooltip(
                key: tooltipKey,
                showDuration: const Duration(days: 365),
                message: 'message',
                child: const Text('child'),
              ),
              const Text('after'),
            ],
          );
        },
      ),
    ],
  ),
);
```

When the tooltip message is visible, the corresponding semantics tree before
this change should look like this:

```dart
SemanticsNode#0
 │
 ├─SemanticsNode#1
 │ │
 │ └─SemanticsNode#5
 │   │ flags: hasImplicitScrolling
 │   │ scrollChildren: 3
 │   │
 │   ├─SemanticsNode#2
 │   │   tags: RenderViewport.twoPane
 │   │   label: "before"
 │   │   textDirection: ltr
 │   │
 │   ├─SemanticsNode#3
 │   │   tags: RenderViewport.twoPane
 │   │   label: "child"
 │   │   tooltip: "message"
 │   │   textDirection: ltr
 │   │
 │   └─SemanticsNode#4
 │       tags: RenderViewport.twoPane
 │       label: "after"
 │       textDirection: ltr
 │
 └─SemanticsNode#6
     label: "message"
     textDirection: ltr
```

After this change, the same widget tree generates a
slightly different semantics tree, as shown below.
Node #6 becomes a child of node #3, instead of node #0.

```dart
SemanticsNode#0
 │
 └─SemanticsNode#1
   │
   └─SemanticsNode#5
     │ flags: hasImplicitScrolling
     │ scrollChildren: 3
     │
     ├─SemanticsNode#2
     │   tags: RenderViewport.twoPane
     │   label: "before"
     │   textDirection: ltr
     │
     ├─SemanticsNode#3
     │ │ tags: RenderViewport.twoPane
     │ │ label: "child"
     │ │ tooltip: "message"
     │ │ textDirection: ltr
     │ │
     │ └─SemanticsNode#6
     │     label: "message"
     │     textDirection: ltr
     │
     └─SemanticsNode#4
         tags: RenderViewport.twoPane
         label: "after"
         textDirection: ltr
```

## Timeline

Landed in version: 3.16.0-11.0.pre<br>
In stable release: 3.19.0

## References

API documentation:

* [`Tooltip`][]

Relevant PRs:

* [OverlayPortal.overlayChild contributes semantics to OverlayPortal instead of Overlay][]

[`Tooltip`]: {{site.api}}/flutter/material/Tooltip-class.html
[OverlayPortal.overlayChild contributes semantics to OverlayPortal instead of Overlay]: {{site.repo.flutter}}/pull/134921
