---
title: Keep simulated key events regular
description: Simulated events must conform to required rules in unit tests.
---

## Summary

In unit tests, simulated events are required to follow
Flutter's event model documented in `HardwareKeyboard`.

## Context

While Flutter used to be much more tolerant to
the structure of simulated key events,
now that Flutter adopts a "regular key event model,"
the keyboard system requires that the sequence of
incoming key events, simulated or real,
must conform to a set of rules.
Otherwise, it throws assertion errors.

This new model assures consistency between
key events and keyboard states,
simplifying applications' handling logic,
and allows the state of "keyboard modes" to be
tracked without extra information.

## Description of change

Key events now have three types:
- Key down events, simulated with [`simulateKeyDownEvent`];
- Key up events, simulated with [`simulateKeyUpEvent`];
- Key repeat events, simulated with [`simulateKeyRepeatEvent`]
(new!)

The "regular event model," simply put, requires that
the events for the same key must take place in
the order of one "key down," optional "key repeats,"
and one "key up." 

A more formal definition is as follows:
- The stream of events must consist of
  "key event sequences,"
  which can interleave with each other.
- A key event sequence consists of
  key events of the same physical key and
  the same logical key.
- A key event sequence consists of 
  one key down event,
  zero or more key repeat events,
  and one key up event in order.

Flutter will throw the assertion errors on malformed events, such as:
```
A KeyDownEvent is dispatched, but the state shows that the physical key is already pressed.

A KeyUpEvent is dispatched, but the state shows that the physical key is not pressed.

A KeyDownEvent is dispatched, but the state shows that the physical key is pressed on a different logical key.

If this occurs in real application, please report this bug to Flutter. If this occurs in unit tests, please ensure that simulated events follow Flutter's event model as documented in `HardwareKeyboard`.
```

## Migration guide

If the error message indicates that
the physical key is already pressed,
then insert a [`simulateKeyUpEvent`]
for the same key at a proper place
before that line.

This can most commonly occur when simulating
the key down event of the same key multiple times
in the same test case.

Code before migration:

<!-- skip -->
```dart
// Check if KeyA triggers widget 1.
await tester.pumpWidget(widget1());
await simulateKeyDownEvent(LogicalKeyboardKey.keyA);
expect(widget1Triggered, true);

// Check if KeyA triggers widget 2.
await tester.pumpWidget(widget2());
await simulateKeyDownEvent(LogicalKeyboardKey.keyA);
expect(widget2Triggered, true);
```

Code after migration:

<!-- skip -->
```dart
// Check if KeyA triggers widget 1.
await tester.pumpWidget(widget1());
await simulateKeyDownEvent(LogicalKeyboardKey.keyA);
expect(widget1Triggered, true);
// Add a required key up event.
await simulateKeyUpEvent(LogicalKeyboardKey.keyA);

// Check if KeyA triggers widget 2.
await tester.pumpWidget(widget2());
await simulateKeyDownEvent(LogicalKeyboardKey.keyA);
expect(widget2Triggered, true);
// Add an optional key up event (good to have).
await simulateKeyUpEvent(LogicalKeyboardKey.keyA); 
```

Similarly, if the error message indicates that
the physical key is not pressed,
then insert a [`simulateKeyDownEvent`]
for the same key at a proper place
before that line.

One of the possible cases
is to have simulated a key up event
at the beginning of the test,
without pressing the key first.

Code before migration:

<!-- skip -->
```dart
// Check if KeyA up triggers widget 3.
await tester.pumpWidget(widget3());
await simulateKeyUpEvent(LogicalKeyboardKey.keyA);
expect(widget3Triggered, true);
```

Code after migration:

<!-- skip -->
```dart
// Check if KeyA triggers widget 1.
await tester.pumpWidget(widget3());
// Add a required key down event.
await simulateKeyDownEvent(LogicalKeyboardKey.keyA);
await simulateKeyUpEvent(LogicalKeyboardKey.keyA);
expect(widget3Triggered, true);
```

If the error message indicates that
the physical key is pressed on
a different logical key,
then check the key down, repeat and up simulation
for this physical key and
make sure they produce the same logical key.

One of the possible cases
is that the application relies on the behavior
that the logical key for the same key
changes during the press.
This behavior will be changed soon
so that all key repeat and up events
will have the same logical key as 
the key down event.
How migration should be done depends on
the specific demand,
and please file an issue
if you have trouble migrating.


## Timeline

Landed in version: 2.5.0-5.0.pre<br>
In stable release: 2.5.0

## References

API documentation:
* [`simulateKeyDownEvent`][]
* [`simulateKeyUpEvent`][]
* [`simulateKeyRepeatEvent`][]
* [`KeyEvent`][]
* [`RawKeyEvent`][]

Relevant PRs:
* [PR 87174][]: Reland: Keyboard events

[`simulateKeyDownEvent`]: {{site.api}}/flutter/flutter_test/simulateKeyDownEvent.html
[`simulateKeyUpEvent`]: {{site.api}}/flutter/flutter_test/simulateKeyUpEvent.html
[`simulateKeyRepeatEvent`]: https://master-api.flutter.dev/flutter/flutter_test/simulateKeyRepeatEvent.html
[`KeyEvent`]: https://master-api.flutter.dev/flutter/services/KeyEvent-class.html
[`RawKeyEvent`]: {{site.api}}/flutter/services/RawKeyEvent-class.html
[PR 87174]: {{site.github}}/flutter/flutter/pull/87174

