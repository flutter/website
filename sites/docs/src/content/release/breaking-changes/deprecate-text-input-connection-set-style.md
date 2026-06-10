---
title: Deprecate `TextInputConnection.setStyle`
description: >-
  The `TextInputConnection.setStyle` method has been deprecated
  in favor of the `TextInputConnection.updateStyle` method.
---

{% render "docs/breaking-changes.md" %}

## Summary

`TextInputConnection.setStyle` is deprecated in favor of
`TextInputConnection.updateStyle`, which supports synchronizing
`letterSpacing`, `wordSpacing`, and `lineHeight` to the engine.

## Context

The previous `setStyle` method didn't support `letterSpacing`, `wordSpacing`,
or `lineHeight`. This caused visual misalignment of the selection highlight
and IME caret when these properties were used.

The replacement `updateStyle` method uses
`TextInputStyle` to support these properties,
ensuring the system input is synchronized with the rendered text.

## Migration guide

If you author a custom text input client,
replace calls to `TextInputConnection.setStyle`
with `TextInputConnection.updateStyle`.

### Code before migration

```dart
connection.setStyle(
  fontFamily: 'Roboto',
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  textDirection: TextDirection.ltr,
  textAlign: TextAlign.start,
);
```

### Code after migration

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

Landed in version: 3.43.0-0.1.pre<br>
In stable release: 3.44

## References

Relevant PR:

* [Fix IME and selection by syncing more text styles][pr-180436]

Relevant issues:

* [Incorrect position of Japanese predictive conversion popup in TextFormField using maxLines on the Web][issue-161592]

[pr-180436]: {{site.repo.flutter}}/pull/180436
[issue-161592]: {{site.repo.flutter}}/issues/161592
