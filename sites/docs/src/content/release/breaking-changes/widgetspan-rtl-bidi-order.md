---
title: WidgetSpan order in right-to-left text
description: >-
  WidgetSpans now follow bidirectional visual order in right-to-left text.
  Remove workarounds that compensated for the previous layout.
---

{% render "docs/breaking-changes.md" %}

## Summary

`WidgetSpan`s in right-to-left (RTL) and mixed-direction text
now follow the visual order determined by the Unicode bidirectional algorithm.
Apps that compensated for the previous incorrect order
can display inline widgets in the wrong positions after upgrading.

## Background

Skia's paragraph layout previously placed inline widget placeholders
in source order, even when the surrounding text was visually reordered.
This caused inline widgets in Arabic, Hebrew, and mixed-direction text
to appear in the wrong positions.

The fix places placeholders in bidirectional visual order.
Placeholder boxes remain associated with widgets in logical insertion order;
their coordinates reflect the corrected positions.
No public API signatures changed.

The following example shows the corrected positions of inline widgets
in mixed-direction text:

| Before | After |
| :---: | :---: |
| ![Incorrect widget order][before] | ![Correct widget order][after] |

## Migration guide

If your app uses `WidgetSpan`s without compensating for the old layout,
no code changes are needed.
Otherwise, remove workarounds added specifically for this issue:

* `Transform.translate` offsets and `GlobalKey`-based code that
  measured and swapped widgets on the same line.
* Reversing the source order of `WidgetSpan`s for RTL text.
  Keep spans in the logical order of the content and let text layout
  determine their visual positions.
* Mirroring placeholder-box x-coordinates in custom layout code.
  Use the returned coordinates directly.

For example, remove a translation that compensated for the old RTL order.
Here, `rtlSwapOffset` is an offset calculated by the app's workaround,
and `inlineWidget` is the widget embedded in the text.

Code before migration:

```dart
WidgetSpan(
  child: Transform.translate(
    offset: rtlSwapOffset,
    child: inlineWidget,
  ),
)
```

Code after migration:

```dart
WidgetSpan(child: inlineWidget)
```

Also remove the code that calculated the compensating offsets.
Check RTL and mixed-direction text, including wrapped lines,
and update golden tests that captured the incorrect layout.

## Timeline

Landed in version: 3.50.0-0.1.pre<br>
In stable release: Not yet

## References

GitHub issue:

* [Issue 54400][]

Relevant PRs:

* [Skia CL 1366676][]

[after]: /assets/images/docs/breaking-changes/widgetspan-rtl-after.png
[before]: /assets/images/docs/breaking-changes/widgetspan-rtl-before.png
[Issue 54400]: {{site.repo.flutter}}/issues/54400
[Skia CL 1366676]: https://skia-review.googlesource.com/c/skia/+/1366676
