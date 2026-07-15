---
title: "Profiling Flutter Applications Using the Timeline"
description: "Using the Timeline allows you to find and address specific performance issues in your application. It is also a great tool to identify the…"
publishDate: 2019-03-01
author: chinmaygarde
image: images/1MBoVBDD8a68IiUpcaD3CjQ.webp
category: tutorial
layout: blog
---

*Using the Timeline allows you to find and address specific performance issues in your application. It is also a great tool to identify the relative performance costs of all the features provided by Flutter, and allows you to make more informed decisions about where you might want to avoid certain features or identify headroom to use effects that might make your application stand out.*

<DashImage figure src="images/1MBoVBDD8a68IiUpcaD3CjQ.webp" alt="The Timeline" caption="The Timeline" />


One of the more useful profiling tools provided by Flutter out of the box is the ability to record traces to the Dart Timeline. The timeline allows you to ask and answer specific questions about why your application might be janking. As someone who is often assigned to look at performance issues in unfamiliar codebases, profiling using the timeline happily requires minimal understanding of the codebase of the application. Because of this, the timeline is often the first and most useful tool I personally use to diagnose and fix performance issues. For performance bottlenecks in Flutter itself, [filing an issue](https://github.com/flutter/flutter/issues) that includes reduced test cases and a Timeline trace make it easy to identify, cross reference, and prioritize specific tasks that improve performance in the Flutter Engine and framework. I must admit that for similarly prioritized issues, I’ll pick the issue with an attached timeline trace to work on first.

## What is the Timeline

The Timeline is a [ring buffer](https://en.wikipedia.org/wiki/Circular_buffer) of events that are recorded by application code as it goes about its operation. The type of events to be recorded and their recording frequency is determined by what the authors of the subsystem that emitted the event have determined to be of possible relevance to performance.

To work with the Timeline, you need the following:

* An ability to start and stop recording timeline events.

* An ability to export the timeline events into a portable format and view them offline.

* Code that emits Timeline events.

## Timeline Trace Event Format

The events logged in the ring buffer are extremely lightweight. To actually view these events in a diagnosable form, you must export it to a suitably portable format. The [Trace Event Format](https://docs.google.com/document/d/1CvAClvFfyA5R-PhYUmn5OOQtYMH4h6I0nSsKchNAySU/edit) is used by Flutter to export these timeline events for viewing in a dedicated trace viewer. This is the same format and viewer developed in the [Catapult](https://github.com/catapult-project/catapult) family of performance profile gathering, display and analysis tools.

The Trace Event Format and Viewer and used by a number of other projects. Such projects include [Chromium](https://dev.chromium.org/developers/how-tos/trace-event-profiling-tool) & [Android (via systrace)](https://developer.android.com/studio/command-line/systrace). In fact, it is so useful that Chromium has one built-in. Try navigating to *chrome://tracing* in a Chromium based browser.

Traces that you share with other developers are JSON files or their tarballs. A neat tip that I didn’t know until recently is that the trace viewer can untar the JSON file tarball for you automatically.

## Some Background on How Flutter Renders Frames

Before we attempt to identify potential performance issues, we need to have some understanding of what a healthy Flutter application looks like. This section is a crash course in how Flutter renders its frames.

### The Threads

When a Flutter application is launched, it starts (or picks from a pool) three more threads. These threads sometimes have overlapping concerns, but broadly, they are referred to as the UI thread, the GPU thread and the IO thread. It is important to note the the UI thread is not the same as the platform’s main thread. Some platforms also called their main threads their UI thread. The UI thread used by Flutter is different from this thread. Descriptively, Flutter calls the platform’s main thread the “Platform thread”.

<DashImage figure src="images/1ZVLNiQC-KCmz3e7t_w3LQg.webp" alt="Threading in the Flutter Engine" caption="Threading in the Flutter Engine" />


The UI thread is the thread on which all Dart code executing on behalf of the framework and your application is run. Unless your application or the framework (via methods like [foundation::compute](https://docs.flutter.io/flutter/foundation/compute.html)) launches its own isolates (via methods like [Isolate.spawn](https://docs.flutter.io/flutter/dart-isolate/Isolate/spawn.html)), Dart code will never run on any other thread. Even in cases of secondary isolate launches, Dart code will never run on either the GPU or IO threads.

The Platform thread is where all code that relies on plugins runs. This thread is also where the platform’s native frameworks might service their tasks. Flutter applications interact with their plugins in an asynchronous manner and plugins should not be able to block any of the threads managed by Flutter.

Apart from the four threads just described, the Dart VM also manages a pool of threads. This thread pool is used to service a variety of functions like waiting on socket for *dart:io*, garbage collection and JIT code generation (only in *debug* mode and Flutter uses AOT in *release* mode).

### The Frame Pipeline

<DashImage figure src="images/1jc6WYuRTFSJVslRi70YBHw.webp" alt="Frame Pipeline" caption="Frame Pipeline" />


To generate a single frame, the Flutter engine first arms the vsync latch. A vsync event is an indication to the Flutter engine to start doing work that eventually renders a new frame on the screen. The vsync event generated by the platform takes into account the refresh rate of the display (among other factors).

The vsync event wakes up the UI thread. This is where the Dart code for the Flutter application and the framework runs. The result of all the operations on the UI thread is a rendering backend (OpenGL, Vulkan or Software) agnostic description of the scene to render to the screen. This description is called the layer tree.

As soon as the layer tree is created, the GPU thread is woken up. This thread begins the transformation of the layer tree into a GPU command buffer. This command buffer is then submitted to the GPU on the same thread.

For sufficiently complex scenes, the UI thread could be generating the next frame concurrently as the GPU thread is consuming the layer tree for the previous one. The engine refers to the work done on the UI and GPU threads as belonging to a pipeline item. The pipeline depth is the number of frame workloads the engine is working on at any given time. The pipeline depth may vary.

### What Causes Jank

Give this mode of operation, jank can be perceived in a Flutter application if either one of the following conditions are met:

* Either the UI or GPU thread component of a pipeline item exceeds the frame budget (typically 16.67 ms for a 60Hz display refresh rate).

* The engine changes the pipeline depth.

* The vsync events from the platform are emitted or latched onto at an inconsistent rate.

One notable exception to this list is a scenario where the engine selectively ignores vsync events at a consistent rate. For example, on a 60Hz display, if the engine only starts working on a pipeline item on every other vsync pulse, the Flutter application will render at a consistent 30Hz.

<DashImage figure src="images/1iDRQWjq4Y_mWd4Diyd67jQ.webp" alt="Janky Frame (due to shader compilation)" caption="Janky Frame (due to shader compilation)" />


## How to Collect & Read Timeline Traces

Armed with this knowledge of how the Flutter engine operates as well as having a cursory understanding of the conditions that cause jank, we are ready to collect traces ourselves.

The trace collection overhead is fairly low but it is definitely not free. For this reason, the Flutter engine gathers traces in only the [debug](https://flutter.dev/docs/testing/build-modes#debug) or [profile](https://flutter.dev/docs/testing/build-modes#profile) modes. The profile mode is most similar to the performance your users can expect when running your application. This mode AOT compiles your Dart code and otherwise behaves just like [release](https://flutter.dev/docs/testing/build-modes#release) mode. However, it also enables the timeline as well as other tracing tools available via the Dart observatory.

The time it takes to create a profile mode build is also about the same as the release mode. Don’t let this discourage you from using profile mode, however. I usually like to add traces to the Timeline in debug mode (with all the benefits hot reloading brings to the table). Then, when I am reasonably sure that my traces will collect the information I need, I perform one build in profile mode to gather valid timing information.

To collect traces, you need to open the Dart Observatory for your Flutter application. The Observatory is a web application served by all Flutter applications running on the device in either debug or profile mode. The web application is launched on the device and is provided at a randomly available port. The Flutter tools do the work of forwarding this port to your host.
> **Note**: Observatory is being replaced by Dart DevTools. This browser-based tool is still in development but is available to preview. For installation and getting started instructions, see the [DevTools’ docs](https://flutter.github.io/devtools/) and, in particular, [using the timeline view](https://flutter.github.io/devtools/timeline).

### Observatory from the Command Line

* Launch the application using ***flutter run — profile*** (or ***debug*** if you are prototyping your traces)

* The tools should forward the observatory port to your host and display a line like so: ***An Observatory debugger and profiler on iPhone X is available at: http://127.0.0.1:60551/***

* Launch that URL in your web browser

### Observatory from the IDE

* Launch the Flutter Application using the Play button or shortcut.

* In the Run panel, click the stopwatch icon to launch the observatory for that application in your web browser.

<DashImage figure src="images/1wA1fIv94nkn0LnY5OJ3IXg.webp" alt="Observatory from the IDE" caption="Observatory from the IDE" />


## Navigate to the Timeline in the Observatory

Either click on the timeline link on the main observatory page or navigate to the timeline directly by opening **http://127.0.0.1:61102/#/timeline** (replace the # with the actual port number).

If you always want to forward the observatory to the same port on the host, specify the ***— observatory-port=&lt;port&gt;*** command line option. That way, you can just reload your web browser after relaunching the application on the device. I do this to avoid looking up the new observatory port. Enter **flutter help run** at the command line for more details.

<DashImage figure src="images/1ntk5Tcf1yuOhmHDlE8Zjig.webp" alt="The Observatory Homepage" caption="The Observatory Homepage" />


You will now see an empty timeline. Trace are assigned categories, and, by default, no categories are enabled.

<DashImage figure src="images/1TlX5df1vv352ypRRfveEAA.webp" alt="An Empty Timeline" caption="An Empty Timeline" />


## Collecting a Trace

Enable tracing on all trace categories by clicking on ***All*** then click the ***clear*** button to start tracing on the device. Notice that the “Recorded Streams” are all enabled. The timeline is still empty but the device has started gathering traces. Make sure to interact with the application in a way that adds traces to the Timeline. Usually, rendering a few frames works.

<DashImage figure src="images/1kS5PXfU-kAN-NgwijJFQ7w.webp" alt="Timeline with Streams Enabled" caption="Timeline with Streams Enabled" />


When you are done tracing and want to view the trace, click the ***Refresh*** button to have the Observatory pull the current trace buffer from the device.

<DashImage figure src="images/1tNI6e9KnMvxqSyJGqGA-gQ.webp" alt="A Freshly Collected Trace (enable Flow & VSync events)" caption="A Freshly Collected Trace (enable Flow & VSync events)" />


You can quickly navigate the trace using the mouse and ***W***, ***A***, ***S***, ***D*** keys. It is also a good idea to enable the ***Flow events*** and ***Highlight VSync*** options in the ***View Options*** dropdown. This allows you to view traces within the context of frames as they are being rendered on the screen.

Navigating the trace using the mouse depends on what navigation mode is selected. I usually have the ‘selection’ tool enabled from the panel. I use this to select specific trace elements while using the keyboard keys to pan. However, can switch between the mouse mode by clicking the appropriate panel item or pressing one of ***1*** for selection , ***2*** for pan, ***3*** for zoom or ***4*** for timing.

<DashImage figure src="images/1jSbyYB6C2wBoP5x_3FNGtA.webp" alt="The Selection Pane (Easy to miss, so just use the shortcuts)" caption="The Selection Pane (Easy to miss, so just use the shortcuts)" />


It is also a good idea to press ***?*** on your keyboard. This brings up a help dialog of supported shortcuts.

## Saving & Sharing Traces

Clicking the ***save*** button makes the browser download a JSON file containing the trace. You can share that trace in bug reports or email. To view a shared trace, navigate to ***about://tracing*** in Chrome and load the previously saved trace file.

The trace viewer in Chrome at ***about://tracing*** works with compressed JSON files as well. I find these to be easier to share and work with.

## Elements of a Trace

### Duration Events

By far the most common type of trace events used in the engine are duration events. Such events allow you to annotate a block of code in your trace. These are extremely simple to add as they require no identifiers. In Dart, you can use the [***dart:developer*** package’s ***Timeline***](https://docs.flutter.io/flutter/dart-developer/Timeline-class.html) class to add traces yourself. The Flutter engine & framework already adds duration events to workloads it considers important. You should feel free to do the same. Clicking on a specific duration gives you a summary of the time spent on that event.

<DashImage figure src="images/1YxI3oc-2oOSmCB0U5_Q2HA.webp" alt="Duration Events & Summary" caption="Duration Events & Summary" />


Look for duration events on the UI or GPU threads that are significant chunks of the frame interval. The frame intervals can be highlighted by enabling the ***Highlight Vsync*** button described earlier or just pressing the ***v*** key.

If you see a particularly large duration event, the next step is to highlight which part of code is contributing to that chunk being as large as it is. Identifying such chunks is significantly easier when using the sampling profiler described below. But, if you have some understanding of the codebase in question, you can also speculatively add traces to your code. While firm instrumentation numbers should only be gathered in ***profile*** mode, I like to work in ***debug*** mode with hot reload to speculatively add traces to see if I am getting closer to isolating the bottleneck.

### The Event Summary

Clicking on an event displays the event summary in a pane at the bottom. The ***Events*** section of the summary is especially useful because it attempts to connect all logically related duration events. These relationships are inferred using flow events described below. The Flutter framework and engine already add flow events for all frame related workloads. In this way, it is easier for you to isolate all the work (across multiple threads) related to a specific frame. When you click the link for the related flow, the trace viewer selects and highlights all the connected flows.

In the example below, selecting all related traces and sorting the list by ***Self Time*** shows that the ***PhysicalShapeLayer::Paint*** trace is the dominant trace. You can tell that this trace is on the GPU thread because mousing over the same in the summary highlights the same.

<DashImage figure src="images/1iok8mEWRxvbqaZa_8dF9qQ.webp" alt="The Event Summary" caption="The Event Summary" />


Once such dominant traces are identified, I usually know which parts of the code to dig down deeper into. The summary is also useful because multiple occurrences of small events with extremely small durations are easy to miss visually in the trace. But such traces are immediately highlighted in the summary.

### Repeating Events

Sometimes, instead of a single event, you want to characterize the performance of repeating events that generate duration traces. This can be done by drag selecting a section of the timeline containing such events.

<DashImage figure src="images/1bEv-aW0gogJaxlpTDysf3Q.webp" alt="Analyzing Repeating Events" caption="Analyzing Repeating Events" />

> The trace viewer is called [Catapult](https://www.google.com/url?q=https://github.com/catapult-project/catapult&sa=D&ust=1551398816863000) and there may be different versions of Catapult embedded in Chrome at ***about://tracing*** and the Observatory. I am using the latest version of Chrome for this as it has more up-to-date trace viewer features. You can also use Catapult directly at HEAD on GitHub. If you want to view a trace gathered in Observatory in a newer version of Catapult, save the trace as JSON and load the same in a different version of Catapult. The JSON format is stable.

Once you select a group of traces, you should see a summary of all the traces that are repeating within that selection. Selecting a trace (I am using the latest version of the Catapult trace viewer in the following example), should display useful information like the average time per slice, standard deviation, repeat counts, etc..

<DashImage figure src="images/1FcYP_acRHIIHKbGaAyM-9w.webp" alt="Repeating Event Summary" caption="Repeating Event Summary" />


This should give you a better idea about improvements you make to the codebase that are reflected in smaller duration events in repeating events (like frames). Also, once you identify outliers, you can more easily select the same and analyze the traces around the same to explain the deviation.

### Flow Events

Flow events are used to logically connect duration events (possibly on multiple threads). In the trace viewer, they show up as arrows. By default, Flow events tend to make the trace view quite messy and are disabled. To enable the same, check the “Flow events” box in the “View Options”. Flow events must originate within a duration event. Using the [Flow class in the ***dart:developer***](https://docs.flutter.io/flutter/dart-developer/Flow-class.html) package does this for you automatically. The Flutter engine also adds an implicit flow called “PipelineItem” to all frame related workloads. All duration events connected with a flow count as “related” in the events summary described above. The descendants of connected events are also counted.

In the following example, the Flutter engine is producing the next frame on the UI thread before the previous frame has been rendered by the GPU thread. Without flows, it would have been very difficult to correlate duration events with specific frame workloads.

<DashImage figure src="images/1-8wNvN-zrrEQlIZZKT5s_A.webp" alt="Flow Events for Pipeline Items" caption="Flow Events for Pipeline Items" />


### The Sampling Profiler

Often, it can be hard to figure out where to begin when adding traces. Whenever the engine wakes up a thread to do work, it adds an implicit duration trace called ***MessageLoop::RunExpiredTasks***. However, there might be no more traces nested within the same. In such case, the sampling profiler comes in extremely handy. The Dart VM collects the backtrace of currently code at a specific frequency. These samples show up as instant events on the UI thread whenever any Dart code is being run.

<DashImage figure src="images/1MKXFenx4GEY1_JxHsdaSjQ.webp" alt="The Sampling Profiler" caption="The Sampling Profiler" />


The samples are easy to miss but extremely handy. Selecting a sample displays a backtrace of the Dart and native stack at that point in time. If you are lost and don’t know where to begin adding traces, just keep selecting a sample till you identify code that looks familiar.

And, that’s a short overview of some of the ways in which you can use the timeline effectively to instrument your application. Happy tracing.
