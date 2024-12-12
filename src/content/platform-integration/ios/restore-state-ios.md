--- 
title: "Restore state on iOS"
description: "How to restore the state of your iOS app after it's been killed by the OS."
---

When a user runs a mobile app and then selects another
app to run, the first app is moved to the background,
or _backgrounded_. The operating system (both iOS and Android)
often kills the backgrounded app to release memory or
improve performance for the app running in the foreground.

You can use the [`RestorationManager`][] (and related)
classes to handle state restoration. 
An iOS app requires [a bit of extra setup][] in Xcode,
but the restoration classes otherwise work the same on
both iOS and Android.

For more information, check out [State restoration on Android][]
and the [VeggieSeasons][] code sample.

[a bit of extra setup]: {{site.api}}/flutter/services/RestorationManager-class.html#state-restoration-on-ios
[`RestorationManager`]: {{site.api}}/flutter/services/RestorationManager-class.html
[State restoration on Android]: /platform-integration/android/restore-state-android
[VeggieSeasons]: {{site.repo.samples}}/tree/main/veggieseasons

