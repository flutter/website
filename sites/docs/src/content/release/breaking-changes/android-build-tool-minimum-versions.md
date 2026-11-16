---
title: Raised minimum Android build tool versions
description: >-
  Flutter 3.50 requires Android Gradle Plugin 9.1.1, Gradle 9.3.1,
  and Kotlin Gradle Plugin 2.4.10 (when applied) or later
  to build for Android. Android Gradle Plugin 10 isn't supported yet.
---

{% render "docs/breaking-changes.md" %}

## Summary

To build a Flutter app, module, or plugin for Android,
Flutter 3.50 requires newer minimum versions of the Android build tools
than Flutter 3.47 required.
Builds configured below these minimums—or with Android Gradle Plugin (AGP) 10
or later—fail with an error naming the dependency and required version.

The following table compares the minimum, warning, and template default versions
between Flutter 3.47 and Flutter 3.50:

| Dependency | Flutter 3.47 minimum | Flutter 3.50 minimum | Warns below (3.50) | New project default (3.50) |
| :--- | :--- | :--- | :--- | :--- |
| Android Gradle Plugin (AGP) | 8.11.1 | **9.1.1** | 9.3.1 | 9.3.1 |
| Gradle | 8.14.0 | **9.3.1** | 9.5.0 | 9.5.0 |
| Kotlin Gradle Plugin (KGP) | 2.2.20 | **2.4.10** | 2.4.20 | 2.4.20 |
| Java (JDK) | 17 | 17 | 17 | — |

