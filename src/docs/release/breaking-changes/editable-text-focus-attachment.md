---
title: TextField FocusNode attach location change
description: EditableText.focusNode is no longer attached to EditableTextState's BuildContext
---

## Summary

`EditableText.focusNode` is now attached to a dedicated `Focus` widget below
`EditableText`.

## Context

A text input field widget (`TextField`, for example) typically owns a `FocusNode`.
When that `FocusNode` is the primary focus of the app, events such as key presses 
will be sent to the `BuildContext` the `FocusNode` is attached to. 

The `FocusNode` also plays a roll in shortcut handling: The `Shortcuts` widget 
translates key sequences into an `Intent`, and tries to find the first suitable 
handler for that `Intent` starting from the `BuildContext` the `FocusNode` attaches 
to, to the root of the widget tree. This means an `Actions` widget (which provides 
handlers for differetn `Intent`s) will not be able to handle any shortcut `Intent`s 
when the `BuildContext` that thas the primary focus is above it in the tree.

Previously for `EditableText`, the `FocusNode` was attached to the `BuildContext`
of `EditableTextState`. Any `Actions` widgets defined in `EditableTextState` (which 
will be inflated below the `BuildContext` of the `EditableTextState`) couldn't 
handle shortcuts even when that `EditableText` was focused, for the reason stated 
above.

## Description of change

`EditableTextState` now creates a dedicated `Focus` widget to host `EditableText.focusNode`.
This allows `EditableTextState`s to define handlers for shortcut `Intent`s. For 
instance, `EditableText` now has a handler that handles the "deleteCharacter" intent
when the <kbd>DEL<kbd> key is pressed.

This change does not involve any public API changes but breaks codebases relying on 
that particular implementation detail to tell if a `FocusNode` is associated with a
text input field.

This change does not break any builds but can introduce runtime issues, or
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
`TextField` to a specific value:

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

