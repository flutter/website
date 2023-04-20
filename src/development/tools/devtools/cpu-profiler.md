---
title: Using the CPU profiler view
description: Learn how to use the DevTools CPU profiler view.
---

{{site.alert.note}}
  The CPU profiler view works with Dart CLI and mobile apps only.
  Use Chrome DevTools to [analyze performance][]
  of a web app.  
{{site.alert.end}}

The CPU profiler view allows you to record and profile a
session from your Dart or Flutter application.
The profiler can help you solve performance problems
or generally understand your app’s CPU activity.
The Dart VM collects CPU samples
(a snapshot of the CPU call stack at a single point in time)
and sends the data to DevTools for visualization.
By aggregating many CPU samples together,
the profiler can help you understand where the CPU
spends most of its time.

{{site.alert.note}}
  **If you are running a Flutter application,
  use a profile build to analyze performance.**
  CPU profiles are not indicative of release performance
  unless your Flutter application is run in profile mode.
{{site.alert.end}}

{% include_relative _profiler.md %}

[analyze performance]: {{site.developers}}/web/tools/chrome-devtools/evaluate-performance/
  
## Other resources
  
To learn how to use DevTools to analyze
the CPU usage of a compute-intensive Mandelbrot app,
check out a guided [CPU Profiler View tutorial][profiler-tutorial].
Also, learn how to analyze CPU usage when the app
uses isolates for parallel computing.

[profiler-tutorial]: {{site.medium}}/@fluttergems/mastering-dart-flutter-devtools-cpu-profiler-view-part-6-of-8-31e24eae6bf8
