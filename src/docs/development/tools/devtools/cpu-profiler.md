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

[analyze performance]: https://developers.google.com/web/tools/chrome-devtools/evaluate-performance/
