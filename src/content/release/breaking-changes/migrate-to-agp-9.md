---
title: Migrating Flutter Android projects to Built-in Kotlin
description: >-
  Update your Flutter Android Gradle files to use built-in Kotlin support.
  Essential for migrating projects to Android Gradle Plugin 9.0.0+.
---

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
to use the new DSL: [Issue #180137][].

Support has been added to upgrade to AGP 9+. All projects,
including apps and plugins must manually migrate to built-in Kotlin.
In a future flutter version, support for applying KGP will be removed.

To learn more about Android Gradle Plugin,
see the [Android Gradle Plugin docs][AGP block].

## Migrate

These instructions assume you are updating from
an AGP version created before 9.0.0 to an AGP version 9.0.0+.
You should also use the minimum compatible dependency versions
listed in the [Android Gradle Plugin docs][AGP block].

This guide provides migration steps for Flutter Android apps,
Flutter plugins, and add-to-app android host apps.

### Update the Gradle file

If your app doesn't apply
the `kotlin-android` plugin (also called Kotlin Gradle Plugin),
then skip to the next step.

First, find the `kotlin-android` plugin (or the `org.jetbrains.kotlin.android`),
likely located in the `plugins` block of the `<app-src>/android/build.gradle`
or the `<app-src>/android/build.gradle.kts` file.
If you use the legacy apply() method, it will be located in
the Groovy-based `<app-src>/android/build.gradle` file, as this syntax is
not supported in Kotlin DSL.

The following are migration examples for migrating a Flutter Android app,
a Flutter plugins, and an add-to-app android host apps:

<Tabs key="migrate-different-projects">
<Tab name="app">

<Tabs key="modern-legacy-apply">
<Tab name="plugins block">

**Before**:

```kotlin title="<app-src>/android/build.gradle(.kts)"
plugins {
    id("com.android.application")
    id("kotlin-android")
    // ...
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

```kotlin diff title="<app-src>/android/build.gradle.kts"
  plugins {
      id("com.android.application")
-     id("kotlin-android")
      // ...
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

```kotlin diff title="<app-src>/android/build.gradle.kts"
+ kotlin {
+     compilerOptions {
+         jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
+     }
+ }
```

Here is how the file will likely end up:

**After**:

```kotlin title="<app-src>/android/build.gradle(.kts)"
plugins {
    id("com.android.application")
    // ...
}

android {
    // ...
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

// ...
```

</Tab>
<Tab name="legacy apply">

**Before**:

```groovy title="<app-src>/android/build.gradle"
apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
// ...

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

```groovy diff title="<app-src>/android/build.gradle"
  apply plugin: 'com.android.application'
- apply plugin: 'kotlin-android'
// ...

  android {
      // ...
-     kotlinOptions {
-         jvmTarget = JavaVersion.VERSION_17.toString()
-     }
      // ...
  }
```
Replace the `kotlinOptions` block with the following:

```groovy diff title="<app-src>/android/build.gradle"
+ kotlin {
+     compilerOptions {
+         jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
+     }
+ }
```

Here is how the file will likely end up:

**After**:

```groovy title="<app-src>/android/build.gradle"
apply plugin: 'com.android.application'
// ...

android {
    // ...
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

// ...
```

</Tab>
</Tabs>
</Tab>

<Tab name="plugin">

<Tabs key="modern-legacy-apply">
<Tab name="plugins block">

**Before**:

```kotlin title="<app-src>/android/build.gradle(.kts)"
plugins {
    id("com.android.library")
    id("kotlin-android")
    // ...
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

```kotlin diff title="<app-src>/android/build.gradle.kts"
  plugins {
      id("com.android.library")
-     id("kotlin-android")
      // ...
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

```kotlin diff title="<app-src>/android/build.gradle.kts"
+ kotlin {
+     compilerOptions {
+         jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
+     }
+ }
```

Here is how the file will likely end up:

**After**:

```kotlin title="<app-src>/android/build.gradle(.kts)"
plugins {
    id("com.android.library")
    // ...
}

android {
    // ...
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

// ...
```

</Tab>
<Tab name="legacy apply">

**Before**:

```groovy title="<app-src>/android/build.gradle"
apply plugin: 'com.android.library'
apply plugin: 'kotlin-android'
// ...

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

```groovy diff title="<app-src>/android/build.gradle"
  apply plugin: 'com.android.library'
- apply plugin: 'kotlin-android'
// ...

  android {
      // ...
-     kotlinOptions {
-         jvmTarget = JavaVersion.VERSION_17.toString()
-     }
      // ...
  }
```
Replace the `kotlinOptions` block with the following:

```groovy diff title="<app-src>/android/build.gradle"
+ kotlin {
+     compilerOptions {
+         jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
+     }
+ }
```

Here is how the file will likely end up:

**After**:

```groovy title="<app-src>/android/build.gradle"
apply plugin: 'com.android.library'
// ...

android {
    // ...
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

// ...
```

</Tab>
</Tabs>

</Tab>

<Tab name="host app">

**Before**:

```kotlin title="<app-src>/android/build.gradle(.kts)"
plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
    // ...
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

```kotlin diff title="<app-src>/android/build.gradle.kts"
  plugins {
      alias(libs.plugins.android.application)
-     alias(libs.plugins.kotlin.android)
      // ...
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

```kotlin diff title="<app-src>/android/build.gradle.kts"
+ kotlin {
+     compilerOptions {
+         jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
+     }
+ }
```

Here is how the file will likely end up:

**After**:

```kotlin title="<app-src>/android/build.gradle(.kts)"
plugins {
    alias(libs.plugins.android.application)
    // ...
}

android {
    // ...
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

// ...
```

</Tab>
</Tabs>

:::note This is a no-op. No further migration is required.

To ensure compatibility between the legacy Kotlin Gradle Plugin (KGP) 
and the built-in Kotlin support during this migration,
we now automatically add `android.builtInKotlin=false`
and `android.newDsl=false` to your `gradle.properties` file.

If these flags are missing from your gradle.properties file,
they will be automatically generated when you next build or run your app
using flutter run or flutter build apk. Alternatively, performing a build
through Android Studio tooling will also populate these entries.
Once the process completes, verify that the flags have been added.

For more details, see [Issue #183910].
:::

### Validate

Execute `flutter run` or `flutter build apk` to confirm that
your app builds and launches on a connected Android device or emulator.

## Next steps

- **Remove Support for KGP:** In a future version of Flutter,
  support for applying KGP will be removed. Developers must 
  migrate their projects (apps, plugins, host app projects) or else
  they will be unable to build.

- **Remove DSL Gradle Property:** Once the Flutter team completes the migration
  to the new AGP DSL, remove `android.newDsl=false` from your
  `gradle.properties` file. This document will be updated
  to reflect that change.

## References

Relevant issues:

- [Issue #175688][]: Audit flutter for compatibility with the AGP 9.0.0
- [Issue #180137][]: Migrate from old to new AGP DSL
- [Issue #181383][]: Flutter plugins should support AGP 9.0.0
- [Issue #183910][]: Add Disable Built-in Kotlin and new DSL Migrators

The Gradle build files in your app vary based on the Flutter version
used when your app was created.
Consider staying up to date with the latest version
of the build files by periodically running `flutter upgrade`
in your app's directory.

[AGP block]: {{site.android-dev}}/build/releases/gradle-plugin

[Issue #175688]: {{site.github}}/flutter/flutter/issues/175688
[Issue #180137]: {{site.github}}/flutter/flutter/issues/180137
[Issue #181383]: {{site.github}}/flutter/flutter/issues/181383
[Issue #183910]: {{site.github}}/flutter/flutter/issues/183910
