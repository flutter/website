---
title: Using the Performance view
description: Learn how to use the DevTools performance view.
---

{{site.alert.note}}
  The performance view works with Dart CLI and mobile apps only.
  Use Chrome DevTools to [generate timeline events][]
  for a web app.
{{site.alert.end}}

## What is it?

The performance view offers timing and performance information for activity in
your application. It consists of three parts, each increasing in granularity.

* Flutter frames chart (Flutter apps only)
* Timeline events chart
* CPU profiler

{{site.alert.note}}
  **Use a profile build of your application to analyze performance.**
  Frame rendering times are not indicative of release performance
  unless your application is run in profile mode.
{{site.alert.end}}

The performance view also supports importing and exporting of
data snapshots. For more information, see the [Import and export][] section.

## Flutter frames chart

This chart contains Flutter frame information for your application. Each bar set
in the chart represents a single Flutter frame. The bars are color-coded to
highlight the different portions of work that occur when rendering a Flutter
frame: work from the UI thread and work from the raster thread (previously known
as the GPU thread).

![Screenshot from a performance snapshot]({% asset tools/devtools/performance-flutter-frames-chart.png @path %}){:width="100%"}

Selecting a bar from this chart centers the flame chart below on the timeline
events corresponding to the selected Flutter frame. The events are highlighted
with blue brackets.

![Screenshot from a timeline recording]({% asset tools/devtools/performance-timeline-events-chart-selected-frame.png @path %}){:width="100%"}

### UI

The UI thread executes Dart code in the Dart VM. This includes
code from your application as well as the Flutter framework.
When your app creates and displays a scene, the UI thread creates
a layer tree, a lightweight object containing device-agnostic
painting commands, and sends the layer tree to the raster thread
to be rendered on the device. Do **not** block this thread.

### Raster

The raster thread (previously known as the GPU thread) executes 
graphics code from the Flutter Engine.
This thread takes the layer tree and displays it by talking to
the GPU (graphic processing unit). You cannot directly access
the raster thread or its data, but if this thread is slow, it's a
result of something you've done in the Dart code. Skia, the
graphics library, runs on this thread.

Sometimes a scene results in a layer tree that is easy to construct,
but expensive to render on the raster thread. In this case, you
need to figure out what your code is doing that is causing
rendering code to be slow. Specific kinds of workloads are more
difficult for the GPU. They might involve unnecessary calls to
`saveLayer()`, intersecting opacities with multiple objects,
and clips or shadows in specific situations.

For more information on profiling, see
[Identifying problems in the GPU graph][GPU graph].

### Jank

The frame rendering chart shows jank with a red overlay.
A frame is considered to be janky if it takes more than
~16 ms to complete (for 60 FPS devices). To achieve a frame rendering rate of
60 FPS (frames per second), each frame must render in
~16 ms or less. When this target is missed, you may
experience UI jank or dropped frames.

For more information on how to analyze your app's performance,
see [Flutter performance profiling][].

## Timeline events chart

The timeline events chart shows all event tracing from your application.
The Flutter framework emits timeline events as it works to build frames, draw
scenes, and track other activity such as HTTP traffic. These events show up here
in the Timeline. You can also send your own Timeline events via the
dart:developer
[Timeline](https://api.flutter.dev/flutter/dart-developer/Timeline-class.html)
and [TimelineTask](https://api.flutter.dev/flutter/dart-developer/TimelineTask-class.html)
APIs.

![Screenshot of timeline events for a frame]({% asset tools/devtools/performance-timeline-events-chart.png @path %}){:width="100%"}

The flame chart supports zooming and panning:
* To zoom, scroll up and down with the mouse wheel / trackpad
* To pan horizontally, either click and drag the chart or scroll horizontally
with the mouse wheel / trackpad
* To pan vertically, either click and drag the chart or use **alt + scroll**
* The WASD keys also work for controlling zoom and horizontal scroll position

You can click an event to view CPU profiling information in the CPU profiler
below, described in the next section.

{% include_relative _profiler.md %}

## Import and export

DevTools supports importing and exporting performance snapshots.
Clicking the export button (upper-right corner above the
frame rendering chart) downloads a snapshot of the current data on the
performance page. To import a performance snapshot, you can drag and drop the
snapshot into DevTools from any page. **Note that DevTools only
supports importing files that were originally exported from DevTools.**


[generate timeline events]: https://developers.google.com/web/tools/chrome-devtools/evaluate-performance/performance-reference
[GPU graph]: /docs/perf/rendering/ui-performance#identifying-problems-in-the-gpu-graph
[Flutter performance profiling]: /docs/perf/rendering/ui-performance
[Import and export]: #import-and-export
