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

[Code obfuscation]: https://en.wikipedia.org/wiki/Obfuscation_(software)

## Limitations and warnings {: #limitations}

**Flutter's code obfuscation works
only on a [release build][].**

:::warning
It is a **poor security practice** to
store secrets in an app.
:::

Obfuscating your code does _not_
encrypt resources nor does it protect against
reverse engineering.
It only renames symbols with more obscure names.

Web apps don't support obfuscation.
A web app can be [minified][], which provides a similar result.
When you build a release version of a Flutter web app,
the web compiler minifies the app. To learn more,
see [Build and release a web app][].

[release build]: /testing/build-modes#release
[Build and release a web app]: /deployment/web
[minified]: https://en.wikipedia.org/wiki/Minification_(programming)

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

For detailed information about the command line options
available for a build target, run the following
command. The `--obfuscate` and  `--split-debug-info` options should
be listed in the output. If they aren't, you'll need to
install a newer version of Flutter to obfuscate your code.

```console
$ flutter build <build-target> -h
```
   *  `<build-target>`: The build target. For example,
      `apk`.

## Obfuscate your app

To obfuscate your app and create a symbol map, use the
`flutter build` command in release mode
with the `--obfuscate` and `--split-debug-info` options.
If you want to debug your obfuscated
app in the future, you will need the symbol map.

1. Run the following command to obfuscate your app and
   generate a SYMBOLS file:

   ```console
   $ flutter build <build-target> \
      --obfuscate \
      --split-debug-info=/<symbols-directory>
   ```

   *  `<build-target>`: The build target. For example,
      `apk`.
   *  `<symbols-directory>`: The directory where the SYMBOLS
      file should be placed. For example,
      `out/android`.

1. Once you've obfuscated your binary, **backup
   the SYMBOLS file**. You might need this if you lose
   your original SYMBOLs file and you
   want to de-obfuscate a stack trace.

## Read an obfuscated stack trace

To debug a stack trace created by an obfuscated app,
use the following steps to make it human readable:

1. Find the matching SYMBOLS file.
   For example, a crash from an Android arm64
   device would need `app.android-arm64.symbols`.

1. Provide both the stack trace (stored in a file)
   and the SYMBOLS file to the `flutter symbolize` command.

   ```console
   $ flutter symbolize \
      -i <stack-trace-file> \
      -d <obfuscated-symbols-file>
   ```

   *  `<stack-trace-file>`: The file path for the
      stacktrace. For example, `???`.
   *  `<obfuscated-symbols-file>`: The file path for the
      symbols file that contains the obfuscated symbols.
      For example, `out/android/app.android-arm64.symbols`.

   For more information about the `symbolize` command,
   run `flutter symbolize -h`.

## Read an obfuscated name

You can generate a JSON file that contains
an obfuscation map. An obfuscation map is a JSON array with
pairs of original names and obfuscated names. For example,
`["MaterialApp", "ex", "Scaffold", "ey"]`, where
`ex` is the obfuscated name of `MaterialApp`.

To generate an obfuscation map, use the following command:

```console
$ flutter build <build-target> \
   --obfuscate \
   --split-debug-info=/<symbols-directory> \
   --extra-gen-snapshot-options=--save-obfuscation-map=/<obfuscation-map-file>
```

*  `<build-target>`: The build target. For example,
   `apk`.
*  `<symbols-directory>`: The directory where the symbols
   should be placed. For example, `out/android`
*  `<obfuscation-map-file>`: The file path where the
   JSON obfuscation map should be placed. For example,
   `out/android/map.json`

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
