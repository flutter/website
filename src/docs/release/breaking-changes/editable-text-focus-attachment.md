---
title: TextField FocusNode attach location change
description: EditableText.focusNode is no longer attached to EditableTextState's BuildContext
---

## Summary

`EditableText.focusNode` is now attached to a dedicated `Focus` widget within
`EditableText`.

## Context

A `FocusNode` is typically attached to the `BuildContext` of a focusable widget,
and is used to represent and control the focus state of that widget. 

In Flutter's keyboard event handling system, the user `Intent` behind a key press
(or a sequence of key presses), such as delete or insert text, is fired from the
`FocusNode` that currently has the primary focus, and propagates upwards in the
widget tree until it finds the first available handler. In the context of text
editing, text editing `Intent` handlers are typically defined in
`EditableTextState`, and that means the `FocusNode` needs to be attached below
(in terms of the locations in the widget tree) `EditableTextState`, so when the
app user presses <kbd>DEL</kbd> or some other keys in the current text field, the
corresponding handler defined in `EditableTextState` can be found.

## Description of change

`EditableTextState` now creates a dedicated `Focus` widget to host `EditableText.focusNode`.
This does not involve any public API changes but breaks codebases relying on that
particular implementation detail to tell if a `FocusNode` is associated with a
text input field.

This change shouldn't break any builds but can introduce runtime issues, or
cause existing tests to fail.

## Migration guide

The `EditableText` widget takes a `FocusNode` as a paramter, which was
previously attached to its `EditableText`'s `BuildContext`. If you are relying
on runtime typecheck to find out if a `FocusNode` is attached to a text input
field or a selectable text field like so:

- `focusNode.context.widget is EditableText`
- `(focusNode.context as StatefulElement).state as EditableTextState`

Then please read on and consider following the migration steps to avoid breakages.

If you're not sure if a codebase needs migration, search for `is EditableText`,
`as EditableText`, `is EditableTextState` and `as EditableTextState` and verify
any of the search result are doing typecheck/typecast on a `FocusNode.context`.
If there is then migration is needed.

To avoid doing typecheck or downcasting the `BuildContext` associated with the
`FocusNode` of interest, depending on the actual capabilities the codebase is
trying to invoke from the given `FocusNode`, fire an `Intent` from that
`BuildContext`. For instance, if you wish to update the text of the currently focused
`TextField` to a specic value:

Code before migration:

<!-- skip -->
```dart
final Widget? focusedWidget = primaryFocus?.context?.widget;
if (focusedWidget is EditableText) {
  widget.controller.text = 'Updated Text';
}
```

Code after migration:

<!-- skip -->
```dart
final BuildContext? focusedContext = primaryFocus?.context;
if (focusedContext != null) {
  Actions.maybeInvoke(focusedContext, ReplaceTextIntent('UpdatedText'));
}
```

For a comprehensive list of `Intent`s supported by the `EditableText` widget,
please refer to the documentation of the `EditableText` widget.

## Timeline

Landed in version: xxx<br>
In stable release: not yet
Reverted in version: xxx  (OPTIONAL, delete if not used)

## References

API documentation:

* [`EditableText`][]

Relevant PRs:

* [Move text editing Actions to EditableTextState][]

[`EditableText`]: https://master-api.flutter.dev/flutter/widgets/EditableText-class.html
[Move text editing Actions to EditableTextState]: {{site.github}}/flutter/flutter/pull/90684

