---
title: Raised minimum Android build tool versions
description: >-
  Flutter 3.50 requires Android Gradle Plugin 9.1.1, Gradle 9.3.1,
  and Kotlin Gradle Plugin 2.4.10 (when applied) or later to build for Android.
  Android Gradle Plugin 10 isn't supported.
---

{% render "docs/breaking-changes.md" %}

## Summary

To build a Flutter app, module, or plugin for Android, Flutter 3.50 requires
newer minimum versions of the Android build tools than Flutter 3.47 required.
Builds that resolve below these minimums—or configure Android Gradle Plugin
(AGP) 10 or later—fail with an error naming the dependency and required
version.

The following table compares the minimum, warning, and template default
versions between Flutter 3.47 and Flutter 3.50:

| Dependency | Flutter 3.47 minimum | Flutter 3.50 minimum | Warns below (3.50) | New project default (3.50) |
| :--- | :--- | :--- | :--- | :--- |
| Android Gradle Plugin (AGP) | 8.11.1 | **9.1.1** | 9.3.1 | 9.3.1 |
| Gradle | 8.14.0 | **9.3.1** | 9.5.0 | 9.5.0 |
| Kotlin Gradle Plugin (KGP) | 2.2.20 | **2.4.10** | 2.4.20 | 2.4.20 |
| Java (JDK) | 17 | 17 | 17 | — |

Flutter skips the KGP version check when your project uses AGP's
[built-in Kotlin][] (`android.builtInKotlin=true`).
With `android.builtInKotlin=false`
(refer to [Built-in Kotlin and the new AGP DSL][kotlin-and-dsl]),
the Flutter Gradle Plugin depends on KGP `2.4.10` and applies `kotlin-android`
when KGP is on the build classpath.
Gradle resolves lower unpinned KGP declarations up to `2.4.10`,
logging a `< 2.4.20` warning instead of failing the build
(even without Kotlin source files).

Flutter 3.50 doesn't support AGP 10 or later.
Projects configured with AGP 10 fail validation until a future Flutter release
adds AGP 10 support.

:::warning Projects created with Flutter 3.44 or 3.47 need manual updates
Unmodified projects created with Flutter 3.44 or Flutter 3.47 fail to build on
Flutter 3.50 until you update their Gradle files.
Neither `flutter upgrade` nor `flutter build` updates these tool versions:

- **Flutter 3.44 templates** used Gradle `9.1.0` and AGP `9.0.1`.
  Both are below the Flutter 3.50 minimums, so update Gradle to at least
  `9.3.1` and AGP to at least `9.1.1`.
- **Flutter 3.47 templates** used AGP `9.1.0`, which is below the minimum,
  so update AGP to at least `9.1.1`.
  Their Gradle version (`9.3.1`) meets the minimum and logs a warning.

