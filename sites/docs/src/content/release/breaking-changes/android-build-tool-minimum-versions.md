---
title: Raised minimum Android build tool versions
description: >-
  Flutter 3.50 requires Android Gradle Plugin 9.1.1, Gradle 9.3.1,
  and Kotlin Gradle Plugin 2.4.10 (when applied) or later to build for Android.
  Android Gradle Plugin 10 isn't supported.
---

{% render "docs/breaking-changes.md" %}

## Summary

Flutter 3.50 requires newer minimum Android build tool versions than Flutter
3.47 for Android app, module, and plugin builds.
Builds below these minimums, or configured with Android Gradle Plugin (AGP) 10
or later, fail validation with an error naming the required version.

The following table compares the minimum, warning, and template default
versions between Flutter 3.47 and Flutter 3.50:

| Dependency | Flutter 3.47 minimum | Flutter 3.50 minimum | Warns below (3.50) | New project default (3.50) |
| :--- | :--- | :--- | :--- | :--- |
| Android Gradle Plugin (AGP) | 8.11.1 | **9.1.1** | 9.3.1 | 9.3.1 |
| Gradle | 8.14.0 | **9.3.1** | 9.5.0 | 9.5.0 |
| Kotlin Gradle Plugin (KGP) | 2.2.20 | **2.4.10** | 2.4.20 | 2.4.20 |
| Java (JDK) | 17 | 17 | 17 | — |

Your build passes validation without edits if it uses AGP `9.1.1` through
`9.x`, Gradle `9.3.1` or later, and Java `17` or later.
If KGP is applied, don't pin it below `2.4.10`.
To clear deprecation warnings, update to AGP `9.3.1`, Gradle `9.5.0`, and
either [built-in Kotlin][] or KGP `2.4.20`.

Two version rules apply alongside the minimums in the table:

- **KGP check:** Flutter skips KGP validation when [built-in Kotlin][]
  (`android.builtInKotlin=true`) is active.
  With `android.builtInKotlin=false`, the Flutter Gradle Plugin depends on KGP
  `2.4.10` and applies `kotlin-android` when KGP is on the classpath.
  Gradle resolves lower unpinned KGP declarations up to `2.4.10`, logging a
  `< 2.4.20` warning instead of failing (even without Kotlin source files).
  For details, refer to
  [Built-in Kotlin and the new AGP DSL][kotlin-and-dsl].
- **AGP 10 upper bound:** Flutter 3.50 doesn't support AGP 10 or later,
  and projects configured with AGP 10 fail validation.

:::warning Projects created with Flutter 3.44 or 3.47 need manual updates
Unmodified projects created with Flutter 3.44 or Flutter 3.47 fail validation
on Flutter 3.50 until you update their Gradle files.
Neither `flutter upgrade` nor `flutter build` updates these tool versions:

- **Flutter 3.44 templates** used Gradle `9.1.0` and AGP `9.0.1`.
  Both fall below the Flutter 3.50 minimums, so update Gradle to at least
  `9.3.1` and AGP to at least `9.1.1`.
- **Flutter 3.47 templates** used AGP `9.1.0`, which falls below the minimum,
  so update AGP to at least `9.1.1`.
  Their Gradle version (`9.3.1`) meets the minimum and logs a warning.

