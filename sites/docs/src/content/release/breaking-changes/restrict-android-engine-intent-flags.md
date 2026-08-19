---
title: Restrict Android engine flags through Intent extras in release mode
description: >-
  Flutter Android apps no longer accept engine configuration flags from Intent
  extras in release builds.
---

{% render "docs/breaking-changes.md" %}

## Summary

To protect against `Intent`-based spoofing vulnerabilities in production,
the Flutter Android embedding no longer parses Flutter engine configuration
flags from `Intent` extras in release builds.

In debug and profile builds,
the embedding continues to accept engine flags from `Intent` extras to preserve
developer velocity and testing workflows.

For Gradle-based projects,
the Flutter CLI automatically writes command-line configuration flags into
`AndroidManifest.xml` during compilation for release builds.
However, passing configuration flags when running a prebuilt release binary
(`--use-application-binary`) on Android now results in a fatal CLI error
because prebuilt release binaries ignore `Intent` extras.

## Context

The Flutter Android embedding previously allowed the Flutter CLI and developers
to supply engine configuration flags through [`Intent`][] extras at runtime.
On Android, `Intent` extras passed to exported activities (such as `MainActivity`)
can be intercepted, spoofed, or manipulated by malicious third-party apps
running on the same device.

The Android operating system lowers security sandboxing for debuggable builds
to enable debugging tools and administrative access through `adb`.
However, release builds run in untrusted end-user environments where
security enforcement is critical.

Moving the trust boundary for release builds to a cryptographically sealed
`AndroidManifest.xml` protects production applications from `Intent`
manipulation.
Restricting `Intent` flag parsing only in release mode ensures that
debug and profile modes maintain full developer velocity and compatibility
with testing tools.

[`Intent`]: https://developer.android.com/reference/android/content/Intent

## Description of change

In release builds, the Flutter Android embedding strictly ignores engine
configuration flags passed through `Intent` extras.

### Flutter Android embedding behavior

* **Debug and profile builds:** The embedding continues to parse and apply
  engine configuration flags passed through `Intent` extras.
* **Release builds:** The embedding ignores all engine configuration flags
  passed through `Intent` extras.

### Flutter CLI behavior

The Flutter CLI adjusts its launch and build strategy depending on the build
mode and whether you target a prebuilt binary:

| Build mode | Using `--use-application-binary` | Flutter Android embedding | Flutter CLI behavior |
| :--- | :--- | :--- | :--- |
| **Debug / Profile** | Yes | Reads `Intent` extras | Launches binary through `adb` with `Intent` extras without rebuilding. |
| **Debug / Profile** | No | Reads `Intent` extras | Builds app and launches through `adb` with `Intent` extras. |
| **Release** | Yes | Ignores `Intent` extras | Fails with a fatal error if any configuration flags are provided. |
| **Release** | No | Ignores `Intent` extras | Injects configuration flags into `AndroidManifest.xml` during compilation. |

Because prebuilt release binaries cannot have their manifests updated
dynamically at runtime, any configuration flags passed to a prebuilt release
APK silently fail to take effect.
The Flutter CLI now produces a fatal error to prevent silent configuration
failures.

## Migration guide

:::note
You are **not affected** and do not need to make changes if:
- You build and run standard Gradle apps through the Flutter CLI without
  custom `Intent` extras.
- You only run tests and benchmarks in **debug** or **profile** mode.
- You do not pass dynamic engine flags to prebuilt release binaries.
:::

If your workflow relies on passing engine flags to release builds,
review the following migration strategies:

### CI/CD and automated tests with prebuilt binaries

If your automated test pipelines use `--use-application-binary` with `--release`
and pass dynamic configuration flags:

1. Switch your test and benchmark targets to **profile mode** (`--profile`).
   Profile mode retains near-release performance characteristics while
   allowing dynamic runtime configuration through `Intent` extras.
1. If your tests must run against a release binary,
   compile separate release binaries with the required configuration
   statically declared in `AndroidManifest.xml`.

### Non-Gradle and hermetic build systems

If you build Flutter Android applications using hermetic build systems
(such as Blaze or Bazel) that do not use Gradle:

1. Statically declare any necessary engine configuration flags in
   `AndroidManifest.xml` before compiling the release APK.
1. For dynamic testing and benchmarking, build targets in **profile mode**
   instead of release mode.

### Declare engine flags in `AndroidManifest.xml`

To configure engine flags statically for release builds,
add `<meta-data>` elements under the `<application>` or `<activity>` tags in
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
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
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
* [PR 182522][]

[Issue 180686]: https://github.com/flutter/flutter/issues/180686
[PR 190870]: https://github.com/flutter/flutter/pull/190870
[PR 182522]: https://github.com/flutter/flutter/pull/182522
