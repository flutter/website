---
title: Required Kotlin version 
description: Flutter apps built for the Android platform require Kotlin 1.5.31 or greater.
---

## Summary

To build a Flutter app for Android, Kotlin 1.5.31 or greater is required.

If your app uses a lower version,
you will receive the following error message:

```
┌─ Flutter Fix ────────────────────────────────────────────────────────────┐
│                                                                          │
│ [!] Your project requires a newer version of the Kotlin Gradle plugin.   │
│ Find the latest version on                                               │
│ https://kotlinlang.org/docs/gradle.html#plugin-and-versions, then update │
│ <path-to-app>/android/build.gradle:                                      │
│ ext.kotlin_version = '<latest-version>'                                  │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

## Context

Flutter added support for [foldable devices][1] on Android.
This required adding an AndroidX dependency to the Flutter embedding that
requires apps to use Kotlin 1.5.31 or greater.

## Description of change

A Flutter app compiled for Android now includes the Gradle dependency 
`androidx.window:window-java`.

## Migration guide

Open `<app-src>/android/build.gradle`, and change `ext.kotlin_version`:

```diff
buildscript {
-    ext.kotlin_version = '1.3.50'
+    ext.kotlin_version = '1.5.31'
```

## Timeline

Landed in version: v2.9.0 beta<br>
In stable release: 2.10

## References

Relevant PRs:

* [PR 29585: Display Features support][]


[PR 29585: Display Features support]: {{site.github}}/flutter/engine/pull/29585

[1]: {{site.android-dev}}/guide/topics/large-screens/learn-about-foldables
