---
title: Keep simulated key events regular
description: Simulated events must conform to required rules in unit tests.
---

{% comment %}
  PLEASE READ THESE GENERAL INSTRUCTIONS:
  * All lines of text should be 80 chars OR LESS.
    The writers strongly prefer semantic line breaks:
    https://github.com/dart-lang/site-shared/blob/master/doc/writing-for-dart-and-flutter-websites.md#semantic-line-breaks
  * DON'T SUBMIT a PR weeks and weeks in advance.
    Doing this causes it to get stanky in the website
    repo and usually develops conflicts in the index file.
    Ideally, submit a PR once you have confirmed
    info on the version number where the breaking
    change landed.
  * One of the most important things to fill out 
    in this template is the *Timeline* section.
    I won't approve/merge the PR until the "landed in"
    release info is provided. For example:
    `Landed in version: 1.21.0-5.0.pre<br>`.
    Do NOT list the PR in this section. Also, don't
    fill in the "stable" release info unless it's
    already in a published stable release.
    After a stable release, I go through and confirm
    that updates have made it to stable and I then
    update the breaking change and the index file.
  * The text in this page should be backwards looking,
    so write about previous behavior in past tense,
    not future tense. People are reading this months
    from now when the change is likely in the stable
    release, not today. Don't say "in a month" or
    talk about your plan to do something next week.
    Assume you've done it, and that they're looking
    back to figure out how to migrate their code.
  * Use sentence case for headings and titles.
    (`## Migration guide`, NOT `Migration Guide`)
  * DON'T use the abbreviation `i.e.` or `e.g.`.
    Use "for example" or "such as", and similar.
  * For links, use the macros where possible.
    See the examples at the end of this template,
    but don't use "github.com" or "api.flutter.dev" or
    "pub.dev" in your URLs. Use the {{site.github}},
    {{site.api}}, or {{site.pub}} macros.
  * AVOID "will" when possible, in other words,
    stay in the present tense. For example:
    Bad: "When encountering an xxx value,
          the code will throw an exception."
    Good: "When encountering an xxx value,
           the code throws an exception."
    Good use of "will": "In release 2.0, the xxx API
          will be deprecated."
  * If your included Dart code won't pass analysis
    on its own (using the analyzer from the latest
    stable release), then preface that code with an
    HTML `<!-- skip -->` tag.
  * Finally, delete the comment tags and text from the
    final PR.
{% endcomment %}

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

