---
title: Large screen orientation and resizability restrictions ignored on Android 17
description: >-
  For apps targeting Android 17 or higher, orientation, resizability, and
  aspect ratio restrictions no longer apply on large displays (widths 600dp or
  larger).
---

{% render "docs/breaking-changes.md" %}

## Summary

For apps targeting Android 17 or higher,
orientation, resizability, and aspect ratio restrictions no longer apply
on displays with width 600dp or greater.
This means that [`SystemChrome.setPreferredOrientations`][] is ignored
on these devices.

## Background

Android is shifting toward a model where apps are expected to adapt
to various orientations, display sizes, and aspect ratios.
Restrictions like fixed orientation or limited resizability hinder app
adaptability.
See [Android 17 behavior changes][] for more details.

In Android 16, this behavior was introduced as a default
but allowed apps to temporarily opt out
using the `PROPERTY_COMPAT_ALLOW_RESTRICTED_RESIZABILITY` manifest property.
Android 17 removes this opt-out.

## Description of change

If you rely on [`SystemChrome.setPreferredOrientations`][]
to lock your app to a specific orientation,
it is ignored on large screens (widths 600dp and larger)
if your app targets Android 17 or higher.
If your app supports Android 16
and you did not opt out of this behavior,
then it behaves the same on Android 17.

If your app relies on locking orientation,
make your app adaptive to support different screen sizes and orientations.
See the guidance for how to do this for large screens
in [Adaptive and responsive UI][].

## References

* [Android 17 behavior changes][]
* [Android 16 behavior changes][]
* [`SystemChrome.setPreferredOrientations`][]
* [Adaptive and responsive UI][]

[Android 17 behavior changes]: https://developer.android.com/about/versions/17/changes/ff-restrictions-ignored
[Android 16 behavior changes]: https://developer.android.com/about/versions/16/behavior-changes-16#ignore-orientation
[`SystemChrome.setPreferredOrientations`]: {{site.api}}/flutter/services/SystemChrome/setPreferredOrientations.html
[Adaptive and responsive UI]: /ui/adaptive-responsive/large-screens
