---
title: The RenderEditable needs to be laid out before hit testing
description: The hit testing of RenderEditable requires additional information that is only available after the layout.
---

## Summary

The `RenderEditable` needs to be laid out in order to process hit
testing; Otherwise, the framework throws an assertion error indicates
the `RenderEditable` has not been laid out.
`Failed assertion: line xxxx pos xx: '!debugNeedsLayout': is not true.`

## Context

To support gesture recognizers in selectable text, the
`RenderEditable` requires the layout information about the
text spans to determine which text span receive the
pointer event. Therefore, we made the layout to be a hard
requirement for performing the hit testing to the
`RenderEditable`.

## Description of change

The `RenderEditable` needs to be laid out before hit testing.

## Migration guide

If you are seeing `'!debugNeedsLayout': is not true.` assertion error while hit testing the
`RenderEditable`, make sure to layout the `RenderEditable` before doing so.

Code before migration:

<!-- skip -->
```dart
test('attach and detach correctly handle gesture', () {
  final RenderEditable editable = RenderEditable(
    //...
  );
  final PipelineOwner owner = PipelineOwner(onNeedVisualUpdate: () { });
  editable.attach(owner);
  // This should throw an assertion error because the render editable has not been laid out.
  editable.handleEvent(const PointerDownEvent(), BoxHitTestEntry(editable, const Offset(10,10)));
  editable.detach();
});
```

Code after migration:

<!-- skip -->
```dart
test('attach and detach correctly handle gesture', () {
  final RenderEditable editable = RenderEditable(
    //...
  );
  // Layouts the render editable first.
  editable.layout(BoxConstraints.loose(const Size(1000.0, 1000.0)));

  final PipelineOwner owner = PipelineOwner(onNeedVisualUpdate: () { });
  editable.attach(owner);
  editable.handleEvent(const PointerDownEvent(), BoxHitTestEntry(editable, const Offset(10,10)));
  editable.detach();
});
```

## Timeline

This change landed in v1.18.0.

## References

API documentation:
* [`RenderEditable`][]

Relevant issue:
* [Issue 43494: SelectableText.rich used along with TapGestureRecognizer is not working][]

Relevant PR:
* [PR 54479: Enable gesture recognizer in selectable rich text][]


[Issue 43494: SelectableText.rich used along with TapGestureRecognizer is not working]: {{site.github}}/flutter/flutter/issues/43494
[`RenderEditable`]: {{site.api}}/flutter/rendering/RenderEditable-class.html
[PR 54479: Enable gesture recognizer in selectable rich text]: {{site.github}}/flutter/flutter/pull/54479

