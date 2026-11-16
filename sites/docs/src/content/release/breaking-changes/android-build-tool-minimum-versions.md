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
Builds that resolve below these minimums—or configure Android Gradle Plugin
(AGP) 10 or later—fail with an error naming the dependency and required version.

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
(refer to [Built-in Kotlin and the new AGP DSL][kotlin-and-dsl]),
the Flutter Gradle Plugin depends on KGP `2.4.10` and applies `kotlin-android`
whenever KGP is on the build classpath.
Gradle resolves lower unpinned KGP declarations in `settings.gradle.kts` up to
`2.4.10`, so older KGP declarations log a `< 2.4.20` warning rather than failing
the build—even if your app has no Kotlin source files.

Flutter 3.50 doesn't support AGP 10 or later.
Projects configured with AGP 10 fail to build until a future Flutter release
adds AGP 10 support.

Default Android SDK and NDK values are unchanged from Flutter 3.47:
`compileSdk` is `36`, `targetSdk` is `36`, `minSdk` is `24`,
and the default NDK version is `28.2.13676358`.
Setting `minSdk` to `23` logs a warning, and `22` or lower fails the build.

:::warning Projects created with Flutter 3.44 or 3.47 need manual updates
Unmodified projects created with Flutter 3.44 or Flutter 3.47 fail to build on
Flutter 3.50 until you update their Gradle files.
Neither `flutter upgrade` nor `flutter build` updates these tool versions:

- **Flutter 3.44 templates** used Gradle `9.1.0` and AGP `9.0.1`.
  Both are below the Flutter 3.50 minimums, so update Gradle to at least
  `9.3.1` and AGP to at least `9.1.1`.
- **Flutter 3.47 templates** used AGP `9.1.0`, which is below the minimum, so
  update AGP to at least `9.1.1`.
  Their Gradle version (`9.3.1`) meets the minimum and logs a warning.

