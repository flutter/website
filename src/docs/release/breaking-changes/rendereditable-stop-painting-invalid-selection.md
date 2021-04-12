---
title: Change RenderEditable to stop painting the caret when its selection is invalid
description: RenderEditable no longer paints the caret when its selection is invalid.
---

## Summary

When a text field's selection is `TextSelection.collapsed(offset: -1)`, or 
a different range that contains negative positions, `RenderEditable` no 
longer paints the caret or calls`onCaretChanged`.

## Context

The caret indicates the insertion point within the current text in an 
active input field. Typically, when a new character is entered, the 
caret stays immediately after it. In Flutter the caret position is 
represented by a collapsed selection. An invalid selection is a selection
that contains negative text positions, such as `(-1, -1)`. When the 
selection is invalid (which, for example, can happen when you omit the 
`selection` argument when creating a `TextEditingValue`), usually the 
user won't be able to modify or add text until they change the selection 
to a valid value via touch events or mouse interactions.

The `RenderEditable` class is used to paint all types of text fields
in Flutter today. Previously, `RenderEditable` paints the caret at 
the start of the the document when the selection is invalid, as if the 
selection was set to `(0, 0)`. This can be misleading as the 
user would expect new input to be inserted at the start of the document, 
which may not be the case for some input methods. The incorrect coordinates 
of the caret are also reported by the `RenderEditable.onCaretChanged` 
callback.

## Description of change

When `RenderEditable.selection` is set to `TextSelection.collapsed(offset: -1)`, 
`RenderEditable.paint` no longer paints the caret, and the 
`RenderEditable.onCaretChanged` callback is no longer called on this occasion.

## Migration guide

Common failures this change may introduce are golden test failures where:
  - The caret is not shown when a text field's selection is invalid.
  - The scroll offsest of a scrollable container is different (because text fields currently rely on coordinates reported by the`RenderEditable.onCaretChanged` callback to keep themselves on screen as the user types).
  
If you wish to place the caret at the start of a text field, set its
`TextEditingController`'s `selection` to `(0, 0)`:

Code before migration:

<!-- skip -->
```dart
textEditingController.value = TextEditingValue(
  text: <your text>,
  selection: TextSelection.collapsed(offset: -1),
);
```

Code after migration:

<!-- skip -->
```dart
textEditingController.value = TextEditingValue(
  text: <your text>,
  selection: TextSelection.collapsed(offset: 0),
);
```

## Timeline

Landed in version: TBA<br>
In stable release: not yet

## References

{% include master-api.md %}

API documentation:

* [`RenderEditable`][]
* [`RenderEditable.selection`][]
* [`RenderEditable.onCaretChanged`][]

Relevant issues:

* [Issue 79495]

Relevant PRs:

* [Dont paint caret when selection is invalid]


<!-- Master channel link: -->

[`RenderEditable`]: https://master-api.flutter.dev/flutter/rendering/RenderEditable-class.html
[`RenderEditable.selection`]: https://master-api.flutter.dev/flutter/rendering/RenderEditable/selection.html
[`RenderEditable.onCaretChanged`]: https://master-api.flutter.dev/flutter/rendering/RenderEditable/onCaretChanged.html

[Issue 79495]: {{site.github}}/flutter/flutter/issues/79495
[Dont paint caret when selection is invalid]: {{site.github}}/flutter/flutter/pull/79607
