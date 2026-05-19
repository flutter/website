---
title: Built-in Kotlin migration for plugin authors
description: >-
  Migrate Flutter plugins to use built-in Kotlin.
---

## Migrate your Flutter plugin

This guide outlines the migration steps specifically for plugin authors.

### Update the Gradle file

The following steps assume you can update your plugin's Flutter SDK minimum
to 3.44. If you cannot update the Flutter SDK minimum to 3.44, follow the
instructions for
[supporting Flutter versions earlier than 3.44][flutter-sdk-minimum-below-3.44].

First, find the `kotlin-android` plugin (or the `org.jetbrains.kotlin.android`
plugin).
It is likely located in the `plugins` block of the
`<plugin-project>/build.gradle` or the `<plugin-project>/build.gradle.kts` file.
If you use the legacy `apply` syntax, it will be located in
the Groovy-based `<plugin-project>/build.gradle` file, as this syntax is
not supported in Kotlin DSL.

The following examples demonstrate how to migrate a Flutter plugin:

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

### Update the plugin's `pubspec.yaml`

Using the `kotlin.compilerOptions {}` DSL block requires
a minimum Kotlin Gradle Plugin (KGP) version of 2.0.0.
Beginning with Flutter 3.44, the minimum required KGP version is 2.0.0.
To ensure that apps using your plugin can safely migrate to built-in Kotlin,
you should require a minimum Flutter version of 3.44 for this plugin version.

Since you are updating the minimum Flutter version,
you must also update the minimum associated Dart version.

Update the minimum Flutter version and the minimum Dart version:

```yaml diff title="<plugin-project>/pubspec.yaml"
# ...

environment:
-  sdk: ^<previous-dart-minimum>
+  sdk: ^3.12.0
-  flutter: ">=<previous-flutter-minimum>"
+  flutter: ">=3.44.0"

# ...
```

Here is how the file will likely end up:

```yaml title="<plugin-project>/pubspec.yaml"
# ...

environment:
  sdk: ^3.12.0
  flutter: ">=3.44.0"

# ...
```

## Supporting Flutter versions earlier than 3.44

If you updated your plugin's Flutter SDK minimum to 3.44, skip this section
and proceed to updating the plugin's `CHANGELOG.md`.

If you cannot update the plugin's Flutter SDK minimum to 3.44, you must make
the following changes to `<plugin-project>/android/build.gradle` or
`<plugin-project>/android/build.gradle.kts` to support apps on AGP < 9
and AGP >= 9:

<Tabs key="workaround-for-plugins">
<Tab name="Kotlin DSL fix">

**Before**:

```kotlin title="<app-src>/android/build.gradle.kts"
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

Add a check to apply the Kotlin Gradle Plugin only when the app's Android
Gradle Plugin version is earlier than 9.

```kotlin diff title="<app-src>/android/build.gradle.kts"
+ val agpMajor = com.android.Version.ANDROID_GRADLE_PLUGIN_VERSION.substringBefore('.').toInt()
+
+ if (agpMajor < 9) {
+    apply(plugin = "org.jetbrains.kotlin.android")
+ }
```

Add the `compilerOptions` configuration using the project extension:

```kotlin diff title="<app-src>/android/build.gradle.kts"
+ project.extensions.configure(org.jetbrains.kotlin.gradle.dsl.KotlinAndroidProjectExtension::class.java) {
+     compilerOptions {
+         jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
+     }
+ }
```

Here is how the file will likely end up:

**After**:

```kotlin title="<app-src>/android/build.gradle.kts"
plugins {
    id("com.android.library")
    // ...
}

val agpMajor = com.android.Version.ANDROID_GRADLE_PLUGIN_VERSION.substringBefore('.').toInt()

if (agpMajor < 9) {
    apply(plugin = "org.jetbrains.kotlin.android")
}

android {
    // ...
}

project.extensions.configure(org.jetbrains.kotlin.gradle.dsl.KotlinAndroidProjectExtension::class.java) {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

// ...
```

</Tab>
<Tab name="Groovy DSL fix">

**Before**:

```groovy title="<app-src>/android/build.gradle"
apply plugin: 'com.android.library'
apply plugin: 'kotlin-android'

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

  android {
      // ...
-     kotlinOptions {
-         jvmTarget = JavaVersion.VERSION_17.toString()
-     }
      // ...
  }
```

Add a check to apply the Kotlin Gradle Plugin only when the app's Android
Gradle Plugin version is earlier than 9.

```groovy diff title="<app-src>/android/build.gradle"
+ def agpMajor = com.android.Version.ANDROID_GRADLE_PLUGIN_VERSION.tokenize('.')[0] as int
+
+ if (agpMajor < 9) {
+    apply plugin: 'kotlin-android'
+ }
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
apply plugin: 'com.android.library'

def agpMajor = com.android.Version.ANDROID_GRADLE_PLUGIN_VERSION.tokenize('.')[0] as int
if (agpMajor < 9) {
    apply plugin: 'kotlin-android'
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

### Update the plugin's `CHANGELOG.md`

Include your changes in the CHANGELOG of the newly released plugin version:

```markdown diff title="<plugin-project>/CHANGELOG.md"
+ ## <new-plugin-release-version>

+ - Updates minimum supported SDK version to Flutter 3.44/Dart 3.12.
+ - Migrates to built-in Kotlin

// ...
```

### Validate

Execute `flutter run` or `flutter build apk` to confirm that
your plugin example app builds and launches
on a connected Android device or emulator.

If your plugin example app also applies KGP,
then you will also have to migrate the example app.
Follow the [migration guide for app developers][app-migration-guide] to migrate your example app.

[app-migration-guide]: {{site.flutter-docs}}/release/breaking-changes/migrate-to-built-in-kotlin/for-app-developers
[flutter-sdk-minimum-below-3.44]: {{site.flutter-docs}}/release/breaking-changes/migrate-to-built-in-kotlin/for-plugin-authors#supporting-flutter-versions-earlier-than-3-44
