---
title: Raised minimum Android build tool versions
description: >-
  Flutter 3.50 requires Android Gradle Plugin 9.1.1, Gradle 9.3.1,
  and (if you apply it) Kotlin Gradle Plugin 2.4.10 or later
  to build for Android. Android Gradle Plugin 10 isn't supported yet.
---

{% render "docs/breaking-changes.md" %}

## Summary

To build a Flutter app, module, or plugin for Android,
Flutter 3.50 requires newer versions of the Android build tools
than Flutter 3.47 did.
Builds that use an older version fail with an error
that names the dependency and the minimum version.

| Dependency | Flutter 3.47 minimum | Flutter 3.50 minimum | Warns below (3.50) | New project default (3.50) |
| :--- | :--- | :--- | :--- | :--- |
| Android Gradle Plugin (AGP) | 8.11.1 | **9.1.1** | 9.3.1 | 9.3.1 |
| Gradle | 8.14.0 | **9.3.1** | 9.5.0 | 9.5.0 |
| Kotlin Gradle Plugin (KGP)* | 2.2.20 | **2.4.10** | 2.4.20 | 2.4.20 |
| Java (JDK) | 17 | 17 | 17 | — |

\* Not checked for projects that use AGP's [built-in Kotlin][].
With `android.builtInKotlin=false` (the value Flutter's templates and
migrator set), Flutter applies the `kotlin-android` plugin for you
whenever KGP is on the classpath, which template projects declare in
`settings.gradle.kts`. So the KGP check applies to template-based apps
even if they contain no Kotlin code.

In addition, Flutter 3.50 **doesn't support AGP 10 or later**.
A project that uses AGP 10 fails to build until a future Flutter release
adds support for it.

The following defaults are **unchanged** from Flutter 3.47:
`compileSdk` 36, `targetSdk` 36, `minSdk` 24
(a `minSdk` of 23 warns, and 22 or lower fails),
and NDK `28.2.13676358`.

