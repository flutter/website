---
title: Deprecated imperative apply of Flutter Gradle Plugin
description: >
  How to migrate your Android app's Gradle build files to the new, declarative
  format.
---

## Summary

To build a Flutter app for Android, the Flutter Gradle plugin must be applied.
Historically, this was done imperatively with Gradle's imperative apply syntax.

In Flutter 3.13 and 3.16, support has been added for the declarative apply of
Flutter Gradle Plugin, and it is the recommended. Since Flutter 3.16, all new
projects generated with `flutter create` will use the declarative apply of
Flutter Gradle Plugin out of the box. Older projects, however, should be
migrated manually.

To learn about advantages the new declarative apply syntax has over the old
imperative apply syntax, see [Gradle docs][plugins block].

This change will make Flutter's Gradle plugins easier to develop.

[plugins block]: https://docs.gradle.org/current/userguide/plugins.html#sec:plugins_block

## Migrate

### android/settings.gradle

Replace contents of `android/settings.gradle` with the following:

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
}

include ":app"
```

### android/build.gradle

### android/app/build.gradle

