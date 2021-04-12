---
title: Improving rendering performance
description: How to measure and evaluate your app's rendering performance.
---

{% include performance.md %}

Rendering animations in your app is one of the most cited
topics of interest when it comes to measuring performance.
Thanks in part to Flutter's Skia engine and its ability
to quickly create and dispose of widgets,
Flutter applications are performant by default,
so you only need to avoid common pitfalls to achieve
excellent performance.

## General advice

If you _are_ seeing janky (non smooth) animations, make
**sure** that you are profiling performance with an
app built in _profile_ mode.
The default Flutter build creates an app in _debug_ mode,
which is not indicative of release performance.
For information,
see [Flutter's build modes][].

A couple common pitfalls:

* Rebuilding far more of the UI than expected each frame.
  To track widget rebuilds, see [Show performance data][].
* Building a large list of children directly, rather than
  using a ListView.

For more information on evaluating performance
including information on common pitfalls,
see the following docs:

* [Performance best practices][]
* [Flutter performance profiling][]

## Mobile-only advice

Do you see noticeable jank on your mobile app, but only on
the first run of an animation? If so, see
[Reduce shader animation jank on mobile][].

[Reduce shader animation jank on mobile]: /docs/perf/rendering/shader

## Web-only advice

The following series of articles cover what the Flutter Material
team learned when improving performance of the Flutter Gallery
app on the web:

* [Optimizing performance in Flutter web apps with tree shaking and deferred loading][shaking]
* [Improving perceived performance with image placeholders, precaching, and disabled navigation transitions][images]
* [Building performant Flutter widgets][]


[Building performant Flutter widgets]: {{site.medium}}/flutter/building-performant-flutter-widgets-3b2558aa08fa
[Flutter's build modes]: /docs/testing/build-modes
[Flutter performance profiling]: /docs/perf/rendering/ui-performance
[images]: {{site.medium}}/flutter/improving-perceived-performance-with-image-placeholders-precaching-and-disabled-navigation-6b3601087a2b
[Performance best practices]: /docs/perf/rendering/best-practices
[shaking]: {{site.medium}}/flutter/optimizing-performance-in-flutter-web-apps-with-tree-shaking-and-deferred-loading-535fbe3cd674
[Show performance data]: /docs/development/tools/android-studio#show-performance-data