:::warning
**Projects created with Flutter 3.44 or 3.47 need manual updates.**
The templates in those releases used AGP 9.0.1 and 9.1.0 and
KGP 2.3.20 and 2.4.0, all of which are below the new minimums,
and `flutter upgrade` doesn't edit your Gradle files.
Until you update the versions as described in the
[migration guide](#migration-guide), those projects fail to build
with Flutter 3.50.

The new AGP minimum (9.1.1) is also higher than the version that
Flutter 3.47 warned about (9.0.1),
so projects on AGP 9.0.1 through 9.1.0 got no advance warning.
:::

Because every supported AGP version is now 9 or later,
every Flutter Android project is subject to the
AGP 9 changes that Flutter manages for you with two Gradle properties:
[built-in Kotlin][] (`android.builtInKotlin`) and the
[new AGP DSL][] (`android.newDsl`).
[Built-in Kotlin and the new AGP DSL](#built-in-kotlin-and-the-new-agp-dsl)
explains what that means when you upgrade.

[built-in Kotlin]: /release/breaking-changes/migrate-to-built-in-kotlin
[new AGP DSL]: /release/breaking-changes/flutter-gradle-plugin-variant-api

## Context

Flutter checks the versions of Gradle, Java, AGP, and KGP
each time it builds for Android and
enforces a [support policy][] for them:
a version is first marked as "warn" for at least one stable release,
then raised to the minimum ("error") in a later release.

Flutter 3.50 raises the minimums for two reasons:

* Requiring AGP 9 means every project builds with the same generation
  of AGP behavior (built-in Kotlin and the new DSL),
  which lets the [Flutter Gradle Plugin use only public AGP APIs][new AGP DSL]
  instead of maintaining code paths for AGP 8 and AGP 9.
* AGP 9.1.1 and later support `compileSdk` 37 (Android 17),
  which Flutter plans to move to in a future release
  without another minimum version change.

Flutter 3.50 doesn't support AGP 10 because AGP 10 removes the
legacy DSL and Variant APIs and the `android.newDsl=false` opt-out
that Flutter still sets for projects, and Flutter hasn't been
validated against it.
To learn more, refer to the [AGP roadmap][].

[support policy]: /go/android-dependency-versions
[AGP roadmap]: {{site.android-dev}}/build/releases/gradle-plugin-roadmap

## Description of change

When you run `flutter run`, `flutter build`, or a Gradle task
that applies the Flutter Gradle Plugin,
Flutter checks the build dependency versions before it configures
the build.

If a dependency is below the minimum, the build fails:

```plaintext noHighlight
Error: Your project's Android Gradle Plugin version (Android Gradle Plugin
version 9.1.0) is lower than Flutter's minimum supported version of
Android Gradle Plugin version 9.1.1. Please upgrade your Android Gradle
Plugin version.
Alternatively, use the flag "--android-skip-build-dependency-validation"
to bypass this check.

Potential fix: Your project's AGP version is typically defined in the
plugins block of the `settings.gradle` file (<project>/android/settings.gradle),
by a plugin with the id of com.android.application.
```

If a dependency is below the "warn" version, the build succeeds
and prints a warning that Flutter support for that version
will soon be dropped.

If the AGP version is 10 or later, the build fails:

```plaintext noHighlight
Error: Your project's Android Gradle Plugin version (10.0.0) is not yet
supported. Flutter does not support Android Gradle Plugin 10, and support
will be added in a future Flutter release. Please downgrade your
Android Gradle Plugin version to a version below 10.0.0 to continue.
Alternatively, use the flag "--android-skip-build-dependency-validation"
to bypass this check (unsupported; your build may fail).
```

Other changes to the version checks in Flutter 3.50:

* The checks run before the Flutter Gradle Plugin reads any Android
  DSL or registers tasks, so an unsupported version now reports this
  message instead of an unrelated Gradle or AGP error.
* If your project uses AGP's built-in Kotlin
  (AGP 9 or later without `android.builtInKotlin=false`),
  Flutter no longer checks the KGP version,
  because Kotlin is bundled with AGP and can't be upgraded separately.
* If applying the `kotlin-android` plugin fails for a reason other than
  the plugin being missing, Flutter reports the real error
  instead of a generic message.

## Migration guide

### Check your current versions

Run `flutter analyze --suggestions` from your project directory.
It reports the Java, Gradle, AGP, and KGP versions that your project
uses and whether they're compatible with each other.
You can also run `flutter doctor -v` to check which Java version
Flutter uses for Android builds.

### Update the Android Gradle Plugin

Flutter recommends the version that new projects use, 9.3.1,
so that you don't get the "will soon be dropped" warning.

Projects created with Flutter 3.16 or later declare AGP in
the `plugins` block of `android/settings.gradle.kts`
(or `android/settings.gradle`):

```kotlin diff title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
-   id("com.android.application") version "9.1.0" apply false
+   id("com.android.application") version "9.3.1" apply false
    id("org.jetbrains.kotlin.android") version "2.4.0" apply false
}
```

Older projects declare it as a `classpath` dependency in
`android/build.gradle`:

```groovy diff title="<flutter-project>/android/build.gradle"
buildscript {
    dependencies {
-       classpath 'com.android.tools.build:gradle:8.11.1'
+       classpath 'com.android.tools.build:gradle:9.3.1'
    }
}
```

If you're upgrading from AGP 8, also read
[Built-in Kotlin and the new AGP DSL](#built-in-kotlin-and-the-new-agp-dsl).

### Update Gradle

Update the Gradle wrapper. Flutter recommends 9.5.0.
Each AGP version has its own minimum Gradle version:
AGP 9.1 requires Gradle 9.3.1 (Flutter's new minimum)
and AGP 9.3 requires Gradle 9.5.0.
For other versions, refer to the
[AGP and Gradle compatibility table][].

```properties diff title="<flutter-project>/android/gradle/wrapper/gradle-wrapper.properties"
- distributionUrl=https\://services.gradle.org/distributions/gradle-9.1.0-all.zip
+ distributionUrl=https\://services.gradle.org/distributions/gradle-9.5.0-all.zip
```

Gradle 9 runs on Java 17 or later only.
If Flutter uses an older JDK, point it at a newer one with
`flutter config --jdk-dir=<path>`.
Gradle also prints `--enable-native-access` warnings on Java 24 and later;
Flutter 3.50 suppresses them for the Gradle invocations it makes.

[AGP and Gradle compatibility table]: {{site.android-dev}}/build/releases/gradle-plugin#updating-gradle

### Update the Kotlin Gradle Plugin

Skip this step if your project uses [built-in Kotlin][]
(`android.builtInKotlin=true`).
If `android.builtInKotlin=false` is set, update KGP even if your
project contains no Kotlin code, because Flutter applies KGP for you.

If your project applies `org.jetbrains.kotlin.android`,
update it to 2.4.20 (2.4.10 is the minimum):

```kotlin diff title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.3.1" apply false
-   id("org.jetbrains.kotlin.android") version "2.4.0" apply false
+   id("org.jetbrains.kotlin.android") version "2.4.20" apply false
}
```

Older projects set `ext.kotlin_version` in `android/build.gradle` instead.

Applying KGP is deprecated with AGP 9.
Flutter prints a warning when your app or one of its plugins applies KGP,
and a future Flutter release stops supporting it.
Plan to migrate to built-in Kotlin instead of updating KGP
by following the [built-in Kotlin guide for app developers][].

[built-in Kotlin guide for app developers]: /release/breaking-changes/migrate-to-built-in-kotlin/for-app-developers

### Built-in Kotlin and the new AGP DSL

AGP 9 changed two defaults that affect how Gradle build scripts
are written:
Kotlin support is built in (the `kotlin-android` plugin is rejected),
and only the new AGP DSL is read.
Flutter keeps projects building across those changes with two
Gradle properties, and handles them for you:

* `flutter create` adds `android.builtInKotlin=false` and
  `android.newDsl=false` to `android/gradle.properties`.
* When you build an existing project that doesn't declare them,
  Flutter's migrator adds the same two lines,
  each with a comment that says the migrator added it.

If your project was on AGP 8 and is building with AGP 9 for the first time,
expect those lines to appear after your first `flutter run` or
`flutter build`.
They keep your existing build scripts and plugins working;
you don't need to change your Kotlin setup to upgrade to Flutter 3.50.

When you're ready, migrate to built-in Kotlin
(`android.builtInKotlin=true`) by following the
[built-in Kotlin guide][built-in Kotlin].
Migrating to the new DSL is covered in
[Flutter Gradle Plugin uses the Android Gradle Plugin Variant API][new AGP DSL];
Flutter 3.50 still sets `android.newDsl=false`,
so that migration isn't required yet.

### Plugin authors

Flutter plugins are built as part of the app that uses them,
so the app's AGP, Gradle, and KGP versions apply to your plugin too.
Test your plugin's example app with AGP 9.1.1 and 9.3.1,
both with and without `android.builtInKotlin=false`.
To learn more, refer to the
[built-in Kotlin guide for plugin authors][].

[built-in Kotlin guide for plugin authors]: /release/breaking-changes/migrate-to-built-in-kotlin/for-plugin-authors

### Bypass the check

If you can't update yet, pass
`--android-skip-build-dependency-validation` to `flutter run` or
`flutter build` to skip the version check.
This is unsupported: the Flutter Gradle Plugin uses AGP APIs that
older versions don't provide, so your build might still fail.

## Timeline

Landed in version: 3.50.0-0.1.pre<br>
In stable release: 3.50

## References

Relevant issues:

* [Issue 189518][]: Support Android 17 (API 37)
* [Issue 193593][]: Fail clearly on unsupported AGP versions

Relevant pull requests:

* [PR 193813][]: Raise minimum version to AGP 9.1.1
* [PR 193262][]: Update templates to AGP 9.3.1, Gradle 9.5.0, KGP 2.4.20
* [PR 193609][]: Add unsupported AGP version functionality
* [PR 192206][]: Skip KGP version validation for AGP built-in Kotlin
* [PR 195060][]: Run the dependency version check first
* [PR 195691][]: Report the real error when applying `kotlin-android` fails
* [PR 193814][]: Enable native access for Gradle

[Issue 189518]: {{site.repo.flutter}}/issues/189518
[Issue 193593]: {{site.repo.flutter}}/issues/193593
[PR 193813]: {{site.repo.flutter}}/pull/193813
[PR 193262]: {{site.repo.flutter}}/pull/193262
[PR 193609]: {{site.repo.flutter}}/pull/193609
[PR 192206]: {{site.repo.flutter}}/pull/192206
[PR 195060]: {{site.repo.flutter}}/pull/195060
[PR 195691]: {{site.repo.flutter}}/pull/195691
[PR 193814]: {{site.repo.flutter}}/pull/193814