Both templates also declared an older KGP (`2.3.20` in 3.44, `2.4.0` in 3.47).
Flutter 3.50's Gradle plugin resolves KGP up to `2.4.10`,
so the build logs a warning rather than failing on KGP until you declare KGP
`2.4.20` or later.
Update to the Flutter 3.50 template versions (`AGP 9.3.1`, `Gradle 9.5.0`, and
`KGP 2.4.20`) in the [migration guide](#migration-guide) to clear all warnings.
:::

## Background

Flutter checks your Gradle, Java, AGP, and KGP versions on every Android build
and enforces a [support policy][] for these tools.

Flutter 3.50 raises the minimum versions for two reasons:

- Requiring AGP 9 means every project builds with AGP 9's API surface.
  The Flutter Gradle Plugin uses public AGP 9 APIs instead of maintaining
  separate code paths for AGP 8 and AGP 9.
- AGP `9.1.1` and later support `compileSdk` 37 (Android 17),
  preparing Flutter to target Android 17 in a future release without another
  minimum version bump.

According to the [AGP roadmap][], AGP 10 removes the legacy DSL,
the legacy variant APIs, and the `android.newDsl=false` opt-out that Flutter
sets for projects.
Because Flutter hasn't been validated against AGP 10,
Flutter 3.50 rejects AGP 10 builds cleanly before Gradle configuration fails:

```plaintext noHighlight
Error: Your project's Android Gradle Plugin version (10.0.0) is not yet
supported. Flutter does not support Android Gradle Plugin 10, and support
will be added in a future Flutter release. Please downgrade your
Android Gradle Plugin version to a version below 10.0.0 to continue.
Alternatively, use the flag "--android-skip-build-dependency-validation"
to bypass this check (unsupported; your build may fail).
```

When a dependency version falls below the minimum,
the build fails with a validation error naming the required version:

```plaintext noHighlight
Error: Your project's Android Gradle Plugin version (Android Gradle Plugin
version 9.1.0) is lower than Flutter's minimum supported version of
Android Gradle Plugin version 9.1.1. Please upgrade your Android Gradle
Plugin version.
Alternatively, use the flag "--android-skip-build-dependency-validation"
to bypass this check.
```

## Migration guide

No changes are required to pass validation when your project uses AGP `9.1.1`
through `9.x`, Gradle `9.3.1` or later, and Java `17` or later
(without pinning KGP below `2.4.10`).
To clear deprecation warnings, use AGP `9.3.1` or later, Gradle `9.5.0` or
later, and either [built-in Kotlin][] or KGP `2.4.20` or later.

### Check your versions

Check the build files and toolchain settings in your Flutter project:

- **AGP and KGP:** Inspect the `plugins {}` block in your
  `android/settings.gradle.kts` (or `android/settings.gradle`) file.
  Projects created before Flutter 3.16 declare these versions in the
  `buildscript` block of `android/build.gradle`.
- **Gradle:** Inspect the `distributionUrl` line in your
  `android/gradle/wrapper/gradle-wrapper.properties` file.
- **Java (JDK):** Run `flutter doctor -v` and check the Java version listed
  under the Android toolchain section.

### Update the Android Gradle Plugin

Update AGP to `9.3.1` (the default for Flutter 3.50 project templates) to avoid
the deprecation warning, or to at least `9.1.1`.

Projects created with Flutter 3.16 or later declare AGP in the `plugins {}`
block of `android/settings.gradle.kts` (or `android/settings.gradle`):

```kotlin diff title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
-   id("com.android.application") version "9.1.0" apply false
+   id("com.android.application") version "9.3.1" apply false
    id("org.jetbrains.kotlin.android") version "2.4.0" apply false
}
```

Projects created before Flutter 3.16 declare AGP as a `classpath` dependency
in `android/build.gradle`:

```groovy diff title="<flutter-project>/android/build.gradle"
buildscript {
    dependencies {
-       classpath 'com.android.tools.build:gradle:8.11.1'
+       classpath 'com.android.tools.build:gradle:9.3.1'
    }
}
```

If you're upgrading from AGP 8, also refer to
[Built-in Kotlin and the new AGP DSL][kotlin-and-dsl].

### Update Gradle

Update the Gradle wrapper in your
`android/gradle/wrapper/gradle-wrapper.properties` file.
Flutter recommends Gradle `9.5.0`.
Each AGP version requires a minimum Gradle version:
AGP `9.1` requires at least Gradle `9.3.1` (Flutter's minimum),
and AGP `9.3` requires at least Gradle `9.5.0`.
For other combinations, consult the [AGP and Gradle compatibility table][].

```properties diff title="<flutter-project>/android/gradle/wrapper/gradle-wrapper.properties"
- distributionUrl=https\://services.gradle.org/distributions/gradle-9.1.0-all.zip
+ distributionUrl=https\://services.gradle.org/distributions/gradle-9.5.0-all.zip
```

Gradle 9 requires Java 17 or later.
If Flutter uses an older JDK, configure a newer JDK path with
`flutter config --jdk-dir=JDK_PATH`.

### Update the Kotlin Gradle Plugin

Skip this step if your project uses [built-in Kotlin][]
(`android.builtInKotlin=true`).
When `android.builtInKotlin=false` is set, the Flutter Gradle Plugin resolves
unpinned KGP declarations up to `2.4.10` and applies `kotlin-android` even if
your app has no Kotlin source files.
KGP versions resolved below `2.4.20` log a warning
(and KGP pinned below `2.4.10` fails the build).

Update `org.jetbrains.kotlin.android` to `2.4.20` in your
`android/settings.gradle.kts` file:

```kotlin diff title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.3.1" apply false
-   id("org.jetbrains.kotlin.android") version "2.4.0" apply false
+   id("org.jetbrains.kotlin.android") version "2.4.20" apply false
}
```

Projects created before Flutter 3.16 set `ext.kotlin_version` in
`android/build.gradle` instead.

Applying KGP is deprecated with AGP 9.
Flutter logs a warning when your app or one of its plugins applies KGP,
and a future Flutter release will remove KGP support.
To migrate off KGP instead of continuing to update its version, follow the
[built-in Kotlin guide for app developers][].

### Test Flutter plugins

Flutter plugins compile with the AGP, Gradle, and KGP versions configured by
the consuming app.
Test your plugin's example app with AGP `9.1.1` and `9.3.1`,
both with and without `android.builtInKotlin=false`.
For migration details, consult the
[built-in Kotlin guide for plugin authors][].

### Bypass the version check

If you can't update your build tools immediately, pass
`--android-skip-build-dependency-validation` to `flutter run` or
`flutter build` to skip the version check.
Bypassing validation is unsupported: the Flutter Gradle Plugin calls AGP 9
APIs that older versions don't provide, so your build can still fail.

## Built-in Kotlin and the new AGP DSL

AGP 9 enables [built-in Kotlin][] by default (rejecting the `kotlin-android`
plugin) and reads only the [new AGP DSL][].
Flutter keeps existing projects building across those AGP 9 changes with two
Gradle properties in `android/gradle.properties`:

- `flutter create` writes `android.builtInKotlin=false` and
  `android.newDsl=false` to new projects.
- If either line is missing, Flutter's migrator appends that line (with a
  marker comment) on the next `flutter run` or `flutter build`.
  Builds started directly from Gradle or Android Studio don't run the migrator.

These properties keep existing build scripts and plugins working without an
immediate built-in Kotlin or DSL migration.
When `android.builtInKotlin=false` is set, KGP below `2.4.20` logs a warning,
so update KGP to `2.4.20` or migrate to built-in Kotlin.

When you're ready to adopt AGP 9's defaults:

- To migrate to built-in Kotlin (`android.builtInKotlin=true`), follow
  [Migrating Flutter Android projects to built-in Kotlin][built-in Kotlin].
- To prepare custom build scripts for `android.newDsl=true`, consult
  [Extend the Android Gradle Plugin][Variant API].
  Flutter 3.50 sets `android.newDsl=false` by default, so migrating your own
  build scripts isn't required yet.

## Timeline

In stable release: 3.50

## References

- [Android dependency versions support policy][support policy]: Policy defining
  minimum, warning, and template default versions for Android build tools in
  Flutter.
- [AGP and Gradle compatibility table][]: Official Android matrix for matching
  AGP, Gradle, and JDK versions.
- [Migrating Flutter Android projects to built-in Kotlin][built-in Kotlin]:
  Guide to removing the deprecated `kotlin-android` plugin on AGP 9 and later.

[AGP and Gradle compatibility table]: {{site.android-dev}}/build/releases/about-agp#updating-gradle
[AGP roadmap]: {{site.android-dev}}/build/releases/gradle-plugin-roadmap
[built-in Kotlin]: /release/breaking-changes/migrate-to-built-in-kotlin
[built-in Kotlin guide for app developers]: /release/breaking-changes/migrate-to-built-in-kotlin/for-app-developers
[built-in Kotlin guide for plugin authors]: /release/breaking-changes/migrate-to-built-in-kotlin/for-plugin-authors
[kotlin-and-dsl]: #built-in-kotlin-and-the-new-agp-dsl
[new AGP DSL]: {{site.android-dev}}/build/releases/agp-9-0-0-release-notes#android-gradle-plugin-changed-dsl
[support policy]: /go/android-dependency-versions
[Variant API]: {{site.android-dev}}/build/extend-agp
