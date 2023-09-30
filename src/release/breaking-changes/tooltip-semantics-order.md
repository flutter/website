---
title: Accessibility traversal order of tooltip changed 
description: >
  the Tooltip widget's message immedately follows the Tooltip widget's child 
  during accessibility traversal.
---

## Summary

During accessibility traversal, `Tooltip.message` is visited immedately after
`Tooltip.child`.

## Background

The `Tooltip` widget usually wraps an interactive UI component such as a button,
and shows a help message when long pressed. 
When the message is visible, assistive technologies should announce it after
the button.

The `Tooltip` widget originally put`Tooltip.message` on an `OverlayEntry` when 
long pressed.
As a result, the generated semantics tree does not put `Tooltip.message` 
immediately after `Tooltip.child`.

You may see accessibility test failures when a tooltip message is visible.
This is because this update moved the tooltip message in the semantics tree.

## Migration guide

Update your failing accessibility tests. For the following widget tree:

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

Generated semantics tree before migration:

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

Generated semantics tree after migration, notice how node #6 is moved behind 
node #3:

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

Landed in version: 3.15.0-7.0.pre<br>
In stable release: not yet

## References

API documentation:

* [`Tooltip`][]

Relevant PRs:

* [OverlayPortal.overlayChild contributes semantics to OverlayPortal instead of Overlay][]

[`Tooltip`]: {{site.api}}/flutter/material/Tooltip-class
[OverlayPortal.overlayChild contributes semantics to OverlayPortal instead of Overlay]: {{site.repo.flutter}}/pull/134921
