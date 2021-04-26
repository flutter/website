---
title: Flutter performance profiling
subtitle: Where to look when your Flutter app drops frames in the UI.
description: Diagnosing UI performance issues in Flutter.
---

{% include performance.md %}

{{site.alert.secondary}}
  <h4 class="no_toc">What you’ll learn</h4>

  * Flutter aims to provide 60 frames per second (fps) performance,
    or 120 fps performance on devices capable of 120Hz updates.
  * For 60fps, frames need to render approximately every 16ms.
  * Jank occurs when the UI doesn't render smoothly. For example,
    every so often, a frame takes 10 times longer to render,
    so it gets dropped, and the animation visibly jerks.
{{site.alert.end}}

It's been said that "a _fast_ app is great,
but a _smooth_ app is even better."
If your app isn't rendering smoothly,
how do you fix it? Where do you begin?
This guide shows you where to start,
steps to take, and tools that can help.

{{site.alert.note}}
  * An app's performance is determined by more than one measure.
    Performance sometimes refers to raw speed, but also to the UI's
    smoothness and lack of stutter. Other examples of performance
    include I/O or network speed. This page primarily focuses on the
    second type of performance (UI smoothness), but you can use most
    of the same tools to diagnose other performance problems.
  * To perform tracing inside your Dart code, see [Tracing Dart code][]
    in the [Debugging][] page.
{{site.alert.end}}

[Debugging]: /docs/testing/debugging
[Tracing Dart code]: /docs/testing/debugging#tracing-dart-code

## Diagnosing performance problems

To diagnose an app with performance problems, you'll enable
the performance overlay to look at the UI and raster threads.
(The raster thread was previously known as the GPU thread.)
Before you begin, you want to make sure that you're running in
[profile mode][], and that you're not using an emulator.
For best results, you might choose the slowest device that
your users might use.

[profile mode]: /docs/testing/build-modes#profile

### Connect to a physical device

Almost all performance debugging for Flutter applications
should be conducted on a physical Android or iOS device,
with your Flutter application running in [profile mode][].
Using debug mode, or running apps on simulators
or emulators, is generally not indicative of the final
behavior of release mode builds.
_You should consider checking performance
on the slowest device that your users might reasonably use._

{{site.alert.secondary}}
  <h4 class="no_toc" markdown="1">**Why you should run on a real device:**</h4>

* Simulators and emulators don’t use the same hardware, so their
  performance characteristics are different&mdash;some operations are
  faster on simulators than real devices, and some are slower.
* Debug mode enables additional checks (such as asserts) that don’t run
  in profile or release builds, and these checks can be expensive.
* Debug mode also executes code in a different way than release mode.
  The debug build compiles the Dart code "just in time" (JIT) as the
  app runs, but profile and release builds are pre-compiled to native
  instructions (also called “ahead of time”, or AOT) before the app is
  loaded onto the device. JIT can cause the app to pause for JIT
  compilation, which itself can cause jank.
{{site.alert.end}}

### Run in profile mode

Flutter’s profile mode compiles and launches your application
almost identically to release mode, but with just enough additional
functionality to allow debugging performance problems.
For example, profile mode provides tracing information to the
profiling tools.

Launch the app in profile mode as follows:

- In Android Studio and IntelliJ, use the
  **Run > Flutter Run main.dart in Profile Mode** menu item.
- In VS Code, open your `launch.json` file, and set the
  `flutterMode` property to `profile`
  (when done profiling, change it back to `release` or `debug`):

  ```json
  "configurations": [
    {
      "name": "Flutter",
      "request": "launch",
      "type": "dart",
      "flutterMode": "profile"
    }
  ]
  ```
- From the command line, use the `--profile` flag:

  ```terminal
  $ flutter run --profile
  ```

