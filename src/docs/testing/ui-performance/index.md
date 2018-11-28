---
title: Flutter Performance Profiling
subtitle: Where to look when your Flutter app drops frames in the UI.
description: Diagnosing UI performance issues in Flutter.
---

{{site.alert.secondary}}
  <h4 class="no_toc">What you’ll learn</h4>

  * Flutter aims to provide 60 frames per second (fps) performance, or 120
    fps performance on devices capable of 120Hz updates.
  * For 60fps, frames need to render approximately every 16ms.
  * Jank occurs when the UI doesn't render smoothly. For example, every so
    often, a frame takes 10 times longer to render, so it gets dropped, and
    the animation visibly jerks.
{{site.alert.end}}

It's been said that "a _fast_ app is great, but a _smooth_ app is even better."
If your app isn't rendering smoothly, how do you fix it? Where do you begin?
This guide shows you where to start, steps to take, and tools that can
help.

{{site.alert.note}}
  - An app's performance is determined by more than one measure. Performance
    sometimes refers to raw speed, but also to the UI's smoothness and lack of
    stutter. Other examples of performance include I/O or network speed. This
    page primarily focuses on the second type of performance (UI smoothness),
    but you can use most of the same tools to diagnose other performance
    problems.
  - To perform tracing inside your Dart code, see [Tracing any Dart code
    performance](/docs/testing/debugging#tracing-any-dart-code-performance) in the
    [Debugging](/docs/testing/debugging) page.
{{site.alert.end}}

## Diagnosing performance problems

To diagnose an app with performance problems, you'll enable
the performance overlay to look at the UI and GPU threads. Before
you begin, you want to make sure that you're running in profile mode,
and that you're not using an emulator. For best results, you might
choose the slowest device that your users might use.

{% comment %}
<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What's the point?</b>

* Profile your app on a physical device.
* Profile your app in [profile mode](https://github.com/flutter/flutter/wiki/Flutter%27s-modes).
* Check performance on the slowest device your users might use.
* Start by enabling the performance overlay.

</div>
{% endcomment %}

### Connect to a physical device

Almost all performance debugging for Flutter applications should be
conducted on a physical Android or iOS device, with your Flutter application
running in profile mode. Using debug mode, or running apps on simulators
or emulators, is generally not indicative of the final
behavior of release mode builds. _You should consider checking performance
on the slowest device that your users might reasonably use._

<aside class="alert alert-info" markdown="1">
**Why you should run on a real device:**

* Simulators and emulators don’t use the same hardware, so their
  performance characteristics are different&mdash;some operations are
  faster on simulators than real devices, and some are slower.
* Debug mode enables additional checks (such as asserts) that don’t run
  in profile or release builds, and these checks can be expensive.
* Debug mode also executes code in a different way than release mode.
  The debug build compiles the Dart code "just in time" (JIT)
  as the app runs, but profile and release builds are pre-compiled to native
  instructions (also called “ahead of time”, or AOT) before the app is
  loaded onto the device. JIT can cause the app to pause for JIT
  compilation, which itself can cause jank.
</aside>

### Run in profile mode

Flutter’s profile mode compiles and launches your application almost
identically to release mode, but with just enough additional
functionality to allow debugging performance problems.
For example, profile mode provides tracing information to
[Observatory](https://dart-lang.github.io/observatory/) and other tools.

Launch the app in profile mode as follows:

{% comment %}
Not yet available in VS Code.
{% endcomment %}

<ul markdown="1">
<li markdown="1">In Android Studio and IntelliJ, use the
    **Run > Flutter Run main.dart in Profile Mode** menu item.
</li>
<li markdown="1">In VS Code, open your `launch.json` file, and set the
`flutterMode` property to `profile`
(when done profiling, change it back to `release` or `debug`):

```
"configurations": [
	{
		"name": "Flutter",
		"request": "launch",
		"type": "dart",
		"flutterMode": "profile"
	}
]
```
</li>
<li markdown="1">From the command line, use the `--profile`
    flag:

{% prettify sh %}
$ flutter run --profile
{% endprettify %}
</li>
</ul>

For more information on how the different modes work, see [Flutter's
modes](https://github.com/flutter/flutter/wiki/Flutter%27s-modes).

You'll begin by enabling the performance overlay, as discussed
in the next section.

## The performance overlay

The performance overlay displays statistics in two graphs
that show where time is being spent in your app.
If the UI is janky (skipping frames), these graphs help you figure out why.
The graphs display on top of your running app, but they aren’t drawn
like a normal widget&mdash;the Flutter engine itself paints the overlay
and only minimally impacts performance.
Each graph represents the last 300 frames for that thread.

This section describes how to enable the
[PerformanceOverlay,](https://docs.flutter.io/flutter/widgets/PerformanceOverlay-class.html)
and use it to diagnose the cause of jank in your application.
The following screenshot shows the performance overlay running on the Flutter
Gallery example:

<center><img src="/docs/testing/ui-performance/images/performance-overlay-green.png" alt="screenshot of performance overlay showing zero jank"></center>
<center>Performance overlay showing the GPU thread (top), and UI thread (bottom).
	The vertical green bars represent the current frame.</center><br>

Flutter uses several threads to do its work. All your Dart code runs on
the UI thread. Although you have no direct access to any other thread,
your actions on the UI thread have performance consequences on other threads.

1. Platform thread<br>
   The platform's main thread. Plugin code runs here.
   For more information, see the
   [UIKit](https://developer.apple.com/documentation/uikit)
   documentation for iOS, or the
   [MainThread](https://developer.android.com/reference/android/support/annotation/MainThread)
   documentation for Android.
   This thread is not shown in the performance overlay.

1. UI thread<br>
   The UI thread executes Dart code in the Dart VM.
   This thread includes code that you wrote, and code executed by
   Flutter's framework on your app's behalf.
   When your app creates and displays a scene, the UI thread creates
   a _layer tree_, a lightweight object containing device-agnostic
   painting commands, and sends the layer tree to the GPU thread to
   be rendered on the device. _Don't block this thread!_
   Shown in the bottom row of the performance overlay.

1. GPU thread<br>
   The GPU thread takes the layer tree and displays it by talking
   to the GPU (graphic processing unit). You cannot directly access
   the GPU thread or its data but, if this thread is slow,
   it's a result of something you've done in the Dart code.
   Skia, the graphics library, runs on this thread, which is sometimes
   called the _rasterizer_ thread.
   Shown in the top row of the performance overlay.

1. I/O thread<br>
   Performs expensive tasks (mostly I/O) that would otherwise block
   either the UI or GPU threads.
   This thread is not shown in the performance overlay.


For more information on these threads, see
[Architecture notes.](https://github.com/flutter/engine/wiki#architecture-notes)

Each frame should be created and displayed within 1/60th of a second
(approximately 16ms). A frame exceeding this limit (in either graph)
fails to display, resulting in jank, and a vertical red bar appears in one or
both of the graphs.
If a red bar appears in the UI graph, the Dart code is too expensive.
If a red vertical bar appears in the GPU graph, the scene is too
complicated to render quickly.

<center><img src="/docs/testing/ui-performance/images/performance-overlay-jank.png" alt="Screenshot of performance overlay showing jank with red bars."></center>
<center>The vertical red bars indicate that the current frame is expensive to both render and paint.<br>When both graphs have red, start by diagnosing the UI thread (Dart VM).</center><br>

### Displaying the performance overlay

You can toggle display of the performance overlay as follows:

* Using the Flutter Inspector
* From the command line
* Programmatically

#### From the Flutter Inspector

The easiest way to enable the PerformanceOverlay widget is by enabling it
in the Flutter Inspector, which is available through the Flutter plugin
for your IDE. The Inspector view opens by default when running an
application. If the inspector isn't open, you can display it as follows.

In Android Studio and IntelliJ IDEA:

 1. Select **View > Tool Windows > Flutter Inspector**.
 1. In the toolbar, select the icon that looks like a bookshelf
    (![bookshelf-like icon][]).

    ![IntelliJ Flutter Inspector Window][]

The Flutter Inspector is available in Android Studio and IntelliJ.
Learn more about what the Inspector can do in the
[Flutter Widget Inspector](/docs/development/tools/inspector) doc, as well as the
[Flutter Inspector talk](https://www.youtube.com/watch?v=JIcmJNT9DNI)
presented at DartConf 2018.

[bookshelf-like icon]: /docs/testing/ui-performance/images/performance-overlay-icon.png

#### In VS Code

1. Select **View > Command Palette…** to bring up the command palette.
1. In the text field, enter "performance" and select
   **Toggle Performance Overlay** from the list that pops up.
   If this command isn’t available, make sure that that the app is running.

#### From the Command line

Toggle the performance overlay using the **P** key from the command line.

#### Programmatically

You can programmatically enable the PerformanceOverlay widget by
setting the `showPerformanceOverlay` property to `true` on the MaterialApp
or WidgetsApp constructor:

<!-- skip -->
{% prettify dart %}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      [[highlight]]showPerformanceOverlay: true,[[/highlight]]
      title: 'My Awesome App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'My Awesome App'),
    );
  }
}
{% endprettify %}

You are probably familiar with the Flutter Gallery example app.
To use the performance overlay with Flutter Gallery,
use the copy in the [examples](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery)
directory that was installed with Flutter,
and run the app in profile mode. The program is written
so that the app menu allows you to dynamically toggle the overlay,
as well as enable checks for calls to `saveLayer` and the presence of
cached images.

<aside class="alert alert-info" markdown="1">
**Note:** You can’t enable the performance overlay in the Flutter
Gallery app downloaded from the App Store. That version of the app
is compiled to release mode (not profile mode), and doesn’t provide
a menu for enabling or disabling the overlay.
</aside>

### Identifying problems in the UI graph

If the performance overlay shows red in the UI graph, start by profiling
the Dart VM, even if the GPU graph also shows red. To do this, use
[Observatory](https://dart-lang.github.io/observatory/), Dart’s profiling tool.

#### Displaying Observatory

Observatory provides features like profiling, examining the heap,
and displaying code coverage. Observatory's _timeline_ view allows you
to capture a snapshot of the stack at a moment in time.
When you open Observatorty's timeline from the Flutter Inspector,
you'll be using a version that has been customized for Flutter apps.

Go to Flutter's timeline view in a browser as follows:

 1. To open the timeline view, use the line chart icon ![line-chart icon][].

    (Instead, you could open Observatory using the stopwatch icon (![stopwatch
    icon][]), but the "view <u>inspector</u>" link takes you to the standard
    version of the timeline, not the version customized for Flutter.)

    ![IntelliJ Flutter Inspector Window][]

    [line-chart icon]: /docs/testing/ui-performance/images/observatory-timeline-icon.png
    [stopwatch icon]: /docs/testing/ui-performance/images/observatory-icon.png

 1. In VS Code, bring up the command palette and enter "observatory".
    Select **Flutter: Open Observatory Timeline** from the list that pops up.
    If this command isn’t available, make sure that the app is running.


#### Using Observatory's timeline

<aside class="alert alert-info" markdown="1">
**Note:** The Observatory UI and Flutter's custom timeline page are currently
evolving. For this reason, we aren't fully documenting the UI at this time.
If you are comfortable experimenting with Observatory, and would like to give
us feedback, please file [issues or feature
requests](https://github.com/dart-lang/sdk/issues?q=is%3Aopen+is%3Aissue+label%3Aarea-observatory)
as you find them.
</aside>

### Identifying problems in the GPU graph

Sometimes a scene results in a layer tree that is easy to construct,
but expensive to render on the GPU thread. When this happens,
the UI graph has no red, but the GPU graph shows red.
In this case, you’ll need to figure out what your code is doing that is causing
rendering code to be slow. Specific kinds of workloads are more difficult for
the GPU.  They may involve unnecessary calls to
[`saveLayer`](https://docs.flutter.io/flutter/dart-ui/Canvas/saveLayer.html),
intersecting opacities with multiple objects, and clips or shadows in specific
situations.

If you suspect that the source of the slowness is during an animation, use the
[timeDilation](https://docs.flutter.io/flutter/scheduler/timeDilation.html)
property to greatly slow the animation down.

You can also slow the animation speed using the Flutter Inspector.
In the inspector's gear menu, select **Enable Slow Animations**.
If you want more control of the animation speed, set the
[timeDilation](https://docs.flutter.io/flutter/scheduler/timeDilation.html)
property in your code.

Is the slowness on the first frame, or on the whole animation?
If it's the whole animation, is clipping causing the slow down?
Maybe there's an
alternative way of drawing the scene that doesn't use clipping. For example,
overlay opaque corners onto a square instead of clipping to a rounded rectangle.
If it's a static scene that's being faded, rotated, or otherwise manipluated,
maybe a
[RepaintBoundary](https://docs.flutter.io/flutter/widgets/RepaintBoundary-class.html)
can help.

#### Checking for offscreen layers

The
[`saveLayer`](https://docs.flutter.io/flutter/dart-ui/Canvas/saveLayer.html)
method is one of the most expensive methods in the Flutter
framework.  It’s useful when applying post-processing to the scene,
but it can slow your app and should be avoided if you don’t need it.
Even if you don’t call `saveLayer` explicitly, implicit calls may happen
on your behalf. You can check whether your scene is using `saveLayer` with the
[PerformanceOverlayLayer.checkerboardOffscreenLayers](https://docs.flutter.io/flutter/rendering/PerformanceOverlayLayer/checkerboardOffscreenLayers.html)
switch.

{% comment %}
[TODO: Document disabling the graphs and checkerboardRasterCachedImages.
Flutter Inspector doesn't seem to support this?]
{% endcomment %}

Once the switch is enabled, run the app and look for any images that are
outlined with a flickering box. The box flickers from frame to frame if a
new frame is being rendered.  For example, perhaps you have a group of
objects with opacities that are rendered using `saveLayer`. In this case,
it's probably more performant to apply an opacity to each individual widget,
rather than a parent widget higher up in the widget tree. The same goes for
other potentially expensive operations, such as clipping or shadows.

<aside class="alert alert-info" markdown="1">
**Note:** Opacity, clipping, and shadows are not, in themselves, a bad idea.
However, applying them to the top of the widget tree might cause extra calls to
`saveLayer`, and needless processing.
</aside>

When you encounter calls to `saveLayer`, ask yourself these questions:

* Does the app need this effect?
* Can any of these calls be eliminated?
* Can I apply the same effect to an individual element instead of a group?

#### Checking for non-cached images

Caching an image with
[RepaintBoundary](https://docs.flutter.io/flutter/widgets/RepaintBoundary-class.html)
is good, _when it makes sense_.

One of the most expensive operations, from a resource perspective, is
rendering a texture using an image file. First, the compressed image is
fetched from persistent storage.
The image is decompressed into host memory (GPU memory), and transferred
to device memory (RAM).

In other words, image I/O can be expensive.
The cache provides snapshots of complex hierarchies so they are easier to
render in subsequent frames.
_Because raster cache entries are expensive to construct and take up loads
of GPU memory, cache images only where absolutely necessary._

You can see which images are being cached by enabling the
[PerformanceOverlayLayer.checkerboardRasterCachedImages](https://docs.flutter.io/flutter/widgets/PerformanceOverlay/checkerboardRasterCacheImages.html)
switch.

{% comment %}
[TODO: Document how to do this, either via UI or programmatically.
At this point, disable the graphs and checkerboardOffScreenLayers.]
{% endcomment %}

Run the app and look for images rendered with a randomly colored checkerboard,
indicating that the image is cached. As you interact with the scene,
the checkerboarded images should remain constant—you don’t want to see
flickering, which would indicate that the cached image is being re-cached.

In most cases, you want to see checkerboards on static images,
but not on non-static images.  If a static image isn't cached,
you can cache it by placing it into a
[RepaintBoundary](https://docs.flutter.io/flutter/widgets/RepaintBoundary-class.html)
widget. Though the engine may still ignore a repaint boundary if it
thinks the image isn't complex enough.

## Debug flags

Flutter provides a wide variety of debug flags and functions to help you
debug your app at various points along the development cycle.
To use these features, you must compile in debug mode.
The following list, while not complete,
highlights some of the more useful flags (and one function)
from the [rendering
library](https://docs.flutter.io/flutter/rendering/rendering-library.html)
for debugging performance issues.

* [`debugDumpRenderTree()`](https://docs.flutter.io/flutter/rendering/debugDumpRenderTree.html)<br>
  Call this function when not in a layout or repaint phase to dump the
  rendering tree to the console.  (Pressing **t** from `flutter run`
  calls this command.) Search for "RepaintBoundary" to see diagnostics
  on how useful a boundary is.
* [`debugPaintLayerBordersEnabled`](https://docs.flutter.io/flutter/rendering/debugPaintLayerBordersEnabled.html)
* [`debugRepaintRainbowEnabled`](https://docs.flutter.io/flutter/rendering/debugRepaintRainbowEnabled.html)<br>
  Enable this property and run your app to see if any parts of your UI
  that aren't changing (for example, a static header) are rotating
  through many colors in the output.
  Those areas are candidates for adding repaint boundaries.
* [`debugPrintMarkNeedsLayoutStack`](https://docs.flutter.io/flutter/rendering/debugPrintMarkNeedsLayoutStacks.html)<br>
  Enable this property if you're seeing more layouts than you expect
  (for example, on the timeline, on a profile, or from a "print" statement
  inside a layout method). Once enabled, the console is flooded with
  stack traces showing why each render object is being marked dirty for
  layout.
* [`debugPrintMarkNeedsPaintStacks`](https://docs.flutter.io/flutter/rendering/debugPrintMarkNeedsPaintStacks.html)<br>
  Similar to `debugPrintMarkNeedsLayoutStack`, but for excess painting.

You can learn about other debug flags in
[Debugging Flutter Apps](/docs/testing/debugging).

## Benchmarking

You can measure and track your app’s performance by writing benchmark tests.
The Flutter Driver library provides support for benchmarking. Using this
integration test framework, you can generate metrics to track the following:

* Jank
* Download size
* Battery efficiency
* Startup time

Tracking these benchmarks allows you to be informed when a regression is
introduced that adversely affects performance.

For more information, see
[Integration testing](/docs/testing#integration-testing),
a section in [Testing Flutter Apps](/docs/testing).

## More information

The following resources provide more information on using Flutter's tools
and debugging in Flutter:

* [Debugging Flutter Apps](/docs/testing/debugging)
* [Flutter Widget Inspector](/docs/development/tools/inspector)
* [Flutter Inspector talk](https://www.youtube.com/watch?v=JIcmJNT9DNI),
  presented at DartConf 2018
* [Why Flutter Uses
  Dart](https://hackernoon.com/why-flutter-uses-dart-dd635a054ebf),
  an article on Hackernoon.
* [Observatory: A Profiler for Dart Apps](https://dart-lang.github.io/observatory/)
* [Flutter API](https://docs.flutter.io/index.html) docs, particularly the
  [PerformanceOverlay](https://docs.flutter.io/flutter/widgets/PerformanceOverlay-class.html)
  class, and the
  [dart:developer](https://docs.flutter.io/flutter/dart-developer/dart-developer-library.html)
  package.

[IntelliJ Flutter Inspector Window]: {% asset tools/android-studio/visual-debugging.png @path %}
