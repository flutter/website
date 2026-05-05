---
title: Built-in Kotlin migration for app developers
description: >-
  Migrate Flutter apps to use built-in Kotlin.
---

## Migrate

This guide outlines the migration steps specifically for app developers.

These instructions assume you are updating from
an AGP version created before 9.0.0 to an AGP version 9.0.0+.
You should also use the minimum compatible dependency versions
listed in the [Android Gradle Plugin docs][AGP block].

### Verify flags in properties file

Flutter sets the default behavior to use the legacy Kotlin Gradle Plugin (KGP)
and the old AGP DSL types to support projects that have not yet migrated.
The Flutter migrator tool automatically adds `android.builtInKotlin=false`
and `android.newDsl=false` to your `gradle.properties` file.

If these flags are missing from your `gradle.properties` file,
the Flutter tool automatically adds them when you next build or run your app
using `flutter run` or `flutter build apk`.

Alternatively, building the project using Android Studio tooling also adds
these flags automatically.
Once the process completes, verify that the flags have been added.
For more details, see [Issue #183910].

All add-to-app projects must manually add `android.builtInKotlin=false`
and `android.newDsl=false` to the Android host app's `gradle.properties` file.
The Flutter migrator tool cannot run during add-to-app Android host app builds
because the host app is a pure native Android project.

```properties diff title="<host-app-project>/gradle.properties"
# ...
+ android.newDsl=false
+ android.builtInKotlin=false
```

:::note
If your app doesn't apply
the `kotlin-android` plugin (also called Kotlin Gradle Plugin),
then you only need to add `android.newDsl=false` and do not need
further migration.
:::

### Update the Gradle file

First, find the `kotlin-android` plugin (or the `org.jetbrains.kotlin.android`
plugin).
It is likely located in the `plugins` block of the
`<app-src>/android/build.gradle` or the
`<app-src>/android/build.gradle.kts` file.
If you use the legacy `apply` syntax, it will be located in
the Groovy-based `<app-src>/android/build.gradle` file, as this syntax is
not supported in Kotlin DSL.

The following examples demonstrate how to migrate a Flutter Android app
and an add-to-app Android host app:

#### Migrate your Flutter Android app

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

Add the `kotlin.compilerOptions{}` DSL block with the following:

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
Add the `kotlin.compilerOptions{}` DSL block with the following:

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

#### Migrate your add-to-app Android host app

Android native apps use the `alias` keyword to apply plugins,
which is incompatible with the legacy `apply()` syntax.
Therefore, only the `plugins {}` block instructions are included.

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
Add the `kotlin.compilerOptions{}` DSL block with the following:

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

### Validate

Execute `flutter run` or `flutter build apk` to confirm that
your app builds and launches on a connected Android device or emulator.

If your app fails to build because you are using an unmigrated Flutter plugin,
follow the instructions below:

### Report incompatible Kotlin Gradle Plugin usage to plugin authors

Follow these instructions only if your app uses a Flutter plugin
that has not yet migrated to built-in Kotlin.

1. Find the repository of the unmigrated Flutter plugin by searching for the
   plugin name on [pub.dev](https://pub.dev) or online.
2. Refer to the plugin CHANGELOG to confirm that no existing version
   has migrated to built-in Kotlin.
3. Report an issue to the plugin authors, informing them that the Kotlin
   Gradle Plugin is incompatible and won't be supported in a future version
   of Flutter.

You can use the following template for the issue:

**Issue Title:** Migrate Plugin to Built-in Kotlin

**Issue Body:**
I am using `<plugin-name>` in my Flutter app.

Starting with Android Gradle Plugin (AGP) 9.0,
support for applying the Kotlin Gradle Plugin (KGP) has been removed.
Because this plugin applies KGP, it causes a compilation error
that prevents my app from building.
Here is an example of the error [Issue #181383][].

Flutter has temporarily added support to allow KGP
while apps and plugins migrate to AGP 9.0+,
but this support will be removed in a future version of Flutter.

Please migrate this plugin to use built-in Kotlin to ensure your plugin
users can successfully build their apps in future versions of Flutter.

Here is the Flutter [migration guide for plugin authors][plugin-migration-guide].

Please be respectful and mindful of the plugin repository's rules and code
of conduct when reporting issues and interacting with plugin authors.

For reference, see the [Flutter Code of Conduct][Code of Conduct].

## Next steps

See the [migration overview](./) for next steps.

## References

Relevant issues:

- [Issue #183910][]: Add Disable Built-in Kotlin and new DSL Migrators
- [Issue #181383][]: Flutter plugins should support AGP 9.0.0

The Gradle build files in your app vary based on the Flutter version
used when your app was created.
Consider staying up to date with the latest version
of the build files by periodically running `flutter upgrade`
in your app's directory.

[AGP block]: {{site.android-dev}}/build/releases/gradle-plugin

[Issue #183910]: {{site.github}}/flutter/flutter/issues/183910
[Issue #181383]: {{site.github}}/flutter/flutter/issues/181383

[plugin-migration-guide]: {{site.flutter-docs}}/release/breaking-changes/migrate-to-built-in-kotlin/for-plugin-authors
[Code of Conduct]: https://github.com/flutter/flutter/blob/master/CODE_OF_CONDUCT.md
