---
title: Migrating Flutter Android app to Android Gradle Plugin 9.0.0
description: >-
  How to migrate your Flutter app's Android Gradle files 
  to build apps with Android Gradle Plugin 9.0.0+.
---
:::warning
**Current Status:** Please **do not** update your 
Flutter app for Android to AGP 9. Flutter apps using plugins 
are currently incompatible with AGP 9: [Issue #181383][]. 
This support is paused while the Flutter team audits 
the migration for backwards compatibility with older versions of AGP.

If you would still like to migrate to AGP 9, follow the migration guide below.
:::

## Summary

To build a Flutter app for Android, the Android Gradle Plugin (AGP)
must be applied. As of AGP 9.0.0,
the following migrations are required to successfully apply AGP 9+.

First, built-in Kotlin is the new default, meaning any apps
using the `kotlin-android` plugin will not build successfully.
You must migrate from `kotlin-android` to built-in Kotlin.

Second, AGP 9+ will only use the new AGP DSL interfaces.
This means any old DSL types will not be properly read. 
The Flutter team is working on migrating old DSL types 
to use the new DSL: [Issue #180137][]. In the meantime, 
you can set a Gradle property flag to use the old DSL.

In a future Flutter release, support will be added for applying AGP 9+. 
For now, all projects must be migrated manually.

To learn more about Android Gradle Plugin,
see the [Android Gradle Plugin docs][AGP block].

## Migrate

These instructions assume you are updating from 
an AGP version created before 9.0.0 to an AGP version 9.0.0+.
You should also use the minimum compatible dependency versions
listed in the [Android Gradle Plugin docs][AGP block].

### Update the Gradle file

If your app doesn't apply 
the `kotlin-android` plugin (also called Kotlin Gradle Plugin), 
then skip to the next step.

First, find the `kotlin-android` plugin, likely located 
in the `plugins` block of the `<app-src>/android/build.gradle` 
or `<app-src>/android/build.gradle.kts` file.
As an example, consider the `build.gradle.kts` file from
a Flutter app created before this change:

**Before**:

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    // ...
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }
    // ...
}

// ...
```

Next, remove the `kotlin-android` plugin and the `kotlinOptions` block:

```kotlin diff
  plugins {
      id("com.android.application")
-     id("kotlin-android")
      // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
      id("dev.flutter.flutter-gradle-plugin")
  }
  
  android {
      // ...
-     kotlinOptions {
-         jvmTarget = JavaVersion.VERSION_17.toString()
-     }
      // ...
  }
```

Replace the `kotlinOptions` block with the following:

```kotlin diff
+ kotlin {
+     compilerOptions {
+         jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
+     }
+ }
```

Here is how the file will likely end up:

**After**:

```kotlin
plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    // ...
    kotlin {
        compilerOptions {
            jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
        }
    }
    // ...
}

// ...
```

### Set the Gradle property flag

Next, to use the old AGP DSL, set the Gradle property flag
`android.newDsl` to `false` in 
your app's `<app-src>/android/gradle.properties` file.

```properties diff
  org.gradle.jvmargs=-Xmx8G -XX:MaxMetaspaceSize=4G -XX:ReservedCodeCacheSize=512m -XX:+HeapDumpOnOutOfMemoryError
  android.useAndroidX=true
+ android.newDsl=false
```

### Validate

Execute `flutter run` to confirm that your app builds and
launches on a connected Android device or emulator.

## Next steps

- **Full Support for Plugins:** Full support for plugins on AGP 9
  will be enabled once the team confirms the migration is backwards compatible with
  older versions of AGP.

- **Remove DSL Gradle Property:** Once the Flutter team completes the migration
  to the new AGP DSL, remove `android.newDsl=false` from your
  `gradle.properties` file. This document will be updated
  to reflect that change.

## References

Relevant issues:

- [Issue #175688][]: Audit flutter for compatibility with the AGP 9.0.0
- [Issue #180137][]: Migrate from old to new AGP DSL
- [Issue #181383][]: Flutter plugins should support AGP 9.0.0

The Gradle build files in your app vary based on the Flutter version 
used when your app was created. 
Consider staying up to date with the latest version 
of the build files by periodically running `flutter upgrade` 
in your app's directory.

[AGP block]: {{site.android-dev}}/build/releases/gradle-plugin

[Issue #175688]: {{site.github}}/flutter/flutter/issues/175688
[Issue #180137]: {{site.github}}/flutter/flutter/issues/180137
[Issue #181383]: {{site.github}}/flutter/flutter/issues/181383