Both templates also declared an older KGP (`2.3.20` in 3.44, `2.4.0` in 3.47).
Flutter 3.50's Gradle plugin resolves KGP up to `2.4.10`, so the build doesn't
fail on KGP, and instead logs a warning until you declare KGP `2.4.20` or later.
Update to the Flutter 3.50 template versions (`AGP 9.3.1`, `Gradle 9.5.0`, and
`KGP 2.4.20`) in the [migration guide](#migration-guide) to clear all warnings.

Projects using AGP `9.0.1` through `9.1.0`, Gradle `9.1.0` through `9.3.0`, or
KGP `2.3.20` through `2.4.9` also received no advance warning in Flutter 3.47,
which warned only below AGP `9.0.1`, Gradle `9.1.0`, and KGP `2.3.20`.
:::

## Context

Flutter checks your Gradle, Java, AGP, and KGP versions on every Android build
and enforces a [support policy][] for these tools.
Under that policy, Flutter marks a version as "warn" for at least one stable
release before raising the minimum ("error") in a later release.

:::important
`TODO(reidbaker)`: Flutter 3.50 errors on AGP `9.0.1`–`9.1.0`, Gradle
`9.1.0`–`9.3.0`, and KGP `2.3.20`–`2.4.9` without a prior warning release in
Flutter 3.47.
Decide whether to state that Flutter 3.50 is an exception to the policy above
or remove the policy sentence before publishing.
:::

Flutter 3.50 raises the minimum versions for two reasons:

- Requiring AGP 9 means every project builds with AGP 9's API surface.
  The [Flutter Gradle Plugin now uses only public AGP APIs][variant-api-guide]
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

No changes are required to pass validation if your project already uses AGP
`9.1.1` through `9.x`, Gradle `9.3.1` or later, Java `17` or later, and doesn't
pin KGP below `2.4.10`.
To clear deprecation warnings, use AGP `9.3.1` or later, Gradle `9.5.0` or
later, and either [built-in Kotlin][] or KGP `2.4.20` or later.

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

Running `flutter analyze --suggestions` checks cross-tool compatibility between
Java, Gradle, AGP, and KGP (printing `compatible java/gradle/agp/kgp` when
valid), not Flutter's minimum thresholds.

### Update the Android Gradle Plugin

Update AGP to `9.3.1` (the default for new Flutter 3.50 projects)
to avoid the deprecation warning, or to at least `9.1.1`.

Projects created with Flutter 3.16 or later declare AGP in the `plugins {}`
block of the `android/settings.gradle.kts` (or `android/settings.gradle`) file:

```kotlin diff title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
-   id("com.android.application") version "9.1.0" apply false
+   id("com.android.application") version "9.3.1" apply false
    id("org.jetbrains.kotlin.android") version "2.4.0" apply false
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

[AGP and Gradle compatibility table]: {{site.android-dev}}/build/releases/about-agp#updating-gradle

### Update the Kotlin Gradle Plugin

Skip this step if your project uses [built-in Kotlin][]
(`android.builtInKotlin=true`).
When `android.builtInKotlin=false` is set, the Flutter Gradle Plugin resolves
unpinned KGP declarations up to `2.4.10` and applies `kotlin-android` even if
your app has no Kotlin source files.
KGP versions resolved below `2.4.20` log a warning (and KGP pinned below
`2.4.10` fails the build).

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

AGP 9 enables [built-in Kotlin][] by default (rejecting the `kotlin-android`
plugin) and reads only the [new AGP DSL][].
Flutter keeps existing projects building across those AGP 9 changes with two
Gradle properties in `android/gradle.properties`:

- `flutter create` writes `android.builtInKotlin=false` and
  `android.newDsl=false` to new projects.
- If either line is missing, Flutter's migrator appends it (with a marker
  comment) on the next `flutter run` or `flutter build`.
  Builds started directly from Gradle or Android Studio don't run this migrator.

These properties keep existing build scripts and plugins working without an
immediate built-in Kotlin or DSL migration.
When `android.builtInKotlin=false` is set, KGP below `2.4.20` logs a warning,
so update KGP to `2.4.20` or migrate to built-in Kotlin.

When you're ready to adopt AGP 9's defaults:

- To migrate to built-in Kotlin (`android.builtInKotlin=true`), follow
  [Migrating Flutter Android projects to built-in Kotlin][built-in Kotlin].
- To prepare build scripts for `android.newDsl=true`,
  consult the [Variant API migration guide][variant-api-guide].
  Flutter 3.50 still sets `android.newDsl=false`, so migrating your own build
  scripts isn't required yet.

## Timeline

Landed in version: 3.49.0-0.1.pre, 3.50.0-0.1.pre, 3.50.0-0.3.pre, and 3.50.0-0.4.pre<br>
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
- [PR 194918][] (cherry-picked to 3.50 in [PR 195060][]): Run the dependency
  version check before reading Android DSL extensions
- [PR 195080][] (cherry-picked to 3.50 in [PR 195691][]): Report the real error
  when applying `kotlin-android` fails

[built-in Kotlin]: /release/breaking-changes/migrate-to-built-in-kotlin
[Issue 189518]: {{site.repo.flutter}}/issues/189518
[Issue 193593]: {{site.repo.flutter}}/issues/193593
[kotlin-and-dsl]: #built-in-kotlin-and-the-new-agp-dsl
[new AGP DSL]: {{site.android-dev}}/build/releases/agp-9-0-0-release-notes#android-gradle-plugin-changed-dsl
[PR 192206]: {{site.repo.flutter}}/pull/192206
[PR 193262]: {{site.repo.flutter}}/pull/193262
[PR 193609]: {{site.repo.flutter}}/pull/193609
[PR 193813]: {{site.repo.flutter}}/pull/193813
[PR 194918]: {{site.repo.flutter}}/pull/194918
[PR 195060]: {{site.repo.flutter}}/pull/195060
[PR 195080]: {{site.repo.flutter}}/pull/195080
[PR 195691]: {{site.repo.flutter}}/pull/195691
[variant-api-guide]: /release/breaking-changes/flutter-gradle-plugin-variant-api
