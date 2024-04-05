---
title: Dropping support for Android KitKat
description: >
  Raising the minimum supported Android version from KitKat (API 19) to Lollipop (API 21).
---

## Summary

We have raised Flutter's minimum supported Android version to Lollipop (API 21).
Beginning with Flutter's 3.22 stable release, Flutter will no longer work on devices
running Andoird KitKat (API 19).

## Context

The context, purpose, and description of this deprecation are detailed in the
document [go/rfc-android-k-deprecation][].

## Migration guide

Flutter develoers targeting Android will need to increase the `minSdkVersion`
in their `AndroidManifest.xml` files from `19` to `21`.

## Timeline

In stable release: 3.22

[go/rfc-android-k-deprecation]: {{site.api}}/go/rfc-android-k-deprecation
