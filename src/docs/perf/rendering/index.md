---
title: Improving rendering performance
description: How to measure and evaluate your app's rendering performance.
---

Rendering animations in your app is one of the most cited
topics of interest when it comes to measuring performance. 
Thanks in part to Flutter's Skia engine and its ability
to quickly create and dispose of widgets, 
Flutter applications are performant by default,
so you only need to avoid common pitfalls to achieve
excellent performance.

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

[Flutter's build modes]: /docs/testing/build-modes
[Flutter performance profiling]: /docs/perf/rendering/ui-performance 
[Performance best practices]: /docs/perf/rendering/best-practices
[Show performance data]: /docs/development/tools/android-studio#show-performance-data
