---
title: Deprecated API removed after v2.10
description: After reaching end of life, the following deprecated APIs were removed from Flutter.
---

## Summary

In accordance with Flutter's [Deprecation Policy][],
deprecated APIs that reached end of life after the
2.10 stable release have been removed.

All affected APIs have been compiled into this
primary source to aid in migration. A
[quick reference sheet][] is available as well.


[Deprecation Policy]: {{site.repo.flutter}}/wiki/Tree-hygiene#deprecation
[quick reference sheet]: {{site.url}}/go/deprecations-removed-after-2-10

## Changes

This section lists the deprecations by affected class.

---

### `maxLengthEnforced` of `TextField` & related classes

Supported by Flutter Fix: yes

`maxLengthEnforced` was deprecated in v1.25.

Use `maxLengthEnforcement` instead.
Where `maxLengthEnforced` was true, replace with `MaxLengthEnforcement.enforce`.
Where `maxLengthEnforced` was false, replace with `MaxLengthEnforcement.none`.
This change allows more behaviors to be specified beyond the original binary
choice, adding `MaxLengthEnforcement.truncateAfterCompositionEnds` as an
additional option.

The following classes all have the same change of API:

- `TextField`
- `TextFormField`
- `CupertinoTextField`

**Migration guide**

[In-depth migration guide available][]

Code before migration:
<!-- skip -->
```dart
const TextField textField = TextField(maxLengthEnforced: true);
const TextField textField = TextField(maxLengthEnforced: false);
final lengthEnforced = textField.maxLengthEnforced;

const TextFormField textFormField = TextFormField(maxLengthEnforced: true);
const TextFormField textFormField = TextFormField(maxLengthEnforced: false);
final lengthEnforced = textFormField.maxLengthEnforced;

const CupertinoTextField cupertinoTextField = CupertinoTextField(maxLengthEnforced: true);
const CupertinoTextField cupertinoTextField = CupertinoTextField(maxLengthEnforced: false);
final lengthEnforced = cupertinoTextField.maxLengthEnforced;
```

Code after migration:
<!-- skip -->
```dart
const TextField textField = TextField(maxLengthEnforcement: MaxLengthEnforcement.enforce);
const TextField textField = TextField(maxLengthEnforcement: MaxLengthEnforcement.none);
final lengthEnforced = textField.maxLengthEnforcement;

const TextFormField textFormField = TextFormField(maxLengthEnforcement: MaxLengthEnforcement.enforce);
const TextFormField textFormField = TextFormField(maxLengthEnforcement: MaxLengthEnforcement.none);
final lengthEnforced = textFormField.maxLengthEnforcement;

const CupertinoTextField cupertinoTextField = CupertinoTextField(maxLengthEnforcement: MaxLengthEnforcement.enforce);
const CupertinoTextField cupertinoTextField = CupertinoTextField(maxLengthEnforcement: MaxLengthEnforcement.none);
final lengthEnforced = cupertinoTextField.maxLengthEnforcement;
```

**References**

API documentation:
* [`TextField`][]
* [`TextFormField`][]
* [`CupertinoTextField`][]

Relevant issues:
* [Issue 67898]({{site.repo.flutter}}/issues/67898)

