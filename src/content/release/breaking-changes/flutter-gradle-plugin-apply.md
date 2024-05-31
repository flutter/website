---
title: Deprecated imperative apply of Flutter's Gradle plugins
description: >-
  How to migrate your Flutter app's Android Gradle build files to the
  new, declarative format.
---

## Summary

To build a Flutter app for Android, Flutter's Gradle plugins must be applied.
Historically, this was done imperatively with Gradle's
[legacy, imperative apply script method][].

In Flutter 3.16, support was added for applying these plugins with Gradle's
[declarative plugins {} block][] (also called the Plugin DSL) and it is
now the recommended approach. Since Flutter 3.16, projects generated with
`flutter create` use the Plugin DSL to apply Gradle plugins. Projects created
with versions of Flutter prior to 3.16 need to be migrated manually.

Applying Gradle plugins using the `plugins {}` block executes the same code as
before and should produce equivalent app binaries.

To learn about advantages the new Plugin DSL syntax has over the legacy `apply`
script syntax, see [Gradle docs][plugins block].

Migrating the app ecosystem to use the new approach will also make it easier for
Flutter team to develop Flutter's Gradle plugins, and to enable exciting new
features in the future, such as using Kotlin instead of Groovy in Gradle
buildscripts.

## Migrate

### android/settings.gradle

First, find the values of the Android Gradle Plugin (AGP) and Kotlin that the project currently 
uses. Unless they have been moved, they are likely defined in the buildscript block of the 
`<app-src>/android/build.gradle` file. As an example, consider the `build.gradle` file from 
a new Flutter app created before this change:

```groovy
buildscript {
    ext.kotlin_version = '1.7.10'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.3.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
}

tasks.register("clean", Delete) {
    delete rootProject.buildDir
}
```

The AGP version is the number that comes at the end of the line 
`classpath 'com.android.tools.build:gradle:7.3.0'`, so `7.3.0` 
in this case. Similarly, the Kotlin version comes at the end of the line
`ext.kotlin_version = '1.7.10'`, in this case `1.7.10`.

Next, replace the contents of `<app-src>/android/settings.gradle` with the below,
remembering to replace `{agpVersion}` and `{kotlinVersion}` with previously
identified values:

```groovy
pluginManagement {
    def flutterSdkPath = {
        def properties = new Properties()
        file("local.properties").withInputStream { properties.load(it) }
        def flutterSdkPath = properties.getProperty("flutter.sdk")
        assert flutterSdkPath != null, "flutter.sdk not set in local.properties"
        return flutterSdkPath
    }()

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "{agpVersion}" apply false
    id "org.jetbrains.kotlin.android" version "{kotlinVersion}" apply false
}

include ":app"
```

If you made some changes to this file, make sure they're placed after
`pluginManagement {}` and `plugins {}` blocks, since Gradle enforces that no
other code may be placed before these blocks.

### android/build.gradle

Remove the whole `buildscript` block from `<app-src/android/build.gradle`:

```diff
-buildscript {
-    ext.kotlin_version = '{kotlinVersion}'
-    repositories {
-        google()
-        mavenCentral()
-    }
-
-    dependencies {
-        classpath "org.jetbrains.kotlin:gradle-plugin:$kotlin_version"
-    }
-}
```

Here's how that file will likely end up:

```groovy
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
}

tasks.register("clean", Delete) {
    delete rootProject.buildDir
}
```

### android/app/build.gradle

Most changes have to be made in the `<app-src>/android/app/build.gradle`. First,
remove these 2 chunks of code that use the legacy imperative apply method:

```diff
-def flutterRoot = localProperties.getProperty('flutter.sdk')
-if (flutterRoot == null) {
-    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
-}
```

```diff
-apply plugin: 'com.android.application'
-apply plugin: 'com.jetbrains.kotlin.android'
-apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
```

Now apply the plugins again, but this time using the Plugin DSL syntax. At the
very top of your file, add:

```groovy
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}
```

Finally, if your `dependencies` block contains a dependency on `"org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"`, 
then remove that dependency.
```diff
dependencies {
-    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
}
```
If it was the only dependency in the `dependencies` block, then 
alternatively you may remove the block entirely.

### Validation

Execute `flutter run` to confirm your app builds and launches on a connected
Android device or emulator.

## Examples

### Google Mobile Services and Crashlytics

If your app was using Google Mobile Services and Crashlytics, remove the
following lines from `<app-src>/android/build.gradle`:

```diff
 buildscript {
     // ...

     dependencies {
         // ...
-        classpath "com.google.gms:google-services:4.4.0"
-        classpath "com.google.firebase:firebase-crashlytics-gradle:2.9.9"
     }
 }
```

and remove these 2 lines from `<app-src>/android/app/build.gradle`:

```diff
-apply plugin: 'com.google.gms.google-services'
-apply plugin: 'com.google.firebase.crashlytics'
```

To migrate to the new, declarative-apply syntax for
the GMS and Crashlytics plugins, add them to `plugins` block
in your app's `<app-src>/android/settings.gradle` file.
The additions should look similar to the following,
but with your desired plugin versions, likely matching
the ones you removed from the `<app-src>/android/build.gradle` file.

```diff
 plugins {
     id "dev.flutter.flutter-plugin-loader" version "1.0.0"
     id "com.android.application" version "{agpVersion}" apply false
     id "org.jetbrains.kotlin.android" version "{kotlinVersion}" apply false
+    id "com.google.gms.google-services" version "4.4.0" apply false
+    id "com.google.firebase.crashlytics" version "2.9.9" apply false
 }
```

and the following lines to `<app-src>/android/app/build.gradle`:

```diff
 plugins {
     id "com.android.application"
     id "dev.flutter.flutter-gradle-plugin"
     id "org.jetbrains.kotlin.android"
+    id "com.google.gms.google-services"
+    id "com.google.firebase.crashlytics"
 }
```

## Timeline

Support in stable release: 3.16.0
Recommended in stable release: 3.19.0

## References

Gradle build files generated by `flutter create` differ across Flutter versions.
For a detailed overview, see [issue #135392][]. You should consider using the
latest versions of build files.

[legacy, imperative apply script method]: https://docs.gradle.org/8.5/userguide/plugins.html#sec:script_plugins
[declarative plugins {} block]: https://docs.gradle.org/8.5/userguide/plugins.html#sec:plugins_block
[plugins block]: https://docs.gradle.org/current/userguide/plugins.html#plugins_dsl_limitations
[issue #135392]: https://github.com/flutter/flutter/issues/135392
