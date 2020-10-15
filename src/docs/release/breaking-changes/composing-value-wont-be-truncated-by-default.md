---
title: Composing value won't be truncated by default
description: A composing value won't be truncated in LengthLimitingTextInputFormatter by default.
---

## Summary

A composing `TextEditingValue` won't be truncated in `LengthLimitingTextInputFormatter` by default. If you want to truncate the composing value, pass a `LengthLimitingTextInputFormatter` with `composingMaxLengthEnforced` set to `true` rather than set `maxLength` only.

## Context

Before [the first PR][Fix TextField crashed with composing and maxLength set], `LengthLimitingTextInputFormatter` will always truncate the editing value, which may leads to engine crashes when the composing range is overflowed sometimes. With this changes, a composing `TextEditingValue` will not be truncated if only `maxLength` set, and still be truncated after the composing ends (See [`maxLength` documentation] for more specific behavior). But it's not optional.

With [the second PR][Add `composingMaxLengthEnforced` to length limiting formatter], this behavior can be enabled/disabled by passing `composingMaxLengthEnforced` to the `LengthLimitingTextInputFormatter`.

## Description of change

* A composing `TextEditingValue` will skip the `maxLength` limit.
* An named optional parameter `composingMaxLengthEnforced` has been added to the `LengthLimitingTextInputFormatter`, defaults to `false`.

## Migration guide

If you still want to limit all kinds of inputting value (such as "verification code"), you need a separate `LengthLimitingTextInputFormatter` rather than set the `maxLength` only.

Code before migration:

<!-- skip -->
```dart
TextField(
  maxLength: 6,
)
```

Code after migration:

<!-- skip -->
```dart
TextField(
  inputFormatters: <TextInputFormatter>[
    LengthLimitingTextInputFormatter(
      6,
      composingMaxLengthEnforced: true, // <-- Enforce truncate
    ),
  ],
)
```

## Timeline

The first change was made in August of 2020 after the 1.22.0-1.0.pre release.
The second change was made in October of 2020 after the v1.23.0-18.0.pre release.

## References

API documentation:
* [`LengthLimitingTextInputFormatter`][]

Relevant PR:
* [Fix TextField crashed with composing and maxLength set][]
* [Add `composingMaxLengthEnforced` to length limiting formatter][]

[`LengthLimitingTextInputFormatter`]: {{site.api}}/flutter/services/LengthLimitingTextInputFormatter-class.html

[`maxLength` documentation]: {{site.api}}/flutter/services/LengthLimitingTextInputFormatter/maxLength.html

[Fix TextField crashed with composing and maxLength set]: {{site.github}}/flutter/flutter/pull/63754

[Add `composingMaxLengthEnforced` to length limiting formatter]: {{site.github}}/flutter/flutter/pull/68086