Relevant PRs:
* Deprecated in [#68086]({{site.repo.flutter}}/pull/68086)
* Removed in [#98539]({{site.repo.flutter}}/pull/98539)

[In-depth migration guide available]: {{site.url}}/release/breaking-changes/use-maxLengthEnforcement-instead-of-maxLengthEnforced
[`TextField`]: {{site.api}}/flutter/material/TextField-class.html
[`TextFormField`]: {{site.api}}/flutter/material/TextFormField-class.html
[`CupertinoTextField`]: {{site.api}}/flutter/cupertino/CupertinoTextField-class.html

---

### `VelocityTracker` constructor

Supported by Flutter Fix: yes

The default constructor for `VelocityTracker`was deprecated in v1.22.

The `VelocityTracker.withKind()` should be used instead. This allows for a
`PointerDeviceKind` to be specified for the tracker. The previous default for
`VelocityTracker.kind` was `PointerDeviceKind.touch`.

**Migration guide**

Code before migration:
<!-- skip -->
```dart
final VelocityTracker tracker = VelocityTracker();
```

Code after migration:
<!-- skip -->
```dart
final VelocityTracker tracker = VelocityTracker.withKind(PointerDeviceKind.touch);
```

**References**

API documentation:
* [`VelocityTracker`][]
* [`PointerDeviceKind`][]

Relevant PRs:
* Deprecated in [#66043]({{site.repo.flutter}}/pull/66043)
* Removed in [#98541]({{site.repo.flutter}}/pull/98541)

[`VelocityTracker`]: {{site.api}}/flutter/gestures/VelocityTracker-class.html
[`PointerDeviceKind`]: {{site.api}}/flutter/dart-ui/PointerDeviceKind.html

---

### `DayPicker` & `MonthPicker`

Supported by Flutter Fix: no

The `DayPicker` and `MonthPicker` widgets were first deprecated in v1.15, and
then extended in v1.26.

They have been replaced by one comprehensive widget, `CalendarDatePicker`.

These widgets were displayed using the `showDatePicker` method. This method was
migrated to present the new `CalendarDatePicker` before this release, and so
their final removal should not necessitate further action.

**References**

Design document:
* [Material Date Picker Redesign][]

API documentation:
* [`CalendarDatePicker`][]
* [`showDatePicker`][]

Relevant issues:
* [Issue 50133]({{site.repo.flutter}}/issues/50133)

Relevant PRs:
* Deprecated in [#50546]({{site.repo.flutter}}/issues/50546)
* Removed in [#98543]({{site.repo.flutter}}/issues/98543)

[Material Date Picker Redesign]: {{site.url}}/go/material-date-picker-redesign
[`CalendarDatePicker`]: {{site.api}}/flutter/material/CalendarDatePicker-class.html
[`showDatePicker`]: {{site.api}}/flutter/material/showDatePicker.html

---

### `FlatButton`, `RaisedButton`, & `OutlineButton`

Supported by Flutter Fix: no

The `FlatButton`, `RaisedButton`, and `OutlineButton` widgets were first
deprecated in v1.20, and then extended in v1.26.

They are replaced by new buttons, `TextButton`, `ElevatedButton`, and
`OutlinedButton`. These new widgets also use new associated themes, rather than
the generic `ButtonTheme`.

<div class="table-wrapper" markdown="1">

| Old Widget     | Old Theme       | New Widget        | New Theme             |
| ---------------|-----------------|-------------------|-----------------------|
| `FlatButton`   | `ButtonTheme`   | `TextButton`      | `TextButtonTheme`     |
| `RaisedButton` | `ButtonTheme`   | `ElevatedButton`  | `ElevatedButtonTheme` |
| `OutlineButton`| `ButtonTheme`   | `OutlinedButton`  | `OutlinedButtonTheme` |
{:.table .table-striped .nowrap}
</div>

**Migration guide**

[In-depth migration guide available for detailed styling][]

Code before migration:
<!-- skip -->
```dart
FlatButton(
  onPressed: onPressed,
  child: Text('Button'),
  // ...
);

RaisedButton(
  onPressed: onPressed,
  child: Text('Button'),
  // ...
);

OutlineButton(
  onPressed: onPressed,
  child: Text('Button'),
  // ...
);
```

Code after migration:
<!-- skip -->
```dart
TextButton(
  onPressed: onPressed,
  child: Text('Button'),
  // ...
);

ElevatedButton(
  onPressed: onPressed,
  child: Text('Button'),
  // ...
);

OutlinedButton(
  onPressed: onPressed,
  child: Text('Button'),
  // ...
);
```

**References**

Design document:
* [New Material buttons and themes][]

API documentation:
* [`ButtonStyle`][]
* [`ButtonStyleButton`][]
* [`ElevatedButton`][]
* [`ElevatedButtonTheme`][]
* [`ElevatedButtonThemeData`][]
* [`OutlinedButton`][]
* [`OutlinedButtonTheme`][]
* [`OutlinedButtonThemeData`][]
* [`TextButton`][]
* [`TextButtonTheme`][]
* [`TextButtonThemeData`][]

Relevant PRs:
* New API added in [#59702]({{site.repo.flutter}}/issues/59702)
* Deprecated in [#73352]({{site.repo.flutter}}/issues/73352)
* Removed in [#98546]({{site.repo.flutter}}/issues/98546)

[In-depth migration guide available for detailed styling]: {{site.url}}/release/breaking-changes/buttons
[New Material buttons and themes]: {{site.url}}/go/material-button-migration-guide
[`ButtonStyle`]: {{site.api}}/flutter/material/ButtonStyle-class.html
[`ButtonStyleButton`]: {{site.api}}/flutter/material/ButtonStyleButton-class.html
[`ElevatedButton`]: {{site.api}}/flutter/material/ElevatedButton-class.html
[`ElevatedButtonTheme`]: {{site.api}}/flutter/material/ElevatedButtonTheme-class.html
[`ElevatedButtonThemeData`]: {{site.api}}/flutter/material/ElevatedButtonThemeData-class.html
[`OutlinedButton`]: {{site.api}}/flutter/material/OutlinedButton-class.html
[`OutlinedButtonTheme`]: {{site.api}}/flutter/material/OutlinedButtonTheme-class.html
[`OutlinedButtonThemeData`]: {{site.api}}/flutter/material/OutlinedButtonThemeData-class.html
[`TextButton`]: {{site.api}}/flutter/material/TextButton-class.html
[`TextButtonTheme`]: {{site.api}}/flutter/material/TextButtonTheme-class.html
[`TextButtonThemeData`]: {{site.api}}/flutter/material/TextButtonThemeData-class.html

---

### `Scaffold` `SnackBar` methods

Supported by Flutter Fix: no

The following `Scaffold` `SnackBar` methods were deprecated in v1.23.

- `showSnackBar`
- `removeCurrentSnackBar`
- `hideCurrentSnackBar`

The same named methods of the `ScaffoldMessenger` should be used instead. A
default `ScaffoldMessenger` is already created in every `MaterialApp`.

**Migration guide**

[In-depth migration guide available][]

Code before migration:
<!-- skip -->
```dart
Scaffold.of(context).showSnackBar(mySnackBar);
Scaffold.of(context).removeCurrentSnackBar(mySnackBar);
Scaffold.of(context).hideCurrentSnackBar(mySnackBar);
```

Code after migration:
<!-- skip -->
```dart
ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
ScaffoldMessenger.of(context).removeCurrentSnackBar(mySnackBar);
ScaffoldMessenger.of(context).hideCurrentSnackBar(mySnackBar);
```

**References**

Design Document
* [ScaffoldMessenger Design][]

Video Content
* [SnackBar Delivery][]
* [Widget of the Week][]

API documentation:
* [`ScaffoldMessenger`][]
* [`SnackBar`][]

Relevant issues:
* [Issue 57218]({{site.repo.flutter}}/issues/57218)
* [Issue 62921]({{site.repo.flutter}}/issues/62921)

Relevant PRs:
* New API added in [#64101]({{site.repo.flutter}}/issues/64101)
* Deprecated in [#67947]({{site.repo.flutter}}/issues/67947)
* Removed in [#98549]({{site.repo.flutter}}/issues/98549)

[In-depth migration guide available]: {{site.url}}/release/breaking-changes/scaffold-messenger
[ScaffoldMessenger Design]: {{site.url}}/go/scaffold-messenger
[SnackBar Delivery]: https://youtu.be/sYG7HAGu_Eg?t=10271
[Widget of the Week]: https://youtu.be/lytQi-slT5Y
[`ScaffoldMessenger`]: {{site.api}}/flutter/material/ScaffoldMessenger-class.html
[`SnackBar`]: {{site.api}}/flutter/material/SnackBar-class.html

---

### `RectangularSliderTrackShape.disabledThumbGapWidth`

Supported by Flutter Fix: yes

The `RectangularSliderTrackShape.disabledThumbGapWidth` was first deprecated in
v1.5, and then extended in v1.26.

This was no longer used by the framework, as the animation of the slider thumb
no longer occurs when disabled.

**Migration guide**

Code before migration:
<!-- skip -->
```dart
RectangularSliderTrackShape(disabledThumbGapWidth: 2.0);
```

Code after migration:
<!-- skip -->
```dart
RectangularSliderTrackShape();
```

**References**

API documentation:
* [`RectangularSliderTrackShape`][]

Relevant PRs:
* Animation changed in [#30390]({{site.repo.flutter}}/issues/30390)
* Deprecated in [#65246]({{site.repo.flutter}}/issues/65246)
* Removed in [#98613]({{site.repo.flutter}}/issues/98613)

[`RectangularSliderTrackShape`]: {{site.api}}/flutter/material/RectangularSliderTrackShape-class.html

---

### Text selection of `ThemeData` to `TextSelectionThemeData`

Supported by Flutter Fix: yes

The following `ThemeData` members were first deprecated in v1.23, and extended
in v1.26.

- `useTextSelectionTheme`
- `textSelectionColor`
- `cursorColor`
- `textSelectionHandleColor`

These should be replaced by a more comprehensive `TextSelectionThemeData`,
which is now specified in `ThemeData` itself.

The `useTextSelectionTheme` flag served as a temporary migration flag to
distinguish the two APIs, it can be removed now.

**Migration guide**

[In-depth migration guide available][]

Code before migration:
<!-- skip -->
```dart
ThemeData(
  useTextSelectionTheme: false,
  textSelectionColor: Colors.blue,
  cursorColor: Colors.green,
  textSelectionHandleColor: Colors.red,
);
```

Code after migration:
<!-- skip -->
```dart
ThemeData(
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.blue,
    cursorColor: Colors.green,
    selectionHandleColor: Colors.red,
  ),
);
```

**References**

Design Document
* [Text Selection Theme][]

API documentation:
* [`ThemeData`][]
* [`TextSelectionThemeData`][]

Relevant issues:
* [Issue 17635]({{site.repo.flutter}}/issues/17635)
* [Issue 56082]({{site.repo.flutter}}/issues/56082)
* [Issue 61227]({{site.repo.flutter}}/issues/61227)

Relevant PRs:
* New API added in [#62014]({{site.repo.flutter}}/issues/62014)
* Deprecated in [#66485]({{site.repo.flutter}}/issues/66482)
* Removed in [#98578]({{site.repo.flutter}}/issues/98578)

[In-depth migration guide available]: {{site.url}}/release/breaking-changes/text-selection-theme
[Text Selection Theme]: {{site.url}}/go/text-selection-theme
[`ThemeData`]: {{site.api}}/flutter/material/ThemeData-class.html
[`TextSelectionThemeData`]: {{site.api}}/flutter/material/TextSelectionThemeData-class.html

---

### `RenderEditable.onSelectionChanged` to `TextSelectionDelegate.textEditingValue`

Supported by Flutter Fix: no

`RenderEditable.onSelectionChanged` and `TextSelectionDelegate.textEditingValue`
were deprecated in v1.26.

Instead of calling one or both of these methods, call
`TextSelectionDelegate.userUpdateTextEditingValue`. This fixed a bug where the
`TextInputFormatter` would receive the wrong selection value.

**Migration guide**

Code before migration:
<!-- skip -->
```dart
renderEditable.onSelectionChanged(selection, renderObject, cause);
textSelectionDelegate.textEditingValue = value;
```

Code after migration:
<!-- skip -->
```dart
textSelectionDelegate.userUpdateTextEditingValue(value, cause);
```

**References**

API documentation:
* [`RenderEditable`][]
* [`TextSelectionDelegate`][]

Relevant issues:
* Resolved [#75505]({{site.repo.flutter}}/issues/75502)

Relevant PRs:
* Deprecated in [#75541]({{site.repo.flutter}}/issues/75541)
* Removed in [#98582]({{site.repo.flutter}}/issues/98582)

[`RenderEditable`]: {{site.api}}/flutter/rendering/RenderEditable-class.html
[`TextSelectionDelegate`]: {{site.api}}/flutter/services/TextSelectionDelegate-mixin.html

---

### `Stack.overflow`

Supported by Flutter Fix: yes

`Stack.overflow`, as well as the `Overflow` enum were deprecated in v1.22.

The replacement is `Stack.clipBehavior`, a change made as part of unifying clip
behaviors and semantics across the framework. Where `Overflow.visible` was used,
use `Clip.none`. Where `Overflow.clip` was used, use `Clip.hardEdge`.

**Migration guide**

[In-depth migration guide available][]

Code before migration:
<!-- skip -->
```dart
const Stack stack = Stack(overflow: Overflow.visible);
const Stack stack = Stack(overflow: Overflow.clip);
```

Code after migration:
<!-- skip -->
```dart
const Stack stack = Stack(clipBehavior: Clip.none);
const Stack stack = Stack(clipBehavior: Clip.hardEdge);
```

**References**

API documentation:
* [`Stack`][]
* [`Clip`][]

Relevant issues:
* Resolved [#66030]({{site.repo.flutter}}/issues/66030)

Relevant PRs:
* Deprecated in [#66305]({{site.repo.flutter}}/issues/66305)
* Removed in [#98583]({{site.repo.flutter}}/issues/98583)

[In-depth migration guide available]: {{site.url}}/release/breaking-changes/clip-behavior
[`Stack`]: {{site.api}}/flutter/widgets/Stack-class.html
[`Clip`]: {{site.api}}/flutter/dart-ui/Clip.html

---

### `UpdateLiveRegionEvent`

Supported by Flutter Fix: no

The `SemanticsEvent` `UpdateLiveRegionEvent`, was first deprecated in v1.12, and
then extended in v1.26.

This was never implemented by the framework, and any references should be
removed.

**References**

API documentation:
* [`SemanticsEvent`][]

Relevant PRs:
* Deprecated in [#45940]({{site.repo.flutter}}/issues/45940)
* Removed in [#98615]({{site.repo.flutter}}/issues/98615)

[`SemanticsEvent`]: {{site.api}}/flutter/semantics/SemanticsEvent-class.html

---

### `RenderObjectElement` methods

Supported by Flutter Fix: yes

The following `RenderObjectElement` methods were deprecated in v1.21.

- `insertChildRenderObject`
- `moveChildRenderObject`
- `removeChildRenderObject`

These methods are replaced, respectively, by:

- `insertRenderObjectChild`
- `moveRenderObjectChild`
- `removeRenderObjectChild`

These changes were made as a soft breaking deprecation in order to change the
function signature.

**Migration guide**

Code before migration:
<!-- skip -->
```dart
element.insertChildRenderObject(child, slot);
element.moveChildRenderObject(child, slot);
element.removeChildRenderObject(child);
```

Code after migration:
<!-- skip -->
```dart
element.insertRenderObjectChild(child, slot);
element.moveChildRenderObject(child, oldSlot, newSlot);
element.removeChildRenderObject(child, slot);
```

**References**

API documentation:
* [`RenderObjectElement`][]

Relevant issues:
* [Issue 63269]({{site.repo.flutter}}/issues/63269)

Relevant PRs:
* Deprecated in [#64254]({{site.repo.flutter}}/issues/64254)
* Removed in [#98616]({{site.repo.flutter}}/issues/98616)

[`RenderObjectElement`]: {{site.api}}/flutter/widgets/RenderObjectElement-class.html

---

## Timeline

In stable release: TBD

