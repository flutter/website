---
title: Using the Performance view
description: Learn how to use the DevTools performance view.
---

## What is it?

The performance view allows you to record and profile a session from your Dart application.

{{site.alert.note}}
  **If you are running a Flutter application, use a profile build to analyze performance.**
  Cpu profiles are not indicative of release performance unless your Flutter application is
  run in profile mode.
{{site.alert.end}}

## CPU Profiler
Start recording a CPU profile by clicking Record. When you are done recording, click Stop. At this
point, CPU profiling data will be pulled from the VM and displayed in the profiler views (Call Tree,
Bottom Up, and Flame Chart). 

### Flame chart

This tab of the profiler shows CPU samples for the recorded duration.
This chart should be viewed as a top-down stack trace, where the 
top-most stack frame calls the one below it. The width of each stack 
frame represents the amount of time it consumed the CPU. Stack frames 
that consume a lot of CPU time may be a good place to look for possible 
performance improvements.

![Screenshot of a flame chart]({% asset tools/devtools/cpu_profiler_flame_chart.png @path %}){:width="100%"}

### Call tree

The call tree view shows the method trace for the CPU profile.
This table is a top-down representation of the profile,
meaning that a method can be expanded to show its _callees_.

<dl markdown="1">
<dt markdown="1">**Total time**</dt>
<dd>Time the method spent executing its own code as well as
    the code for its callees.</dd>
<dt markdown="1">**Self time**</dt>
<dd>Time the method spent executing only its own code.</dd>
<dt markdown="1">**Method**</dt>
<dd>Name of the called method.</dd>
<dt markdown="1">**Source**</dt>
<dd>File path for the method call site.</dd>
</dl>

![Screenshot of a call tree table]({% asset tools/devtools/cpu_profiler_call_tree.png @path %}){:width="100%"}

### Bottom up

The bottom up view shows the method trace for the CPU profile but,
as the name suggests, it's a bottom-up representation of the profile.
This means that each top-level method in the table is actually the
last method in the call stack for a given CPU sample (in other words,
it's the leaf node for the sample).

In this table, a method can be expanded to show its _callers_.

<dl markdown="1">
<dt markdown="1">**Total time**</dt>
<dd markdown="1">Time the method spent executing its own code
    as well as the code for its callee.

<dt markdown="1">**Self time**</dt>
<dd markdown="1">For top-level methods in the bottom-up tree
    (leaf stack frames in the profile), this is the time the
    method spent executing only its own code. For sub nodes
    (the callers in the CPU profile), this is the self time
    of the callee when being called by the caller.
    Using the following example, the self time of the caller
    `Element.updateSlotForChild.visit()` is equal to the self time of
    the callee `[Stub] OneArgCheckInLineCache` when being called by
    the caller.

<dt markdown="1">**Method**</dt>
<dd markdown="1">Name of the called method.

<dt markdown="1">**Source**</dt>
<dd markdown="1">File path for the method call site.

![Screenshot of a bottom up table]({% asset tools/devtools/cpu_profiler_bottom_up.png @path %}){:width="100%"}