For more information on the different modes,
see [Flutter's build modes][].

You'll begin by opening DevTools and viewing
the performance overlay, as discussed in the next section.

[Flutter's build modes]: /docs/testing/build-modes

## Launch DevTools

DevTools provides features like profiling, examining the heap,
displaying code coverage, enabling the performance overlay,
and a step-by-step debugger.
DevTools' [Timeline view][] allows you to investigate the
UI performance of your application on a frame-by-frame basis.

Once your app is running in profile mode,
[launch DevTools][].

[launch DevTools]: /docs/development/tools/devtools
[Timeline view]: /docs/development/tools/devtools/timeline

## The performance overlay

The performance overlay displays statistics in two graphs
that show where time is being spent in your app. If the UI
is janky (skipping frames), these graphs help you figure out why.
The graphs display on top of your running app, but they aren’t
drawn like a normal widget&mdash;the Flutter engine itself
paints the overlay and only minimally impacts performance.
Each graph represents the last 300 frames for that thread.

This section describes how to enable the performance overlay
and use it to diagnose the cause of jank in your application.
The following screenshot shows the performance overlay running
on the Flutter Gallery example:

![Screenshot of overlay showing zero jank]({% asset tools/devtools/performance-overlay-green.png @path %})
<br>Performance overlay showing the raster thread (top),
and UI thread (bottom).<br>The vertical green bars
represent the current frame.

## Interpreting the graphs

The top graph (marked "GPU") shows the time spent by 
the raster thread, the bottom one graph shows the time 
spent by the UI thread.
The white lines across the graphs show 16ms increments
along the vertical axis; if the graph ever goes over one
of these lines then you are running at less than 60Hz.
The horizontal axis represents frames. The graph is
only updated when your application paints,
so if it's idle the graph stops moving.

The overlay should always be viewed in [profile mode][],
since [debug mode][] performance is intentionally sacrificed
in exchange for expensive asserts that are intended to aid
development, and thus the results are misleading.

Each frame should be created and displayed within 1/60th of
a second (approximately 16ms). A frame exceeding this limit
(in either graph) fails to display, resulting in jank,
and a vertical red bar appears in one or both of the graphs.
If a red bar appears in the UI graph, the Dart code is too
expensive. If a red vertical bar appears in the GPU graph,
the scene is too complicated to render quickly.

![Screenshot of performance overlay showing jank with red bars]({% asset tools/devtools/performance-overlay-jank.png @path %})
<br>The vertical red bars indicate that the current frame is
expensive to both render and paint.<br>When both graphs
display red, start by diagnosing the UI thread.

[debug mode]: /docs/testing/build-modes#debug

## Flutter's threads

Flutter uses several threads to do its work, though
only two of the threads are shown in the overlay.
All of your Dart code runs on the UI thread.
Although you have no direct access to any other thread,
your actions on the UI thread have performance consequences
on other threads.

<dl markdown="1">
<dt markdown="1">**Platform thread**</dt>
<dd markdown="1">The platform's main thread. Plugin code runs here.
    For more information, see the [UIKit][] documentation for iOS,
    or the [MainThread][] documentation for Android.
    This thread is not shown in the performance overlay.

<dt markdown="1">**UI thread**</dt>
<dd markdown="1">The UI thread executes Dart code in the Dart VM.
    This thread includes code that you wrote, and code executed by
    Flutter's framework on your app's behalf.
    When your app creates and displays a scene, the UI thread creates
    a _layer tree_, a lightweight object containing device-agnostic
    painting commands, and sends the layer tree to the raster thread to
    be rendered on the device. _Don't block this thread!_
    Shown in the bottom row of the performance overlay.

<dt markdown="1">**Raster thread** (previously known as the GPU thread)</dt>
<dd markdown="1">The raster thread takes the layer tree and displays
    it by talking to the GPU (graphic processing unit).
    You cannot directly access the raster thread or its data but,
    if this thread is slow, it's a result of something you've done
    in the Dart code. Skia, the graphics library, runs on this thread.
    Shown in the top row of the performance overlay.
    This thread was previously known as the "GPU thread" because it
    rasterizes for the GPU. But it is running on the CPU. We renamed it
    to "raster thread" because many developers wrongly (but understandably)
    assumed the thread runs on the GPU unit.

<dt markdown="1">**I/O thread**</dt>
<dd markdown="1">Performs expensive tasks (mostly I/O) that would
    otherwise block either the UI or raster threads.
    This thread is not shown in the performance overlay.
</dl>
    
For links to more information and videos,
see [The Framework architecture][] on the
[GitHub wiki][], and the community article,
[The Layer Cake][].

[GitHub wiki]: {{site.github}}/flutter/flutter/wiki/
[MainThread]: {{site.android-dev}}/reference/android/support/annotation/MainThread
[The Framework architecture]: {{site.github}}/flutter/flutter/wiki/The-Framework-architecture
[The Layer Cake]: https://medium.com/flutter-community/the-layer-cake-widgets-elements-renderobjects-7644c3142401
[UIKit]: https://developer.apple.com/documentation/uikit

### Displaying the performance overlay

You can toggle display of the performance overlay as follows:

* Using the Flutter inspector
* From the command line
* Programmatically

#### Using the Flutter inspector

The easiest way to enable the PerformanceOverlay widget is
from the Flutter inspector, which is available in the
[Inspector view][] in [DevTools][]. Simply click the
**Performance Overlay** button to toggle the overlay
on your running app.

[Inspector view]: /docs/development/tools/devtools/inspector

#### From the command line

Toggle the performance overlay using the **P** key from
the command line.

#### Programmatically

To enable the overlay programmatically, see
[Performance overlay][], a section in the
[Debugging Flutter apps programmatically][] page.

[Debugging Flutter apps programmatically]: /docs/testing/code-debugging
[Performance overlay]: /docs/testing/code-debugging#performance-overlay

## Identifying problems in the UI graph

If the performance overlay shows red in the UI graph,
start by profiling the Dart VM, even if the GPU graph
also shows red.

## Identifying problems in the GPU graph

Sometimes a scene results in a layer tree that is easy to construct,
but expensive to render on the raster thread. When this happens,
the UI graph has no red, but the GPU graph shows red.
In this case, you’ll need to figure out what your code is doing
that is causing rendering code to be slow. Specific kinds of workloads
are more difficult for the GPU. They might involve unnecessary calls
to [`saveLayer`][], intersecting opacities with multiple objects,
and clips or shadows in specific situations.

If you suspect that the source of the slowness is during an animation,
click the **Slow Animations** button in the Flutter inspector
to slow animations down by 5x.
If you want more control on the speed, you can also do this
[programmatically][].

Is the slowness on the first frame, or on the whole animation?
If it's the whole animation, is clipping causing the slow down?
Maybe there's an alternative way of drawing the scene that doesn't
use clipping. For example, overlay opaque corners onto a square
instead of clipping to a rounded rectangle.
If it's a static scene that's being faded, rotated, or otherwise
manipulated, a [`RepaintBoundary`][] might help.

[programmatically]: /docs/testing/code-debugging#debugging-animations
[`RepaintBoundary`]: {{site.api}}/flutter/widgets/RepaintBoundary-class.html
[`saveLayer`]: {{site.api}}/flutter/dart-ui/Canvas/saveLayer.html

#### Checking for offscreen layers

The [`saveLayer`][] method is one of the most expensive methods in
the Flutter framework. It’s useful when applying post-processing
to the scene, but it can slow your app and should be avoided if
you don’t need it.  Even if you don’t call `saveLayer` explicitly,
implicit calls might happen on your behalf. You can check whether
your scene is using `saveLayer` with the
[`PerformanceOverlayLayer.checkerboardOffscreenLayers`][] switch.

{% comment %}
[TODO: Document disabling the graphs and checkerboardRasterCacheImages.
Flutter inspector doesn't seem to support this?]
{% endcomment %}

Once the switch is enabled, run the app and look for any images
that are outlined with a flickering box. The box flickers from
frame to frame if a new frame is being rendered.  For example,
perhaps you have a group of objects with opacities that are rendered
using `saveLayer`. In this case, it's probably more performant to
apply an opacity to each individual widget, rather than a parent
widget higher up in the widget tree. The same goes for
other potentially expensive operations, such as clipping or shadows.

{{site.alert.note}}
  Opacity, clipping, and shadows are not, in themselves,
  a bad idea. However, applying them to the top of the
  widget tree might cause extra calls to `saveLayer`,
  and needless processing.
{{site.alert.end}}

When you encounter calls to `saveLayer`,
ask yourself these questions:

* Does the app need this effect?
* Can any of these calls be eliminated?
* Can I apply the same effect to an individual element instead of a group?

[`PerformanceOverlayLayer.checkerboardOffscreenLayers`]: {{site.api}}/flutter/rendering/PerformanceOverlayLayer/checkerboardOffscreenLayers.html

#### Checking for non-cached images

Caching an image with [`RepaintBoundary`][] is good,
_when it makes sense_.

One of the most expensive operations,
from a resource perspective,
is rendering a texture using an image file.
First, the compressed image
is fetched from persistent storage.
The image is decompressed into host memory (GPU memory),
and transferred to device memory (RAM).

In other words, image I/O can be expensive.
The cache provides snapshots of complex hierarchies so
they are easier to render in subsequent frames.
_Because raster cache entries are expensive to
construct and take up loads of GPU memory,
cache images only where absolutely necessary._

You can see which images are being cached by enabling the
[`PerformanceOverlayLayer.checkerboardRasterCacheImages`][] switch.

{% comment %}
[TODO: Document how to do this, either via UI or programmatically.
At this point, disable the graphs and checkerboardOffScreenLayers.]
{% endcomment %}

Run the app and look for images rendered with a randomly colored
checkerboard, indicating that the image is cached.
As you interact with the scene, the checkerboarded images
should remain constant&mdash;you don’t want to see flickering,
which would indicate that the cached image is being re-cached.

In most cases, you want to see checkerboards on static images,
but not on non-static images.  If a static image isn't cached,
you can cache it by placing it into a [`RepaintBoundary`][]
widget. Though the engine might still ignore a repaint
boundary if it thinks the image isn't complex enough.

[`PerformanceOverlayLayer.checkerboardRasterCacheImages`]: {{site.api}}/flutter/rendering/PerformanceOverlayLayer/checkerboardRasterCacheImages.html

### Viewing the widget rebuild profiler

The Flutter framework is designed to make it hard to create
applications that are not 60fps and smooth. Often, if you have jank,
it's because there is a simple bug causing more of the UI to be
rebuilt each frame than required. The Widget rebuild profiler
helps you debug and fix performance problems due to these sorts
of bugs.

You can view the widget rebuilt counts for the current screen and
frame in the Flutter plugin for Android Studio and IntelliJ.
For details on how to do this, see [Show performance data][]

[Show performance data]: /docs/development/tools/android-studio#show-performance-data

## Benchmarking

You can measure and track your app’s performance by writing
benchmark tests. The Flutter Driver library provides support
for benchmarking. Using this integration test framework,
you can generate metrics to track the following:

* Jank
* Download size
* Battery efficiency
* Startup time

Tracking these benchmarks allows you to be informed when a
regression is introduced that adversely affects performance.

For more information, see [Integration testing][],
a section in [Testing Flutter apps][].

[Integration testing]: /docs/testing#integration-tests
[Testing Flutter apps]: /docs/testing

## Other resources

The following resources provide more information on using
Flutter's tools and debugging in Flutter:

* [Debugging][]
* [Flutter inspector][]
* [Flutter inspector talk][], presented at DartConf 2018
* [Why Flutter Uses Dart][], an article on Hackernoon
* [Why Flutter uses Dart][video], a video on the Flutter channel
* [DevTools][devtools]: performance tooling for Dart and Flutter apps
* [Flutter API][] docs, particularly the [`PerformanceOverlay`][] class,
  and the [dart:developer][] package

[dart:developer]: {{site.api}}/flutter/dart-developer/dart-developer-library.html
[devtools]: /docs/development/tools/devtools
[Flutter API]: {{site.api}}
[Flutter inspector]: /docs/development/tools/devtools/inspector
[Flutter inspector talk]: https://www.youtube.com/watch?v=JIcmJNT9DNI
[`PerformanceOverlay`]: {{site.api}}/flutter/widgets/PerformanceOverlay-class.html
[video]: https://youtu.be/5F-6n_2XWR8
[Why Flutter Uses Dart]: https://hackernoon.com/why-flutter-uses-dart-dd635a054ebf
