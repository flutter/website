---
title: Material Chip Button Semantics description: Brief description similar to
the "context" section below.
---

## Summary

Flutter now applies the semantic label of `button` to all interactive [Material
Chips](https://material.io/components/chips) for accessibility purposes.

## Context

Interactive Material Chips (namely
[ActionChip](https://api.flutter.dev/flutter/material/ActionChip-class.html),
[ChoiceChip](https://api.flutter.dev/flutter/material/ChoiceChip-class.html),
[FilterChip](https://api.flutter.dev/flutter/material/FilterChip-class.html),
and [InputChip](https://api.flutter.dev/flutter/material/InputChip-class.html))
are now semantically marked as being buttons. Please note that the
non-interactive information
[Chip](https://api.flutter.dev/flutter/material/Chip-class.html) is not.

This will allow accessibility tools, search engines, and other semantic analysis
software to determine the meaning of the application. For example, it will allow
screen readers (such as TalkBack on Android and VoiceOver on iOS) to announce a
tappable Chip as a "button", which can assist users in navigating the
application. Prior to this change, users of accessibility tools may have had a
subpar experience, unless application developers implemented a workaround by
manually adding the missing semantics to the Chips in their applications.

## Description of change

In `package:flutter/material.dart`, the `build(...)` method of the
`_RawChipState` class (used by all chips) returns the resulting built chip
widget wrapped in a
[Semantics](https://api.flutter.dev/flutter/widgets/Semantics-class.html)
widget.

This method looked akin to the following:

<!-- skip -->
```dart
@override
Widget build(BuildContext context) {
  Widget result = ... // Actually build the widget here.
  return Semantics(
    container: true,
    selected: widget.selected,
    enabled: canTap ? widget.isEnabled : null,
    child: result,
  );
}
```

The properties set on the `Semantics` widget have now been altered to:

1. Mark the chip as a `button` if it _could_ be interacted with, regardless of
   whether it is currently `enabled` or not.
    1. This means any chip class which passes `tapEnabled: true` to the
       `RawButton` class it extends will be marked as a button. This includes
       [ActionChip](https://api.flutter.dev/flutter/material/ActionChip-class.html),
       [ChoiceChip](https://api.flutter.dev/flutter/material/ChoiceChip-class.html),
       [FilterChip](https://api.flutter.dev/flutter/material/FilterChip-class.html),
       and
       [InputChip](https://api.flutter.dev/flutter/material/InputChip-class.html),
       but not the non-interactive information
       [Chip](https://api.flutter.dev/flutter/material/Chip-class.html).
2. Make the chip's `enabled` semantic flag reflect whether the chip is currently
   tappable or not, if and only if the chip _could_ be interacted with at some
   point (see point 1), otherwise `enabled` is set to `null` (meaning this
   widget is _never_ tappable, as with the non-interactive information
   [Chip](https://api.flutter.dev/flutter/material/Chip-class.html)).
    1. This change brings chips' `enabled` behavior in-line with that of other
       buttons.

The code above now looks akin to the following:

<!-- skip -->
```dart
@override
Widget build(BuildContext context) {
  Widget result = ... // Actually build the widget here.
  return Semantics(
    button: widget.tapEnabled, // Added this line.
    container: true,
    selected: widget.selected,
    enabled: widget.tapEnabled ? canTap : null, // Changed this line.
    child: result,
  );
}
```

The `canTap` property has remained unchanged, and is defined as the following
logical expression:

<!-- skip -->
```dart
bool get canTap {
  return widget.isEnabled
      && widget.tapEnabled
      && (widget.onPressed != null || widget.onSelected != null);
}
```

## Migration guide

**Most developers likely won't need to perform any migration.** This change will
only affect developers who worked around the issue of Material Chips missing
`button` semantics by wrapping the widget given to the `label` field of a `Chip`
with a `Semantics` widget marked as `button: true`. **In this case, the inner
and outer `button` semantics will conflict, resulting in the tappable area of
the button shrinking down to the size of the label after this change is
introduced.** This can be fixed by deleting that `Semantics` widget and
replacing it with its child, or simply removing the `button: true` property if
other semantic properties still need to be applied to the label widget of the
Chip.

The following snippets use
[InputChip](https://api.flutter.dev/flutter/material/InputChip-class.html) as an
example, but the same process applies to
[ActionChip](https://api.flutter.dev/flutter/material/ActionChip-class.html),
[ChoiceChip](https://api.flutter.dev/flutter/material/ChoiceChip-class.html),
and [FilterChip](https://api.flutter.dev/flutter/material/FilterChip-class.html)
as well.

**Case 1: remove the `Semantics` widget.**

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

**Case 2: remove `button:true` from the `Semantics` widget.**

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

Landed in version: TBD<br> In stable release: not yet

## References

{% include master-api.md %}

API documentation:
* [`Semantics`][]
* [`SemanticsProperties.button`][]
* [`SemanticsProperties.enabled`][]
* [`Chip`][]
* [`ActionChip`][]
* [`ChoiceChip`][]
* [`FilterChip`][]
* [`InputChip`][]

Relevant issues:
* [flutter/flutter#58010][]

Relevant PRs:
* [Tweaking Material Chip a11y semantics to match buttons][]
* [Revert "Tweaking Material Chip a11y semantics to match buttons (#60141)"][]
* [Re-land "Tweaking Material Chip a11y semantics to match buttons (#60141)"][]

[`Semantics`]: {{site.api}}/flutter/widgets/Semantics-class.html
[`SemanticsProperties.button`]: {{site.api}}/flutter/semantics/SemanticsProperties/button.html
[`SemanticsProperties.enabled`]: {{site.api}}/flutter/semantics/SemanticsProperties/enabled.html
[`Chip`]: {{site.api}}/flutter/material/Chip-class.html
[`ActionChip`]: {{site.api}}/flutter/material/ActionChip-class.html
[`ChoiceChip`]: {{site.api}}/flutter/material/ChoiceChip-class.html
[`FilterChip`]: {{site.api}}/flutter/material/FilterChip-class.html
[`InputChip`]: {{site.api}}/flutter/material/InputChip-class.html

[flutter/flutter#58010]: {{site.github}}/flutter/flutter/issues/58010

[Tweaking Material Chip a11y semantics to match buttons]: {{site.github}}/flutter/flutter/pull/60141
[Revert "Tweaking Material Chip a11y semantics to match buttons (#60141)"]: {{site.github}}/flutter/flutter/pull/60645
[Re-land "Tweaking Material Chip a11y semantics to match buttons (#60141)"]: {{site.github}}/flutter/flutter/pull/61048
