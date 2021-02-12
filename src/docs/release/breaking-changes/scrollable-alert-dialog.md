---
title: Scrollable AlertDialog (No longer deprecated)
description: AlertDialog should scroll automatically when it overflows.
---

## Summary

{{site.alert.note}}
  `AlertDialog.scrollable` is no longer deprecated because there is
  no backwards-compatible way to make `AlertDialog` scrollable by default.
  Instead, the parameter will remain and you can set `scrollable`
  to true if you want a scrollable `AlertDialog`.
{{site.alert.end}}

An `AlertDialog` now scrolls automatically when it overflows.

## Context

Before this change,
when an `AlertDialog` widget’s contents were too tall,
the display overflowed, causing the contents to be clipped.
This resulted in the following issues:

* There was no way to view the portion of the content that was clipped.
* Most alert dialogs have buttons beneath the content to prompt users for
  actions. If the content overflowed, obscuring the buttons,
  users might be unaware of their existence.

## Description of change

The previous approach listed the title and content
widgets consecutively in a `Column` widget.

<!-- skip -->
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

The new approach wraps both widgets in a
`SingleChildScrollView` above the button bar,
making both widgets part of the same scrollable
and exposing the button bar at the bottom of the dialog.

<!-- skip -->
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

You might see the following issues as a result of this change:

**Semantics tests might fail because of the addition of a `SingleChildScrollView`.**
: Manual testing of the `Talkback` and `VoiceOver` features
  show that they still exhibit the same (correct)
  behavior as before.

**Golden tests might fail.**
: This change might have caused diffs in (previously passing)
  golden tests since the `SingleChildScrollView` now nests both the
  title and content widgets.
  Some Flutter projects have taken to creating semantics tests
  by taking goldens of semantics nodes used in Flutter's debug build.

  <br>Any semantics golden updates that reflect the scrolling
  container addition are expected and these diffs should be safe to accept.

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

**Layout changes might result because of the scroll view.**
: If the dialog was already overflowing,
  this change corrects the problem.
  This layout change is expected.

  <br>A nested `SingleChildScrollView` in `AlertDialog.content`
  should work properly if left in the code,
  but should be removed if unintended, since
  it might cause confusion.

Code before migration:

<!-- skip -->
```dart
AlertDialog(
  title: Text(
    'Very, very large title that is also scrollable',
    textScaleFactor: 5,
  ),
  content: SingleChildScrollView( // won't be scrollable
    child: Text('Scrollable content', textScaleFactor: 5),
  ),
  actions: <Widget>[
    TextButton(child: Text('Button 1'), onPressed: () {}),
    TextButton(child: Text('Button 2'), onPressed: () {}),
  ],
)
```

Code after migration:

<!-- skip -->
```dart
AlertDialog(
  title: Text('Very, very large title', textScaleFactor: 5),
  content: Text('Very, very large content', textScaleFactor: 5),
  actions: <Widget>[
    TextButton(child: Text('Button 1'), onPressed: () {}),
    TextButton(child: Text('Button 2'), onPressed: () {}),
  ],
)
```

## Timeline

Landed in version: 1.16.3<br>
In stable release: 1.17

## References

Design doc:
* [Scrollable `AlertDialog`][]

API documentation:
* [`AlertDialog`][]

Relevant issue:
* [Overflow exceptions with maximum accessibility font size][]

Relevant PRs:
* [Update to `AlertDialog.scrollable`][]
* [Original attempt to implement scrollable `AlertDialog`][]
* [Revert of original attempt to implement scrollable `AlertDialog`][]


[`AlertDialog`]: {{site.api}}/flutter/material/AlertDialog-class.html
[Original attempt to implement scrollable `AlertDialog`]: {{site.github}}/flutter/flutter/pull/43226
[Overflow exceptions with maximum accessibility font size]: {{site.github}}/flutter/flutter/issues/42696
[Revert of original attempt to implement scrollable `AlertDialog`]: {{site.github}}/flutter/flutter/pull/44003
[Scrollable `AlertDialog`]: /go/scrollable-alert-dialog
[Update to `AlertDialog.scrollable`]: {{site.github}}/flutter/flutter/pull/45079
