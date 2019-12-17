---
title: Scrollable AlertDialog
description: AlertDialog should scroll automatically when it overflows.
---

# Scrollable AlertDialog

## Context

Currently, when an AlertDialog widget’s contents are too tall, they can end up
overflowing and can be clipped. This causes the following issues:

1. The content overflows and there is no way to view the rest of the content.
2. Most alert dialogs have buttons beneath its contents to prompt users for
actions. However, if the contents overflow and the buttons are obscured, users
may be unaware of the existence of these buttons.

## Description of change

The current code simply has the title widget and content widgets appear consecutively in a Row widget:

```dart
Column(
  mainAxisSize: MainAxisSize.min,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: <Widget>[
    if (title != null)
      Padding(
        padding: titlePadding ?? EdgeInsets.fromLTRB(24.0, 24.0, 24.0, content == null ? 20.0 : 0.0),
        child: DefaultTextStyle(
          style: titleTextStyle ?? dialogTheme.titleTextStyle ?? theme.textTheme.title,
          child: Semantics(
          child: title,
          namesRoute: true,
          container: true,
          ),
        ),
      ),
    if (content != null)
      Flexible(
        child: Padding(
        padding: contentPadding,
        child: DefaultTextStyle(
          style: contentTextStyle ?? dialogTheme.contentTextStyle ?? theme.textTheme.subhead,
          child: content,
        ),
      ),
    ),
    // ...
  ],
);
```

The proposed change would basically wrap both widgets in a
SingleChildScrollView above the button bar, making both
widgets part of the same scrollable while exposing the
button bar at the bottom of the dialog:

```dart
Column(
  mainAxisSize: MainAxisSize.min,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: <Widget>[
    if (title != null || content != null)
      SingleChildScrollView(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[
           if (title != null)
             titleWidget,
             if (content != null)
             contentWidget,
         ],
       ),
     ),
   // ...
  ],
),
```

## Migration guide

### Potential breaking changes

1. Semantics tests may fail because of the addition of a SingleChildScrollView.

Upon manually testing Talkback and VoiceOver, they still behave correctly and
the same.

However, this change might have caused semantics golden diffs in some tests
since the SingleChildScrollView now nests both the title and content widgets.
Some Flutter projects have taken to creating semantics tests by taking goldens
of semantics nodes using in Flutter's debug build.

Any semantics golden updates that reflect the scrolling container addition
is expected and these diffs should be safe to accept.

Sample resulting Semantics tree:

```
flutter:        ├─SemanticsNode#30 <-- SingleChildScrollView
flutter:          │ flags: hasImplicitScrolling
flutter:          │ scrollExtentMin: 0.0
flutter:          │ scrollPosition: 0.0
flutter:          │ scrollExtentMax: 0.0
flutter:          │
flutter:          ├─SemanticsNode#31 <-- title
flutter:          │   flags: namesRoute
flutter:          │   label: "Hello"
flutter:          │
flutter:          └─SemanticsNode#32 <-- contents
flutter:              label: "Huge content"
```

2. This change may result in layout changes because of the scroll view.

If the dialog was already overflowing, this change would correct the problem
and this layout change is expected.

A nested SingleChildScrollView in `AlertDialog.content` seems to still work
properly if left in, but it should probably be removed if unintended since
it might cause confusion.

### Two-phase update:

This change will be conducted in two phases.

1. The first phase introduces a new parameter to AlertDialog called
`scrollable`. It will default to `false`, so this new parameter will need
to be set to `true` to reflect the latest changes. Any expected breaking tests
described above should be fixed.

2. The second phase would remove the `scrollable` parameter and have the
AlertDialog widget be scrollable by default. This will require all AlertDialogs
to be modified and have their `scrollable` parameters removed.

## Timeline

Late December 2019 - Add scrollable parameter, allow devs to migrate to setting
`scrollable` to true.

Early January 2020 - Remove scrollable parameter, Flutter devs have to remove
`scrollable` parameter and have alert dialogs be scrollable by default.

## References

Design doc:
* [Scrollable AlertDialog](/go/scrollable-alert-dialog)

API documentation:
* [AlertDialog API doc](https://api.flutter.dev/flutter/material/AlertDialog-class.html)

Relevant issues:
* [Overflow exceptions with maximum accessibility font size](https://github.com/flutter/flutter/issues/42696)

Relevant PRs:
* [Update to AlertDialog.scrollable](https://github.com/flutter/flutter/pull/45079)
* [Original attempt to implement scrollable AlertDialog](https://github.com/flutter/flutter/pull/43226)
* [Revert of original attempt to implement scrollable AlertDialog](https://github.com/flutter/flutter/pull/44003)
