---
title: Raised minimum Android build tool versions
description: >-
  Flutter 3.50 requires Android Gradle Plugin 9.1.1, Gradle 9.3.1,
  and Kotlin Gradle Plugin 2.4.10 (when applied) or later to build for Android.
  Android Gradle Plugin 10 isn't supported.
---

{% render "docs/breaking-changes.md" %}

## Summary

Flutter 3.50 raises the minimum versions for Android build tools compared to
Flutter 3.47.
Builds configured below these minimums, or with Android Gradle Plugin (AGP) 10
or later, fail dependency validation.

The following table compares the minimum, warning, and template default
versions between Flutter 3.47 and Flutter 3.50:

| Dependency | Flutter 3.47 minimum | Flutter 3.50 minimum | Warns below (3.50) | Template default (3.50) |
| :--- | :--- | :--- | :--- | :--- |
| Android Gradle Plugin (AGP) | 8.11.1 | **9.1.1** | 9.3.1 | 9.3.1 |
| Gradle | 8.14.0 | **9.3.1** | 9.5.0 | 9.5.0 |
| Kotlin Gradle Plugin (KGP, when applied) | 2.2.20 | **2.4.10** | 2.4.20 | 2.4.20 |
| Java (JDK) | 17 | 17 | 17 | — |

Two version rules apply alongside the minimums in the table:

- **KGP validation:** Flutter skips the KGP check when [built-in Kotlin][]
  (`android.builtInKotlin=true`) is active.
  With `android.builtInKotlin=false`, the Flutter Gradle Plugin (FGP) depends
  on KGP `2.4.10`.
  FGP applies `kotlin-android` whenever KGP is on the classpath, even without
  Kotlin source files.
  In `settings.gradle(.kts)`, Gradle resolves unpinned KGP versions up to
  `2.4.10` and logs a warning.
  Pinning KGP below `2.4.10`, or setting `ext.kotlin_version` below `2.4.10`,
  fails validation.
  For details, refer to [Built-in Kotlin and the new AGP DSL][kotlin-and-dsl].
- **AGP 10 upper bound:** Flutter 3.50 doesn't support AGP 10 or later,
  and builds configured with AGP 10 fail validation.

:::important Projects from Flutter 3.44 or 3.47 need manual updates
Neither `flutter upgrade` nor `flutter build` updates tool versions in an
app's `android/` directory.
Unmodified apps created with Flutter 3.44 or Flutter 3.47 use AGP versions
below `9.1.1` and fail validation until updated.
:::

Use the following table to check how Flutter 3.50 affects your project:

| Project configuration | Behavior on Flutter 3.50 | Action |
| :--- | :--- | :--- |
| AGP `9.1.1` through `9.x`, Gradle `9.3.1+`, Java 17+, and built-in Kotlin (or KGP `2.4.10+`) | Passes validation; warns below AGP `9.3.1`, Gradle `9.5.0`, or KGP `2.4.20` | Optional: update to `9.3.1`, `9.5.0`, and [built-in Kotlin][] (or KGP `2.4.20`) to clear warnings |
| Unmodified Flutter 3.47 app (AGP `9.1.0`, Gradle `9.3.1`, KGP `2.4.0`) | Fails on AGP; warns on Gradle and KGP (resolved to `2.4.10`) | [Update AGP][update-agp], [Gradle][update-gradle], and [KGP][update-kgp] |
| Unmodified Flutter 3.44 app (AGP `9.0.1`, Gradle `9.1.0`, KGP `2.3.20`) | Fails on Gradle and AGP; warns on KGP (resolved to `2.4.10`) | [Update AGP][update-agp], [Gradle][update-gradle], and [KGP][update-kgp] |
| Pre-3.16 `buildscript` app (`classpath` and `ext.kotlin_version`) | Fails on any tool version below the 3.50 minimum | Update `android/build.gradle` and `gradle-wrapper.properties` ([Check your versions][check-versions]) |
| Flutter module or add-to-app project | `flutter pub get` updates standalone `.android/`; host Android apps validate host versions | Update the host Android project's Gradle, AGP, and KGP versions ([Check your versions][check-versions]) |
| Android plugin | Consuming app sets tool versions; plugin's `example/` app runs validation | [Test Flutter plugins][test-plugins] on AGP `9.1.1` and `9.3.1` |

## Background

