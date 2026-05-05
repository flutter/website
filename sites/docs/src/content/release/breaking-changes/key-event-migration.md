---
title: Migrate RawKeyEvent/RawKeyboard system to KeyEvent/HardwareKeyboard system
description: >-
  The raw key event subsystem has been superseded by the key event subsystem,
  and APIs that use RawKeyEvent and RawKeyboard are converted to KeyEvent and
  HardwareKeyboard.
---

{% render "docs/breaking-changes.md" %}

## Summary

For some time now (years), Flutter has had two key event systems implemented.
The new system reached parity with the old platform-specific raw key event
system, and the raw system has been deprecated.

## Context

In the original key event subsystem, handling each platform's quirks in the
framework and in client apps caused overly complex code, and the old system
didn't properly represent the true state of key events on the system.

The legacy API [`RawKeyboard`][] has been deprecated
and will be removed in the future.
The [`HardwareKeyboard`][] and [`KeyEvent`][] APIs replace this legacy API.
An example of this change is [`FocusNode.onKeyEvent`][]
replacing `FocusNode.onKey`.

The behavior of [`RawKeyboard`][] provided a
less unified and less regular event model
than [`HardwareKeyboard`][] does.
Consider the following examples:

* Down events were not always matched with an up event, and vice versa (the set
  of pressed keys was silently updated).
* The logical key of the down event was not always the same as that of the up
  event.
* Down events and repeat events were not easily distinguishable (had to be
  tracked manually).
* Lock modes (such as CapsLock) only had their "enabled" state recorded. There
  was no way to acquire their pressed state.

So, the new [`KeyEvent`][]/[`HardwareKeyboard`][]-based system was born and, to
minimize breaking changes, was implemented in parallel with the old system with
the intention of eventually deprecating the raw system. That time has arrived,
and application developers should migrate their code to avoid breaking changes
that will occur when the deprecated APIs are removed.

## Description of change

Below are the APIs that have been deprecated.

### Deprecated APIs that have an equivalent

* [`Focus.onKey`][] => [`Focus.onKeyEvent`][]
* [`FocusNode.attach`][]'s `onKey` argument => `onKeyEvent` argument
* [`FocusNode.onKey`][] => [`FocusNode.onKeyEvent`][]
* [`FocusOnKeyCallback`][] => [`FocusOnKeyEventCallback`][]
* [`FocusScope.onKey`][] => [`FocusScope.onKeyEvent`][]
* [`FocusScopeNode.onKey`][] => [`FocusScopeNode.onKeyEvent`][]
* [`RawKeyboard`][] => [`HardwareKeyboard`][]
* [`RawKeyboardListener`][] => [`KeyboardListener`][]
* [`RawKeyDownEvent`][] => [`KeyDownEvent`][]
* [`RawKeyEvent`][] => [`KeyEvent`][]
* [`RawKeyUpEvent`][] => [`KeyUpEvent`][]

### APIs that have been discontinued

These APIs are no longer needed once there is only one key event system, or
their functionality is no longer offered.

* [`debugKeyEventSimulatorTransitModeOverride`][]
* [`GLFWKeyHelper`][]
* [`GtkKeyHelper`][]
* [`KeyboardSide`][]
* [`KeyDataTransitMode`][]
* [`KeyEventManager`][]
* [`KeyHelper`][]
* [`KeyMessage`][]
* [`KeyMessageHandler`][]
* [`KeySimulatorTransitModeVariant`][]
* [`ModifierKey`][]
* [`RawKeyEventData`][]
* [`RawKeyEventDataAndroid`][]
* [`RawKeyEventDataFuchsia`][]
* [`RawKeyEventDataIos`][]
* [`RawKeyEventDataLinux`][]
* [`RawKeyEventDataMacOs`][]
* [`RawKeyEventDataWeb`][]
* [`RawKeyEventDataWindows`][]
* [`RawKeyEventHandler`][]
* [`ServicesBinding.keyEventManager`][]

