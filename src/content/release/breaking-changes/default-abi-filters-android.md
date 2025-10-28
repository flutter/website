---
title: Flutter now sets default `abiFilters` in Android builds
description: >-
  The Flutter Gradle Plugin now automatically configures abiFilters
  for Android builds, which might break custom abiFilters settings.
---

{% render "docs/breaking-changes.md" %}

## Summary

Starting in Flutter 3.35, the Flutter Gradle Plugin automatically sets
[`abiFilters`][] for Android builds to prevent the inclusion of unsupported
architectures in release APKs. This change can break custom
`abiFilters` specified in your app's `build.gradle` file.

## Context

This change was introduced to solve an issue where third-party
dependencies with x86 native libraries would cause Google Play to
incorrectly identify Flutter apps as supporting x86 devices. When users
with x86 devices installed these apps, they would crash at runtime
because Flutter's native libraries aren't available for x86.

The Flutter Gradle Plugin now automatically configures `abiFilters` to
include only the architectures that Flutter supports. This prevents
Google Play from making apps available to incompatible devices.

## Description of change

The Flutter Gradle Plugin now programmatically sets `abiFilters` for
non-debuggable builds when the `--splits-per-abi` option is not enabled
by default to:
- `armeabi-v7a`
- `arm64-v8a`
- `x86_64`

Because this automatic configuration happens before your `build.gradle` files
are processed, it might break custom `abiFilters` settings that depend on the
set being empty.

## Migration guide
If your app doesn't customize `abiFilters`, no changes are required.

If your app needs to customize which architectures are included, you have
several options:

### Option 1: Use the splits-per-abi flag

If you want to control architecture inclusion, use Flutter's built-in
`--splits-per-abi` option instead of manually configuring `abiFilters`:

```console
flutter build apk --splits-per-abi
```

This creates separate APKs for each architecture and automatically disables
the automatic `abiFilters` configuration.

### Option 2: Clear and reconfigure abiFilters

If you must use a single APK with custom architecture filters, clear the
automatically set filters and configure your own in your `build.gradle`.
For example:

```kotlin
android {
    buildTypes {
        release {
            // Clear the automatically set filters.
            ndk.abiFilters.clear()
            // Set your custom filters.
            ndk.abiFilters.addAll(listOf("arm64-v8a"))
        }
    }
}
```

## Timeline

Landed in version: 3.35.0<br>
In stable release: 3.35

Relevant issues:
* [Issue #174004]({{site.repo.flutter}}/issues/174004)
* [Issue #153476]({{site.repo.flutter}}/issues/153476)

Relevant PRs:
* [PR #168293]({{site.repo.flutter}}/pull/168293)

[`abiFilters`]: https://developer.android.com/reference/tools/gradle-api/8.7/com/android/build/api/dsl/Ndk#abiFilters()
