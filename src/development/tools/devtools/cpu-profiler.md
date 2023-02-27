---
title: Using the CPU profiler view
description: Learn how to use the DevTools CPU profiler view.
---

{{site.alert.note}}
  The CPU profiler view works with Dart CLI and mobile apps only.
  Use Chrome DevTools to [analyze performance][]
  of a web app.
{{site.alert.end}}

## What is it?

The CPU profiler view allows you to record and profile a
session from your Dart or Flutter application.

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
