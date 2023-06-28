---
title: Obfuscate Dart code
description: How to remove function and class names from your Dart binary.
---

<?code-excerpt path-base="deployment/obfuscate"?>

## What is code obfuscation?

[Code obfuscation][] is the process of modifying an
app's binary to make it harder for humans to understand.
Obfuscation hides function and class names in your
compiled Dart code, replacing each symbol with
another symbol, making it difficult for an attacker
to reverse engineer your proprietary app.

**Flutter's code obfuscation works
only on a [release build][].**

[Code obfuscation]: https://en.wikipedia.org/wiki/Obfuscation_(software)
[release build]: {{site.url}}/testing/build-modes#release

## Limitations

Note that obfuscating your code does _not_
encrypt resources nor does it protect against
reverse engineering.
It only renames symbols with more obscure names.

{{site.alert.info}}
  It is a **poor security practice** to
  store secrets in an app.
{{site.alert.end}}

## Supported targets

The following build targets
support the obfuscation process
described on this page:

* `aar`
* `apk`
* `appbundle`
* `ios`
* `ios-framework`
* `ipa`
* `linux`
* `macos`
* `macos-framework`
* `windows`

{{site.alert.info}}
  Web apps don't support obfuscation.
  A web app can be [minified][], which provides a similar result.
  When you build a release version of a Flutter web app,
  the web compiler minifies the app. To learn more,
  see [Build and release a web app][].
{{site.alert.end}}

[Build and release a web app]: {{site.url}}/deployment/web
[minified]: https://en.wikipedia.org/wiki/Minification_(programming)

## Obfuscate your app

To obfuscate your app, use the `flutter build` command
in release mode
with the `--obfuscate` and  `--split-debug-info` options.
The `--split-debug-info` option specifies the directory
where Flutter outputs debug files.
In the case of obfuscation, it outputs a symbol map.
For example:

```terminal
$ flutter build apk --obfuscate --split-debug-info=/<project-name>/<directory>
```

Once you've obfuscated your binary, **save
the symbols file**. You need this if you later
want to de-obfuscate a stack trace.

{{site.alert.tip}}
  The `--split-debug-info` option can also be used without `--obfuscate`
  to extract Dart program symbols, reducing code size.
  To learn more about app size, see [Measuring your app's size][].
{{site.alert.end}}

[Measuring your app's size]: {{site.url}}/perf/app-size

For detailed information on these flags, run
the help command for your specific target, for example:

```terminal
$ flutter build apk -h
```

If these flags are not listed in the output,
run `flutter --version` to check your version of Flutter.

## Read an obfuscated stack trace

To debug a stack trace created by an obfuscated app,
use the following steps to make it human readable:

1. Find the matching symbols file.
   For example, a crash from an Android arm64
   device would need `app.android-arm64.symbols`.

1. Provide both the stack trace (stored in a file)
   and the symbols file to the `flutter symbolize` command.
   For example:

   ```terminal
   $ flutter symbolize -i <stack trace file> -d out/android/app.android-arm64.symbols
   ```

   For more information on the `symbolize` command,
   run `flutter symbolize -h`.

## Read an obfuscated name

To make the name that an app obfuscated human readable,
use the following steps:

1. To save the name obfuscation map at app build time,
   use `--extra-gen-snapshot-options=--save-obfuscation-map=/<your-path>`.
   For example:

   ```terminal
   $ flutter build apk --obfuscate --split-debug-info=/<project-name>/<directory> --extra-gen-snapshot-options=--save-obfuscation-map=/<your-path>
   ```

1. To recover the name, use the generated obfuscation map.
   The obfuscation map is a flat JSON array with pairs of
   original names and obfuscated names. For example,
   `["MaterialApp", "ex", "Scaffold", "ey"]`, where `ex`
   is the obfuscated name of `MaterialApp`.

## Caveat

Be aware of the following when coding an app that will
eventually be an obfuscated binary.

* Code that relies on matching specific class, function,
  or library names will fail.
  For example, the following call to `expect()` won't
  work in an obfuscated binary:

<?code-excerpt "lib/main.dart (Expect)"?>
```dart
expect(foo.runtimeType.toString(), equals('Foo'));
```

* Enum names are not obfuscated currently.
