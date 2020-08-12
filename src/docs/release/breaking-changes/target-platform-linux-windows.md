---
title: Adding 'linux' and 'windows' to TargetPlatform enum
description: Two new values were added to the TargetPlatform enum that could require additional cases in switch statements that switch on a TargetPlatform.
---

## Summary

Two new values were added to the [`TargetPlatform`][] enum
that could require additional cases in switch statements that
switch on a `TargetPlatform` and don't include a `default:` case.

## Context

Prior to this change, the `TargetPlatform` enum only contained four values,
and was defined like this:

<!-- skip -->
```dart
enum TargetPlatform {
  android,
  fuchsia,
  iOS,
  macOS,
}
```

A `switch` statement only needed to handle these cases,
and desktop applications that wanted to run on Linux or
Windows usually had a test like this in their
`main()` method:

<!-- skip -->
```dart
// Sets a platform override for desktop to avoid exceptions. See
// https://flutter.dev/desktop#target-platform-override for more info.
void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  runApp(MyApp());
}
```

## Description of change

The `TargetPlatform` enum is now defined as:

<!-- skip -->
```dart
enum TargetPlatform {
  android,
  fuchsia,
  iOS,
  linux, // new value
  macOS,
  windows, // new value
}
```

And the platform test setting
[`debugDefaultTargetPlatformOverride`][] in `main()`
is no longer required on Linux and Windows.

This can cause the Dart analyzer to give the
[`missing_enum_constant_in_switch`][] warning for
switch statements that don't include a `default` case.
Writing a switch without a `default:` case is the
recommended way to handle enums, since the analyzer
can then help you find any cases that aren't handled.

## Migration guide

In order to migrate to the new enum, and avoid the analyzer's
`missing_enum_constant_in_switch` error, which looks like:

```
warning: Missing case clause for 'linux'. (missing_enum_constant_in_switch at [package] path/to/file.dart:111)
```

or 

```
warning: Missing case clause for 'windows'. (missing_enum_constant_in_switch at [package] path/to/file.dart:111)
```

Modify your code as follows: 

Code before migration:

<!-- skip -->
```dart
void dance(TargetPlatform platform) {
  switch (platform) {
    case TargetPlatform.android:
      // Do Android dance.
      break;
    case TargetPlatform.fuchsia:
      // Do Fuchsia dance.
      break;
    case TargetPlatform.iOS:
      // Do iOS dance.
      break;
    case TargetPlatform.macOS:
      // Do macOS dance.
      break;
  }
}
```

Code after migration:

<!-- skip -->
```dart
void dance(TargetPlatform platform) {
  switch (platform) {
    case TargetPlatform.android:
      // Do Android dance.
      break;
    case TargetPlatform.fuchsia:
      // Do Fuchsia dance.
      break;
    case TargetPlatform.iOS:
      // Do iOS dance.
      break;
    case TargetPlatform.linux: // new case
      // Do Linux dance.
      break;
    case TargetPlatform.macOS:
      // Do macOS dance.
      break;
    case TargetPlatform.windows: // new case
      // Do Windows dance.
      break;
  }
}
```

Having `default:` cases in such switch statements isn't
recommended, because then the analyzer can't help you find
all the cases that need to be handled.

Also, any tests like the one referenced above that set the
`debugDefaultTargetPlatformOverride` are no longer needed
for Linux and Windows applications.

## Timeline

Landed in version: 1.15.4<br>
In stable release: 1.17

## References

API documentation:
* [`TargetPlatform`][]

Relevant issues:
* [Issue #31366][]

Relevant PR:
* [Add Windows, and Linux as TargetPlatforms][]

[Add Windows, and Linux as TargetPlatforms]: {{site.github}}/flutter/flutter/pull/51519
[`debugDefaultTargetPlatformOverride`]: {{site.api}}/flutter/foundation/debugDefaultTargetPlatformOverride.html
[Issue #31366]: {{site.github}}/flutter/flutter/issues/31366
[`missing_enum_constant_in_switch`]: {{site.dart-site}}/tools/diagnostic-messages#missing_enum_constant_in_switch
[`TargetPlatform`]: {{site.api}}/flutter/foundation/TargetPlatform-class.html
