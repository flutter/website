---
title: Restrict Android engine flags in release mode
description: >-
  Passing engine configuration flags to Android release binaries using
  Android `Intent` extras or `--use-application-binary` is no longer supported.
---

{% render "docs/breaking-changes.md" %}

## Summary

Previously, the Flutter Android embedding accepted engine configuration flags
(such as `--dart-flags`, `--route`, or tracing flags)
at launch time through Android `Intent` extras in all build modes.
This mechanism allowed developers and tools—including the Flutter CLI
when using `--use-application-binary`—to dynamically configure
running applications without modifying their source code or manifest.

To protect production applications against `Intent`-based spoofing
and parameter injection vulnerabilities,
Flutter Android release builds now ignore engine configuration flags
passed through `Intent` extras,
reading engine configuration strictly from the compiled `AndroidManifest.xml`
or from programmatic configuration prior to engine initialization.

This change impacts workflows in two ways:

- **Direct `Intent` launches:**
  Passing engine configuration flags through `Intent` extras
  (such as through `adb shell am start` or native Android code)
  is ignored by the embedding in release builds.
- **Flutter CLI prebuilt binaries:**
  Because prebuilt binaries cannot have their manifests dynamically modified
  after compilation, the Flutter CLI now produces a fatal error
  if you pass engine configuration flags to a prebuilt release binary
  with `flutter run --release --use-application-binary`.
  This prevents flags from being silently ignored.

Standard release builds
(where the CLI compiles the app with Gradle and injects flags into the manifest)
and all debug and profile workflows continue to work without changes.

## Context

The Flutter engine accepts configuration flags
(such as `--dart-flags`, `--route`, or `--trace-startup`)
to configure runtime behavior when running or driving an application.
Historically, the Flutter Android embedding accepted these flags at runtime
through [`Intent`][] extras.
Both developers (using `adb shell am start` or native code)
and the Flutter CLI (via `adb`) relied on `Intent` extras
to pass flags to running apps.

However, runtime `Intent` extras on Android can be spoofed or intercepted
by other applications on a user's device.
Allowing arbitrary engine flags in production builds presents
security vulnerabilities, such as dynamic parameter injection attacks
(for example, spoofing `--aot-shared-library-name`).

To harden production applications, Flutter establishes
a build-mode-specific trust boundary:

- **Release mode:**
  Production application boundaries are treated as immutable.
  The Android embedding ignores engine configuration flags passed
  through `Intent` extras and logs a warning.
  Release builds read configuration strictly from a signed
  `AndroidManifest.xml` or from programmatic setup before engine startup.
- **Debug and profile modes:**
  Dynamic `Intent` flag support is intentionally maintained
  to preserve developer velocity, dynamic benchmarking,
  and local testing workflows.

For release builds of standard Gradle-based projects,
the Flutter CLI automatically injects command-line flags
into `AndroidManifest.xml` during compilation.
When you use a prebuilt release binary with `--use-application-binary`,
the CLI cannot modify the compiled manifest,
and the binary ignores runtime `Intent` flags.
To prevent tests or scripts from running with unnoticed configuration failures,
the CLI reports a fatal error.

Similarly, any automated scripts, test runners, or host applications
that directly construct Android `Intent`s with configuration extras
will find those flags ignored when launching a release binary.

[`Intent`]: https://developer.android.com/reference/android/content/Intent

## Description of change

### Android embedding behavior

The Flutter Android embedding enforces the following behavior
when receiving engine configuration flags through Android `Intent` extras
(such as from `adb shell am start` or native `Intent.putExtra()` calls):

| Build mode | Intent extras behavior | Notes |
| :--- | :--- | :--- |
| **Debug / Profile** | Accepted and parsed | Flags apply dynamically at launch time. |
| **Release** | **Ignored** | The embedding logs a warning and discards all engine configuration flags received from `Intent` extras. |

In addition, the internal interface method
`FlutterActivityAndFragmentDelegate.Host.getFlutterShellArgs` is deprecated
in favor of `getFlutterEngineFlags()`.

### Flutter CLI behavior

The Flutter CLI enforces the following behavior
when running Flutter apps on Android:

| Build mode | Using `--use-application-binary` | CLI behavior | Notes |
| :--- | :--- | :--- | :--- |
| **Debug / Profile** | Yes | Passes flags to binary through `adb` | No rebuild required; flags apply at runtime. |
| **Debug / Profile** | No | Builds and passes flags through `adb` | Standard development workflow. |
| **Release** | Yes | **Fatal error** if configuration flags are provided | Prebuilt release binaries cannot be dynamically configured. |
| **Release** | No | Injects flags into `AndroidManifest.xml` during compilation | Standard release build workflow. |

## Migration guide

