---
title: Flutter's build modes
description: Describes Flutter's build modes and when you should use debug, release, or profile mode?
---

The Flutter tooling supports three modes when compiling your app,
and a headless mode for testing.
This doc explains the three modes and tells you when to use which.
For more information on headless testing, see
[Unit testing.](/docs/testing#unit-testing)

You choose the compilation mode depending on where you are in
the development cycle. Are you debugging your code? Do you
need profiling information? Are you ready to deploy your app?

The following describes each mode and when to use it.

## Debug

In _debug mode_, the app is set up for debugging on the physical
device, emulator, or simulator. Debug mode means that:

* [Assertions]({{site.dart-site}}/guides/language/language-tour#assert)
   are enabled.
* [Observatory](https://dart-lang.github.io/observatory) is enabled,
   allowing you to use the dart debugger.
* Service extensions are enabled.
* Compilation is optimized for fast development and run cycles (but not for
  execution speed, binary size, or deployment.)

By default, `flutter run` compiles to debug mode.
Your IDE also supports these modes. Android Studio,
for example, provides a **Run > Debug...** menu option, as well
as an triangular green run button icon on the project page.
(The menu item shows a pic of the corresponding icon.)
The emulator and simulator execute _only_ in debug mode.

## Release

Use _release mode_ for deploying the app, when you want maximum
optimization and minimal footprint size. Release mode, which is not
supported on the simulator or emulator, means that:

* Assertions are disabled.
* Debugging information is stripped out.
* Debugging is disabled.
* Compilation is optimized for fast startup, fast execution, and small
  package sizes.
* Service extensions are disabled.

The command `flutter run --release` compiles to release mode.
Your IDE also supports these modes.  Android Studio, for example,
provides a **Run > Run...** menu option, as well as a green bug
icon overlayed with a small triangle on the project page.
(The menu item shows a pic of the corresponding icon.)

You can also compile to release mode with `flutter build`.
For more information, see the docs on releasing
[iOS](../deployment/ios) and [Android](../deployment/android) apps.

## Profile

In _profile mode_, some debugging ability is maintained&mdash;enough
to profile your app's performance. Profile mode is disabled on
the emulator and simulator, because their behavior is not representative
of real performance. Profile mode is similar to release mode, with
the following differences:

* Some service extensions, such as the one that enables the performance
  overlay, are enabled.
* Tracing is enabled, and Observatory can connect to the process.

The command `flutter run --profile` compiles to profile mode.
Your IDE also supports these modes. Android Studio, for example,
provides a **Run > Profile...** menu option.

For more information on these modes, see
[Flutter's modes]({{site.github}}/flutter/flutter/wiki/Flutter%27s-modes)
in the [Flutter SDK wiki]({{site.github}}/flutter/flutter/wiki).