Flutter skips the KGP version check when your project uses AGP's
[built-in Kotlin][] (`android.builtInKotlin=true`).
When `android.builtInKotlin=false` is set
(the default in Flutter's project templates and migrator),
Flutter automatically applies the `kotlin-android` plugin whenever KGP is on
the build classpath.
Because Flutter's templates declare KGP in `settings.gradle.kts`,
template-based apps must use KGP 2.4.10 or later
even if they contain no Kotlin source files.

Flutter 3.50 doesn't support AGP 10 or later.
Projects configured with AGP 10 fail to build until a future Flutter release
adds AGP 10 support.

Default Android SDK and NDK values are unchanged from Flutter 3.47:
`compileSdk` is `36`, `targetSdk` is `36`, `minSdk` is `24`,
and the default NDK version is `28.2.13676358`.
Setting `minSdk` to `23` logs a warning, and `22` or lower fails the build.

:::warning Projects created with Flutter 3.44 or 3.47 need manual updates
Unmodified projects created with Flutter 3.44 or Flutter 3.47 fail to build
on Flutter 3.50, and `flutter upgrade` doesn't edit your project's Gradle files:

- **Flutter 3.44 templates** used AGP `9.0.1`, Gradle `9.1.0`, and KGP `2.3.20`
  (all three are below the Flutter 3.50 minimums).
- **Flutter 3.47 templates** used AGP `9.1.0`, Gradle `9.3.1`, and KGP `2.4.0`
  (AGP and KGP are below the Flutter 3.50 minimums).

In addition, the new minimums are higher than the thresholds that Flutter 3.47
warned about (AGP `9.0.1`, Gradle `9.1.0`, and KGP `2.3.20`).
Projects using AGP `9.0.1` through `9.1.0`, Gradle `9.1.0` through `9.3.0`,
or KGP `2.3.20` through `2.4.9` received no advance warning in Flutter 3.47.
Follow the [migration guide](#migration-guide) to update your build files.
:::

Because Flutter 3.50 requires AGP 9.1.1 or later,
every Flutter Android project builds with AGP 9.
Flutter manages AGP 9's compatibility defaults using two Gradle properties:
[built-in Kotlin][] (`android.builtInKotlin`) and the
[new AGP DSL][] (`android.newDsl`).
To learn how Flutter manages these properties during an upgrade, refer to
[Built-in Kotlin and the new AGP DSL](#built-in-kotlin-and-the-new-agp-dsl).

[built-in Kotlin]: /release/breaking-changes/migrate-to-built-in-kotlin
[new AGP DSL]: /release/breaking-changes/flutter-gradle-plugin-variant-api

## Context

Flutter checks your Gradle, Java, AGP, and KGP versions on every Android build
and enforces a [support policy][] for these tools.
Under that policy, Flutter marks a version as "warn" for at least one stable
release before raising the minimum ("error") in a later release.

Flutter 3.50 raises the minimum versions for two reasons:

- Requiring AGP 9 means every project builds with AGP 9's API surface.
  The [Flutter Gradle Plugin now uses only public AGP APIs][new AGP DSL]
  instead of maintaining separate code paths for AGP 8 and AGP 9.
- AGP 9.1.1 and later support `compileSdk` 37 (Android 17),
  which prepares Flutter to target Android 17 in a future release
  without another minimum version bump.

According to the [AGP roadmap][], AGP 10 removes the legacy DSL,
the legacy Variant APIs, and the `android.newDsl=false` opt-out
that Flutter still sets for projects.
Because Flutter hasn't been validated against AGP 10 yet,
Flutter 3.50 rejects AGP 10 builds cleanly before configuration fails.

[support policy]: /go/android-dependency-versions
[AGP roadmap]: {{site.android-dev}}/build/releases/gradle-plugin-roadmap

## Description of change

When you run `flutter run`, `flutter build`, or any Gradle task
that applies the Flutter Gradle Plugin,
Flutter validates the Android build tool versions before configuring the build.

If a dependency version is below the minimum, the build fails:

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
If you don't see a plugins block, your project was likely created with an
older template version. In this case it is most likely defined in the
top-level build.gradle file (<project>/android/build.gradle) by the following
line in the dependencies block of the buildscript:
"classpath 'com.android.tools.build:gradle:<version>'".
```

When a version meets the minimum but falls below the "warn" threshold,
the build succeeds and warns that Flutter support will soon be dropped.

If the AGP version is 10 or later, the build fails:

```plaintext noHighlight
Error: Your project's Android Gradle Plugin version (10.0.0) is not yet
supported. Flutter does not support Android Gradle Plugin 10, and support
will be added in a future Flutter release. Please downgrade your
Android Gradle Plugin version to a version below 10.0.0 to continue.
Alternatively, use the flag "--android-skip-build-dependency-validation"
to bypass this check (unsupported; your build may fail).

Potential fix: [...]
```

Flutter 3.50 also updates how version checks run:

- Version checks run before the Flutter Gradle Plugin reads Android DSL
  extensions or registers tasks.
  Unsupported versions report the validation error above instead of an
  unrelated Gradle or AGP exception.
- When your project uses AGP's built-in Kotlin
  (AGP 9 or later without `android.builtInKotlin=false`),
  Flutter skips the KGP version check.
  Kotlin support is bundled with AGP and isn't versioned separately.
- If applying `kotlin-android` fails for a reason other than a missing plugin,
  Flutter rethrows the underlying exception instead of logging a generic error.

## Migration guide

No changes are required if your project already uses AGP `9.1.1` through `9.x`,
Gradle `9.3.1` or later, Java `17` or later,
and built-in Kotlin or KGP `2.4.10` or later.
Otherwise, update each out-of-range tool below.

### Check your current versions

Check the build files and toolchain settings in your Flutter project:

- **AGP and KGP:** Inspect the `plugins {}` block in your
  `android/settings.gradle.kts` (or `android/settings.gradle`) file.
  Projects created before Flutter 3.16 declare these versions in the
  `buildscript` block of `android/build.gradle`.
- **Gradle:** Inspect the `distributionUrl` line in your
  `android/gradle/wrapper/gradle-wrapper.properties` file.
- **Java (JDK):** Run `flutter doctor -v` and check the Java version listed
  under the Android toolchain section.

You can also run `flutter analyze --suggestions` from your project directory
to check whether your Java, Gradle, AGP, and KGP versions are compatible with
each other.
When all pairs are compatible, the command prints `compatible` without version
numbers.
The command prints versions only when a pair is incompatible,
and doesn't check Flutter's minimum thresholds.

### Update the Android Gradle Plugin

Update AGP to `9.3.1` (the default for new Flutter 3.50 projects)
to avoid the deprecation warning, or to at least `9.1.1`.

Projects created with Flutter 3.16 or later declare AGP in the `plugins {}`
block of the `android/settings.gradle.kts` (or `android/settings.gradle`) file.
If that block also declares `org.jetbrains.kotlin.android` and your project
uses `android.builtInKotlin=false`, update KGP at the same time
(refer to [Update the Kotlin Gradle Plugin](#update-the-kotlin-gradle-plugin)):

```kotlin diff title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
-   id("com.android.application") version "9.1.0" apply false
+   id("com.android.application") version "9.3.1" apply false
    id("org.jetbrains.kotlin.android") version "2.4.20" apply false
}
```

Projects created before Flutter 3.16 declare AGP as a `classpath` dependency
in the `android/build.gradle` file:

```groovy diff title="<flutter-project>/android/build.gradle"
buildscript {
    dependencies {
-       classpath 'com.android.tools.build:gradle:8.11.1'
+       classpath 'com.android.tools.build:gradle:9.3.1'
    }
}
```

If you're upgrading from AGP 8, also refer to
[Built-in Kotlin and the new AGP DSL](#built-in-kotlin-and-the-new-agp-dsl).

### Update Gradle

Update the Gradle wrapper in your
`android/gradle/wrapper/gradle-wrapper.properties` file.
Flutter recommends Gradle `9.5.0`.
Each AGP version requires a minimum Gradle version:
AGP `9.1` requires at least Gradle `9.3.1` (Flutter's new minimum),
and AGP `9.3` requires at least Gradle `9.5.0`.
For other combinations, consult the [AGP and Gradle compatibility table][].

```properties diff title="<flutter-project>/android/gradle/wrapper/gradle-wrapper.properties"
- distributionUrl=https\://services.gradle.org/distributions/gradle-9.1.0-all.zip
+ distributionUrl=https\://services.gradle.org/distributions/gradle-9.5.0-all.zip
```

Gradle 9 requires Java 17 or later.
If Flutter uses an older JDK, configure a newer JDK path with
`flutter config --jdk-dir=JDK_PATH`.
On Java 24 and later, Gradle prints `--enable-native-access` warnings;
Flutter 3.50 suppresses these warnings when invoking Gradle.

[AGP and Gradle compatibility table]: {{site.android-dev}}/build/releases/about-agp#updating-gradle

### Update the Kotlin Gradle Plugin

Skip this step if your project uses [built-in Kotlin][]
(`android.builtInKotlin=true`).
If `android.builtInKotlin=false` is set, update KGP even when your app
contains no Kotlin source files, because Flutter applies KGP automatically.

Update `org.jetbrains.kotlin.android` to `2.4.20`
(`2.4.10` is the minimum) in your `android/settings.gradle.kts` file:

```kotlin diff title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.3.1" apply false
-   id("org.jetbrains.kotlin.android") version "2.4.0" apply false
+   id("org.jetbrains.kotlin.android") version "2.4.20" apply false
}
```

Projects created before Flutter 3.16 set `ext.kotlin_version` in the
`android/build.gradle` file instead.

Applying KGP is deprecated with AGP 9.
Flutter logs a warning when your app or one of its plugins applies KGP,
and a future Flutter release will remove KGP support.
To migrate off KGP instead of continuing to update its version, follow the
[built-in Kotlin guide for app developers][].

[built-in Kotlin guide for app developers]: /release/breaking-changes/migrate-to-built-in-kotlin/for-app-developers

### Test Flutter plugins

Flutter plugins compile with the AGP, Gradle, and KGP versions configured by
the consuming app.
Test your plugin's example app with AGP `9.1.1` and `9.3.1`,
both with and without `android.builtInKotlin=false`.
For migration details, consult the
[built-in Kotlin guide for plugin authors][].

[built-in Kotlin guide for plugin authors]: /release/breaking-changes/migrate-to-built-in-kotlin/for-plugin-authors

### Bypass the version check

If you can't update your build tools immediately, pass
`--android-skip-build-dependency-validation` to `flutter run` or
`flutter build` to skip the version check.
Bypassing validation is unsupported: the Flutter Gradle Plugin calls AGP 9
APIs that older versions don't provide, so your build can still fail.

## Built-in Kotlin and the new AGP DSL

AGP 9 enables built-in Kotlin by default (rejecting the `kotlin-android`
plugin) and reads only the new AGP DSL.
Flutter keeps existing projects building across those AGP 9 changes with two
Gradle properties:

- `flutter create` writes `android.builtInKotlin=false` and
  `android.newDsl=false` to `android/gradle.properties`.
- On `flutter run` or `flutter build`, Flutter's migrator appends both lines
  (with marker comments) to `android/gradle.properties` if they're missing.

When a project upgrades from AGP 8 to AGP 9,
those lines appear in `android/gradle.properties` after the first `flutter run`
or `flutter build`.
These properties keep existing build scripts and plugins working without an
immediate built-in Kotlin migration.
While `android.builtInKotlin=false` is set, you must still update KGP to at
least `2.4.10`.

When you're ready to adopt AGP 9's defaults:

- To migrate to built-in Kotlin (`android.builtInKotlin=true`), follow
  [Migrating Flutter Android projects to built-in Kotlin][built-in Kotlin].
- To prepare build scripts for the new AGP DSL (`android.newDsl=true`),
  consult the [Variant API migration guide][new AGP DSL].
  Flutter 3.50 still sets `android.newDsl=false`, so migrating your own build
  scripts isn't required yet.

## Timeline

Landed in version: 3.50.0-0.1.pre, 3.50.0-0.3.pre, and 3.50.0-0.4.pre<br>
In stable release: 3.50

## References

Relevant issues:

- [Issue 189518][]: Update CI to test against Android 17 (API level 37)
- [Issue 193593][]: Add preemptive log about not using AGP 10 until supported

Relevant pull requests:

- [PR 192206][]: Skip KGP version validation for AGP built-in Kotlin
- [PR 193262][]: Update templates to AGP 9.3.1, Gradle 9.5.0, and KGP 2.4.20
- [PR 193609][]: Add unsupported AGP version error
- [PR 193813][]: Raise minimum version to AGP 9.1.1
- [PR 193814][]: Enable native access for Gradle on Java 24+
- [PR 194918][] (cherry-picked to 3.50 in [PR 195060][]): Run the dependency
  version check before reading Android DSL extensions
- [PR 195080][] (cherry-picked to 3.50 in [PR 195691][]): Report the real error
  when applying `kotlin-android` fails

[Issue 189518]: {{site.repo.flutter}}/issues/189518
[Issue 193593]: {{site.repo.flutter}}/issues/193593
[PR 192206]: {{site.repo.flutter}}/pull/192206
[PR 193262]: {{site.repo.flutter}}/pull/193262
[PR 193609]: {{site.repo.flutter}}/pull/193609
[PR 193813]: {{site.repo.flutter}}/pull/193813
[PR 193814]: {{site.repo.flutter}}/pull/193814
[PR 194918]: {{site.repo.flutter}}/pull/194918
[PR 195060]: {{site.repo.flutter}}/pull/195060
[PR 195080]: {{site.repo.flutter}}/pull/195080
[PR 195691]: {{site.repo.flutter}}/pull/195691