:::note
You are **not affected** and do not need to take action if:
- You build and run standard release apps with the Flutter CLI
  (`flutter run --release`, `flutter build apk --release`,
  or `flutter build appbundle`).
- You run tests and benchmarks in **debug** or **profile** mode.
- You use `--use-application-binary` without passing engine configuration flags.
:::

You are **affected** if:
- You launch release builds using Android `Intent` extras directly
  (such as with `adb shell am start` or custom launch intents in native code)
  to pass engine configuration flags or route arguments.
- Your CI/CD pipelines, automated scripts, or test runners pass flags
  to prebuilt release binaries using `--use-application-binary`.
- You build Flutter Android applications using non-Gradle or hermetic build
  systems (such as Bazel) and configure release binaries with launch-time flags.

If your workflows are affected, use one of the following migration paths:

### Switch testing and benchmarking to profile mode

If your automated test pipelines, scripts, or benchmarks pass flags
to release binaries dynamically at launch time:

1.  Switch your test target to **profile mode** (`--profile`).
    Profile mode mirrors release performance characteristics
    while retaining support for dynamic runtime flag configuration
    through `Intent` extras and the Flutter CLI without recompilation.

### Configure direct Intent launches and hermetic build systems

If you launch release builds using Android `Intent`s directly
(for example, via `adb shell am start` or custom test runners),
or if you build Flutter Android apps with non-Gradle or hermetic build systems
(such as Bazel) that separate compilation from execution:

1.  **Do not rely on `Intent` extras for release builds.**
    Any engine flags passed in `Intent` extras to a release binary
    are silently ignored by the embedding at runtime.
1.  **Use profile mode for dynamic testing:**
    For integration tests or performance benchmarks that require
    varying flags dynamically at launch time, compile and run
    a **profile** build instead of a release build.
1.  **Declare flags statically in `AndroidManifest.xml`:**
    If you must run a release binary with specific engine flags,
    statically declare those flags in your `AndroidManifest.xml`
    before compiling the release binary.
    For details, refer to
    [Declare engine flags in `AndroidManifest.xml`](#declare-engine-flags-in-androidmanifestxml).

### Build release binaries with flags directly using the Flutter CLI

If you must run tests against a release binary with the Flutter CLI:

1.  Run `flutter build` or `flutter run` with your configuration flags
    without `--use-application-binary`.
    The CLI automatically embeds the flags into the compiled manifest.
1.  Alternatively, compile separate release binaries
    for each required configuration.

### Configure engine flags programmatically in native host code

If you launch Flutter from native Android code
(such as in an add-to-app integration or custom native activity)
and previously passed engine flags through `Intent` extras:

1.  **Override `getFlutterEngineFlags()`:**
    If you subclass `FlutterActivity` or `FlutterFragment`, override
    `getFlutterEngineFlags()` instead of using `Intent` extras
    or the deprecated `getFlutterShellArgs()`:

    ```kotlin
    class MyFlutterActivity : FlutterActivity() {
        override fun getFlutterEngineFlags(): List<String> {
            val flags = super.getFlutterEngineFlags().toMutableList()
            flags.add("--trace-startup")
            return flags
        }
    }
    ```

1.  **Use `FlutterFragment.NewEngineFragmentBuilder`:**
    If you host a `FlutterFragment`, pass flags using the builder:

    ```kotlin
    val fragment = FlutterFragment.NewEngineFragmentBuilder()
        .flutterEngineFlags(listOf("--trace-startup"))
        .build<FlutterFragment>()
    ```

1.  **Pre-initialize and cache a `FlutterEngine`:**
    If you manage the engine lifecycle directly, supply engine arguments
    to the `FlutterEngine` constructor:

    ```kotlin
    val args = arrayOf("--trace-startup", "--enable-impeller=true")
    val flutterEngine = FlutterEngine(context, args)
    FlutterEngineCache.getInstance().put("my_engine_id", flutterEngine)
    ```

### Declare engine flags in `AndroidManifest.xml`

To configure engine flags statically in release builds,
add `<meta-data>` elements under the `<application>` tag in
your `android/app/src/main/AndroidManifest.xml` file:

```xml title="AndroidManifest.xml" highlightLines=6-12
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

Relevant issues:

* [Issue 180686][]
* [Issue 190461][]

Relevant pull requests:

* [PR 190870][]
* [PR 191328][]
* [PR 191924][]

[Issue 180686]: https://github.com/flutter/flutter/issues/180686
[Issue 190461]: https://github.com/flutter/flutter/issues/190461
[PR 190870]: https://github.com/flutter/flutter/pull/190870
[PR 191328]: https://github.com/flutter/flutter/pull/191328
[PR 191924]: https://github.com/flutter/flutter/pull/191924
