---
title: Use maxLengthEnforcement instead of maxLengthEnforced
description: Introduing MaxLengthEnforcement enum.
---

## Summary

_If you didn't use `maxLengthEnforced` in `TextField`/`TextFormField`/`CupertinoTextField`, or you don't care about the truncate behavior for the composing text editing value, you can stop reading._

To control the behavior of `maxLength` in the `LengthLimitingTextInputFormatter`, use `maxLengthEnforcement` instead of `maxLengthEnforced`, and `maxLengthEnforced` is deprecated.

## Context

Before [the first PR][Fix TextField crashed with composing and maxLength set], `LengthLimitingTextInputFormatter` will always truncate the editing value, which may leads to engine crashes when the composing range is overflowed sometimes. With this changes, a composing `TextEditingValue` will not be truncated if only `maxLength` set, and still be truncated after the composing ends (See [`maxLength` documentation][] for more specific behavior). But it's not optional.

With [the second PR][Introduce `MaxLengthEnforcement`], all behaviors of max length limiting will be controlled by passing `maxLenghLimitingEnforcement` to the `LengthLimitingTextInputFormatter`. It's also exposed to `TextField`/`TextFormField`/`CupertinoTextField`. Since then, `maxLengthEnforced` is deprecated. (See also: [`MaxLengthEnforcement` documentation][`MaxLengthEnforcement`] .)

## Description of change

* Add `MaxLenghLimitingEnforcement` enum, which controlls all max length limiting behavious.
* `maxLengthEnforced` in text fields is deprecated.
* A composing `TextEditingValue` will skip the `maxLength` limit by default.
* A named optional parameter `maxLenghLimitingEnforcement` has been added to the `TextField`/`TextFormField`/`CupertinoTextField`/`LengthLimitingTextInputFormatter`, defaults to `MaxLengthLimitingEnforcement.regular`.

## Migration guide

### Not enforces limitation

If you want a max length warning, but not truncate when it's exceed the limitation, use `MaxLengthEnforcement.warningOnly` instead of `maxLengthEnforced: false`.

Code before migration:

<!-- skip -->
```dart
TextField(
  maxLength: 6,
  maxLengthEnforced: false,
)
```

Code after migration:

<!-- skip -->
```dart
TextField(
  maxLength: 6,
  maxLengthEnforcement: MaxLengthEnforcement.warningOnly,
)
```

### Limit composing

If you still want to limit all kinds of inputting value (such as "verification code"), you should use `MaxLengthEnforcement.truncateComposing` from now.

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
  maxLength: 6,
  maxLengthEnforcement: MaxLengthEnforcement.truncateComposing, // <-- Enforce truncate
)
```

## Timeline

The first change was made in August of 2020 after the 1.22.0-1.0.pre release.
The second change was made in October of 2020 after the v1.23.0-18.0.pre release.

## References

API documentation:
* [`MaxLengthEnforcement`][]
* [`LengthLimitingTextInputFormatter`][]

Relevant PR:
* [Fix TextField crashed with composing and maxLength set][]
* [Introduce `MaxLengthEnforcement`][]

[`MaxLengthEnforcement`]: {{site.api}}/flutter/services/MaxLengthEnforcement-class.html

[`LengthLimitingTextInputFormatter`]: {{site.api}}/flutter/services/LengthLimitingTextInputFormatter-class.html

[`maxLength` documentation]: {{site.api}}/flutter/services/LengthLimitingTextInputFormatter/maxLength.html

[Fix TextField crashed with composing and maxLength set]: {{site.github}}/flutter/flutter/pull/63754

[Introduce `MaxLengthEnforcement`]: {{site.github}}/flutter/flutter/pull/68086
