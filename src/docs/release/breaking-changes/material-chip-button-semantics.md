---
title: Material Chip button semantics
description: Interactive Material Chips are now semantically marked as buttons.
---

## Summary

Flutter now applies the semantic label of `button` to
all interactive [Material Chips][] for accessibility purposes.

## Context

Interactive Material Chips (namely [`ActionChip`][],
[`ChoiceChip`][], [`FilterChip`][], and [`InputChip`][])
are now semantically marked as being buttons.
However, the non-interactive information [`Chip`][] is not.

Marking Chips as buttons helps accessibility tools,
search engines, and other semantic analysis software
understand the meaning of an app. For example, it
allows screen readers (such as TalkBack on Android
and VoiceOver on iOS) to announce a tappable Chip
as a "button", which can assist users in navigating
your app. Prior to this change, users of accessibility
tools may have had a subpar experience,
unless you implemented a workaround by manually adding the
missing semantics to the Chip widgets in your app.

## Description of change

The outermost [`Semantics`][] widget that wraps all
Chip classes to describe their semantic properties
is modified.

The following changes apply to
[`ActionChip`][], [`ChoiceChip`][], [`FilterChip`][],
and [`InputChip`][]:

* The [`button`][`SemanticsProperties.button`] property
  is set to `true`.
* The [`enabled`][`SemanticsProperties.enabled`] property
  reflects whether the Chip is _currently_ tappable
  (by having a callback set).

These property changes bring interactive Chips' semantic
behavior in-line with that of other [Material Buttons][].

For the non-interactive information [`Chip`][]:

* The [`button`][`SemanticsProperties.button`] property
  is set to `false`.
* The [`enabled`][`SemanticsProperties.enabled`] property
  is set to `null`.

## Migration guide

**You might not need to perform any migration.**
This change only affects you if you worked around
the issue of Material Chips missing `button` semantics by
wrapping the widget given to the `label` field of a
`Chip` with a `Semantics` widget marked as
`button: true`. **In this case, the inner and outer `button`
semantics conflict, resulting in the tappable area
of the button shrinking down to the size of the label
after this change is introduced.** Fix this issue
either by deleting that `Semantics` widget and replacing
it with its child, or by removing the `button: true`
property if other semantic properties still
need to be applied to the `label` widget of the Chip.

The following snippets use [`InputChip`][] as an example,
but the same process applies to [`ActionChip`][],
[`ChoiceChip`][], and [`FilterChip`][] as well.

**Case 1: Remove the `Semantics` widget.**

Code before migration:

<!-- skip -->
```dart
Widget myInputChip = InputChip(
  onPressed: () {},
  label: Semantics(
    button: true,
    child: Text('My Input Chip'),
  ),
);
```

Code after migration:

<!-- skip -->
```dart
Widget myInputChip = InputChip(
  onPressed: () {},
  label: Text('My Input Chip'),
);
```

**Case 2: Remove `button:true` from the `Semantics` widget.**

Code before migration:

<!-- skip -->
```dart
Widget myInputChip = InputChip(
  onPressed: () {},
  label: Semantics(
    button: true,
    hint: 'Example Hint',
    child: Text('My Input Chip'),
  ),
);
```

Code after migration:

<!-- skip -->
```dart
Widget myInputChip = InputChip(
  onPressed: () {},
  label: Semantics(
    hint: 'Example Hint',
    child: Text('My Input Chip'),
  ),
);
```

## Timeline

Landed in version: 1.23.0-7.0.pre<br>
In stable release: 2.0.0

## References

API documentation:

* [`ActionChip`][]
* [`Chip`][]
* [`ChoiceChip`][]
* [`FilterChip`][]
* [`InputChip`][]
* [Material Buttons][]
* [Material Chips][]
* [`Semantics`][]
* [`SemanticsProperties.button`][]
* [`SemanticsProperties.enabled`][]

Relevant issue:

* [Issue 58010][]: InputChip doesn't announce any
  action for a11y on iOS

Relevant PRs:

* [PR 60141][]: Tweaking Material Chip a11y semantics
  to match buttons
* [PR 60645][]: Revert "Tweaking Material Chip a11y
  semantics to match buttons (#60141)"
* [PR 61048][]: Re-land "Tweaking Material Chip a11y semantics to match buttons (#60141)"

[`ActionChip`]: {{site.api}}/flutter/material/ActionChip-class.html
[`Chip`]: {{site.api}}/flutter/material/Chip-class.html
[`ChoiceChip`]: {{site.api}}/flutter/material/ChoiceChip-class.html
[`FilterChip`]: {{site.api}}/flutter/material/FilterChip-class.html
[`InputChip`]: {{site.api}}/flutter/material/InputChip-class.html
[Material Buttons]: {{site.material}}/components/buttons
[Material Chips]: {{site.material}}/components/chips
[`Semantics`]: {{site.api}}/flutter/widgets/Semantics-class.html
[`SemanticsProperties.button`]: {{site.api}}/flutter/semantics/SemanticsProperties/button.html
[`SemanticsProperties.enabled`]: {{site.api}}/flutter/semantics/SemanticsProperties/enabled.html

[Issue 58010]: {{site.github}}/flutter/flutter/issues/58010

[PR 60141]: {{site.github}}/flutter/flutter/pull/60141
[PR 60645]: {{site.github}}/flutter/flutter/pull/60645
[PR 61048]: {{site.github}}/flutter/flutter/pull/61048
