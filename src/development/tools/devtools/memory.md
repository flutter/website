---
title: Using the Memory view
description: Learn how to use the DevTools memory view.
---

## What is it?

Allocated Dart objects created using a class constructor (for
example, by using `new MyClass()` or `MyClass()`) live in a
portion of memory called the heap. The memory in the heap is
managed by the Dart VM (virtual machine).

## DevTools memory page

The DevTools Memory page lets you peek at how an isolate is using
memory at a given moment. 

Memory profiling in DevTools consists of 3 main functions:

* Charting memory usage statistics and events
* Anaylsis to view all memory via a heap to detect memory issues
  and inspect objects
* Allocation monitoring to track object allocations and
  their stack traces for selected classes.

## Charting memory statistics and events

At the top-level, when the **Memory** tab is selected,
memory statistics from the VM are collected and displayed
in the two overview charts (Dart memory and Android only).
The collected statistics include general memory usage, such as
total heap used, external heap size, maximum heap capacity, and
Resident Set Size (RSS). As you interact with your application,
various events are detected and collected in the same timeline
as the memory statistics, such as memory GC (garabage collection),
Flutter events, and user fired events (using the `dart:developer` package).
All of these collected statistics and events are displayed in charts.
For more information, see [Memory anatomy](#memory-anatomy).

## Analysis and snapshots

A snapshot is a complete view of
all objects in the Dart memory heap.
Each time a snapshot is taken, a complex
and time consuming analysis
is performed over the collected memory data.
The memory profiler attempts to identify any memory patterns
that might cause leaks or lead to application crashes.
For example, loading large assets for images displayed
as thumbnails&mdash;memory usage can be improved by loading smaller
assets or adjusting the `cacheWidth` and `cacheHeight`
to decode an image to a smaller size,
reducing the memory burden on the `ImageCache`.
This analysis catches issues like this.
For more information, see [Analysis tab](#analysis-tab).

## Allocations and tracking

Monitoring all allocations involves directly interacting
with DevTools and your application to isolate a short period
of time where you are interested in knowing how many objects
were allocated, how many bytes were allocated, or in tracking
all the places in your code where a particular
class is allocated.
This information is available under the **Allocations**
tab of the Memory profiler and is a fairly fast computation
with less overhead than using a snapshot.

Monitoring allocations and resetting accumulators
helps to analyze the accumulator counts (the number of
objects or bytes allocated), in a short timeframe.
If you suspect that your application is leaking memory
or has other bugs relating to memory allocation,
the accumulators can be used to understand the
allocation rate. Additionally, you can track
allocations of a few specific classes; tracking too
many classes might slow the running of your application
and isn't recommended. The VM records the stack
trace at the time a class constructor is called
(causing an allocation). This can isolate the exact
location in your code when and where memory is being allocated.
For more information, see [Allocation tab](#allocation-tab).

{{site.alert.note}}
  **Use [profile mode][] when running your app to analyze performance.**
  Memory usage is not indicative of release performance unless your
  application is run in profile mode. In general, memory usage is
  fairly accurate, in relative terms, between debug, release, or
  profile modes. Profile mode might show higher absolute memory usage
  because a service isolate is created to profile your application.
  This isolate won't exist in release mode. Absolute memory used might
  also be higher in debug versus release mode. In [release mode][],
  work can be computed and optimized ahead of time, while in [debug mode][]
  that same work might have to be computed at runtime,
  requiring more information.
{{site.alert.end}}

## Memory anatomy

A timeseries graph is used to visualize the state of the Flutter memory
at successive intervals of time. Each data point on the chart
corresponds to the timestamp (x-axis) of measured quantities (y-axis)
of the heap. For example, usage, capacity, external, garbage
collection, and resident set size are captured.

![Screenshot of a memory anatomy page]({{site.url}}/assets/images/docs/tools/devtools/memory_chart_anatomy.png){:width="100%"}

### Events pane

The event timeline displays Dart VM and DevTools events
on a shared timeline. These events can be snapshots (manual and auto),
Dart VM GCs, user requested GCs, or monitor and accumulator reset actions.

![Screenshot of DevTools events]({{site.url}}/assets/images/docs/tools/devtools/memory_eventtimeline.png)

This chart displays DevTools events (such as manual GC, VM GC,
snapshot, monitor Allocations **Track** and **Reset** of accumulators button
clicks) in relation to the memory chart timeline. Clicking over the
markers in the Event timeline displays a hover card of the time when
the event occurred. This might help identify when a memory leak has
possibly occurred in the timeline (x-axis).

![Screenshot of the event timeline legend]({{site.url}}/assets/images/docs/tools/devtools/memory_eventtimeline_legend.png)

This legend shows the symbol for each DevTools event and its meaning:

<dl markdown="1">
<dt markdown="1">**Snapshot**</dt>
![User snapshot]({{site.url}}/assets/images/docs/tools/devtools/memory_eventtimeline_snapshot.png){:width="17px"}
<dd markdown="1">User initiated snapshot&mdash;all memory
                 information is collected and an analysis is performed.
</dd>
<dt markdown="1">**Auto-Snapshot**</dt>
![Auto snapshot]({{site.url}}/assets/images/docs/tools/devtools/memory_eventtimeline_auto_snapshot.png){:width="18px"}
<dd markdown="1">DevTools initiated a snapshot after detecting
                 that memory has grown by 40% or more from its
                 last measurement. This can help to quickly detect
                 memory spikes in your Flutter application for later
                 analysis, and is the same information collected
		 in a manual snapshot.
</dd>
<dt markdown="1">**Track**</dt>
![Monitor]({{site.url}}/assets/images/docs/tools/devtools/memory_eventtimeline_monitor.png){:width="17px"}
<dd markdown="1">Collects the current state of all active classes, the
                 number of instances, and the byte size of all instances.
                 In addition, the deltas indicate the change in the
                 accumulators since the last **Reset**.
</dd>
<dt markdown="1">**Reset**</dt>
![Reset]({{site.url}}/assets/images/docs/tools/devtools/memory_eventtimeline_reset_monitor.png){:width="18px"}
<dd markdown="1">When both the instance and byte accumulators
                 were reset to zero.
</dd>
<dt markdown="1">**User Initiated GC**</dt>
![GC]({{site.url}}/assets/images/docs/tools/devtools/memory_eventtimeline_gc.png){:width="18px"}
<dd markdown="1">User initiated request to the VM to perform a
                 garbage collection on memory. This is not a guarantee
                 that GC occured&mdash;it's only a request.
</dd>
<dt markdown="1">**VM GC**</dt>
![VM GC]({{site.url}}/assets/images/docs/tools/devtools/memory_eventtimeline_vmgc.png){:width="11px"}
<dd markdown="1">GC (VM garbage collection) has occurred and has freed
                 up space that is no longer used. For more information on
                 how Dart performs garbage collection, see
                 [Don't Fear the Garbage Collector][].
</dd>
<dt markdown="1">**User and Flutter Event**</dt>
<dd>The dark magenta triangle displayed in the event pane indicates
    that "Multiple Flutter or User Events" occurred at this timestamp.
</dd>
![Aggregate Events]({{site.url}}/assets/images/docs/tools/devtools/memory_multi_events.png){:width="25px"}
<dd>The lighter magenta triangle indicates that
    "One Flutter or User Event" occurred at this timestamp.
</dd>
![Single Events]({{site.url}}/assets/images/docs/tools/devtools/memory_one_event.png){:width="23px"}
<dd>To view the events, click on the triangle to display a hover card.
    Expand the events at the bottom of the hover card
    to display all events for that timestamp.
</dd>
</dl>

Displayed below the events pane is the [memory chart](#memory-overview-chart)
and the [Android memory chart](#android-chart). The android-memory chart is
specific to an Android app, and it shows Android ADB meminfo from an
ADB app summary.

### Adding user custom events to the timeline

Sometimes it might be difficult to correlate the actions in your Flutter
application code and the collected memory statistics and events charted in
the Memory timeline chart. To learn precisely what your app is doing
to the heap, you can inject your own events into the Memory Profile timeline.

Post your own custom events by using the `postEvent` method in the
`dart:developer` package. The event name must be prefixed with
**DevTools.Event_**. For example, **DevTools.Event_**_MyEventName_

To use, add the following import to your code:

<!--skip-->
```dart
import 'dart:developer' as developer;
```

and a method to post custom events to the Memory timeline:

<!--skip-->
```dart
void devToolsPostEvent(String eventName, Map<String, Object> eventData) {
  developer.postEvent('DevTools.Event_$eventName', eventData);
}
```

To post an event from your code, call the `devToolsPostEvent` method.
For example, in your function, `recordLoadedImage`, you could
post the 'MyImages' event to the memory timeline as follows:

<!--skip-->
```dart
Widget recordLoadedImage(ImageChunkEvent imageChunkEvent, String imageUrl) {
 
  // Record the event in the memory event pane.
  devToolsPostEvent('MyFirstApp', { 'method': 'recordLoadedImage', 'param': imageUrl });

  if (imageChunkEvent == null) return null;

  //...
  }
```

Clicking on the aggregated event triangle in the event pane dispays a
hover card with the details of all events. The following example displays
two custom events at the timestamp 04:36:21 with the event name 'MyFirstApp',
and the two `eventData` entries (`method` and `param`),
are displayed with their values: 

![Hover Card Custom Events]({{site.url}}/assets/images/docs/tools/devtools/memory_hover_events.png)

Scrolling the events displays:

![Custom Events Details]({{site.url}}/assets/images/docs/tools/devtools/memory_events_detail.png)

## Memory overview chart

The memory overview chart is a timeseries graph of collected
memory statistics. It visually presents the state of the
Dart or Flutter heap and Dart's or Flutter's native memory
over time.

The chart's x-axis is a timeline of events (timeseries). The data
plotted in the y-axis all has a timestamp when the data was
collected. In other words, it shows the polled state (capacity,
used, external, RSS (resident set size), and GC (garbage collection))
of the memory every 500 ms. This helps provide a live appearance on
the state of the memory as the application is running.

Clicking the **Legend** button displays the collected
measurements and symbols and colors used to display the data.

![Screenshot of a memory anatomy page]({{site.url}}/assets/images/docs/tools/devtools/memory_chart_anatomy.png){:width="100%"}

The **Memory Size Scale** y-axis automatically adjusts to the
range of data collected in the current visible chart range.

The quantities plotted on the y-axis are as follows:

**Dart/Flutter Heap**
: Objects (Dart/Flutter objects) in the heap.

**Dart/Flutter Native**
: Memory that is not in the Dart/Flutter heap but
  is still part of the total memory footprint. Objects in this
  memory would be native objects (for example, from a memory read
  from a file, or a decoded image). The native objects are exposed
  to the Dart VM from the native OS (such as Android, Linux, Windows,
  iOS) using a Dart embedder. The embedder creates a Dart wrapper
  with a finalizer, allowing Dart code to communicate with these
  native resources. Flutter has an embedder for Android and iOS.
  For more information, see [Dart on the Server][server] or
  [Custom Flutter Engine Embedders][embedder].

**Timeline**
: The timestamps of all collected memory statistics
  and events at a particular point in time (timestamp).

**Raster Cache**
: The size of the Flutter engine's raster cache layer(s)
  or picture(s), while performing the final rendering after compositing.
  For more information, see [Flutter Architectural Overview][architecture]
  and [DevTools Performance][performance].

**Allocated**
: The current capacity of the heap is typically slightly
  larger than the total size of all heap objects.

**RSS - Resident Set Size**
: The resident set size displays the
  amount of memory for a process. It doesn't include memory that is
  swapped out. It includes memory from shared libraries that are
  loaded, as well as all stack and heap memory.

For more information, see [Dart VM internals][vm].

### Hover card

Clicking in a chart displays a vertical yellow line where the click
occurred on the x-axis (Timestamp); a hover card is displayed with
the information collected:

![Screenshot of the basic memory chart]({{site.url}}/assets/images/docs/tools/devtools/memory_basic_chart.png)

**Memory Events**
: Memory Events recorded in the Event Pane. This includes
  VM GC, User Initiated GC, User Initiated Snapshot,
  Auto-Snapshot, Allocation Monitoring and, Reset of Accumulators

**Dart / Flutter Memory**
: Displays collected data Capacity, Used, External, RSS,
  Raster Cache (pictures/layers)

**Flutter and User Events**
: Includes extension events, such as `Flutter.ImageSizesForFrame`,
  user custom events. For more information, see [Events](#events-pane).

Aggregate events, as the name implies, collects all the events nearest
a particular timestamp (tick) and displays the events to the x-axis'
closest tick.

If more than one event was collected at this timestamp,
a dark magenta triangle is displayed with the aggregate
list of events. The aggregate events collects all the events
nearest a particular timestamp (tick) and displays the events
on the x-axis near the closest tick. Expanding the events
displays the values for each event:

![Aggregate Events]({{site.url}}/assets/images/docs/tools/devtools/memory_multi_events.png){:width="25px"}

If only one event is collected, a lighter magenta triangle color is
displayed with the single event values:

![Single Events]({{site.url}}/assets/images/docs/tools/devtools/memory_one_event.png){:width="23px"}

If the Android memory chart is displayed then the collected Android data
is displayed between the "Dart / Flutter Memory" and the "Flutter and
User Events":

![Hovercard of Android chart is visible]({{site.url}}/assets/images/docs/tools/devtools/memory_android_hovercard.png)

### Android chart

When connected to an Android app, DevTools collects Android's ADB
(Android Debug Bridge) meminfo from an ADB app summary (polled every 500 ms).
This meminfo section is the most interesting at a high-level.
If you were to collect this info from the ADB tool, it would look like the
following:

```sh
> adb shell dumpsys meminfo io.flutter.demo.gallery -d

 App Summary
                       Pss(KB)
                       -------
           Java Heap:     5192
         Native Heap:    11992
                Code:     2132
               Stack:       60
            Graphics:    53700
       Private Other:    42800
              System:    84493
 
               TOTAL:   200369       TOTAL SWAP PSS:    82168
```

This chart is another timeseries graph of the state of Android memory as
the application is running. The quantities plotted on the y-axis are
the above values (Java Heap, Native Heap, Code size, Stack size,
Graphics stack, System size and total).

Clicking on a timestamp (x-position) displays all data points
collected for that time period:

![Screenshot of Android Memory Chart]({{site.url}}/assets/images/docs/tools/devtools/memory_android.png)

The hover card displays the values of all collected Android memory data.

<dl markdown="1">
<dt markdown="1">**Time**</dt>
<dd>The timestamp for the current data values collected -
    see descriptions below.
</dd>
<dt markdown="1">**Total**</dt>
<dd>The total memory in use. Total memory is comprised of
    several different categories, all of which are plotted
    along the y-axis. These categories are described below.
</dd>
<dt markdown="1">**Other**</dt>
<dd>Other memory usage corresponds to the ‘Private Other’
    field from ADB. This is memory used by the app that the
    system isn't sure how to categorize. Note: The Other trace
    is a combination of Other and System (shared and system
    memory usage), and corresponds to ‘System’ field from ADB.
</dd>
<dt markdown="1">**Code**</dt>
<dd>Code memory usage corresponds to the ‘Code’ field from ADB.
    This is memory that your app uses for static code and resources,
    such as dex byte code, optimized or compiled dex code, .so libraries,
    and fonts.
</dd>
<dt markdown="1">**Native Heap**</dt>
<dd>Native Heap usage corresponds to the ‘Native Heap’ field
    from ADB. This is memory from objects allocated from C or
    C++ code. Even if you're not using C++ in your app, you might
    see some native memory used here because the Android framework
    uses native memory to handle various tasks on your behalf. Some
    examples of these tasks are handling image assets and other
    graphics&mdash;even though the code you've written is in Java or Kotlin.
</dd>
<dt markdown="1">**Java Heap**</dt>
<dd>Java Heap usage corresponds to the ‘Java Heap’ field from ADB.
    This is memory from objects allocated from Java or Kotlin code.
</dd>
<dt markdown="1">**Stack**</dt>
<dd>Stack usage corresponds to the ‘Stack’ field from ADB. This is
    memory used by both native and Java stacks in your app. This usually
    relates to how many threads your app is running.
</dd>
<dt markdown="1">**Graphics**</dt>
<dd>Graphics usage corresponds to the ‘Graphics’ field from ADB. This
    is memory used for graphics buffer queues to display pixels on the screen,
    including GL surfaces, GL textures, and so on.
    Note: This is memory shared with the CPU&mdash;not dedicated GPU memory.
</dd>
</dl>

## Memory controls

At the top of the memory page, above the charts, are several buttons and
dropdowns that control how memory data is displayed:

![Screenshot of a memory controls]({{site.url}}/assets/images/docs/tools/devtools/memory_controls.png){:width="100%"}

<dl markdown="1">
<dt markdown="1">**Pause**</dt>
<dd>Pauses the memory overview chart to allow inspecting
    the currently plotted data. Incoming memory data is still received;
    notice the Range selector continues to grow to the right.
</dd>
<dt markdown="1">**Resume**</dt>
<dd>Resumes the memory overview chart so that it's live, displaying the
    current time and the latest memory statistics.
</dd>
<dt markdown="1">**Clear**</dt>
<dd>Clears all collected data from the memory profiler.
</dd>
<dt markdown="1">**Display**</dt>
<dd>The duration of the x-axis. For example, if this dropdown
    is set to "Display 5 minutes", memory data from the last
    5 minutes is displayed.
</dd>
<dt markdown="1">- Display 1 Minute</dt>
<dt markdown="1">- Display 5 Minutes</dt>
<dt markdown="1">- Display 10 Minutes</dt>
<dt markdown="1">- Display All Minutes (slider disabled)</dt>
<dt markdown="1">**Source**</dt>
<dd>Source can be either **Live Feed**, which pulls data from the
    connected Flutter app, or one of the available offline data
    files, which are created by clicking **Export**.
</dd>
<dt markdown="1">**Android Memory**</dt>
<dd>Displays or hides the Android Memory Chart.
</dd>
<dt markdown="1">**GC**</dt>
<dd>Initiates a garbage collection&mdash;a compaction of the heap.
</dd>
<dt markdown="1">**Export**</dt>
<dd>Saves collected data for the Event Timeline, Memory Overview Chart,
    and Android Overview Chart. Files saved are displayed under the
    **Source** dropdown. Selecting a file loads the offline data.
</dd>
</dl>

## Memory actions

Below the memory charts (Event Timeline, Memory Overview, and Android Overview
charts), are interactive actions used to collect and analyze information about
memory usage while using the application that DevTools is connected.
Two tabs are displayed:

![Two Tabs Memory Actions]({{site.url}}/assets/images/docs/tools/devtools/memory_two_tabs.png)

### Analysis tab

The **Analysis** tab collects memory snapshots, both user initiated and
auto-collected by DevTools (when DevTools detects memory spikes).
Each snapshot is analyzed.

### Analysis actions

The actions available for Analysis are:

![Screenshot of a memory actions]({{site.url}}/assets/images/docs/tools/devtools/memory_analysis_actions.png)

**Snapshot**
: Clicking the **Snapshot** button makes a request to the
  Dart VM to collect the current state of memory. The
  memory objects can be sorted by attributes, such as class
  name, size, and allocated instances.
  For more information, see [Snapshot classes](#snapshots)).

**Treemap**
: If the **Treemap** switch is on, the snapshot displays currently
  active memory objects, the last snapshot, and memory in a high-level
  view as a tree map.

**Group By**
: A dropdown to select how data is grouped, which can either be by
  instance or by class name.

**Collapse All**
: Collapse all nodes in the tree table.

**Expand All**
: Expand all nodes in the tree table.

### Analysis and snapshots

All analyses and snapshots are displayed in a table tree:

![Two Tabs Memory Actions]({{site.url}}/assets/images/docs/tools/devtools/memory_table_tree_view.png){:width="100%"}

The snapshots are grouped by library and within the library are grouped
by class. Each class displays the list of known instances for that class.

A snapshot is a complete view of all memory objects at a particular
point in time. You can navigate in the tree to a class and its instances
(if the constructor was called to create an instance). If instances exist,
expanding the class displays all live instances (objects). Clicking on
an instance of a class brings up the memory inspector.

![Two Tabs Memory Actions]({{site.url}}/assets/images/docs/tools/devtools/memory_navigate_inspect.png){:width="100%"}

## Snapshots

![The snapshot button]({{site.url}}/assets/images/docs/tools/devtools/memory_snapshot.png)

Clicking the **Snapshot** button shows the current state of the heap
and displays all active classes and their instances: 

![Screenshot of the snapshot classes]({{site.url}}/assets/images/docs/tools/devtools/memory_snapshot_tree.png){:width="100%"}

This pane shows classes allocated in the heap, all instances for a class,
and the ability to inspect a particular instance.

In addition, a snapshot can automatically occur when DevTools notices a
spike in memory usage (when detecting growth of 40% or greater).

Every snapshot, whether manual or automatic, generates an
analysis of the snapshot. For example, analysis might indicate
that image problems have occurred. In the future, other
common Flutter coding issues will be flagged, such as problems
with fonts, files, or JSON.

<dl markdown="1">
<dt markdown="1">**Tree View of Memory**</dt>
<dd>The tree table view displays outstanding memory events (user
    requested snapshots, automatic snapshots, snapshot analyses,
    memory allocation monitoring).
</dd>
<dt markdown="1">**Memory Inspector**</dt>
<dd>Displays either the contents of an analysis, snapshot, or
    monitoring based on the currently selected row in the tree view.
</dd>
</dl>

Snapshots have major tree nodes:

<dl markdown="1">
<dt markdown="1">**External**</dt>
<dd markdown="1">Memory that is not in the Dart heap but is still part
    of the total memory footprint. Objects in external memory would be
    native objects (for example, from a memory read from a file,
    or a decoded image). The native objects are exposed to the Dart
    VM from the native OS (such as Android, Linux, Windows, iOS)
    using a Dart embedder. The embedder creates a Dart wrapper with
    a finalizer, allowing Dart code to communicate with these native
    resources. Flutter has an embedder for Android and iOS.
    For more information, see [Dart on the Server][server] or
    [Custom Flutter Engine Embedders][embedder].
</dd>
<dt markdown="1">**Filtered**</dt>
<dd>Displays the packages being filtered.</dd>
<dt markdown="1">**Packages**</dt>
<dd>User packages used by the application and
    Src&mdash;the empty Dart package.</dd>
</dl>

Under each node are class nodes, an aggregate of the
objects allocated to this class. Clicking a class name displays
all the instances in a class.
Clicking on an instance inspects the fields and values of that
instance.

## Inspecting a class instance in a snapshot

Expanding a class displays the active instances for that class.
Clicking on an particular instance displays the type and value of
the fields for that instance:

![Screenshot of the inspecting an instance]({{site.url}}/assets/images/docs/tools/devtools/memory_inspector.png)

## Analysis of a snapshot

Every snapshot creates a corresponding **Analyzed** entry under the
**Analysis** node (the analyzed date/time corresponds to the matching
snapshot date/time):

![Screenshot of a snapshot analysis]({{site.url}}/assets/images/docs/tools/devtools/memory_analysis.png)

Currently, analysis looks for common problems with images, such as
loading large files instead of scaled thumbnails, or not using a
`ListBuilder` to manage images in a list, and so on.

The analysis pulls all image-related classes and instances from
a snapshot and organizes the data in one place. This saves you
the pain of having to search through all the classes and inspect the
instances to find the image-related classes.

In the above analysis, the raw images are located in the **External**
portion of memory, as `_Int32List` (or `_Int64List` for newer phones).
DevTools organizes the images by size into buckets. In this example,
eleven images are 10K-50K, one image is 10M-50M,
seven images are 1M-10M and four images are greater than 50M.
That's a grand total of over 500M to render thumbnail-sized
images on a phone. Obviously, this should be improved!

## Allocation tab

The **Allocation** tab monitors the instances of all classes,
reporting the number of objects allocated,
and the number of bytes consumed by all objects.
The numbers are displayed in absolute totals as well
as in accumulated totals. Initially, the accumulated values
(the number of objects and their size in bytes) are
equal to the initial totals at the time of the first
monitor request. The accumulators can be reset to zero at
any time such that the next monitor request returns the
accumlated values since the last reset.

Additionally, a small set of classes can track the allocation of each instance
of a class. The tracking captures a stack trace when the constructor was
called. The overhead to track these allocations is expensive (slow)
therefore tracking should be used sparingly.

### Allocation actions

You can perform the following Allocation actions:

![Screenshot of a memory actions]({{site.url}}/assets/images/docs/tools/devtools/memory_allocations_actions.png){:width="100%"}

<dl markdown="1">
<dt markdown="1">**Track**</dt>
<dd markdown="1">Records and monitors the number of instances
                 and size of all instances in bytes. Clicking
                 the **Track** button populates a table with
                 instance allocation data. For each instance in
                 the allocation table, the **Delta** column reflects
                 the number of memory allocations since the last reset.
</dd>
<dt markdown="1">**Reset**</dt>
<dd markdown="1">Resets the accumulator counts (**Delta** columns) for each
                 instance in the allocation table. The next time the **Monitor**
                 button is pressed, the **Delta** columns populate with
                 the new instances and sizes since the last reset.
</dd>
<dt markdown="1">**Search**</dt>
<dd markdown="1">The **Search** field is enabled when the instance allocation data
                 exists. Typing, or selecting a name from the dropdown,
                 navigates to that class name in the table.
</dd>
<dt markdown="1">**Filter**</dt>
<dd markdown="1">When clicked, displays a dialog box listing libraries and class names
                 that you can select.
</dd>
</dl>

### Allocation view

Allocations are displayed in a table view that lists the
classes available to the connected application:

![Two Tabs Memory Actions]({{site.url}}/assets/images/docs/tools/devtools/memory_allocations_overview.png){:width="100%"}

Each row displays the class name, the number of instances and bytes
allocated, with deltas for each (the count since the last reset).

<dl markdown="1">
<dt markdown="1">**Track with Stack Trace**</dt>
<dd markdown="1">If enabled, records the stack trace when the instance
                 is created (when the class constructor is called).
</dd>
<dt markdown="1">**Class Name**</dt>
<dd markdown="1">Class allocations monitored.
</dd>
<dt markdown="1">**Total Instances**</dt>
<dd markdown="1">Total number of active instances for the class.
</dd>
<dt markdown="1">**Delta Instances**</dt>
<dd markdown="1">An accumulator indicating a change to the instance count.
                 When **Reset** is pressed, the accumulators reset to zero;
                 then each time the **Track** button is pressed,
                 the data in the table is updated.
</dd>
<dt markdown="1">**Total Bytes**</dt>
<dd markdown="1">Total number of bytes allocated to all instances of the class.
</dd>
<dt markdown="1">**Delta Bytes**</dt>
<dd markdown="1">An accumulator indicating a change to the number of
                 instance bytes created. When **Reset** is pressed,
                 the accumulators reset to zero; then each time the
                 **Track** button is pressed, the data in the table
                 is updated.
</dd>
<dt markdown="1">**Timestamp of Last Track**</dt>
<dd markdown="1">The timestamp when the **Track** button was pressed.
</dd>
<dt markdown="1">**Change Bubble**</dt>
<dd markdown="1">A small bubble indicating that data in the table has
                 been updated.
</dd>
</dl>

For more information, see [Allocation Tracking](#allocation-tracking).

### Managing the objects and statistics in the heap (Monitor Allocations)

This feature can help you find memory leaks. Here are some of the
available buttons:

![The Monitor Allocations button]({{site.url}}/assets/images/docs/tools/devtools/memory_monitor_allocations.png)

Clicking the allocation **Track** button monitors the total
number of instances and bytes allocated for a class.
In addition, two accumulators are provided for instances and bytes
allocated. You can reset these values to zero by pressing
the **Reset Accumulators** button. The mechanism is useful
for finding memory leaks.

![Reset Accumulators button]({{site.url}}/assets/images/docs/tools/devtools/memory_reset.png)

Pressing the **Reset** button resets the accumulators for all classes
to zero and a "monitor reset" event is sent to the
Event Timeline. Clicking the **Reset** button again resets both
accumulators to zero.

<dl markdown="1">
<dt markdown="1">**Classes**</dt>
<dd markdown="1">Active classes in the heap.
</dd>
<dt markdown="1">**Instances column**</dt>
<dd>Total active objects (instances) for all classes in the heap.
</dd>
<dt markdown="1">**Delta column**</dt>
<dd>Total number of instances since last **Reset** was pressed.
    Clicking the **Reset** button initializes the accumulated
    (Delta) instances of a class. This is useful for finding memory leaks.
</dd>
<dt markdown="1">**Bytes column**</dt>
<dd>Total bytes consumed for all instances of a class in the heap.
</dd>
<dt markdown="1">**Delta column**</dt>
<dd>The number of bytes allocated since the **Reset** was last pressed.
    Clicking the **Reset** button initializes the accumulated (Delta) bytes for
    all instances of a class. This is useful for finding memory leaks.
</dd>
</dl>

## Allocation tracking

In addition to tracking the number of objects and bytes consumed
for all instances of a class, a stack trace can be recorded when a
class's constructor is called. This can help narrow where allocations
might have gone astray.
To do this, enable the **Track** checkbox for a class. For example:

![Enable Stack Trace Tracking]({{site.url}}/assets/images/docs/tools/devtools/memory_enable_stacktrace.png){:width="100%"}

Interact with your application. When you want to view the
instances allocation press the **Track** button again
to update the count for the instances being tracked.
For example, 118 instances of `ObjectWithUniqueId`
are being tracked in the following screenshot.
Expanding the instances tracked displays all 
instances and the timestamp when each instance was created:

![Class Tracking]({{site.url}}/assets/images/docs/tools/devtools/memory_tracking.png){:width="100%"}

Selecting an instance displays the call stack at the time the
class's constructor was called and the instance was allocated:

![Call Stack]({{site.url}}/assets/images/docs/tools/devtools/memory_tracking_callstack.png){:width="100%"}

## Filtering, searching, and auto-complete

Both the **Analysis** and **Allocations** tabs support
searching and filtering. Begin typing name of the class
you'd like to find (for example, **Ob**_ectWithUniqueId_)
to display a list that matches the characters
typed so far. The first item in the list is highlighted:

<dl markdown="1">
<dt markdown="1">**ENTER**</dt>
<dd markdown="1">Selects the highlighted line (GlobalObjectKey) and
                 navigates to the row with that class name in the
                 active **Snapshot** table or the **Allocations** table.
</dd>
<dt markdown="1">**UP/DOWN arrows**</dt>
<dd markdown="1">Rotates through the list of possible matches highlighting
                 the next item in the list.
</dd>
<dt markdown="1">**ESCAPE**</dt>
<dd markdown="1">Clears and cancels all searching.
</dd>
</dl>

![Searching]({{site.url}}/assets/images/docs/tools/devtools/memory_search_1.png)

Typing more characters to further narrow down the list of possible
class names. For example, typing **Obje** displays:

![Narrower Search]({{site.url}}/assets/images/docs/tools/devtools/memory_search_2.png)

Finally, typing **ObjectW** displays the exact match:

![Narrowed Search]({{site.url}}/assets/images/docs/tools/devtools/memory_search_3.png)

### Filtering

Filtering allows you to move libraries and classes from the main list
to a **Filter** group. This help reduce the number of classes visible that are
less important while profiling memory:

![Filtering]({{site.url}}/assets/images/docs/tools/devtools/memory_filtering.png){:width="100%"}

<dl markdown="1">
<dt markdown="1">**Hide Private Classes**</dt>
<dd markdown="1">Class names prefix with an underscore.
</dd>
<dt markdown="1">**Hide Classes with No Instances**</dt>
<dd markdown="1">Classes never constructed are filtered.
</dd>
<dt markdown="1">**Hide Libraries with No Instances**</dt>
<dd markdown="1">All classes in a library never constructed
                 the library is filtered.
</dd>
<dt markdown="1">**Hide Libraries or Packages**</dt>
<dd markdown="1">List of all libraries used in your application
                 are displayed. By default the libraries enabled
                 above are filtered out (for example, dart:*,
                 package:flutter*, and so on).
                 The libraries filtered out can
                 be enabled if you are interested in Dart core
                 libraries and classes or the Flutter framework.
</dd>
</dl>

### Setting

The Memory profiler has its own settings dialog:

![Settings]({{site.url}}/assets/images/docs/tools/devtools/memory_settings.png){:width="100%"}

<dl markdown="1">
<dt markdown="1">**Collect Android Memory Statistics using ADB**</dt>
<dd markdown="1">By default, if DevTools is connected to your
                 application through an Android device or emulator,
                 Android memory statistics are not collected.
                 Collecting with ADB can be expensive and might hide
                 performance issues in your app.
</dd>
<dt markdown="1">**Display Data in Units (B, K, MB, GB)**</dt>
<dd markdown="1">By default, data displayed in the hover card
                 is scaled using units instead of raw values.
                 Turning this off displays the raw numbers.
                 For example, 125M displays as 125,235,712
</dd>
<dt markdown="1">**Enable advanced memory settings**</dt>
<dd markdown="1">If enabled, the GC button is available to
                 ask the VM to garbage collect memory (manually).
                 This manual GC is only a request to the VM. The
                 VM might decide to do no compaction, some compaction,
                 or complete compaction of the heap.
</dd>
</dl>

## Memory problem case study

A memory leak study using large network images is available
on GitHub. You can follow the step-by-step instructions
on using the Devtools memory profiler to detect the
memory problem and fix it. For more information,
see the [memory leak case study][case_study].

## Glossary of VM terms

The following computer science terms will help you better
understand how your application uses memory.

<dl markdown="1">
<dt markdown="1">**Garbage collection (GC)**</dt>
<dd>GC is the process of searching the
    heap to locate, and reclaim, regions of "dead" memory&mdash;memory
    that is no longer being used by an application. This process
    allows the memory to be re-used and minimizes the risk of an
    application running out of memory, causing it to crash. Garbage
    collection is performed automatically by the Dart VM. In DevTools,
    you can perform garbage collection on demand by clicking the
    GC button.
</dd>
<dt markdown="1">**Heap**</dt>
<dd>Dart objects that are dynamically allocated live in a portion of
    memory called _the heap_. An object allocated from the heap is freed
    (eligible for garbage collection) when nothing points to it,
    or when the application terminates. When nothing points to an
    object, it is considered to be dead. When an object is pointed
    to by another object, it is live.
</dd>
<dt markdown="1">**Isolates**</dt>
<dd markdown="1">Dart supports concurrent execution by way of isolates,
    which you can think of processes without the overhead.
    Each isolate has its own memory and code that can't be
    affected by any other isolate. For more information,
    see [The Event Loop and Dart][event-loop].
</dd>
<dt markdown="1">**Memory leak**</dt>
<dd>A memory leak occurs when an object is live
    (meaning that another object points to it), but it is not being
    used (so it shouldn't have any references from other objects).
    Such an object can't be garbage collected, so it takes up space
    in the heap and contributes to memory fragmentation.
    Memory leaks put unnecessary pressure on the VM and can be
    difficult to debug.
</dd>
<dt markdown="1">**Virtual machine (VM)**</dt>
<dd>The Dart virtual machine is a piece of
    software that directly executes Dart code.
</dd>
</dl>

[architecture]: {{site.url}}/resources/architectural-overview
[performance]: {{site.url}}/development/tools/devtools/performance
[server]: https://dart-lang.github.io/server/server.html
[embedder]: {{site.repo.flutter}}/wiki/Custom-Flutter-Engine-Embedders
[vm]: https://mrale.ph/dartvm/
[event-loop]: {{site.dart-site}}/articles/archive/event-loop
[profile mode]: {{site.url}}/testing/build-modes#profile
[release mode]: {{site.url}}/testing/build-modes#release
[debug mode]: {{site.url}}/testing/build-modes#debug
[Don't Fear the Garbage Collector]: {{site.flutter-medium}}/flutter-dont-fear-the-garbage-collector-d69b3ff1ca30
[case_study]: {{site.repo.organization}}/devtools/tree/master/case_study/memory_leaks/images_1
