---
title: Soft hyphens render at line breaks
description: >-
  Text now shows a hyphen when a line breaks at a soft hyphen (U+00AD),
  and TextStyle.getParagraphStyle has a new hyphens parameter.
---

{% render "docs/breaking-changes.md" %}

## Summary

When a line of text breaks at a soft hyphen (U+00AD),
Flutter now draws a visible hyphen at the end of the line.
A new [`Hyphens`][] enum controls this,
and [`TextStyle.getParagraphStyle`][] has a new `hyphens` parameter.
Classes that override `getParagraphStyle` must add the parameter.

## Background

A soft hyphen marks a place where a word can be broken across lines.
Flutter already broke lines at soft hyphens,
but never drew the hyphen, so broken words looked cut off.

The new `hyphens` parameter on [`Text`][], [`RichText`][], [`TextPainter`][],
and `dart:ui`'s [`ParagraphStyle`][] takes a `Hyphens` value:

* `Hyphens.manual` (the default) draws a hyphen at the break.
* `Hyphens.hidden` doesn't draw a hyphen.
  The soft hyphen is still a place where the line can break.

This change affects apps in two ways.

**Rendering.** Text now shows a hyphen
wherever a line breaks at a soft hyphen.
Lines still break in the same places,
but the hyphen makes its line wider,
so it can change `Paragraph.longestLine` and the size of text
laid out with [`TextWidthBasis.longestLine`][].
Golden image tests that contain such text might need updating.

This applies to all platforms except the web,
where soft hyphens aren't rendered yet.
Editable text, such as `TextField`, and `SelectableText`
also render the hyphen but don't have a `hyphens` parameter yet,
so there's no way to opt out for them.

**API.** `TextStyle.getParagraphStyle` gained an optional `hyphens` parameter.
Because Dart requires an override to accept every parameter
of the method it overrides, a class that overrides `getParagraphStyle`
no longer compiles until it adds the parameter.
This mostly affects test doubles and proxies of `TextStyle`,
not typical app code.

## Migration guide

### Keep the old rendering {: #keep-the-old-rendering }

To keep soft hyphens invisible, pass `Hyphens.hidden`.

Code before migration:

```dart
Text('inter\u00ADnational')
```

Code after migration:

```dart
Text('inter\u00ADnational', hyphens: Hyphens.hidden)
```

### Update overrides of `getParagraphStyle` {: #update-overrides }

If you override `TextStyle.getParagraphStyle`, add the new parameter.

Code before migration:

```dart
@override
ui.ParagraphStyle getParagraphStyle({
  TextAlign? textAlign,
  // ...other parameters...
  StrutStyle? strutStyle,
}) {
  // ...
}
```

Code after migration:

```dart
@override
ui.ParagraphStyle getParagraphStyle({
  TextAlign? textAlign,
  // ...other parameters...
  StrutStyle? strutStyle,
  Hyphens? hyphens,
}) {
  // ...
}
```

If your override forwards to another `getParagraphStyle`
or constructs a `ParagraphStyle`, pass `hyphens` through.
Otherwise, accepting and ignoring the parameter is enough.

## Timeline

Landed in version: 3.49.0-1.0.pre-294<br>
In stable release: Not yet

## References

API documentation:

* [`Hyphens`][]
* [`ParagraphStyle`][]
* [`RichText`][]
* [`Text`][]
* [`TextPainter`][]
* [`TextStyle.getParagraphStyle`][]

Relevant issues:

* [Support soft hyphenation][issue-18443]

Relevant PRs:

* [Support soft hyphen (U+00AD) rendering with a Hyphens API][]

[`Hyphens`]: {{site.api}}/flutter/dart-ui/Hyphens.html
[`ParagraphStyle`]: {{site.api}}/flutter/dart-ui/ParagraphStyle-class.html
[`RichText`]: {{site.api}}/flutter/widgets/RichText-class.html
[`Text`]: {{site.api}}/flutter/widgets/Text-class.html
[`TextPainter`]: {{site.api}}/flutter/painting/TextPainter-class.html
[`TextStyle.getParagraphStyle`]: {{site.api}}/flutter/painting/TextStyle/getParagraphStyle.html
[`TextWidthBasis.longestLine`]: {{site.api}}/flutter/painting/TextWidthBasis.html
[issue-18443]: {{site.repo.flutter}}/issues/18443
[Support soft hyphen (U+00AD) rendering with a Hyphens API]: {{site.repo.flutter}}/pull/185152
