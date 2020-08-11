---
title: Using the Memory view
description: Learn how to use the DevTools memory view.
---

## What is it?

Allocated Dart objects created using a class constructor
(for example, by using `new MyClass()` or `MyClass()`)
live in a portion of memory called the heap.

DevTools Memory pane lets you peek at how an isolate is using
memory at a given moment. This pane using Monitor Allocations and
Reset, can display accumulator counts. The accumulators
can be used to study the rate of memory allocations,
if you suspect your application is leaking memory or has
other bugs relating to memory allocation.

Snapshot is a complete view of all Dart memory. Additionally, an analysis
of the snapshot is also done.  The analysis looks for Flutter and Dart
memory patterns that may cause leaks and could eventually crash a Flutter
application.  For example, loading large images, megabyte size, when a
thumbnail or something much smaller would have been much more efficient.

Memory profiling consists of six parts, each increasing
in granularity:

* Memory overview chart
* Android specific memory chart (via Android's ADB tool)
* Event timeline e.g., garbage collection (GC), and a user's memory tooling interactions
* Monitoring of Dart total instances/bytes size totals and managing accumulators to detect memory leaks
* Analysis of a Snapshot to detect possible Flutter memory problems 
* Snapshot of all live memory class instances and sentinels (instances
to be GC'd)

{{site.alert.note}}
  **Use [profile mode][] when running your app to analyze performance.**
  Memory usage is not indicative of release performance unless your
  application is run in profile mode. In general, memory usage is
  fairly accurate, in relative terms, between debug, release, or
  profile modes. Profile mode might show higher absolute memory usage
  because a service isolate is created to profile your application.
  This isolate won't exist in release mode. Absolute memory used might
  also be higher in debug versus release mode. In release mode,
  work can be computed and optimized ahead of time, while in debug
  mode that same work might have to be computed at runtime,
  requiring more information.
{{site.alert.end}}

## Memory Anatomy

A timeseries graph is used to visualize the state of the Flutter memory
at successive intervals of time. Each data point on the chart
corresponds to the timestamp (x-axis) of measured quantities (y-axis)
of the heap, for example, usage, capacity, external, garbage
collection, and resident set size.

![Screenshot of a memory anatomy page]({% asset tools/devtools/memory_chart_anatomy.png @path %}){:width="100%"}

The major sections of the memory profiler are:

<dl markdown="1">
<dt markdown="1">**Event Timeline**</dt>
<dd>Displays DevTools events (such as Snapshot (manual and auto), Dart VM GC, user requested GC, Monitor and Accumulator Reset (button clicks) when they occurred, in relation to the memory chart timeline.</dd>
<dt markdown="1">**Memory Overview Chart**</dt>
<dd>This chart is a timeseries graph to help visualize the state of the Dart heap and External Heaps at various points in time.</dd>
<dt markdown="1">**Android Overview Chart**</dt>
<dd>This chart, for an Android app, collects Android's ADB tool meminfo section of ADB's App Summary section.</dd>
<dt markdown="1">**Timeline Position**</dt>
<dd>Slider controls the x-axis (timeline or left-most position) of the all charts (event, memory and Android).  The increment is based on the current display unit. For example, setting the Display  to 5 minutes then each increment in the slider (from right-most to left) would be now, 5 minutes ago, 10 minutes ago, etc.</dd>
<dt markdown="1">**Tree View of Memory**</dt>
<dd>Table Tree view of outstanding memory events e.g., User requested snapshots, Automatic snapshots, Analysis of snapshots, and Memory Allocation monitoring.</dd>
<dt markdown="1">**Memory View**</dt>
<dd>Display either the contents of the analysis, snapshot or monitoring based on the currently selected row in the Table Tree view.</dd>
</dl>

## Memory Controls

The top line of the memory profile page has a number of buttons and dropdowns to control how memory charts are displayed.

![Screenshot of a memory controls]({% asset tools/devtools/memory_controls.png @path %}){:width="100%"}

<dl markdown="1">
<dt markdown="1">**Pause**</dt>
<dd>Pause the memory overview chart to allow inspecting
    the currently plotted data. Incoming memory data is still received;
    notice the Range selector continues to grow to the right.</dd>
<dt markdown="1">**Resume**</dt>
<dd>The memory overview chart is live and displaying the
    current time and the latest memory data received.</dd>
<dt markdown="1">**Clear**</dt>
<dd>All collected data plotted in charts and event timeline are deleted and all snapshots, analyses and allocation monitoring is deleted too.</dd>
<dt markdown="1">**Display dropdown**</dt>
<dd>All memory data collected (timeseries).
    The left-most or first time/data (memory information) when the application was launched. The right-most or last time/data is the continual memory information received (live) until the application is stopped.  The timeline is scaled by the selected "Display" dropdown e.g., 
<dt markdown="1">- Display 1 Minute</dt>
<dt markdown="1">- Display 5 Minutes</dt>
<dt markdown="1">- Display 10 Minutes</dt>
<dt markdown="1">- Display All Minutes (slider disabled)</</dt>
</dd>
<dt markdown="1">**Source**</dt>
<dd>Source can be either "Live Feed" current connected running Flutter application or offline "Export" file.</dd>
<dt markdown="1">**Android Memory**</dt>
<dd>Displays or hides the Android Memory Chart.</dd>
<dt markdown="1">**GC**</dt>
<dd>Initiates a garbage collection - compaction of the heap</dd>
<dt markdown="1">**Export**</dt>
<dd>Saves collected data for Event Timeline, Memory Overview Chart and Android Overview Chart. Files saved are displayed under the Source drop-down. Selecting a file will load the offline data.</dd>
</dl>

## Memory Actions

Below the memory charts (Event Timeline, Memory Overview and Android Overview charts) are actions to collect information about memory e.g., Snapshots, Table Tree view, Treemap view, Groupings, or Monitor Allocations, Searching and Filtering.

![Screenshot of a memory actions]({% asset tools/devtools/memory_actions.png @path %}){:width="100%"}

<dl markdown="1">
<dt markdown="1">**Snapshot**</dt>
<dd markdown="1">Display a table of all current active
    memory objects.  Clicking the Snapshot button makes a request to the Dart VM to collect the current state of memory.  A snapshot displays a table of current memory objects. The memory objects can be sorted by class name, size, allocated instances, and so on.(see [Snapshot classes](#snapshot-classes)).
<dt markdown="1">**Treemap**</dt>
<dd markdown="1">Display all collected snapshots, analysis and monitor in a Table Tree view (most-detailed) default (see [Snapshot classes](#snapshot-classes)).  If Treemap is switched on then the last snapshot, high-level data, is disabled as a tree map. (TBD details).</dd>
<dt markdown="1">**Group By**</dt>
<dd markdown="1">Dropdown to select how trees are ordered for display by instance or by class name.</dd>
<dt markdown="1">**Collapse All**</dt>
<dd markdown="1">Collapse all nodes in the Table Tree view.</dd>
<dt markdown="1">**Expand All**</dt>
<dd markdown="1">Expand all nodes in the Table Tree view.</dd>
<dt markdown="1">**Monitor Allocations**</dt>
<dd markdown="1">User clicked on Monitor Allocations.  To record the number of instances and size of all instances in bytes.  The accumulators (Delta column) can be used to track memory allocated since last reset.</dd>
<dt markdown="1">**Reset Accumulators**</dt>
<dd>User clicked Reset button.  Zeros the accumulators (Delta column).  When next Monitor Allocations is pressed the count/ of new instances and size of new instnaces since the last reset.</dd>
<dt markdown="1">**Search**</dt>
<dd>The search field is enabled when a snapshot exists.  The current selected snapshot, or last snapshot, class name will be searched (auto-completed).  Typing, or selecting a name from the dropdown, will navigate to that class name in the snapshot.</dd>
<dt markdown="1">**Filter**</dt>
<dd>Display a dialog box of libraries and class names to display (checked on).</dd>
</dl>

## Memory Overview Chart

![Screenshot of the basic memory chart]({% asset tools/devtools/memory_basic_chart.png @path %}){:width="100%"}

This chart is a timeseries graph to help visualize the state of the heap at various points in time.

The chart's x-axis is a timeline of events (timeseries).
In other words, it shows the polled state of the memory
every 500 ms. This helps give a live appearance on the
state of the memory as the application is running.
The quantities plotted on the y-axis are (from top to bottom):

<dl markdown="1">
<dt markdown="1">**Legend**</dt>
<dd>All collected measurements regarding the memory.
    Clicking a legend name hides or shows that data.</dd>
<dt markdown="1">**X-axis timestamp**</dt>
<dd>Time of the collected memory information
    (capacity, used, external, RSS (resident set size),
    and GC (garbage collection).</dd>
<dt markdown="1">**Hover information of collected data**</dt>
<dd>At a particular time (x-axis) the detailed collected
    memory data.</dd>
<dt markdown="1">**Capacity**</dt>
<dd>Current capacity of the heap.</dd>
<dt markdown="1">**Used**</dt>
<dd>Objects (Dart objects) in the heap.</dd>
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

To view RSS (resident set size), click the name of the RSS located
in the legend.

* The resident set size displays the amount of memory to a process.
  It doesn't include memory that is swapped out. It includes memory
  from shared libraries that are loaded, as well as all stack and
  heap memory.

For more information, see [Dart VM internals][vm].

## Memory Android Chart (ADB)

DevTools, for an Android app, collects Android's ADB tool parsing the meminfo section of ADB's App Summary section.  This section is the most interesting from a high-level
```
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

This chart is another timeseries graph but of Android memory (polled ADB values).  to help visualize the state of the
heap at various points in time.

The chart's x-axis is a timeline of events (timeseries).
In other words, it shows the polled state of the memory
every 500 ms. This helps give a live appearance on the
state of the memory as the application is running.
The quantities plotted on the y-axis are (from top to bottom):

## Event Timeline

![Screenshot of DevTools events]({% asset tools/devtools/memory_eventtimeline.png @path %}){:width="100%"}

This chart displays DevTools events (such as manual GC, VM GC, Snapshot, Monitor Allocations and Reset Accumulators button
clicks) in relation to the memory chart timeline. Hovering over the
markers in the Event timeline displays the time when the event occurred.
This helps identify when a memory leak might have occurred in the
timeline (x-axis).

![Screenshot of the event timeline legend]({% asset tools/devtools/memory_eventtimeline_legend.png @path %}){:width="100%"}

The above list of glyphs plotted on the Event Timeline corresponds to users actions or a VM has garbaged collected.

<dl markdown="1">
<dt markdown="1">**Snapshot**</dt>
<dd markdown="1">User initiated snapshot - all memory information collected and an analysis performed.</dd>
<dt markdown="1">**Auto-Snapshot**</dt>
<dd markdown="1">DevTools initiated a snapshot detecting that memory grow by 40% or more from previous size.  This is used to detect memory spikes in your Flutter application (same information collected as in a manual snapshot).</dd>
<dt markdown="1">**Monitor Allocations**</dt>
<dd markdown="1">Collects current state of all active classes number of instances and byte size of all instances.  In addtion, the deltas are the change in the accumulators since the last "Reset Accumulators" button pressed.</dd>
<dt markdown="1">**Reset Accumulators**</dt>
<dd markdown="1">When both the instance and bytes accumulators were reset to zero.</dd>
<dt markdown="1">**User Initiated GC**</dt>
<dd markdown="1">When user manual request the VM to perform a garbage collection of memory (only a suggestion to the VM).</dd>
<dt markdown="1">**VM GC**</dt>
<dd markdown="1">GC (garbage collection) has occurred. For more information on how Dart performs garbage collection, see [Don't Fear the Garbage Collector][].</dd>
</dl>

## Managing the objects and statistics in the heap (Monitor Allocations)

![The Monitor Allocations button]({% asset tools/devtools/memory_monitor_allocations.png @path %}){:width="100%"}

Clicking the Monitor Allocations button will monitor the total number of instances and total number of bytes allocated for a class.  In addition, two accumulators are maintained for instances and bytes allocated these accumulators can be reset, to zero, by user action (pressing the Reset Accumulators button).  The mechanism is useful to find memory leaks.

![Reset Accumulators button]({% asset tools/devtools/memory_reset.png @path %}){:width="100%"}

When the **Reset Accumulators** button is pressed, the accumulators for all classes resets to zero. When reset is occurs a "monitor reset" event to the Event Timeline.  Clicking the **Reset Accumulators** button again resets both accumulators to zero.

<dl markdown="1">
<dt markdown="1">**Classes**</dt>
<dd markdown="1">Active classes in the heap.</dd>
<dt markdown="1">**Instances column is total active objects for all classes in the heap**</dt>
<dd>Total classes allocated in the heap and total objects (instances) in the heap.</dd>
<dt markdown="1">**Delta column the accumulator count of all instances since last "Reset Accumulators" was pressed.**</dt>
<dd>Clicking the Reset Accumulators button resets the both the accumulated instances count and accumulated instances bytes. This is useful for finding memory leaks.</dd>
<dt markdown="1">**Bytes column is total bytes consumed for all instances of a class in the heap**</dt>
<dt markdown="1">**Delta column is the accumulator counts since last "Reset Accumulators" was pressed.**</dt>
<dd>Clicking the Reset Accumulators button resets the both the accumulated bytes of all instances of a class. This is useful for finding memory leaks.</dd>
</dl>

## Snapshots

![The Snapshot button]({% asset tools/devtools/memory_snapshot.png @path %}){:width="100%"}

Clicking the **Snapshot** button shows the current state of the heap with regard to all active classes and their instances. 

![Screenshot of the Snapshot classes]({% asset tools/devtools/memory_snapshot_tree.png @path %}){:width="100%"}

This pane shows classes allocated in the heap, all instances for a class, and the ability to inspect a particular instance.

In addition, a snapshot can automatically occur when DevTools notices a spike in memory used (growth of > 40%).

Every snapshot, manual or automatic, will generate an analysis of the snapshot e.g., groups image problems that might have occurred. In the future, other common Flutter coding issues e.g., Fonts, Files, JSON, etc. that could cause memory problems will be flagged.

Snapshots have major tree nodes:
<dl markdown="1">
<dt markdown="1">External</dt>
<dd>Memory that is not in the Dart heap but is still part
  of the total memory footprint. Objects in external memory would be
  native objects (for example, from a memory read from a file,
  or a decoded image). The native objects are exposed to the Dart
  VM from the native OS (such as Android, Linux, Windows, iOS)
  using a Dart embedder. The embedder creates a Dart wrapper with
  a finalizer, allowing Dart code to communicate with these native
  resources. Flutter has an embedder for Android and iOS.
  For more information, see [Dart on the Server][server] or
  [Custom Flutter Engine Embedders][embedder].</dd>
<dt markdown="1">Filtered</dt>
<dd>Filter are the packages being filtered.</dd>
<dt markdown="1">Packages</dt>
<dd>User packages used by the application and Src - the empty Dart package.</dd>
</dl>

Under each of the above nodes are class nodes, an aggregate of the objects allocated to this class. Clicking a class name displays a list of class instances. and under each class are all the instances of a class. Clicking on an instance will inspect the contents of that instances (fields and values).

## Inspecting a Class instance in a Snapshot

Expanding a class displays the active instances for that class.  Clicking on an particular instance displays the type and value of the fields for that instance.

![Screenshot of the inspecting an instance]({% asset tools/devtools/memory_inspector.png @path %}){:width="100%"}

## Analysis of a Snapshot

Every snapshot creates a corresponding Analyzed entry under the Analysis node (the Analyzed date/time corresponds to the matching Snapshot date/time).

![Screenshot of a Snapshot Analysis]({% asset tools/devtools/memory_analysis.png @path %}){:width="100%"}

Currently, Analysis looks for common problems with images e.g., loading large files instead of scaled thumbnails, not using a ListBuilder to manage images in a list, etc.

The Analysis pulls all Image related classes and instances from a snapshot and organizes the data in one place instead of having to search for the all the classes and inspect the instances to understand what are just image related classes.

In the above Analysis the raw images are located in the Externals portion of memory _Int32List (or _Int64List for newer phones) organizes the instances sizes into buckets.  Eleven images are 10K-50K, one image is 10M-50M, seven images are 1M-10M and four images are greater than 50M.  For a grand total of over 500M of this app constitute images rendered as small images on a phone.

## Glossary of VM terms

Here are some computer science concepts that will help you better
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
    GC button.</dd>
<dt markdown="1">**Heap**</dt>
<dd>Dart objects that are dynamically allocated live in a portion of
    memory called the heap. An object allocated from the heap is freed
    (eligible for garbage collection) when nothing points to it,
    or when the application terminates. When nothing points to an
    object, it is considered to be dead. When an object is pointed
    to by another object, it is live.</dd>
<dt markdown="1">**Isolates**</dt>
<dd markdown="1">Dart supports concurrent execution by way of isolates,
    which you can think of processes without the overhead.
    Each isolate has its own memory and code that can't be
    affected by any other isolate. For more information,
    see [The Event Loop and Dart][event-loop].
<dt markdown="1">**Memory leak**</dt>
<dd>A memory leak occurs when an object is live
    (meaning that another object points to it), but it is not being
    used (so it shouldn't have any references from other objects).
    Such an object can't be garbage collected, so it takes up space
    in the heap and contributes to memory fragmentation.
    Memory leaks put unnecessary pressure on the VM and can be
    difficult to debug.</dd>
<dt markdown="1">**Virtual machine (VM)**</dt>
<dd>The Dart virtual machine is a piece of
    software that directly executes Dart code.</dd>

[server]: https://dart-lang.github.io/server/server.html
[embedder]: {{site.github}}/flutter/flutter/wiki/Custom-Flutter-Engine-Embedders
[vm]: https://mrale.ph/dartvm/
[event-loop]: {{site.dart-site}}/articles/archive/event-loop
[profile mode]: /docs/testing/build-modes#profile
[release mode]: /docs/testing/build-modes#release
[debug mode]: /docs/testing/build-modes#debug
[Don't Fear the Garbage Collector]: {{site.flutter-medium}}/flutter-dont-fear-the-garbage-collector-d69b3ff1ca30
