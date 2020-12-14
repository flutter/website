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
use `maxLengthEnforcement` instead of `maxLengthEnforced`, which was deprecated.

## Context

`maxLengthEnforced` used to decide whether text fields should truncate
the inputting value when it reached the `maxLength` limit. Additionally,
`TextField` and `TextFormField` will display a warning message in the
characters counter.

Although `maxLengthEnforced` allow users to control the behavior of the
truncation, so does the `LengthLimitingTextInputFormatter`, they didn't handle
the truncate behavior for CJK (Chinese, Japanese, and Korean) characters
properly, while these characters require the user to type a sequence of Latin
characters to enter one such character, which will cause composing CJK
characters failed to produce proposing characters.

In order to solve the breaking behavior about CJK's truncation, a new tri-state
enum `MaxLengthEnforcement` has introduced, which describes supported strategies
for handling active composing region when applying a
`LengthLimitingTextInutFormatter`. This enum has been added to text fields to
replace the `maxLengthEnforced` parameter. With the new enum parameter,
developers can choose different strategies based on the type of the content
the text field expects.

(For more information, see the docs for [`maxLength`][] and
[`MaxLengthEnforcement`][].)

The default max length truncation behavior is based on the `TargetPlatform`
that you're using or running on.

## Description of change

* Added a `MaxLengthEnforcement` enum as a replacement for the now-deprecated
  boolean `maxLengthEnforced` parameter on `TextField`, `TextFormField`,
  and `CupertinoTextField`.
* The `maxLengthEnforced` property in editable text field classes is deprecated.
* A named optional parameter, `maxLengthEnforcement` is added to
  the `TextField`, `TextFormField`, `CupertinoTextField`,
  and `LengthLimitingTextInputFormatter` classes.
* The default value of the maxLengthEnforced property is inferred based on the
  target platform, to improve the input experience:
  * Android, Windows: defaults to `MaxLengthEnforcement.enforced`.
  * iOS, Web, MacOS, Linux, Fuchsia: defaults to
    `MaxLengthEnforcement.truncateAfterCompositionEnds`.

## Migration guide

The following tips describe how to produce common behaviors, and which behavior
is using on different platforms by default. Notice that the enforcement API is
exposed to `TextField`, `TextFormField`, `CupertinoTextField` and
`LengthLimitingTextInputFormatter`.

_Use the default behavior for the current platform is recommended, since it
won't break someone that is not surposed to input like the behavior that
developers has defined._

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

[PR 63754]: {{site.github}}//flutter/flutter/pull/63754

[PR 68086]: {{site.github}}/flutter/flutter/pull/68086

[`MaxLengthEnforcement` design doc]: /go/max-length-enforcement

[`MaxLengthEnforcement`]: {{site.master-api}}/flutter/services/MaxLengthEnforcement-class.html

[`LengthLimitingTextInputFormatter`]: {{site.master-api}}/flutter/services/LengthLimitingTextInputFormatter-class.html

[`maxLength`]: {{site.master-api}}/flutter/services/LengthLimitingTextInputFormatter/maxLength.html