## Migration guide

The Flutter framework libraries have already been migrated.
If your code uses any of the classes or methods listed in
the previous section, migrate to these new APIs.

### Migrating your code that uses `RawKeyEvent`

For the most part, there are equivalent `KeyEvent` APIs available for all of the
`RawKeyEvent` APIs.

Some APIs relating to platform specific information contained in
[`RawKeyEventData`][] objects or their subclasses have been removed and are no
longer supported. One exception is that [`RawKeyEventDataAndroid.eventSource`][]
information is accessible now as [`KeyEvent.deviceType`][] in a more
platform independent form.

#### Migrating `isKeyPressed` and related functions

If the legacy code used the [`RawKeyEvent.isKeyPressed`][],
[`RawKeyEvent.isControlPressed`][], [`RawKeyEvent.isShiftPressed`][],
[`RawKeyEvent.isAltPressed`][], or [`RawKeyEvent.isMetaPressed`][] APIs, there
are now equivalent functions on the [`HardwareKeyboard`][] singleton instance,
but are not available on [KeyEvent]. [`RawKeyEvent.isKeyPressed`][] is available
as [`HardwareKeyboard.isLogicalKeyPressed`][].

Before:

```dart
KeyEventResult _handleKeyEvent(RawKeyEvent keyEvent) {
  if (keyEvent.isControlPressed ||
      keyEvent.isShiftPressed ||
      keyEvent.isAltPressed ||
      keyEvent.isMetaPressed) {
    print('Modifier pressed: $keyEvent');
  }
  if (keyEvent.isKeyPressed(LogicalKeyboardKey.keyA)) {
    print('Key A pressed.');
  }
  return KeyEventResult.ignored;
}
```

After:

```dart
KeyEventResult _handleKeyEvent(KeyEvent _) {
  if (HardwareKeyboard.instance.isControlPressed ||
      HardwareKeyboard.instance.isShiftPressed ||
      HardwareKeyboard.instance.isAltPressed ||
      HardwareKeyboard.instance.isMetaPressed) {
    print('Modifier pressed: $keyEvent');
  }
  if (HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.keyA)) {
    print('Key A pressed.');
  }
  return KeyEventResult.ignored;
}
```

#### Setting `onKey` for focus

If the legacy code was using the [`Focus.onKey`][], [`FocusScope.onKey`][],
[`FocusNode.onKey`][], or [`FocusScopeNode.onKey`][] parameters, then there is
an equivalent [`Focus.onKeyEvent`][], [`FocusScope.onKeyEvent`][],
[`FocusNode.onKeyEvent`][], or [`FocusScopeNode.onKeyEvent`][] parameter that
supplies `KeyEvent`s instead of `RawKeyEvent`s.

Before:

```dart
Widget build(BuildContext context) {
  return Focus(
    onKey: (RawKeyEvent keyEvent) {
      print('Key event: $keyEvent');
      return KeyEventResult.ignored;
    }
    child: child,
  );
}
```

After:

```dart
Widget build(BuildContext context) {
  return Focus(
    onKeyEvent: (KeyEvent keyEvent) {
      print('Key event: $keyEvent');
      return KeyEventResult.ignored;
    }
    child: child,
  );
}
```

#### Repeat key event handling

If you were relying on the [`RawKeyEvent.repeat`][] attribute to determine if a
key was a repeated key event, that has now been separated into a separate
[`KeyRepeatEvent`][] type.

Before:

```dart
KeyEventResult _handleKeyEvent(RawKeyEvent keyEvent) {
  if (keyEvent is RawKeyDownEvent) {
    print('Key down: ${keyEvent.data.logicalKey.keyLabel}(${keyEvent.repeat ? ' (repeated)' : ''})');
  }
  return KeyEventResult.ignored;
}
```

After:

