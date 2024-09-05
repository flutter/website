---
title: Flutter and Dart DevTools
description: How to use Flutter DevTools with Flutter.
---

## What is DevTools?

DevTools is a suite of performance and debugging tools
for Dart and Flutter.
_Flutter DevTools_ and _Dart DevTools_ refer to the
same set of tools.

![Dart DevTools Screens](/assets/images/docs/tools/devtools/dart-devtools.gif){:width="100%"}

For a video introduction to DevTools, check out
the following deep dive and use-case walkthrough:

{% ytEmbed '_EYk-E29edo', 'Dive in to Flutter and Dart DevTools' %}

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
* Validate deep links in your Android app.

We expect you to use DevTools in conjunction with
your existing IDE or command-line based development workflow.

<a id="how-do-i-install-devtools"></a>
<a id="install-devtools"></a>

## How to launch DevTools {:#start}

See the [VS Code][], [Android Studio/IntelliJ][], or
[command line][] pages for instructions on how to launch DevTools.

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

[CPU profiler]: /tools/devtools/cpu-profiler
[Performance]: /perf
[Performance > Timeline]: /tools/devtools/performance#timeline-events-tab
[UI frames]: /perf/ui-performance

## Providing feedback

Please give DevTools a try, provide feedback, and file issues
in the [DevTools issue tracker][]. Thanks!

## Other resources

For more information on debugging and profiling
Flutter apps, see the [Debugging][] page and,
in particular, its list of [other resources][].

For more information on using DevTools with
Dart command-line apps, see the
[DevTools documentation on dart.dev]({{site.dart-site}}/tools/dart-devtools).

[Android Studio/IntelliJ]: /tools/devtools/android-studio
[VS Code]: /tools/devtools/vscode
[command line]: /tools/devtools/cli
[DevTools issue tracker]: {{site.github}}/flutter/devtools/issues
[Debugging]: /testing/debugging
[Other resources]: /testing/debugging#other-resources
