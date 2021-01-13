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

The `maxLengthEnforced` parameter was used to decide whether text fields should
truncate the input value when it reaches the `maxLength` limit. Additionally,
`TextField` and `TextFormField` will display a warning message in the
characters counter when this parameter is set to false and the length of the
user input exceeds `maxLength`.

However, to enter CJK characters, some input methods require the user to enter
a sequence of Latin characters into the text field, then turn this sequence
into desired CJK characters
(this process will later be referred to as *text composition*).
The Latin sequence is usually longer than the resulting CJK characters,
so setting a hard maximum character limit on a text field may give an
unpleasant input experience if the user uses one of these input methods,
as the user may not be able to finish the text composition normally due to the
maxLength character limit.

Text composition is generally used by the input method to indicate that the
text within the highlighted composing region is being actively edited.
It may also be used when entering regular Latin characters. For example,
Gboard's English keyboard on Android
(as with many other input methods on Android) puts the currently English word
in a composing region.

To improve the input experience in these scenarios, a new tri-state enum
`MaxLengthEnforcement` was introduced, which describes supported strategies
for handling active composing region when applying a
`LengthLimitingTextInutFormatter`. This enum has been added to text fields to
replace the `maxLengthEnforced` parameter. With the new enum parameter,
developers can choose different strategies based on the type of the content
the text field expects.

(For more information, see the docs for [`maxLength`][] and
[`MaxLengthEnforcement`][].)

The default value of the `maxLengthEnforcement` parameter is inferred from the
`TargetPlatform` of the application, to confirm to the platform's conventions.

## Description of change

* Added a `MaxLengthEnforcement` enum as a replacement for the now-deprecated
  boolean `maxLengthEnforced` parameter on `TextField`, `TextFormField`,
  `CupertinoTextField`, and `LengthLimitingTextInputFormatter` classes.
* The default value of the maxLengthEnforced property is inferred based on the
  target platform, to improve the input experience:
  * Android, Windows: defaults to `MaxLengthEnforcement.enforced`.
  * iOS, Web, MacOS, Linux, Fuchsia: defaults to
    `MaxLengthEnforcement.truncateAfterCompositionEnds`.

## Migration guide

_Use the default behavior for the current platform is recommended, since it
won't break someone that is not surposed to input like the behavior that
developers has defined._

### Default values of `maxLengthEnforcement`

* Android, Windows: `MaxLengthEnforcement.enforced`. The native behavior of
  these platforms is enforced. The inputting value will be truncated whether
  the user is entering with composition or not.
* iOS, MacOS: `MaxLengthEnforcement.truncateAfterCompositionEnds`.
  iOS and MacOS has no default behavior and it requires users implement the
  behavior themselves. Allow the composition to exceed to avoid breaking CJK
  input.
* Web, Linux, Fuchsia: `MaxLengthEnforcement.truncateAfterCompositionEnds`.
  These platforms allow the composition to exceed by default.

### To enforce the limit all the time

To enforce the limit that always truncate the value when it reaches the limit
(e.g. entering verfication code), use `MaxLengthEnforcement.enforced` in
editable text fields.

_This option may give suboptimal user experience when used with input methods
that rely on text composition. Consider using the `truncateAfterCompositionEnds`
option when the text field expects arbitrary user input which may contain CJK
characters. See [Context](#Context) section for more information._

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
is exceeded, use `MaxLengthEnforcement.none` instead of
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

To avoid truncating text while the user is inputting text via composition,
specify `MaxLengthEnforcement.truncateAfterCompositionEnds`. This behavior
allows some Chinese, Japanese, and Korean (CJK) characters to temporarily
ignore the limit until editing is complete.

_Gboard's English keyboard on Android (and many other Android input methods)
creates a composing region for the current English word being entered. When
used in a `truncateAfterCompositionEnds` text field, the user may not be
stopped right away at the `maxLength` limit. Consider the `enforced` option
if the text field does not expect CJK characters on a phonetic keyboard._

Code for the implementation:

<!-- skip -->
```dart
TextField(
  maxLength: 6,
  maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds, // <-- Temporarily lift the limit
)
```

## Timeline

Landed in version: v1.26.0-1.0.pre
In stable release: not yet

## References

Design doc:
* [`MaxLengthEnforcement` design doc][]

API documentation:
* [`MaxLengthEnforcement`][]
* [`LengthLimitingTextInputFormatter`][]
* [`maxLength`][]

Relevant issues:
* [Issue 63753][]
* [Issue 67898][]

Relevant PR:
* [PR 63754][]: Fix TextField crashed with composing and maxLength set
* [PR 68086][]: Introduce `MaxLengthEnforcement`

[`MaxLengthEnforcement` design doc]: /go/max-length-enforcement

[`MaxLengthEnforcement`]: {{site.master-api}}/flutter/services/MaxLengthEnforcement-class.html

[`LengthLimitingTextInputFormatter`]: {{site.master-api}}/flutter/services/LengthLimitingTextInputFormatter-class.html

[`maxLength`]: {{site.master-api}}/flutter/services/LengthLimitingTextInputFormatter/maxLength.html

[Issue 63753]: {{site.github}}/flutter/flutter/issues/63753

[Issue 67898]: {{site.github}}/flutter/flutter/issues/67898

[PR 63754]: {{site.github}}//flutter/flutter/pull/63754

[PR 68086]: {{site.github}}/flutter/flutter/pull/68086