Both templates also declared an older KGP (`2.3.20` in 3.44, `2.4.0` in 3.47).
Flutter 3.50 resolves unpinned KGP up to `2.4.10`, so the build logs a warning
rather than failing until you declare KGP `2.4.20` or later.
Follow the [migration guide](#migration-guide) to update to `AGP 9.3.1`,
`Gradle 9.5.0`, and `KGP 2.4.20` and clear all warnings.
:::

## Background

Flutter checks your Gradle, Java, AGP, and KGP versions on every Android build
and enforces a [support policy][] for these tools.
Flutter 3.50 raises the minimum versions for two reasons:

- Requiring AGP 9 gives every build AGP 9's public APIs, so the Flutter Gradle
  Plugin doesn't maintain separate AGP 8 and AGP 9 code paths.
- AGP `9.1.1` and later support `compileSdk` 37 (Android 17),
  preparing Flutter to target Android 17 without another minimum version bump.

The [AGP migration timeline][] schedules the removal of the legacy DSL,
the legacy variant APIs, and the `android.newDsl=false` opt-out for AGP 10.
Because Flutter hasn't been validated against AGP 10,
Flutter 3.50 rejects AGP 10 builds before Gradle configuration fails:

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

### Check your versions

Inspect the build files and toolchain settings in your Flutter project to check
which tools need updates:

- **AGP and KGP:** Check the `plugins {}` block in
  `android/settings.gradle.kts` (or `android/settings.gradle`),
  or `buildscript` in `android/build.gradle` on projects created before
  Flutter 3.16.
  Refer to [Update the Android Gradle Plugin][update-agp] and
  [Update the Kotlin Gradle Plugin][update-kgp].
- **Gradle:** Check `distributionUrl` in
  `android/gradle/wrapper/gradle-wrapper.properties`.
  Refer to [Update Gradle][update-gradle].
- **Java (JDK):** Run `flutter doctor -v` and check the Java version listed
  under the Android toolchain section.

### Update the Android Gradle Plugin

Before updating AGP, check two compatibility requirements:

- AGP `9.3.1` requires Gradle `9.5.0` or later
  (refer to [Update Gradle][update-gradle]),
  while AGP `9.1.1` works with Gradle `9.3.1` or later.
- If you're upgrading from AGP 8, also review
  [Built-in Kotlin and the new AGP DSL][kotlin-and-dsl].

Update AGP to `9.3.1` (the Flutter 3.50 template default) to clear warnings,
or to at least `9.1.1`.
On projects created with Flutter 3.16 or later, edit `plugins {}` in
`android/settings.gradle.kts` (or `android/settings.gradle`).

Code before migration:

```kotlin title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.1.0" apply false
    id("org.jetbrains.kotlin.android") version "2.4.0" apply false
}
```

Code after migration:

```kotlin title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    // Minimum in 3.50 is 9.1.1; 9.3.1 clears warnings (requires Gradle 9.5.0+).
    id("com.android.application") version "9.3.1" apply false
    id("org.jetbrains.kotlin.android") version "2.4.0" apply false
}
```

On projects created before Flutter 3.16, update the `classpath` dependency in
`android/build.gradle` instead.

Code before migration:

```groovy title="<flutter-project>/android/build.gradle"
buildscript {
    dependencies {
        classpath 'com.android.tools.build:gradle:8.11.1'
    }
}
```

Code after migration:

```groovy title="<flutter-project>/android/build.gradle"
buildscript {
    dependencies {
        // Minimum in 3.50 is 9.1.1; 9.3.1 clears warnings (requires Gradle 9.5.0+).
        classpath 'com.android.tools.build:gradle:9.3.1'
    }
}
```

### Update Gradle

Before updating the Gradle wrapper, check your Java and AGP versions:

- Gradle 9 requires Java 17 or later.
  If Flutter uses an older JDK, configure a Java 17 or newer path with
  `flutter config --jdk-dir=<JDK_PATH>`.
- Each AGP version requires a minimum Gradle version:
  AGP `9.1` requires at least Gradle `9.3.1` (Flutter's minimum),
  and AGP `9.3` requires at least Gradle `9.5.0`.
  For other combinations, consult the [AGP and Gradle compatibility table][].

Update `distributionUrl` in `android/gradle/wrapper/gradle-wrapper.properties`
to Gradle `9.5.0` (or at least `9.3.1` with AGP `9.1.1`).

Code before migration:

```properties title="<flutter-project>/android/gradle/wrapper/gradle-wrapper.properties"
distributionUrl=https\://services.gradle.org/distributions/gradle-9.1.0-all.zip
```

Code after migration:

```properties title="<flutter-project>/android/gradle/wrapper/gradle-wrapper.properties"
# Minimum in 3.50 is 9.3.1; AGP 9.3.1 requires Gradle 9.5.0 or later.
distributionUrl=https\://services.gradle.org/distributions/gradle-9.5.0-all.zip
```

### Update the Kotlin Gradle Plugin

Skip this step if your project uses [built-in Kotlin][]
(`android.builtInKotlin=true`).
When `android.builtInKotlin=false` is set, the Flutter Gradle Plugin resolves
unpinned KGP declarations up to `2.4.10` and applies `kotlin-android` even
without Kotlin source files.
Resolved KGP versions below `2.4.20` log a warning,
and KGP pinned below `2.4.10` fails the build.

Update `org.jetbrains.kotlin.android` to `2.4.20` in
`android/settings.gradle.kts`
(projects created before Flutter 3.16 set `ext.kotlin_version` in
`android/build.gradle` instead).

Code before migration:

```kotlin title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.3.1" apply false
    id("org.jetbrains.kotlin.android") version "2.4.0" apply false
}
```

Code after migration:

```kotlin title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.3.1" apply false
    // Minimum when KGP is applied is 2.4.10; 2.4.20 clears warnings.
    id("org.jetbrains.kotlin.android") version "2.4.20" apply false
}
```

Applying KGP is deprecated on AGP 9, and Flutter logs a warning when your app
or a plugin applies it ([Issue 184837][]).
To migrate off KGP instead of continuing to update its version, follow the
[built-in Kotlin guide for app developers][].

### Test Flutter plugins

Flutter plugins compile with the AGP, Gradle, and KGP versions configured by
the consuming app.
Test your plugin's example app on both AGP `9.1.1` (with Gradle `9.3.1`) and
AGP `9.3.1` (with Gradle `9.5.0`), with `android.builtInKotlin=false` and
`android.builtInKotlin=true`.
For plugin migration details, consult the
[built-in Kotlin guide for plugin authors][].

### Bypass the version check

:::caution Unsupported flag
Bypassing dependency validation is unsupported.
The Flutter Gradle Plugin calls AGP 9 APIs that older versions don't provide,
so your build can still fail.
:::

If you can't update your build tools immediately, pass
`--android-skip-build-dependency-validation` to `flutter run` or
`flutter build`:

```bash
flutter build apk --android-skip-build-dependency-validation
```

## Built-in Kotlin and the new AGP DSL

AGP 9 enables [built-in Kotlin][] by default (rejecting the `kotlin-android`
plugin) and exposes only the [new AGP DSL][].
Flutter keeps existing build scripts and plugins working across those AGP 9
defaults with two Gradle properties in `android/gradle.properties`:

- `flutter create` writes `android.builtInKotlin=false` and
  `android.newDsl=false` to new projects.
- When either property is missing, `flutter run` or `flutter build` appends it
  with a marker comment.
  Builds started directly from Gradle or Android Studio don't run that
  migrator.

If you build directly from Gradle or Android Studio, confirm that
`android/gradle.properties` sets both properties:

```properties title="<flutter-project>/android/gradle.properties"
# Keep legacy KGP and DSL compatibility until your app and plugins migrate.
android.builtInKotlin=false
android.newDsl=false
```

When `android.builtInKotlin=false` is set, KGP resolved below `2.4.20` logs a
warning, so update KGP to `2.4.20` or migrate to built-in Kotlin.

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
- [AGP DSL and API migration timeline][AGP migration timeline]: Official
  Android schedule for legacy DSL and Variant API removals.
- [Migrating Flutter Android projects to built-in Kotlin][built-in Kotlin]:
  Guide to removing the deprecated `kotlin-android` plugin on AGP 9 and later.

[AGP and Gradle compatibility table]: {{site.android-dev}}/build/releases/about-agp#updating-gradle
[AGP migration timeline]: {{site.android-dev}}/build/releases/gradle-plugin-roadmap#agp-10
[built-in Kotlin]: /release/breaking-changes/migrate-to-built-in-kotlin
[built-in Kotlin guide for app developers]: /release/breaking-changes/migrate-to-built-in-kotlin/for-app-developers
[built-in Kotlin guide for plugin authors]: /release/breaking-changes/migrate-to-built-in-kotlin/for-plugin-authors
[Issue 184837]: {{site.repo.flutter}}/issues/184837
[kotlin-and-dsl]: #built-in-kotlin-and-the-new-agp-dsl
[new AGP DSL]: {{site.android-dev}}/build/releases/agp-9-0-0-release-notes#android-gradle-plugin-new-dsl
[support policy]: /go/android-dependency-versions
[update-agp]: #update-the-android-gradle-plugin
[update-gradle]: #update-gradle
[update-kgp]: #update-the-kotlin-gradle-plugin
[Variant API]: {{site.android-dev}}/build/extend-agp