```dart
KeyEventResult _handleKeyEvent(KeyEvent _) {
  if (keyEvent is KeyDownEvent || keyEvent is KeyRepeatEvent) {
    print('Key down: ${keyEvent.logicalKey.keyLabel}(${keyEvent is KeyRepeatEvent ? ' (repeated)' : ''})');
  }
  return KeyEventResult.ignored;
}
```

Though it is not a subclass of [`KeyDownEvent`][],
a [`KeyRepeatEvent`][] is also a key down event.
Don't assume that `keyEvent is! KeyDownEvent` only allows key up events.
Check both `KeyDownEvent` and `KeyRepeatEvent`.

## Timeline

Landed in version: 3.18.0-7.0.pre<br>
In stable release: 3.19.0

## References

Replacement API documentation:

* [`Focus.onKeyEvent`][]
* [`FocusNode.onKeyEvent`][]
* [`FocusOnKeyEventCallback`][]
* [`FocusScope.onKeyEvent`][]
* [`FocusScopeNode.onKeyEvent`][]
* [`HardwareKeyboard`][]
* [`KeyboardListener`][]
* [`KeyDownEvent`][]
* [`KeyRepeatEvent`][]
* [`KeyEvent`][]
* [`KeyEventHandler`][]
* [`KeyUpEvent`][]

Relevant issues:

* [`RawKeyEvent` and `RawKeyboard`, et al should be deprecated and removed (Issue 136419)][]

Relevant PRs:

* [Deprecate RawKeyEvent, et al. and exempt uses in the framework.][]

