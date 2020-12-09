---
title: Nullable CupertinoThemeData.brightness
description: CupertinoThemeData.brightness is now nullable, and it returns the value specified by the user (defaults to null) as is.
---

## Summary
[`CupertinoThemeData.brightness`] is now nullable.

## Context

[`CupertinoThemeData.brightness`][] is now used to
override `MediaQuery.platformBrightness` for Cupertino widgets.
Before this change, the [`CupertinoThemeData.brightness`][]
getter returned `Brightness.light` when it was set to null.

## Description of change

Previously [`CupertinoThemeData.brightness`][]
was implemented as a getter:

<!-- skip -->
```dart
Brightness get brightness => _brightness ?? Brightness.light;
final Brightness _brightness;
```

It is now a stored property:

<!-- skip -->
```dart
final Brightness brightness;
```

## Migration guide

Generally [`CupertinoThemeData.brightness`][]
is rarely useful outside of the Flutter framework.
To retrieve the brightness for Cupertino widgets,
now use [`CupertinoTheme.brightnessOf`][] instead.

With this change, it is now possible to override
`CupertinoThemeData.brightness` in a `CupertinoThemeData`
subclass to change the brightness override. For example:

<!-- skip -->
```dart
class AwaysDarkCupertinoThemeData extends CupertinoThemeData {
  Brightness brightness => Brightness.dark;
}
```

When a `CupertinoTheme` uses the above `CupertinoThemeData`,
dark mode is enabled for all its Cupertino descendants
that are affected by this `CupertinoTheme`.


## Timeline

Landed in version: 1.16.3<br>
In stable release: 1.17

## References

Design doc:
* [Make `CupertinoThemeData.brightness nullable`][]

API documentation:
* [`CupertinoThemeData.brightness`][]

Relevant issue:
* [Issue 47255][]

Relevant PR:
* [Let material `ThemeData` dictate brightness if `cupertinoOverrideTheme.brightness` is null][]


[`CupertinoTheme.brightnessOf`]: {{site.api}}/flutter/cupertino/CupertinoTheme/brightnessOf.html
[`CupertinoThemeData.brightness`]: {{site.api}}/flutter/cupertino/CupertinoThemeData/brightness.html
[Issue 47255]: {{site.github}}/flutter/flutter/issues/47255
[Let material `ThemeData` dictate brightness if `cupertinoOverrideTheme.brightness` is null]: {{site.github}}/flutter/flutter/pull/47249
[Make `CupertinoThemeData.brightness nullable`]: /go/nullable-cupertinothemedata-brightness
