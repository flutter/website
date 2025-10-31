---
title: Dropping support for Android KitKat
description: >-
  Flutter is raising the minimum supported Android version from
  KitKat (API 19) to Lollipop (API 21).
---

{% render "docs/breaking-changes.md" %}

## Summary

Flutter's minimum supported Android version is now Lollipop (API 21).
Beginning with Flutter's 3.22 stable release,
Flutter will no longer work on devices running Android KitKat (API 19).

## Context

The context, purpose, and description of this deprecation can be found in
the [go/rfc-android-k-deprecation][] design document.

## Migration guide

Flutter developers targeting Android will need to increase the
`minSdkVersion` in their `build.gradle` and `AndroidManifest.xml` files
from `19` to at least `21`.

## Timeline

In stable release: 3.22

[go/rfc-android-k-deprecation]: {{site.main-url}}/go/rfc-android-k-deprecation
