---
title: Use maxLengthEnforcement instead of maxLengthEnforced
description: Introducing the MaxLengthEnforcement enum.
---

## Summary

To control the behavior of `maxLength` in the
`LengthLimitingTextInputFormatter`, use `maxLengthEnforcement`
instead of the now-deprecated `maxLengthEnforced`.

## Context

The `maxLengthEnforced` parameter was used to decide
whether text fields should truncate the input value
when it reaches the `maxLength` limit, or whether
(for `TextField` and `TextFormField`)
a warning message should instead be shown in the
character count when the length of the user input
exceeded `maxLength`.

However, to enter CJK characters, some input methods
require the user to enter a sequence of Latin characters
into the text field, then turn this sequence
into desired CJK characters (a referred to as *text composition*).
The Latin sequence is usually longer than the resulting CJK characters,
so setting a hard maximum character limit on a text field may mean
the user is unable to finish the text composition normally due to the
`maxLength` character limit.

Text composition is also used by some input methods to
indicate that the text within the highlighted composing
region is being actively edited, even when entering
Latin characters. For example, Gboard's English keyboard on Android
(as with many other input methods on Android) puts the current word
in a composing region.

To improve the input experience in these scenarios,
a new tri-state enum, `MaxLengthEnforcement`, was introduced.
Its values describe supported strategies for handling
active composing regions when applying a
`LengthLimitingTextInutFormatter`.
A new `maxLengthEnforcement` parameter that uses
this enum has been added to text fields to replace
the boolean `maxLengthEnforced` parameter.
With the new enum parameter,
developers can choose different strategies
based on the type of the content the text field expects.

For more information, see the docs for [`maxLength`][] and
[`MaxLengthEnforcement`][].

The default value of the `maxLengthEnforcement`
parameter is inferred from the `TargetPlatform`
of the application, to conform to the platform's conventions:

## Description of change

* Added a `maxLengthEnforcement` parameter using the
  new enum type `MaxLengthEnforcement`,
  as a replacement for the now-deprecated boolean
  `maxLengthEnforced` parameter on
  `TextField`, `TextFormField`, `CupertinoTextField`, and
  `LengthLimitingTextInputFormatter` classes.

## Migration guide

_Using the default behavior for the current platform is recommended,
since this will be the behavior most familiar to the user._

### Default values of `maxLengthEnforcement`

* Android, Windows: `MaxLengthEnforcement.enforced`.
  The native behavior of these platforms is enforced.
  The inputting value will be truncated whether
  the user is entering with composition or not.
* iOS, MacOS: `MaxLengthEnforcement.truncateAfterCompositionEnds`.
  These platforms do not have a "maximum length"
  feature and therefore require that developers implement
  the behavior themselves. No standard convention seems
  to have evolved on these platforms. We have chosen
  to allow the composition to exceed the maximum length
  to avoid breaking CJK input.
* Web and Linux: `MaxLengthEnforcement.truncateAfterCompositionEnds`.
  While there is no standard on these platforms
  (and many implementation exist with conflicting behavior),
  the common convention seems to be to allow the composition
  to exceed the maximum length by default.
* Fuchsia: `MaxLengthEnforcement.truncateAfterCompositionEnds`.
  There is no platform convention on this platform yet,
  so we have chosen to default to the convention that is
  least likely to result in data loss.

### To enforce the limit all the time

To enforce the limit that always truncate the value when
it reaches the limit (for example, when entering a
verification code), use `MaxLengthEnforcement.enforced` in
editable text fields.

_This option may give suboptimal user experience when used
with input methods that rely on text composition.
Consider using the `truncateAfterCompositionEnds`
option when the text field expects arbitrary user input
which may contain CJK characters.
See the [Context](#context) section for more information._

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

To show a max length error in `TextField`,
but _not_ truncate when the limit is exceeded,
use `MaxLengthEnforcement.none` instead of
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
CupertinoTextField()
```

### To enforce the limit, but not for composing text

To avoid truncating text while the user is inputting text
by using composition, specify
`MaxLengthEnforcement.truncateAfterCompositionEnds`.
This behavior allows input methods that use composing
regions larger than the resulting text,
as is common for example with Chinese, Japanese,
and Korean (CJK) text, to temporarily
ignore the limit until editing is complete.

_Gboard's English keyboard on Android
(and many other Android input methods)
creates a composing region for the word being entered.
When used in a `truncateAfterCompositionEnds` text field,
the user won't be stopped right away at the `maxLength` limit.
Consider the `enforced` option if you are confident that
the text field will not be used with input methods
that use temporarily long composing regions such as CJK text._

Code for the implementation:

<!-- skip -->
```dart
TextField(
  maxLength: 6,
  maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds, // Temporarily lifts the limit.
)
```

### Be wary of assuming input will not use composing regions

It is tempting when targeting a particular locale to assume
that all users will be satisfied with input from that locale.
For example, forum software targeting an English-language
community might be assumed to only need to deal with English
text. However, this kind of assumption is often incorrect.
For example, maybe the English-language forum participants
will want to discuss Japanese anime or Vietnamese cooking.
Maybe one of the participants is Korean and prefers to express
their name in their native ideographs. For this reason,
freeform fields should rarely use the `enforced` value
and should instead prefer the
`truncateAfterCompositionEnds` value if at all possible.

## Timeline

Landed in version: v1.26.0-1.0.pre<br>
In stable release: 2.0.0

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

[`MaxLengthEnforcement`]: {{site.api}}/flutter/services/MaxLengthEnforcement-class.html

[`LengthLimitingTextInputFormatter`]: {{site.api}}/flutter/services/LengthLimitingTextInputFormatter-class.html

[`maxLength`]: {{site.api}}/flutter/services/LengthLimitingTextInputFormatter/maxLength.html

[Issue 63753]: {{site.github}}/flutter/flutter/issues/63753

[Issue 67898]: {{site.github}}/flutter/flutter/issues/67898

[PR 63754]: {{site.github}}//flutter/flutter/pull/63754

[PR 68086]: {{site.github}}/flutter/flutter/pull/68086
