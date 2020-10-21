---
title: Use maxLengthEnforcement instead of maxLengthEnforced
description: Introduing the MaxLengthEnforcement enum.
---

## Summary

_If you don't use the `maxLength` or `maxLengthEnforced` properties in a
`TextField`, `TextFormField`, or `CupertinoTextField`,
or you don't care about the truncation behavior of an
eidtable text field, you can stop reading._

To control the behavior of `maxLength`
in the `LengthLimitingTextInputFormatter`,
use `maxLengthEnforcement` instead of `maxLengthEnforced`, which is deprecated.

## Context

Before [PR 63754][]: Fix TextField crashed with composing and maxLength set,
the `LengthLimitingTextInputFormatter` always truncated the editing value,
which resulted in engine crashes when the composing range sometimes overflowed.
With this change, an editable `TextEditingValue` is not truncatedif only
`maxLength` is set, but _is_ truncated after editing is complete.
(For more specific behavior, see the [`maxLength` documentation][].)

With [PR 68086][]: Introduce `MaxLengthEnforcement`,
the truncation behavior is now controlled by passing
`maxLengthLimitingEnforcement` to the `LengthLimitingTextInputFormatter`,
which is then exposed to the `TextField`, `TextFormField`,
and `CupertinoTextField` widgets.
The `maxLengthEnforced` property is now deprecated.
(For more information, see the docs for[`MaxLengthEnforcement`] .)

The default max length truncation behavior is truncate all the time,
which is `MaxLengthEnforcement.enforced`.

## Description of change

* Added a `MaxLengthLimitingEnforcement` enum, which controls all max length
  limiting behavior.
* The `maxLengthEnforced` property in editable text field classes is deprecated.
* A named optional parameter, `maxLenghLimitingEnforcement` is added to
  the `TextField`, `TextFormField`, `CupertinoTextField`,
  and `LengthLimitingTextInputFormatter` classes, which defaults to
  `MaxLengthLimitingEnforcement.enforced`.

## Migration guide

The following tips describe how to emit a warning, but not truncate,
on entering text, and how to truncating as text is entered.

### Not enforces limitation

To print a max length warning in `TextField`, but _not_ truncate the limit
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

For `CupertinoTextField`, simply do not set the `maxLength` value.

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

### Unenforce composing

If you want to exempt inputting value when it's still editing (composing),
you should use `MaxLengthEnforcement.allowComposingTextToFinish` from now.
This behavior allows some CJK characters temporary ignore the limitation
until it finishes entering.

Code for the implementation:

<!-- skip -->
```dart
TextField(
  maxLength: 6,
  maxLengthEnforcement: MaxLengthEnforcement.allowComposingTextToFinish, // <-- Temporary lift the limit
)
```

## Timeline

Landed in version:  v.23.0-18.0.pre
In stable release: not yet

## References

API documentation:
* [`MaxLengthEnforcement`][]
* [`LengthLimitingTextInputFormatter`][]

Relevant PR:
* [PR 63754][]: Fix TextField crashed with composing and maxLength set
* [PR 68086][]: Introduce `MaxLengthEnforcement`

[PR 63754]: {{site.github.com}}//flutter/flutter/pull/63754

[PR 68086]: {{site.github}}/flutter/flutter/pull/68086

[`MaxLengthEnforcement`]: {{site.api}}/flutter/services/MaxLengthEnforcement-class.html

[`LengthLimitingTextInputFormatter`]: {{site.api}}/flutter/services/LengthLimitingTextInputFormatter-class.html

[`maxLength` documentation]: {{site.api}}/flutter/services/LengthLimitingTextInputFormatter/maxLength.html
