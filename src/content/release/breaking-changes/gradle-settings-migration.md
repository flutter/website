---
title: Gradle settings migration
description: >
  A change to enable the developer to edit Kotlin and Dart files with syntax highlighting and auto
  completion in Android Studio.
---

{% render docs/breaking-changes.md %}

## Summary

A change to enable the developer to edit Kotlin and Dart files
with syntax highlighting and auto completion in Android Studio.

## Context

In order to detect Flutter and Gradle modules in the same IDE instance,
the Gradle settings need to be moved so that the IDE can see both
project types at once.

## Migration guide

### Moving files

The following files must be moved to the root directory of your project:
- `android/settings.gradle[.kts]` (with the `.kts` suffix when you use the Kotlin script)
- `android/build.gradle[.kts]`
- `android/gradle.properties`
- `android/local.properties`

### Changing files

#### `build.gradle.kts`

Change the `newBuildDir` value from:
```dart
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
```
to:
```dart
val newBuildDir: Directory = rootProject.layout.buildDirectory.get()
```

#### `build.gradle.kts`

Add the following line:
```dart
project(":app").projectDir = File(rootDir, "android/app/")
```

#### or `build.gradle`

Add the following line:
```dart
project(':app').projectDir = new File(rootDir, 'android/app/')
```

When your project has multiple modules, add them in `build.gradle[.kts]` and
replace the module name with the actual path.

## Timeline

In stable release: 3.34.0

## References

Relevant issue:

* [Can't resolve symbol `io.flutter.plugin dependency`][Issue-19830]

Relevant PR:

* [Resolve resolve native Flutter dependencies in Android Studio][PR-167332]

[PR-167332]: {{site.repo.flutter}}/pull/167332
[Issue-19830]: {{site.repo.flutter}}/issues/19830
