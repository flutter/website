---
title: nullable CupertinoThemeData.brightness 
description: CupertinoThemeData.brightness is now nullable, and it returns the value specified by the user (defaults to null) as is.
---

## Summary
[`CupertinoThemeData.brightness`] is now nullable.

## Context

[`CupertinoThemeData.brightness`] is used to override `MediaQuery.platformBrightness` for Cupertino widgets. 
Before this change, the [`CupertinoThemeData.brightness`] getter returns `Brightness.light` when it's set to null. 

## Description of change

Previously [`CupertinoThemeData.brightness`] was implemented as a getter:
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

Generally [`CupertinoThemeData.brightness`] is rarely useful outside of the Flutter framework. To retrieve the brightness for Cupertino widgets, use [`CupertinoTheme.brightnessOf`] instead.

With this change, it is now possible to override `CupertinoThemeData.brightness` in a `CupertinoThemeData` subclass to change the brightness override. For example:

```dart
class AwaysDarkCupertinoThemeData extends CupertinoThemeData {
  Brightness brightness => Brightness.dark;
}
```
when a `CupertinoTheme` uses the above `CupertinoThemeData`, dark mode will be enabled for all its Cupertino descendants that are affected by this `CupertinoTheme`.


## Timeline

This change was made in January of 2020 after the v1.13.7 release.

## References
Design doc:
* [Make `CupertinoThemeData.brightness nullable`]

API documentation:
* [`CupertinoThemeData.brightness`]

Relevant issues:
* [Issue 47255] 

Relevant PRs:
* [Let material `ThemeData` dictate brightness if `cupertinoOverrideTheme.brightness` is null]


[Make `CupertinoThemeData.brightness nullable`]: /go/nullable-cupertinothemedata-brightness
[`CupertinoThemeData.brightness`]: {{site.api}}/flutter/cupertino/CupertinoThemeData/brightness.html
[`CupertinoTheme.brightnessOf`]: https://api.flutter.dev/flutter/cupertino/CupertinoTheme/brightnessOf.html
[Issue 47255]: {{site.github}}/flutter/flutter/issues/47255
[Let material `ThemeData` dictate brightness if `cupertinoOverrideTheme.brightness` is null]: {{site.github}}/flutter/flutter/pull/47249