Flutter checks your Gradle, Java, AGP, and KGP versions on every Android build
and enforces a [support policy][] for these tools.
Flutter 3.50 raises the minimum versions for two reasons:

- Requiring AGP 9 provides the public AGP 9 APIs on every build, so FGP
  doesn't maintain separate AGP 8 and AGP 9 code paths.
- AGP `9.1.1` and later support `compileSdk` 37 (Android 17),
  preparing Flutter to target Android 17 without raising the minimum version
  again.

The [AGP migration timeline][] schedules the removal of the legacy DSL,
the legacy variant APIs, and the `android.newDsl=false` opt-out for AGP 10.
Because Flutter hasn't validated AGP 10,
Flutter 3.50 rejects AGP 10 or later during dependency validation:

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

Inspect the build files and toolchain settings in your Flutter app
(or in the host Android project for add-to-app builds):

- **AGP and KGP:** Check `plugins {}` in `android/settings.gradle.kts`
  (or `android/settings.gradle`), or check `gradle/libs.versions.toml`.
  On projects created before Flutter 3.16, check the `buildscript` block in
  `android/build.gradle`.
  Refer to [Update the Android Gradle Plugin][update-agp] and
  [Update the Kotlin Gradle Plugin][update-kgp].
- **Gradle:** Check the `distributionUrl` property in
  `android/gradle/wrapper/gradle-wrapper.properties`.
  Refer to [Update Gradle][update-gradle].
- **Java (JDK):** Run `flutter doctor -v` and check the `Java version` line
  under **Android toolchain**.

For a standalone Flutter module, running `flutter pub get` regenerates the
ephemeral `.android/` directory with the Flutter 3.50 defaults.

### Update the Android Gradle Plugin

Before updating AGP, check two compatibility requirements:

- AGP `9.3.1` requires Gradle `9.5.0` or later
  (refer to [Update Gradle][update-gradle]).
  AGP `9.1.1` works with Gradle `9.3.1` or later.
- If you're upgrading from AGP 8, also review
  [Built-in Kotlin and the new AGP DSL][kotlin-and-dsl].

Update AGP to `9.3.1` (the Flutter 3.50 template default) to clear warnings,
or to at least `9.1.1`.
On projects created with Flutter 3.16 or later, update the `plugins {}` block
in `android/settings.gradle.kts` (or `android/settings.gradle`).

Code before migration:

```kotlin title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "9.1.0" apply false
    // ...
}
```

Code after migration:

