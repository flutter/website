---
title: Breaking Changes from Android Gradle Plugin 9.0.0
description: >-
  How to migrate your Flutter app's Android Gradle files 
  to build apps with Android Gradle Plugin 9.0.0+.
---

## Summary

To build a Flutter app for Android, the Android Gradle Plugin (AGP)
must be applied. Starting AGP 9.0.0, a few breaking changes have been made.
The following migrations must be made in order to successfully apply AGP 9+.

First, built-in Kotlin is the new default, meaning any apps
using the `kotlin-android` plugin will not build successfully.
You must migrate from `kotlin-android` to built-in Kotlin.

Second, AGP 9+ will only use the new AGP DSL interfaces.
This means any old DSL types will not be properly read. 
The Flutter team is working on migrating old DSL types 
to use the new DSL. In the meantime, you can set a gradle property flag 
to allow for usage of the old DSL.

In Flutter 3.40.0, support was added for applying AGP 9+. Projects created
with versions of Flutter prior to 3.40.0 need to be migrated manually.

To learn more about Android Gradle Plugin,
see [Android Gradle Plugin docs][AGP block].

## Migrate

These instructions assume you are updating from an AGP version < 9.0.0
to an AGP version 9.0.0+.
You should also be using minimum compatible dependency versions
listed in the [Android Gradle Plugin docs][AGP block].

### android/app/build.gradle or android/app/build.gradle.kts

If your app does not apply the `kotlin-android` (Kotlin Gradle Plugin), then
skip to the next step.

First, find the `kotlin-android` plugin likely located in the plugins block of
the `<app-src>/android/build.gradle` or `<app-src>/android/build.gradle.kts`
file.
As an example, consider the `build.gradle.kts` file from
a new Flutter app created before this change:

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    ...
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }
    ...
}
...
```

Next, remove the `kotlin-android` plugin and the `kotlinOptions` block like so:

```kotlin diff
plugins {
    id("com.android.application")
    -id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    ...
    -kotlinOptions {
        -jvmTarget = JavaVersion.VERSION_17.toString()
    -}
    ...
}
```

Replace the `kotlinOptions` block with the following:

```kotlin diff
+kotlin {
    +compilerOptions {
        +jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    +}
+}
```

Here is how the file will likely end up:

```kotlin
plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    ...
    kotlin {
        compilerOptions {
            jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
        }
    }
    ...
}
...
```

### android/gradle.properties

Moving on, to allow usage of the old AGP DSL, set the gradle property flag
`android.newDsl` to false in your app's `<app-src>/android/gradle.properties`.

```properties diff
org.gradle.jvmargs=-Xmx8G -XX:MaxMetaspaceSize=4G -XX:ReservedCodeCacheSize=512m -XX:+HeapDumpOnOutOfMemoryError
android.useAndroidX=true
+ android.newDsl=false
```

### Validation

Execute `flutter run` to confirm that your app builds and
launches on a connected Android device or emulator.

## Timeline

Support in stable release: 3.40.0
Recommended in stable release: 3.43.0

## References

Relevant issue:
[Issue #175688][]

The Gradle build files in your app vary based on the Flutter version 
used when generating your app. 
You should consider staying up-to-date with the latest version 
of the build files by running `flutter upgrade` 
in your app's directory periodically.

[AGP block]: https://developer.android.com/build/releases/gradle-plugin

[Issue #175688]: {{site.github}}/flutter/flutter/issues/175688
