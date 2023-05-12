---
title: DevTools
description: How to use the DevTools with Flutter.
---

## What is DevTools?

DevTools is a suite of performance and debugging tools
for Dart and Flutter.

![Dart DevTools Screens]({{site.url}}/assets/images/docs/tools/devtools/dart-devtools.gif){:width="100%"}

## What can I do with DevTools?

Here are some of the things you can do with DevTools:

* Inspect the UI layout and state of a Flutter app.
* Diagnose UI jank performance issues in a Flutter app.
* CPU profiling for a Flutter or Dart app.
* Network profiling for a Flutter app.
* Source-level debugging of a Flutter or Dart app.
* Debug memory issues in a Flutter or Dart
  command-line app.
* View general log and diagnostics information
  about a running Flutter or Dart
  command-line app.
* Analyze code and app size.

We expect you to use DevTools in conjunction with
your existing IDE or command-line based development workflow.

<a name="install-devtools"></a>
## How do I install DevTools?

See the [VS Code][], [Android Studio/IntelliJ][], or
[command line][] pages for installation instructions.

## Troubleshooting some standard issues

**Question**: My app looks janky or stutters.
  How do I fix it?

**Answer**: Performance issues can cause [UI frames][]
  to be janky and/or slow down some operations.

  1. To detect which code impacts concrete late frames,
     start at [Performance > Timeline][].
  2. To learn which code takes the most CPU time in
     the background, use the [CPU profiler][].

For more information, check out the
[Performance][] page.

**Question**: I see a lot of garbage collection (GC) events occurring.
  Is this a problem?

**Answer**: Frequent GC events might display on
  the DevTools > Memory > Memory chart. In most cases,
  it's not a problem.

If your app has frequent background activity with some idle time,
Flutter might use that opportunity to collect the created objects
without performance impact.

[CPU profiler]: {{site.url}}/tools/devtools/cpu-profiler
[Performance]: {{site.url}}/perf
[Performance > Timeline]: {{site.url}}/tools/devtools/performance#timeline-events-chart 
[UI frames]: {{site.url}}/perf/ui-performance



## Providing feedback

Please give DevTools a try, provide feedback, and file issues
in the [DevTools issue tracker][]. Thanks!

## Other resources

For more information on debugging and profiling
Flutter apps, see the [Debugging][] page and,
in particular, its list of [other resources][].

For more information on using DevTools with Dart command-line apps, see the 
[DevTools documentation on dart.dev]({{site.dart-site}}/tools/dart-devtools).

[Android Studio/IntelliJ]: {{site.url}}/tools/devtools/android-studio
[VS Code]: {{site.url}}/tools/devtools/vscode
[command line]: {{site.url}}/tools/devtools/cli
[DevTools issue tracker]: {{site.github}}/flutter/devtools/issues
[Debugging]: {{site.url}}/testing/debugging
[Other resources]: {{site.url}}/testing/debugging#other-resources