[`debugKeyEventSimulatorTransitModeOverride`]: {{site.api}}/flutter/services/debugKeyEventSimulatorTransitModeOverride-class.html
[`Focus.onKey`]: {{site.api}}/flutter/services/Focus/onKey.html
[`FocusNode.attach`]: {{site.api}}/flutter/services/FocusNode/attach.html
[`FocusNode.onKey`]: {{site.api}}/flutter/services/FocusNode/onKey.html
[`FocusOnKeyCallback`]: {{site.api}}/flutter/services/FocusOnKeyCallback-class.html
[`FocusScope.onKey`]: {{site.api}}/flutter/services/FocusScope/onKey.html
[`FocusScopeNode.onKey`]: {{site.api}}/flutter/services/FocusScopeNode/onKey.html
[`GLFWKeyHelper`]: {{site.api}}/flutter/services/GLFWKeyHelper-class.html
[`GtkKeyHelper`]: {{site.api}}/flutter/services/GtkKeyHelper-class.html
[`KeyboardSide`]: {{site.api}}/flutter/services/KeyboardSide-class.html
[`KeyDataTransitMode`]: {{site.api}}/flutter/services/KeyDataTransitMode-class.html
[`KeyEventManager`]: {{site.api}}/flutter/services/KeyEventManager-class.html
[`KeyHelper`]: {{site.api}}/flutter/services/KeyHelper-class.html
[`KeyMessage`]: {{site.api}}/flutter/services/KeyMessage-class.html
[`KeyMessageHandler`]: {{site.api}}/flutter/services/KeyMessageHandler-class.html
[`KeySimulatorTransitModeVariant`]: {{site.api}}/flutter/services/KeySimulatorTransitModeVariant-class.html
[`ModifierKey`]: {{site.api}}/flutter/services/ModifierKey-class.html
[`RawKeyboard`]: {{site.api}}/flutter/services/RawKeyboard-class.html
[`RawKeyboardListener`]: {{site.api}}/flutter/services/RawKeyboardListener-class.html
[`RawKeyDownEvent`]: {{site.api}}/flutter/services/RawKeyDownEvent-class.html
[`RawKeyEvent`]: {{site.api}}/flutter/services/RawKeyEvent-class.html
[`RawKeyEventData`]: {{site.api}}/flutter/services/RawKeyEventData-class.html
[`RawKeyEventDataAndroid`]: {{site.api}}/flutter/services/RawKeyEventDataAndroid-class.html
[`RawKeyEventDataFuchsia`]: {{site.api}}/flutter/services/RawKeyEventDataFuchsia-class.html
[`RawKeyEventDataIos`]: {{site.api}}/flutter/services/RawKeyEventDataIos-class.html
[`RawKeyEventDataLinux`]: {{site.api}}/flutter/services/RawKeyEventDataLinux-class.html
[`RawKeyEventDataMacOs`]: {{site.api}}/flutter/services/RawKeyEventDataMacOs-class.html
[`RawKeyEventDataWeb`]: {{site.api}}/flutter/services/RawKeyEventDataWeb-class.html
[`RawKeyEventDataWindows`]: {{site.api}}/flutter/services/RawKeyEventDataWindows-class.html
[`RawKeyEventHandler`]: {{site.api}}/flutter/services/RawKeyEventHandler-class.html
[`RawKeyUpEvent`]: {{site.api}}/flutter/services/RawKeyUpEvent-class.html
[`ServicesBinding.keyEventManager`]: {{site.api}}/flutter/services/ServicesBinding/keyEventManager.html
[`Focus.onKeyEvent`]: {{site.api}}/flutter/services/Focus/onKeyEvent.html
[`FocusNode.onKeyEvent`]: {{site.api}}/flutter/services/FocusNode/onKeyEvent.html
[`FocusOnKeyEventCallback`]: {{site.api}}/flutter/services/FocusOnKeyEventCallback-class.html
[`FocusScope.onKeyEvent`]: {{site.api}}/flutter/services/FocusScope/onKeyEvent.html
[`FocusScopeNode.onKeyEvent`]: {{site.api}}/flutter/services/FocusScopeNode/onKeyEvent.html
[`HardwareKeyboard`]: {{site.api}}/flutter/services/HardwareKeyboard-class.html
[`HardwareKeyboard.isLogicalKeyPressed`]: {{site.api}}/flutter/services/HardwareKeyboard/isLogicalKeyPressed.html
[`KeyboardListener`]: {{site.api}}/flutter/services/KeyboardListener-class.html
[`KeyDownEvent`]: {{site.api}}/flutter/services/KeyDownEvent-class.html
[`KeyRepeatEvent`]: {{site.api}}/flutter/services/KeyRepeatEvent-class.html
[`KeyEvent`]: {{site.api}}/flutter/services/KeyEvent-class.html
[`KeyEventHandler`]: {{site.api}}/flutter/services/KeyEventHandler-class.html
[`KeyUpEvent`]: {{site.api}}/flutter/services/KeyUpEvent-class.html
[`RawKeyEvent.isKeyPressed`]: {{site.api}}/flutter/services/RawKeyEvent/isKeyPressed.html
[`RawKeyEvent.isControlPressed`]: {{site.api}}/flutter/services/RawKeyEvent/isControlPressed.html
[`RawKeyEvent.isShiftPressed`]: {{site.api}}/flutter/services/RawKeyEvent/isShiftPressed.html
[`RawKeyEvent.isAltPressed`]: {{site.api}}/flutter/services/RawKeyEvent/isAltPressed.html
[`RawKeyEvent.isMetaPressed`]: {{site.api}}/flutter/services/RawKeyEvent/isMetaPressed.html
[`RawKeyEvent.repeat`]: {{site.api}}/flutter/services/RawKeyEvent/repeat.html
[`RawKeyEventDataAndroid.eventSource`]: {{site.api}}/flutter/services/RawKeyEventDataAndroid/eventSource.html
[`KeyEvent.deviceType`]: {{site.api}}/flutter/services/KeyEvent/deviceType.html
[`RawKeyEvent` and `RawKeyboard`, et al should be deprecated and removed (Issue 136419)]: {{site.repo.flutter}}/issues/136419
[Deprecate RawKeyEvent, et al. and exempt uses in the framework.]: {{site.repo.flutter}}/pull/136677
