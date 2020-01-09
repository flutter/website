---
title: nullable CupertinoThemeData.brightness 
description: CupertinoThemeData.brightness should be nullable, and it should return the value specified by the user (defaults to null) as is.
---

# Nullable `CupertinoThemeData.brightness` 


## Context

`CupertinoThemeData.brightness` is used to override `MediaQuery.platformBrightness` for Cupertino widgets. Currently the `CupertinoThemeData.brightness`getter returns `Brightness.light` when it's set to null. 


## Description of change

`CupertinoThemeData.brightness`, currently implemented as a getter:
```dart
Brightness get brightness => _brightness ?? Brightness.light;
final Brightness _brightness;
```
, becomes a stored property
```dart
final Brightness brightness;
```

## Migration guide

Generally `CupertinoThemeData.brightness` is rarely useful outside of the Flutter framework. To retrieve the brightness for Cupertino widgets, use [`CupertinoTheme.brightnessOf`](https://api.flutter.dev/flutter/cupertino/CupertinoTheme/brightnessOf.html) instead.

With this change, it is now possible to override `CupertinoThemeData.brightness` in a `CupertinoThemeData` subclass to change the brightness override. For example:

```dart
class AwaysDarkCupertinoThemeData extends CupertinoThemeData {
  Brightness brightness => Brightness.dark;
}
```
when a `CupertinoTheme` uses the above `CupertinoThemeData`, dark mode will be enabled for all its Cupertino descendants that are affected by this `CupertinoTheme`.


## Timeline

Expect to land in v1.13.x.

## References

API documentation:
* https://api.flutter.dev/flutter/cupertino/CupertinoThemeData/brightness.html

Relevant issues:
* https://github.com/flutter/flutter/issues/47255

Relevant PRs:
* https://github.com/flutter/flutter/pull/47249
