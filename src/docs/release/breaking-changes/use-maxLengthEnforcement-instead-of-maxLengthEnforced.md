---
title: Use maxLengthEnforcement instead of maxLengthEnforced
description: Introducing the MaxLengthEnforcement enum.
---

## Summary

_If you don't use the `maxLength` or `maxLengthEnforced` properties in a
`TextField`, `TextFormField`, or `CupertinoTextField`,
or you don't care about the truncation behavior of an
editable text field, you can stop reading._

To control the behavior of `maxLength`
in the `LengthLimitingTextInputFormatter`,
use `maxLengthEnforcement` instead of `maxLengthEnforced`, which is deprecated.

## Context

Before [PR 63754][]: Fix TextField crashed with composing and maxLength set,
the `LengthLimitingTextInputFormatter` always truncated the value in the text
field, which resulted in engine crashes when the composing range sometimes
overflowed. With this change, an editable `TextEditingValue` is not truncated
if only `maxLength` is set, but _is_ truncated after editing is complete.

With [PR 68086][]: Introduce `MaxLengthEnforcement`,
the truncation behavior is now controlled by passing
`maxLengthEnforcement` to the `LengthLimitingTextInputFormatter`,
which is then exposed to the `TextField`, `TextFormField`,
and `CupertinoTextField` widgets.
The `maxLengthEnforced` property is now deprecated.
(For more information, see the docs for [`maxLength`][] and
[`MaxLengthEnforcement`][].)

The default max length truncation behavior is based on the `TargetPlatform`
that you're using or running on.

## Description of change

* Added a `MaxLengthEnforcement` enum, which controls all max length
  limiting behavior.
* The `maxLengthEnforced` property in editable text field classes is deprecated.
* A named optional parameter, `maxLengthEnforcement` is added to
  the `TextField`, `TextFormField`, `CupertinoTextField`,
  and `LengthLimitingTextInputFormatter` classes.
* The default behavior for different platforms is updated, including Android,
  iOS, Web, Windows, MacOS, Linux, and Fuchsia.

## Migration guide

The following tips describe how to produce common behaviors, and which behavior
is using on different platforms by default. Notice that the enforcement API is
exposed to `TextField`, `TextFormField`, `CupertinoTextField` and
`LengthLimitingTextInputFormatter`.

### Platforms behavior

* Android, Windows: `MaxLengthEnforcement.enforced`. The native behavior of
  these platforms is enforced. The composing will be handled by the IME while
  users are entering CJK characters.
* iOS: `MaxLengthEnforcement.truncateAfterCompositionEnds`. iOS has no default
  behavior and it requires users implement the behavior themselves. Allow the
  composition to exceed to avoid breaking CJK input.
* Web, MacOS, Linux, Fuchsia: `MaxLengthEnforcement.truncateAfterCompositionEnds`.
  These platforms allow the composition to exceed by default.

### To enforce the limit all the time

To enforce the limit that always truncate the value when it reaches the limit,
use `MaxLengthEnforcement.enforced` in editable text fields.

Code before migration:

<!-- skip -->
```dart
TextField(maxLength: 6)
```

or 

<!-- skip -->
```dart
TextField(
  maxLength: 6,
  maxLengthEnforced: true,
)
```

Code after migration:

<!-- skip -->
```dart
TextField(
  maxLength: 6,
  maxLengthEnforcement: MaxLengthEnforcement.enforced,
)
```

### To not enforce the limitation

To show a max length error in `TextField`, but _not_ truncate when the limit
is exceed, use `MaxLengthEnforcement.none` instead of
`maxLengthEnforced: false`.

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
  maxLengthEnforcement: MaxLengthEnforcement.none,
)
```

For `CupertinoTextField`, which isn't able to show an error message,
just don't set the `maxLength` value.

Code before migration:

<!-- skip -->
```dart
CupertinoTextField(
  maxLength: 6,
  maxLengthEnforced: false,
)
```

Code after migration:

<!-- skip -->
```dart
CupertinoTextField(
  // Leave it not set.
)
```

### To enforce the limit, but not for composing text

To avoid truncating text while the user is editing, specify
`MaxLengthEnforcement.truncateAfterCompositionEnds`. This behavior allows some
Chinese, Japanese, and Korean (CJK) characters to temporarily ignore the limit
until editing is complete.

Code for the implementation:

<!-- skip -->
```dart
TextField(
  maxLength: 6,
  maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds, // <-- Temporarily lift the limit
)
```

## Timeline

Landed in version: v1.25.0-5.0.pre
In stable release: not yet

## References

Design doc:
* [`MaxLengthEnforcement` design doc][]

API documentation:
* [`MaxLengthEnforcement`][]
* [`LengthLimitingTextInputFormatter`][]
* [`maxLength`][]

Relevant PR:
* [PR 63754][]: Fix TextField crashed with composing and maxLength set
* [PR 68086][]: Introduce `MaxLengthEnforcement`

[PR 63754]: {{site.github.com}}//flutter/flutter/pull/63754

[PR 68086]: {{site.github}}/flutter/flutter/pull/68086

[`MaxLengthEnforcement` design doc]: /go/max-length-enforcement

[`MaxLengthEnforcement`]: {{site.api}}/flutter/services/MaxLengthEnforcement-class.html

[`LengthLimitingTextInputFormatter`]: {{site.api}}/flutter/services/LengthLimitingTextInputFormatter-class.html

[`maxLength`]: {{site.api}}/flutter/services/LengthLimitingTextInputFormatter/maxLength.html