```kotlin title="<flutter-project>/android/settings.gradle.kts"
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    // Minimum in 3.50 is 9.1.1; 9.3.1 clears warnings (requires Gradle 9.5.0+).
    id("com.android.application") version "9.3.1" apply false
    // ...
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
  If Flutter uses an older JDK, run `flutter config --jdk-dir=JDK_DIR`,
  replacing `JDK_DIR` with your Java 17 or later path.
- Each AGP release requires a minimum Gradle version.
  AGP `9.1` requires at least Gradle `9.3.1`,
  and AGP `9.3` requires at least Gradle `9.5.0`.
  For other combinations, consult the [AGP and Gradle compatibility table][].

Set `distributionUrl` in `android/gradle/wrapper/gradle-wrapper.properties`
to Gradle `9.5.0` (or `9.3.1` with AGP `9.1.1`).

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
With `android.builtInKotlin=false`, update KGP to `2.4.20` to clear warnings,
or to at least `2.4.10`.

On projects created with Flutter 3.16 or later, update
`org.jetbrains.kotlin.android` in `android/settings.gradle.kts`
(or `android/settings.gradle`).

Code before migration:

```kotlin title="<flutter-project>/android/settings.gradle.kts"
plugins {
    // ...
    id("org.jetbrains.kotlin.android") version "2.4.0" apply false
}
```

Code after migration:

```kotlin title="<flutter-project>/android/settings.gradle.kts"
plugins {
    // ...
    // Minimum when applied is 2.4.10; 2.4.20 clears warnings.
    id("org.jetbrains.kotlin.android") version "2.4.20" apply false
}
```

On projects created before Flutter 3.16, update `ext.kotlin_version` in
`android/build.gradle` instead.
Unlike unpinned `plugins {}` declarations, FGP checks `ext.kotlin_version`
directly and fails validation below `2.4.10`.

Code before migration:

```groovy title="<flutter-project>/android/build.gradle"
buildscript {
    ext.kotlin_version = '2.2.20'
    // ...
}
```

Code after migration:

```groovy title="<flutter-project>/android/build.gradle"
buildscript {
    // Minimum when applied is 2.4.10; 2.4.20 clears warnings.
    ext.kotlin_version = '2.4.20'
    // ...
}
```

Applying KGP is deprecated on AGP 9, and Flutter logs a warning when your app
or a plugin applies it ([Issue 184837][]).
To migrate off KGP instead of updating its version, follow the
[built-in Kotlin guide for app developers][].

### Test Flutter plugins

Flutter plugins compile with the AGP, Gradle, and KGP versions configured by
the consuming app.
Verify your plugin's `example/` app against both supported configurations:

- Minimum supported toolchain: AGP `9.1.1` with Gradle `9.3.1`.
- Template default toolchain: AGP `9.3.1` with Gradle `9.5.0`.

Test each configuration with `android.builtInKotlin=false` and
`android.builtInKotlin=true` in `example/android/gradle.properties`.
For plugin migration steps, consult the
[built-in Kotlin guide for plugin authors][].

### Bypass the version check

:::caution Unsupported flag
Bypassing dependency validation is unsupported.
FGP calls AGP 9 APIs that older versions don't provide,
so your build can still fail.
:::

If you can't update your build tools immediately, pass
`--android-skip-build-dependency-validation` to `flutter run`,
`flutter build apk`, or `flutter build appbundle`:

```bash
flutter build apk --android-skip-build-dependency-validation
```

## Built-in Kotlin and the new AGP DSL

AGP 9 enables [built-in Kotlin][] by default (rejecting the `kotlin-android`
plugin) and exposes only the [new AGP DSL][].
Flutter keeps existing build scripts and plugins compatible across those
defaults with two Gradle properties in `android/gradle.properties`:

- `flutter create` writes `android.builtInKotlin=false` and
  `android.newDsl=false` to new projects.
- When either property is missing, `flutter run` or `flutter build` appends it
  with a marker comment.
  Builds started directly from Gradle or Android Studio (including add-to-app
  host builds) don't run that migrator.

If you build directly from Gradle or Android Studio, confirm that your
project's `gradle.properties` file sets both properties:

```properties title="<flutter-project>/android/gradle.properties"
# Keep legacy KGP and DSL compatibility until your app and plugins migrate.
android.builtInKotlin=false
android.newDsl=false
```

Use the following guides when you're ready to adopt the AGP 9 defaults:

- To migrate to built-in Kotlin (`android.builtInKotlin=true`), follow
  [Migrating Flutter Android projects to built-in Kotlin][built-in Kotlin].
- To prepare custom build scripts for `android.newDsl=true`, consult
  [Extend the Android Gradle Plugin][Variant API].
  Flutter 3.50 defaults to `android.newDsl=false`, keeping legacy AGP
  `android {}` types available until you enable `android.newDsl=true`
  ([Issue 180137][]).

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
- [Issue 180137][]: Tracking issue for enabling `android.newDsl=true` by
  default in Flutter project templates.
- [Issue 184837][]: Tracking issue for removing legacy Kotlin Gradle Plugin
  support in a future Flutter release.

[AGP and Gradle compatibility table]: {{site.android-dev}}/build/releases/about-agp#updating-gradle
[AGP migration timeline]: {{site.android-dev}}/build/releases/gradle-plugin-roadmap#agp-10
[built-in Kotlin]: /release/breaking-changes/migrate-to-built-in-kotlin
[built-in Kotlin guide for app developers]: /release/breaking-changes/migrate-to-built-in-kotlin/for-app-developers
[built-in Kotlin guide for plugin authors]: /release/breaking-changes/migrate-to-built-in-kotlin/for-plugin-authors
[check-versions]: #check-your-versions
[Issue 180137]: {{site.repo.flutter}}/issues/180137
[Issue 184837]: {{site.repo.flutter}}/issues/184837
[kotlin-and-dsl]: #built-in-kotlin-and-the-new-agp-dsl
[new AGP DSL]: {{site.android-dev}}/build/releases/agp-9-0-0-release-notes#android-gradle-plugin-new-dsl
[support policy]: /go/android-dependency-versions
[test-plugins]: #test-flutter-plugins
[update-agp]: #update-the-android-gradle-plugin
[update-gradle]: #update-gradle
[update-kgp]: #update-the-kotlin-gradle-plugin
[Variant API]: {{site.android-dev}}/build/extend-agp
