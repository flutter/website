title: Deprecate TextInputConnection.setStyle
description: >-
  Syncs text metrics via `TextInputConnection.updateStyle` to fix IME and
  selection alignment. Deprecates `setStyle`.
---

{% render "docs/breaking-changes.md" %}

## Summary

`TextInputConnection.setStyle` is deprecated in favor of
`TextInputConnection.updateStyle`, which supports synchronizing
`letterSpacing`, `wordSpacing`, and `lineHeight` to the engine.

## Context

The previous `setStyle` method did not support `letterSpacing`, `wordSpacing`,
or `lineHeight`. This caused visual misalignment of the selection highlight
and IME caret when these properties were used.

The replacement `updateStyle` method (via `TextInputStyle`) supports these
properties, ensuring the system input is synchronized with the rendered text.

## Migration guide

Authors of custom text input clients should replace calls to
`TextInputConnection.setStyle` with `TextInputConnection.updateStyle`.

### Code before migration:

```dart
connection.setStyle(
  fontFamily: 'Roboto',
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  textDirection: TextDirection.ltr,
  textAlign: TextAlign.start,
);
```

### Code after migration:

```dart
connection.updateStyle(
  TextInputStyle(
    fontFamily: 'Roboto',
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.start,
    letterSpacing: 1.2,
    wordSpacing: 1.0,
    lineHeight: 1.5,
  ),
);
```

## Timeline

Landed in version: TBD<br>
In stable release: Not yet

## References

Relevant PR:

* [PR 180436][]

Relevant issues:

* [Issue 161592][]

<!-- Stable channel link: -->
[PR 180436]: {{site.repo.flutter}}/pull/180436
[Issue 161592]: {{site.repo.flutter}}/issues/161592
