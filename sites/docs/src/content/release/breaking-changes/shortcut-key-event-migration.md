---
title: Migrate ShortcutActivator and ShortcutManager to KeyEvent system
description: >
  The raw key event subsystem has been superseded by the key event subsystem,
  and APIs that use RawKeyEvent and RawKeyboard are converted to KeyEvent and
  HardwareKeyboard.
---

{% render "docs/breaking-changes.md" %}

## Summary

For some time now (years), Flutter has had two key event systems implemented.
The new system reached parity with the old platform-specific raw key event
system, and the raw system will be removed. To prepare for that, the Flutter
APIs that use the old system are being modified, and for a select few of them we
have decided to make breaking changes in the API in order to preserve the
quality of the API.

## Context

In the original key event subsystem handling each platform's quirks in the
framework and in client apps caused overly complex code, and the old system
didn't properly represent the true state of key events on the system.

So, the new [`KeyEvent`][]-based system was born, and to minimize breaking
changes, was implemented in parallel with the old system with the intention of
eventually deprecating the raw system. That time is quickly arriving, and to
prepare for it, we have made some minimal breaking changes required to preserve
the quality of the API.

## Description of change

Summary of APIs that have been affected:

- `ShortcutActivator.accepts` now takes a `KeyEvent` and `HardwareKeyboard`.
- `ShortcutActivator.isActivatedBy` is now deprecated. Just call `accepts` instead.
- `ShortcutActivator.triggers` is now optional, and returns null if not implemented.
- `ShortcutManager.handleKeypress` now takes a `KeyEvent`.

The change modifies the `ShortcutActivator.accepts` method to take a `KeyEvent`
and `HardwareKeyboard` instead of the previous `RawKeyEvent` and `RawKeyboard`.

The meaning of `ShortcutActivator.accepts` has changed slightly. Before the
change, it was assumed that `accepts` was only called if
`ShortcutActivator.triggers` returned null, or if the key event sent to `accepts`
had a logical key that was in the `triggers` list. Now it is always called, and
may use the `triggers` list as a performance improvement, but is not required
to. Flutter subclasses such as `SingleActivator` and `CharacterActivator`
already do this.

The change also modifies the `ShortcutManager.handleKeypress` method to take a
`KeyEvent` instead of `RawKeyEvent`.

## Migration guide

APIs provided by the Flutter framework are already migrated. Migration is
needed only if you're using any of the methods listed in the previous section.

### Migrating your APIs that use `ShortcutActivator` or its subclasses.

Pass a `KeyEvent` instead of a `RawKeyEvent` to `ShortcutActivator.accepts`.
This may mean switching where you get your key events from. Depending on where
you get them, this can either mean switching to using `Focus.onKeyEvent` instead
of `Focus.onKey`, or a similar change if using `FocusScope`, `FocusNode` or
`FocusScopeNode`.

If you're using a `RawKeyboardListener`, switch to using a
`KeyboardListener` instead. If you're accessing `RawKeyboard` directly, use
`HardwareKeyboard` instead. You'll find that there are non-raw equivalents for
all of the key event sources.

### Migrating your APIs that extend `ShortcutActivator`

The `ShortcutActivator.accepts` method was modified to take a `KeyEvent` and a
`HardwareKeyboard` instead of a `RawKeyEvent` and `RawKeyboard`.

Before:

```dart
class MyActivator extends ShortcutActivator {
  @override
  bool accepts(RawKeyEvent event, RawKeyboard state) {
    // ... (your implementation here)
    returns false;
  }
  // ...
}
```

After:

```dart
class MyActivator extends ShortcutActivator {
  @override
  bool accepts(KeyEvent event, HardwareKeyboard state) {
    // ... (your implementation here)
    returns false;
  }
  // ...
}
```

### Migrating your APIs that extend `ShortcutManager`

The `ShortcutManager` class was modified to take `KeyEvent`s in `handleKeypress`
instead of `RawKeyEvent`s.  One difference in the two APIs is that repeated keys
are determined differently. In the `RawKeyEvent` case, the `repeat` member
indicated a repeat, but in `RawKeyEvent` code, the event is a different type
(`KeyRepeatEvent`).

Before:

```dart
class _MyShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
    if (event is! RawKeyDownEvent) {
      return KeyEventResult.ignored;
    }
    if (event.repeat) {
      // (Do something with repeated keys.)
    }
    // ... (your implementation here)
    return KeyEventResult.handled;
  }
}
```

After:

```dart
class _MyShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    if (event is KeyRepeatEvent) {
      // (Do something with repeated keys.)
    }
    // ... (your implementation here)
    return KeyEventResult.handled;
  }
}
```

## Timeline

Landed in version: 3.17.0-5.0.pre<br>
In stable release: 3.19.0

## References

API documentation:

* [`KeyEvent`][]
* [`HardwareKeyboard`][]
* [`ShortcutActivator`][]
* [`ShortcutManager`][]

Relevant issues:

* [`RawKeyEvent` and `RawKeyboard`, et al should be deprecated and removed (Issue 136419)][]

Relevant PRs:

* [Prepare ShortcutActivator and ShortcutManager to migrate to KeyEvent from RawKeyEvent][]

[`KeyEvent`]: {{site.api}}/flutter/services/KeyEvent-class.html
[`HardwareKeyboard`]: {{site.api}}/flutter/services/HardwareKeyboard-class.html
[`ShortcutActivator`]: {{site.api}}/flutter/widgets/ShortcutActivator-class.html
[`ShortcutManager`]: {{site.api}}/flutter/widgets/ShortcutManager-class.html
[`RawKeyEvent` and `RawKeyboard`, et al should be deprecated and removed (Issue 136419)]: {{site.repo.flutter}}/issues/136419
[Prepare ShortcutActivator and ShortcutManager to migrate to KeyEvent from RawKeyEvent]: {{site.repo.flutter}}/pull/136854
