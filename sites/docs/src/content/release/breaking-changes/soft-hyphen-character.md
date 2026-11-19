---
title: TextStyle.getParagraphStyle has a new hyphenCharacter parameter
description: >-
  Apps can choose the string drawn at a soft hyphen line break,
  and classes that override TextStyle.getParagraphStyle
  must accept a new hyphenCharacter parameter.
---

{% render "docs/breaking-changes.md" %}

## Summary

A new `hyphenCharacter` parameter chooses the string drawn
at the end of a line that breaks at a soft hyphen (U+00AD).
[`TextStyle.getParagraphStyle`][] has the new parameter,
so classes that override `getParagraphStyle` must add it.
Rendering doesn't change unless you set the parameter.

## Background

When a line breaks at a soft hyphen,
Flutter draws a hyphen-minus ("-") at the end of the line,
as described in [Soft hyphens render at line breaks][].
Some languages and designs need a different string there,
such as a Unicode hyphen (U+2010) or nothing at all.

The new `hyphenCharacter` parameter on [`Text`][], [`RichText`][],
[`TextPainter`][], and `dart:ui`'s [`ParagraphStyle`][]
takes the string to draw:

* `null` (the default) draws a hyphen-minus, as before.
* A non-empty string is drawn instead.
  Line breaking leaves room for it,
  so a longer string can move a break earlier.
* The empty string draws nothing,
  but the line still breaks at the soft hyphen.

The string is shaped in the style of the text before it,
so keep it short and make sure that text's font supports it.
It has no effect when `hyphens` is `Hyphens.hidden`.
Widgets built on `EditableText`, such as `TextField` and `SelectableText`,
don't have a `hyphenCharacter` parameter yet.

`TextStyle.getParagraphStyle` gained an optional
`hyphenCharacter` parameter.
Because Dart requires an override to accept every parameter
of the method it overrides, a class that overrides `getParagraphStyle`
no longer compiles until it adds the parameter.
This mostly affects test doubles and proxies of `TextStyle`,
not typical app code.

## Migration guide

If you override `TextStyle.getParagraphStyle`, add the new parameter.

Code before migration:

```dart
@override
ui.ParagraphStyle getParagraphStyle({
  TextAlign? textAlign,
  // ...
  Hyphens? hyphens,
  Locale? locale,
  // ...other parameters...
}) {
  // ...
}
```

Code after migration:

```dart
@override
ui.ParagraphStyle getParagraphStyle({
  TextAlign? textAlign,
  // ...
  Hyphens? hyphens,
  String? hyphenCharacter,
  Locale? locale,
  // ...other parameters...
}) {
  // ...
}
```

If your override forwards to another `getParagraphStyle`
or constructs a `ParagraphStyle`, pass `hyphenCharacter` through.
Otherwise, accepting and ignoring the parameter is enough.

## Timeline

Landed in version: Not yet<br>
In stable release: Not yet

## References

API documentation:

* [`ParagraphStyle`][]
* [`RichText`][]
* [`Text`][]
* [`TextPainter`][]
* [`TextStyle.getParagraphStyle`][]

Relevant issues:

* [Support customizing the soft-hyphen character/string][issue-189617]

Relevant PRs:

* [Add ParagraphStyle.hyphenCharacter to dart:ui][pr-195345]
* [Add hyphenCharacter to TextPainter, RenderParagraph, RichText and Text][pr-196152]

[Soft hyphens render at line breaks]: /release/breaking-changes/soft-hyphen-rendering
[`ParagraphStyle`]: {{site.api}}/flutter/dart-ui/ParagraphStyle-class.html
[`RichText`]: {{site.api}}/flutter/widgets/RichText-class.html
[`Text`]: {{site.api}}/flutter/widgets/Text-class.html
[`TextPainter`]: {{site.api}}/flutter/painting/TextPainter-class.html
[`TextStyle.getParagraphStyle`]: {{site.api}}/flutter/painting/TextStyle/getParagraphStyle.html
[issue-189617]: {{site.repo.flutter}}/issues/189617
[pr-195345]: {{site.repo.flutter}}/pull/195345
[pr-196152]: {{site.repo.flutter}}/pull/196152
