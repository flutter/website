## CPU Profiler

Start recording a CPU profile by clicking Record.
When you are done recording, click Stop. At this point,
CPU profiling data is pulled from the VM and displayed
in the profiler views (Call Tree,
Bottom Up, and Flame Chart).

### Profile granularity

The default rate at which the VM collects CPU samples
is 1 sample / 250 μs.  This is selected by default on
the CPU profiler view as "Profile granularity: medium".
This rate can be modified via the selector at the top
of the page. The sampling rates for low, medium,
and high granularity are 1 / 1000 μs, 1 / 250 μs, and 1 / 50 μs,
respectively. It is important to know the trade-offs
of modifying this setting.

A **higher granularity** profile has a higher sampling rate,
and therefore yields a fine-grained CPU profile with more samples.
This may also impact performance of your app since the VM
is being interrupted more often to collect samples. This also
causes the VM's CPU sample buffer to overflow more quickly.
The VM has limited space where it can store CPU sample information.
At a higher sampling rate, the space fills up and begins
to overflow sooner than it would have if a lower sampling
rate was used. This means that you may not have access to CPU samples
from the beginning of the recorded profile.

A **lower granularity** profile has a lower sampling rate,
and therefore yields a coarse-grained CPU profile with fewer samples.
However, this impacts your app's performance less.
The VM's sample buffer also fills more slowly, so you can see
CPU samples for a longer period of app run time. This means that
you have a better chance of viewing CPU samples from the beginning
of the recorded profile.

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
    In the following example, the self time of the caller
    `createRenderObject` is equal to the self time of
    the callee `debugCheckHasDirectionality` when being called by
    the caller.

<dt markdown="1">**Method**</dt>
<dd markdown="1">Name of the called method.

<dt markdown="1">**Source**</dt>
<dd markdown="1">File path for the method call site.

![Screenshot of a bottom up table]({% asset tools/devtools/cpu_profiler_bottom_up.png @path %}){:width="100%"}
