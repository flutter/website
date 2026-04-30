---
title: Debug performance for web apps
description: Learn how to use Chrome DevTools to debug web performance issues.
---

:::note
Profiling Flutter web apps requires Flutter version 3.14 or later.
:::

The Flutter framework emits timeline events as it works to build frames,
draw scenes, and track other activity such as garbage collections.
These events are exposed in the
[Chrome DevTools performance panel][] for debugging.

:::note
For information on how to optimize web loading speed,
check out the (free) article on Medium,
[Best practices for optimizing Flutter web loading speed][article].

[article]: {{site.flutter-blog}}/best-practices-for-optimizing-flutter-web-loading-speed-7cc0df14ce5c
:::

You can also emit your own timeline events using the `dart:developer`
[Timeline][] and [TimelineTask][] APIs for further performance analysis.

[Chrome DevTools performance panel]: https://developer.chrome.com/docs/devtools/performance
[Timeline]: {{site.api}}/flutter/dart-developer/Timeline-class.html
[TimelineTask]: {{site.api}}/flutter/dart-developer/TimelineTask-class.html

![Screenshot of the Chrome DevTools performance panel](/assets/images/docs/tools/devtools/chrome-devtools-performance-panel.png)

## Optional flags to enhance tracing

To configure which timeline events are tracked, set any of the following top-level properties to `true`
in your app's `main` method.

- [debugProfileBuildsEnabled][]: Adds `Timeline` events for every `Widget` built.
- [debugProfileBuildsEnabledUserWidgets][]: Adds `Timeline` events for every user-created `Widget` built.
- [debugProfileLayoutsEnabled][]: Adds `Timeline` events for every `RenderObject` layout.
- [debugProfilePaintsEnabled][]: Adds `Timeline` events for every `RenderObject` painted.

[debugProfileBuildsEnabled]: {{site.api}}/flutter/widgets/debugProfileBuildsEnabled.html
[debugProfileBuildsEnabledUserWidgets]: {{site.api}}/flutter/widgets/debugProfileBuildsEnabledUserWidgets.html
[debugProfileLayoutsEnabled]: {{site.api}}/flutter/rendering/debugProfileLayoutsEnabled.html
[debugProfilePaintsEnabled]: {{site.api}}/flutter/rendering/debugProfilePaintsEnabled.html

## Instructions

1. _[Optional]_ Set any desired tracing flags to true from your app's main method.
2. Run your Flutter web app in [profile mode][].
3. Open up the [Chrome DevTools Performance panel][] for your application,
    and [start recording][] to capture timeline events.

[start recording]: https://developer.chrome.com/docs/devtools/performance/#record

[profile mode]: /testing/build-modes#profile
[Chrome DevTools performance panel]: https://developer.chrome.com/docs/devtools/performance
