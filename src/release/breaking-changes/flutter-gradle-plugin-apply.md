---
title: Deprecated imperative apply of Flutter Gradle Plugin
description: >
  How to migrate your Android app's Gradle build files to the new, declarative
  format.
---

## Summary

To build a Flutter app for Android, the Flutter Gradle plugin must be applied.
Historically, this was done imperatively with Gradle's
[legacy, imperative apply method][].

In Flutter 3.16, support has been added for applying these plugins with Gradle's
[declarative `plugins {}` block][], and it is the recommended approach.
Since Flutter 3.16, projects generated with `flutter create` use the new apply
method of applying Gradle plugins. Older projects, however, should be migrated
manually.

To learn about advantages the new declarative apply syntax has over the old
imperative apply syntax, see [Gradle docs about plugins {} block][plugins block].

Migrating the app ecosystem to use the new approach will also make it easier for
Flutter team to develop Flutter's Gradle plugins, and to enable exciting new
features in the future, such as using Kotlin instead of Groovy in Gradle
buildscripts.

## Migrate

### android/settings.gradle

Replace contents with:

```gradle
pluginManagement {
    def flutterSdkPath = {
        def properties = new Properties()
        file("local.properties").withInputStream { properties.load(it) }
        def flutterSdkPath = properties.getProperty("flutter.sdk")
        assert flutterSdkPath != null, "flutter.sdk not set in local.properties"
        return flutterSdkPath
    }
    settings.ext.flutterSdkPath = flutterSdkPath()

    includeBuild("${settings.ext.flutterSdkPath}/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "7.3.0" apply false
    id "org.jetbrains.kotlin.android" version "1.7.10" apply false
}

include ":app"
```

### android/build.gradle

Replace contents with:

```gradle
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

```gradle
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

android {
    namespace "com.example.example"
    compileSdk flutter.compileSdkVersion
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.example.example"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
        minSdkVersion flutter.minSdkVersion
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
        }
    }
}

flutter {
    source '../..'
}

dependencies {}
```

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

To migrate to the new, declarative apply of the GMS and Crashlytics plugins, add
the following lines to `<app-src>/android/settings.gradle`:

```diff
 plugins {
     id "dev.flutter.flutter-plugin-loader" version "1.0.0"
     id "com.android.application" version "7.3.0" apply false
     id "org.jetbrains.kotlin.android" version "1.7.10" apply false
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

## References

Gradle build files generated by `flutter create` differ across Flutter versions.
For detailed overview, see [issue #135392][]. You should consider using use the
latest versions of build files.

[legacy apply method]: https://docs.gradle.org/8.5/userguide/plugins.html#sec:script_plugins
[declarative `plugins {}` block method]: https://docs.gradle.org/8.5/userguide/plugins.html#sec:plugins_block
[plugins block]: https://docs.gradle.org/current/userguide/plugins.html#plugins_dsl_limitations
[issue #135392]: https://github.com/flutter/flutter/issues/135392
