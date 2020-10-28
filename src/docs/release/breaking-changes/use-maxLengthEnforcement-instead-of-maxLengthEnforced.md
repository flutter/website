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
`maxLengthLimitingEnforcement` to the `LengthLimitingTextInputFormatter`,
which is then exposed to the `TextField`, `TextFormField`,
and `CupertinoTextField` widgets.
The `maxLengthEnforced` property is now deprecated.
(For more information, see the docs for [`maxLength`][] and
[`MaxLengthEnforcement`][].)

The default max length truncation behavior, `MaxLengthEnforcement.enforced`,
always truncates.

## Description of change

* Added a `MaxLengthLimitingEnforcement` enum, which controls all max length
  limiting behavior.
* The `maxLengthEnforced` property in editable text field classes is deprecated.
* A named optional parameter, `maxLengthLimitingEnforcement` is added to
  the `TextField`, `TextFormField`, `CupertinoTextField`,
  and `LengthLimitingTextInputFormatter` classes, which defaults to
  `MaxLengthLimitingEnforcement.enforced`.

## Migration guide

The following tips describe how to produce common behaviors. Notice that
the enforcement API is exposed to `TextField`, `TextFormField`,
`CupertinoTextField` and `LengthLimitingTextInputFormatter`.

### To enforce the limit all the time

To enforce the limit in the most common way, which always truncate the value
when it reaches the limit, use `MaxLengthEnforcement.enforced` or pass only
`maxLength` to editable text fields.

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
TextField(maxLength: 6)
```

or 

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

Landed in version:  v.23.0-18.0.pre
In stable release: not yet

## References

API documentation:
* [`MaxLengthEnforcement`][]
* [`LengthLimitingTextInputFormatter`][]
* [`maxLength`][]

Relevant PR:
* [PR 63754][]: Fix TextField crashed with composing and maxLength set
* [PR 68086][]: Introduce `MaxLengthEnforcement`

[PR 63754]: {{site.github.com}}//flutter/flutter/pull/63754

[PR 68086]: {{site.github}}/flutter/flutter/pull/68086

[`MaxLengthEnforcement`]: {{site.api}}/flutter/services/MaxLengthEnforcement-class.html

[`LengthLimitingTextInputFormatter`]: {{site.api}}/flutter/services/LengthLimitingTextInputFormatter-class.html

[`maxLength`]: {{site.api}}/flutter/services/LengthLimitingTextInputFormatter/maxLength.html
