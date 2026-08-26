---
title: Restrict command-line flags on prebuilt Android release binaries
description: >-
  Passing configuration flags to prebuilt Android release binaries with
  `--use-application-binary` is no longer supported.
---

{% render "docs/breaking-changes.md" %}

## Summary

Previously, the Flutter CLI could pass engine configuration flags
(such as `--dart-flags`) to a prebuilt Android release binary
(`--use-application-binary --release`) at launch time using Android
`Intent` extras, which the embedding accepted in all build modes.

To protect production applications against `Intent`-based spoofing
vulnerabilities, Flutter Android release builds now ignore `Intent` extras
and read engine configuration strictly from the compiled `AndroidManifest.xml`.
Because prebuilt binaries cannot have their manifests dynamically modified
after compilation, the Flutter CLI now produces a fatal error if you pass
engine configuration flags to a prebuilt release binary (preventing flags from being
silently ignored).

Standard release builds (where the CLI compiles the app and injects flags into
the manifest) and all debug and profile workflows continue to work
without changes.

## Context

The Flutter CLI allows passing flags (such as `--dart-flags` or tracing options)
to configure the Flutter engine when running or driving an application.
Historically, the Flutter Android embedding accepted these flags at runtime
through [`Intent`][] extras.

However, runtime `Intent` extras on Android can be spoofed or intercepted
by other applications on a user's device.
To harden production applications, Flutter Android release builds now read
configuration strictly from a cryptographically signed `AndroidManifest.xml`
and ignore runtime `Intent` flags.

For release builds of standard Gradle-based projects, the Flutter CLI automatically injects
command-line flags into `AndroidManifest.xml` during compilation.
When you use a prebuilt release binary with `--use-application-binary`,
the CLI cannot modify the compiled manifest, and the binary ignores
runtime `Intent` flags.
To prevent tests or scripts from running with unnoticed configuration failures,
the CLI now reports a fatal error.

Debug and profile builds intentionally maintain runtime flag support
to preserve testing velocity and dynamic benchmarking workflows.

[`Intent`]: https://developer.android.com/reference/android/content/Intent

## Description of change

The Flutter CLI enforces the following behavior when running Flutter apps
on Android:

| Build mode | Using `--use-application-binary` | CLI behavior | Notes |
| :--- | :--- | :--- | :--- |
| **Debug / Profile** | Yes | Passes flags to binary through `adb` | No rebuild required; flags apply at runtime. |
| **Debug / Profile** | No | Builds and passes flags through `adb` | Standard development workflow. |
| **Release** | Yes | **Fatal error** if configuration flags are provided | Prebuilt release binaries cannot be dynamically configured. |
| **Release** | No | Injects flags into `AndroidManifest.xml` during compilation | Standard release build workflow. |

## Migration guide

:::note
You are **not affected** and do not need to take action if:
- You build and run standard release apps (`flutter run --release`,
  `flutter build apk --release`, `flutter build appbundle`).
- You run tests and benchmarks in **debug** or **profile** mode.
- You use `--use-application-binary` without passing engine configuration flags.
:::

If your CI/CD pipelines, automated scripts, or build systems pass flags to
prebuilt release binaries, use one of the following migration paths:

### Switch testing and benchmarking to profile mode

If your automated test pipelines use `--use-application-binary` with `--release`
to dynamically test different engine configurations:

1. Switch your test target to **profile mode** (`--profile`).
   Profile mode mirrors release performance characteristics while retaining
   support for dynamic runtime flag configuration without recompilation.

### Build release binaries with flags directly

If you must run tests against a release binary:

1. Run `flutter build` or `flutter run` with your configuration flags
   without `--use-application-binary`.
   The CLI automatically embeds the flags into the compiled manifest.
1. Alternatively, compile separate release binaries for each required
   test configuration.

### Configure non-Gradle or hermetic build systems

If you build Flutter Android applications using hermetic build systems
(such as Bazel) that separate compilation from execution:

1. Statically declare any necessary engine flags in
   `AndroidManifest.xml` before compiling the release APK.
1. Use **profile mode** for test targets that require dynamic configuration
   at launch time.

### Declare engine flags in `AndroidManifest.xml`

To configure engine flags statically in release builds,
add `<meta-data>` elements under the `<application>` tag in
your `android/app/src/main/AndroidManifest.xml` file:

```xml title="AndroidManifest.xml" highlightLines=6-13
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="my_app"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <!-- Declare engine configuration flags statically -->
        <meta-data
            android:name="io.flutter.embedding.android.DartFlags"
            android:value="--some-dart-flag" />
        <meta-data
            android:name="io.flutter.embedding.android.EnableDartProfiling"
            android:value="false" />
        <activity
            ...
        </activity>
    </application>
</manifest>
```

## Timeline

Landed in version: TBD<br>
In stable release: TBD

## References

Design document:

* [go/flutter-android-secure-intents](http://goto.google.com/flutter-android-secure-intents)

Relevant issues:

* [Issue 180686][]

Relevant pull requests:

* [PR 190870][]

[Issue 180686]: https://github.com/flutter/flutter/issues/180686
[PR 190870]: https://github.com/flutter/flutter/pull/190870
