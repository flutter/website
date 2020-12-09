---
title: Obfuscating Dart code
description: How to remove function and class names from your Dart binary.
---

[Code obfuscation][] is the process of modifying an
app's binary to make it harder for humans to understand.
Obfuscation hides function and class names in your
compiled Dart code, making it difficult for an attacker
to reverse engineer your proprietary app.

The following list describes which platforms
support the obfuscation process described in
this page:

**Android**/**iOS**
: Supported as of Flutter 1.16.2.  To obfuscate
  an app built against an earlier version of Flutter,
  use the [obfuscation instructions][] on the Flutter wiki.

**macOS**
: macOS ([in alpha][] as of Flutter 1.13),
  supports obfuscation as of Flutter 1.16.2.

**Linux**/**Windows**
: Not yet supported.

**web**
: Obfuscation is not supported for web apps,
  but a web app can be [minified][],
  which is similar. When you build a
  release version of a Flutter web app, it
  is automatically minified. For more information,
  see [Build and release a web app][].

**Flutter's code obfuscation, when supported, works
only on a [release build][].**

## Obfuscating your app

To obfuscate your app, build a release
version using the `--obfuscate` flag,
combined with the `--split-debug-info` flag.
The `--split-debug-info` flag specifies the
directory where Flutter can output debug files.
This command generates a symbol map.
The `apk`, `appbundle`, `ios`, and `ios-framework`
targets are currently supported. (`macos` and
`aar` are supported on the master and dev
channels.)
For example:

```terminal
flutter build apk --obfuscate --split-debug-info=/<project-name>/<directory>
```

Once you've obfuscated your binary, save
the symbols file. You need this if you later
want to de-obfuscate a stack trace.

**Note that the `--split-debug-info` flag can also
be used by itself. In fact, it can dramatically
reduce code size. For more information on
app size, see [Measuring your app's size][].**

For detailed information on these flags, run
the help command for your specific target, for example:

```terminal
flutter build apk -h
```

If these flags are not listed in the output,
run `flutter --version` to check your version of Flutter.

## Reading an obfuscated stack trace

To debug a stack trace created by an obfuscated app,
use the following steps to make it human readable:

1. Find the matching symbols file.
   For example, a crash from an Android arm64
   device would need `app.android-arm64.symbols`.

1. Provide both the stack trace (stored in a file)
   and the symbols file to the `flutter symbolize` command.
   For example:

```terminal
flutter symbolize -i <stack trace file> -d /out/android/app.android-arm64.symbols
```

   For more information on the `symbolize` command,
   run `flutter symbolize -h`.

## Caveat

Be aware of the following when coding an app that will
eventually be an obfuscated binary.

* Code that relies on matching specific class, function,
  or library names will fail.
  For example, the following call to `expect()` will not
  work in an obfuscated binary:

<!-- skip -->
```dart
expect(foo.runtimeType.toString(), equals('Foo'))
```


[Build and release a web app]: /docs/deployment/web
[Code obfuscation]: https://en.wikipedia.org/wiki/Obfuscation_(software)
[in alpha]: /desktop
[Measuring your app's size]: /docs/perf/app-size
[minified]: https://en.wikipedia.org/wiki/Minification_(programming)
[obfuscation instructions]: {{site.github}}/flutter/flutter/wiki/Obfuscating-Dart-Code
[release build]: /docs/testing/build-modes
