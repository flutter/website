---
title: Debug Flutter apps from code
description: How to enable various debugging tools from your code and at the command line.
---

<?code-excerpt path-base="testing/code_debugging"?>

This guide describes which debugging features you can enable in your code.
For a full list of debugging and profiling tools, check out the
[Debugging][] page.

{{site.alert.note}}
  If you are looking for a way to use GDB to remotely debug the
  Flutter engine running within an Android app process,
  check out [`flutter_gdb`][].
{{site.alert.end}}

[`flutter_gdb`]: https://github.com/flutter/engine/blob/main/sky/tools/flutter_gdb

## Logging

{{site.alert.note}}
  You can view logs in DevTools' [Logging view][]
  or in your system console. This sections
  shows how to set up your logging statements.
{{site.alert.end}}

You have two options for logging for your application.

1. Print to `stdout` and `stderr` using `print()` statements.
1. Import `dart:io` and invoking methods on
   `stderr` and `stdout`. For example:

    <?code-excerpt "lib/main.dart (stderr)"?>
    ```dart
    stderr.writeln('print me');
    ```

If you output too much at once, then Android might discard some log lines.
To avoid this outcome,
use [`debugPrint()`][] from Flutter's `foundation` library.
This wrapper around `print` throttles the output to avoid the Android kernel
dropping output.

You can also log your app using the `dart:developer` [`log()`][] function.
This allows you to include greater granularity and more information
in the logging output.

### Example 1
{:.no_toc}

<?code-excerpt "lib/main.dart (log)"?>
```dart
import 'dart:developer' as developer;

void main() {
  developer.log('log me', name: 'my.app.category');

  developer.log('log me 1', name: 'my.other.category');
  developer.log('log me 2', name: 'my.other.category');
}
```

You can also pass app data to the log call.
The convention for this is to use the `error:` named
parameter on the `log()` call, JSON encode the object
you want to send, and pass the encoded string to the
error parameter.

### Example 2
{:.no_toc}

<?code-excerpt "lib/app_data.dart (PassAppData)"?>
```dart
import 'dart:convert';
import 'dart:developer' as developer;

void main() {
  var myCustomObject = MyCustomObject();

  developer.log(
    'log me',
    name: 'my.app.category',
    error: jsonEncode(myCustomObject),
  );
}
```

DevTool's logging view interprets the JSON encoded error parameter
as a data object.
DevTool renders in the details view for that log entry.

## Setting breakpoints

You can set breakpoints in DevTools' [Debugger][] or
in the built-in debugger of your IDE.

To set programmatic breakpoints:

1. Import the `dart:developer` package into the relevant file.
1. Insert programmatic breakpoints using the `debugger()` statement.
   This statement takes an optional `when` argument.
   This boolean argument sets a break when the given condition resolves to true.

   **Example 3** illustrates this.

### Example 3
{:.no_toc}

<?code-excerpt "lib/debugger.dart"?>
```dart
import 'dart:developer';

void someFunction(double offset) {
  debugger(when: offset > 30);
  // ...
}
```

## Debug flags: application layers

Each layer of the Flutter framework provides a function to dump its
current state or events to the console using the `debugPrint` property.

{{site.alert.note}}
  All of the following examples were run as macOS native apps on
  a MacBook Pro M1 Pro. These will differ from any dumps your
  development machine prints.
{{site.alert.end}}

### Widget tree

To dump the state of the Widgets library,
call the [`debugDumpApp()`][] function.

To dump the state of the Widgets Library or widget tree in your app:

1. Open your source file.
1. Import `package:flutter/rendering.dart`.
1. Call the [`debugDumpApp()`][] function from within the `runApp()` function.
   You need your app in debug mode.
   You cannot call this function inside a `build()` method
   when the app is building.
1. If you haven't started your app, debug it using your IDE.
1. If you have started your app, save your source file.
   Hot reload re-renders your app.

#### Example 4: Call `debugDumpApp()`
{:.no_toc}

<?code-excerpt "lib/dump_app.dart"?>
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AppHome(),
    ),
  );
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: TextButton(
          onPressed: () {
            debugDumpApp();
          },
          child: const Text('Dump Widget Tree'),
        ),
      ),
    );
  }
}
```

This function recursively calls the `toStringDeep()` method starting with
the root of the widget tree. It returns a "flattened" tree.

**Example 4** produces the following widget tree. It includes:

* All the widgets projected through their various build functions
* Many widgets that don't appear in your app's source.
  The framework's widgets' build functions insert them during the build.

  The following tree, for example, shows [`_InkFeatures`][].
  That class is an implementation detail of the [`Material`][] widget.
  That class doesn't appear anywhere in the code in **Example 4**.

<details markdown="1">
<summary><strong>Expand to view the widget tree for Example 4</strong></summary>

{% include_relative trees/widget-tree.md -%}

</details>

When the button changes from being pressed to being released,
this invokes the `debugDumpApp()` function.
It also coincides with the [`TextButton`][] object calling [`setState()`][]
and thus marking itself dirty.
This explains why a Flutter marks a specific object as "dirty".
When you review the widget tree, look for this example:

```nocode
└TextButton(dirty, dependencies: [MediaQuery, _InheritedTheme, _LocalizationsScope-[GlobalKey#5880d]], state: _ButtonStyleState#ab76e)
```

If you write your own widgets, override the
[`debugFillProperties()`][widget-fill] method to add information.
Add [DiagnosticsProperty][] objects to the method's argument
and call the superclass method.
The `toString` method uses this function to fill in the widget's description.

### Render tree

When debugging a layout issue, the Widgets layer's tree might lack detail.
The next level of debugging might require a render tree.

To dump the render tree:

1. Open your source file.
1. Call the [`debugDumpRenderTree()`][] function.
   You can call this any time except during a layout or paint phase.
   Consider calling it from a [frame callback][] or an event handler.
1. If you haven't started your app, debug it using your IDE.
1. If you have started your app, save your source file.
   Hot reload re-renders your app.

#### Example 5: Call `debugDumpRenderTree()`
{:.no_toc}

<?code-excerpt "lib/dump_render_tree.dart"?>
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AppHome(),
    ),
  );
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: TextButton(
          onPressed: () {
            debugDumpRenderTree();
          },
          child: const Text('Dump Render Tree'),
        ),
      ),
    );
  }
}
```

When debugging layout issues, look at the `size` and `constraints` fields.
The constraints flow down the tree and the sizes flow back up.

<details markdown="1">
<summary><strong>Expand for the render tree for Example 5</strong></summary>

{% include_relative trees/render-tree.md -%}

</details>

In the render tree for **Example 5**:

* The window size, set as `Size(800.0, 600.0)`, limits all containers up to and
  including [`RenderPositionedBox`][] widget to the size of the screen.
* Each child has constraints of `BoxConstraints(w=800.0, h=600.0)`.
* According to the `RenderPositionedBox` widget, it has a `creator` of 
[`Center`][] widget.
sets its child's constraints to a loose version of this:
`BoxConstraints(0.0<=w<=411.4, 0.0<=h<=683.4)`. The child, a
[`RenderPadding`][], further inserts these constraints to ensure
there is room for the padding, and thus the [`RenderConstrainedBox`][]
has a loose constraint of `BoxConstraints(0.0<=w<=395.4,
0.0<=h<=667.4)`. This object, which the `creator` field tells us is
probably part of the [`TextButton`][]'s definition,
sets a minimum width of 88 pixels on its contents and a
specific height of 36.0. This is the `TextButton` class implementing
the Material Design guidelines regarding button dimensions.

The inner-most `RenderPositionedBox` loosens the constraints again,
this time to center the text within the button. The
[`RenderParagraph`][] picks its size based on its contents.
If you now follow the sizes back up the chain,
you'll see how the text's size is what influences the
width of all the boxes that form the button, as they all take their
child's dimensions to size themselves.

Another way to notice this is by looking at the "relayoutSubtreeRoot"
part of the descriptions of each box, which essentially tells you how
many ancestors depend on this element's size in some way.
Thus the `RenderParagraph` has a `relayoutSubtreeRoot=up8`,
meaning that when the `RenderParagraph` is dirtied,
eight ancestors also have to be dirtied because they might be
affected by the new dimensions.

If you write your own render objects, you can add information to the
dump by overriding [`debugFillProperties()`][render-fill].
Add [DiagnosticsProperty][] objects to the method's argument
then call the superclass method.

### Layer tree

To debug a compositing issue, use [`debugDumpLayerTree()`][].

#### Example 6: Call `debugDumpLayerTree()`
{:.no_toc}

<?code-excerpt "lib/dump_layer_tree.dart"?>
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AppHome(),
    ),
  );
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: TextButton(
          onPressed: () {
            debugDumpApp();
          },
          child: const Text('Dump Widget Tree'),
        ),
      ),
    );
  }
}
```

<details markdown="1">
<summary><strong>Expand for the output of layer tree for Example 6</strong></summary>

{% include_relative trees/layer-tree.md -%}

</details>

The `RepaintBoundary` widget creates:

1. A `RenderRepaintBoundary` RenderObject in the render tree
   as shown in the **Example 5** results.

   ```nocode
   ╎     └─child: RenderRepaintBoundary#f8f28
   ╎       │ needs compositing
   ╎       │ creator: RepaintBoundary ← _FocusInheritedScope ← Semantics ←
   ╎       │   FocusScope ← PrimaryScrollController ← _ActionsScope ← Actions
   ╎       │   ← Builder ← PageStorage ← Offstage ← _ModalScopeStatus ←
   ╎       │   UnmanagedRestorationScope ← ⋯
   ╎       │ parentData: <none> (can use size)
   ╎       │ constraints: BoxConstraints(w=800.0, h=600.0)
   ╎       │ layer: OffsetLayer#e73b7
   ╎       │ size: Size(800.0, 600.0)
   ╎       │ metrics: 66.7% useful (1 bad vs 2 good)
   ╎       │ diagnosis: insufficient data to draw conclusion (less than five
   ╎       │   repaints)
   ```

1. A new layer in the layer tree as shown in the **Example 6**
   results.

   ```nocode
   ├─child 1: OffsetLayer#0f766
   │ │ creator: RepaintBoundary ← _FocusInheritedScope ← Semantics ←
   │ │   FocusScope ← PrimaryScrollController ← _ActionsScope ← Actions
   │ │   ← Builder ← PageStorage ← Offstage ← _ModalScopeStatus ←
   │ │   UnmanagedRestorationScope ← ⋯
   │ │ engine layer: OffsetEngineLayer#1768d
   │ │ handles: 2
   │ │ offset: Offset(0.0, 0.0)
   ```

This reduces how much needs to be repainted.

### Focus tree

To debug a focus or shortcut issue, dump the focus tree
using the [`debugDumpFocusTree()`][] function.

The `debugDumpFocusTree()` method returns the focus tree for the app.

The focus tree labels nodes in the following way:

* The focused node is labeled `PRIMARY FOCUS`.
* Ancestors of the focus nodes are labeled `IN FOCUS PATH`.

If your app uses the [`Focus`][] widget, use the [`debugLabel`][]
property to simplify finding its focus node in the tree.

You can also use the [`debugFocusChanges`][] boolean property to enable
extensive logging when the focus changes.

#### Example 7: Call `debugDumpFocusTree()`
{:.no_toc}

<?code-excerpt "lib/dump_focus_tree.dart"?>
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AppHome(),
    ),
  );
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: TextButton(
          onPressed: () {
            debugDumpFocusTree();
          },
          child: const Text('Dump Focus Tree'),
        ),
      ),
    );
  }
}
```

<details markdown="1">
<summary><strong>Expand to view the focus tree for Example 7</strong></summary>

{% include_relative trees/focus-tree.md -%}

</details>

### Semantics tree

The `debugDumpSemanticsTree()` function prints the semantic tree for the app.

The Semantics tree is presented to the system accessibility APIs.
To obtain a dump of the Semantics tree:

1. Enable accessibility using a system accessibility tool
   or the `SemanticsDebugger`
1. Use the [`debugDumpSemanticsTree()`][] function.

#### Example 7: Call `debugDumpSemanticsTree()`
{:.no_toc}

<?code-excerpt "lib/dump_semantic_tree.dart"?>
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AppHome(),
    ),
  );
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Semantics(
          button: true,
          enabled: true,
          label: 'Clickable text here!',
          child: GestureDetector(
              onTap: () {
                debugDumpSemanticsTree();
                print('Clicked!');
              },
              child: Text('Click Me!', style: TextStyle(fontSize: 56))),
        ),
      ),
    );
  }
}
```


<details markdown="1">
<summary><strong>Expand the semantic tree for Example 4</strong></summary>

{% include_relative trees/semantic-tree.md -%}

</details>

<!-- this tree is bad, see {{site.repo.flutter}}/issues/2476 -->

### Scheduling

If you want to find out where your events happen relative to the frame's
begin and end, you can set prints to log these events.
To print the beginning and end of the frames to the console,
toggle the [`debugPrintBeginFrameBanner`][]
and the [`debugPrintEndFrameBanner`][].

**The print frame banner log for Example 1**

```nocode
I/flutter : ▄▄▄▄▄▄▄▄ Frame 12         30s 437.086ms ▄▄▄▄▄▄▄▄
I/flutter : Debug print: Am I performing this work more than once per frame?
I/flutter : Debug print: Am I performing this work more than once per frame?
I/flutter : ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
```

To print the call stack causing the current frame to be scheduled,
use the [`debugPrintScheduleFrameStacks`][] flag.

## Debug flags: layout

To debug a layout problem using a GUI, set
[`debugPaintSizeEnabled`][] to `true`.
This flag can be found in the `rendering` library.
You can enable it at any time and affects all painting while `true`.
Consider adding it to the top of your `void main()` entry point.

#### Example 8
{:.no_toc}

See an example in the following code:

<?code-excerpt "lib/debug_flags.dart (debugPaintSizeEnabled)"?>
```dart
//add import to rendering library
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(const MyApp());
}
```

When enabled, Flutter displays the following changes to your app:

* all boxes in a bright teal border
* all padding, from widgets like `Padding`,
  as a box with a faded blue fill and blue border around the child widget
* all alignment, from widgets like `Center` and `Align`, with yellow arrows
* all spacers, from widgets like `Container` when they have no child, in gray

The [`debugPaintBaselinesEnabled`][] flag
does something similar but for objects with baselines.
The app displays the alphabetic baseline in bright green and the
ideographic baseline in orange.

The [`debugPaintPointersEnabled`][] flag turns on a special mode where any objects that you tap get highlighted in teal.
This can help you determine if an object fails to hit test.
This might happen if the object falls outside the bounds of its parent
and thus not considered for hit testing in the first place.

If you're trying to debug compositor layers, for example
to determine whether and where to add `RepaintBoundary`
widgets, you can use the [`debugPaintLayerBordersEnabled`][]
flag, which outlines each layer's bounds in orange,
or the [`debugRepaintRainbowEnabled`][] flag,
which causes layers to be overlayed with a rotating set of
colors whenever they are repainted.

These flags only work in [debug mode][].
Any function or method in the Flutter framework that starts with
"`debug...`" only works in debug mode.

## Debugging animations

{{site.alert.note}}
  To debug animations with the least effort, slow them down.
  To slow down the animation, click **Slow Animations** in DevTools' [Inspector view][]. This reduces the animation to 20% speed.
  If you want more control over the amount of slowness,
  use the following instructions.
{{site.alert.end}}

Set the [`timeDilation`][] variable (from the `scheduler`
library) to a number greater than 1.0, for instance, 50.0.
It's best to only set this once on app startup. If you
change it on the fly, especially if you reduce it while
animations are running, it's possible that the framework
will observe time going backwards, which will probably
result in asserts and generally interfere with your efforts.

## Debug flags: performance

{{site.alert.note}}
  You can achieve similar results to some of these debug
  flags using [DevTools][]. Some of the debug flags provide little benefit. If you find a flag with functionality you would like to add to [DevTools][],
  [file an issue][].
{{site.alert.end}}

Flutter provides a wide variety of debug flags and functions
to help you debug your app at various points along the
development cycle.
To use these features, you must compile your app in debug mode.
The following list, while not complete,
highlights some of flags and one function from the
[rendering library][] for debugging performance issues.

[`debugDumpRenderTree()`][]
: Call this function when not in a layout or repaint
  phase to dump the rendering tree to the console.
  (Press <kbd>t</kbd> from `flutter run` to call this command.)
  Search for "RepaintBoundary" to see diagnostics
  on how useful a boundary is.

{% comment %}
  Feature is not yet added to DevTools:
  Rather than using this flag to dump the render tree
  to a file, view the render tree in the Flutter inspector.
  To do so, bring up the Flutter inspector and select the
  **Render Tree** tab.
{% endcomment %}

To set these flags either:

* edit the framework code
* import the module, set the value in your `main()` function,
  then hot restart.

[`debugPaintLayerBordersEnabled`][]
: Enable this flag if you need to see the boundaries of each layer.
  When enabled, each layer paints a box around its boundary.

[`debugRepaintRainbowEnabled`][]
: To enable this flag in the Flutter inspector, click **Highlight Repaints**.
  If any static widgets are rotating through the colors of the rainbow,
  consider adding repaint boundaries to those areas.

[`debugPrintMarkNeedsLayoutStacks`][]
: Enable this flag if you're seeing more layouts
  than you expect (for example, on the timeline, on a profile,
  or from a `print` statement inside a layout method).
  When enabled, the framework outputs stack traces to the console
  to explain why each render object is being marked as needing layout.
  You can use the `debugPrintStack()` function from the
  `services` library to print your own stack traces on demand,
  if this helps you.

[`debugPrintMarkNeedsPaintStacks`][]
: Similar to `debugPrintMarkNeedsLayoutStacks`,
  but for excess painting. You can use the `debugPrintStack()`
  function from the `services` library to print your own stack
  traces on demand, if this kind of approach is useful to you.

### Tracing Dart code performance

{{site.alert.note}}
  You can use the DevTools [Timeline events tab][] to perform traces.
  You can also import and export trace files into the Timeline view,
  but only files generated by DevTools.
{{site.alert.end}}

To perform custom performance traces and
measure wall/CPU time of arbitrary segments of Dart code
like Android does with [systrace][],
use `dart:developer` [Timeline][] utilities.

1. Open your source code.
1. Wrap the code you want to measure.

    <?code-excerpt "lib/perf_trace.dart"?>
    ```dart
    import 'dart:developer';

    void main() {
      Timeline.startSync('interesting function');
      // iWonderHowLongThisTakes();
      Timeline.finishSync();
    }
    ```

1. While connected to your app, open DevTools' [Timeline events tab][].
1. Select the **Dart** recording option in the **Performance settings**.
1. Perform the function you want to measure.

To ensure that the runtime performance characteristics closely match that
of your final product, run your app in [profile mode][].

## Performance overlay

{{site.alert.note}}
  You can toggle display of the performance overlay on
  your app using the **Performance Overlay** button in the
  [Flutter inspector][]. If you prefer to do it in code,
  use the following instructions.
{{site.alert.end}}

You can programmatically enable the `PerformanceOverlay`` widget by
setting the `showPerformanceOverlay` property to `true` on the
[`MaterialApp`][], [`CupertinoApp`][], or [`WidgetsApp`][]
constructor:

#### Example 10
{:.no_toc}

<?code-excerpt "lib/performance_overlay.dart (PerfOverlay)" replace="/showPerformanceOverlay: true,/[[highlight]]$&[[\/highlight]]/g"?>
```dart
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      [[highlight]]showPerformanceOverlay: true,[[/highlight]]
      title: 'My Awesome App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'My Awesome App'),
    );
  }
}
```

(If you're not using `MaterialApp`, `CupertinoApp`,
or `WidgetsApp`, you can get the same effect by wrapping your
application in a stack and putting a widget on your stack that was
created by calling [`PerformanceOverlay.allEnabled()`][].)

To learn how to interpret the graphs in the overlay,
see [The performance overlay][] in
[Profiling Flutter performance][].

## Widget alignment grid

You can programmatically overlay a
[Material Design baseline grid][] on top of your app to
help verify alignments by using the
`debugShowMaterialGrid` argument in the
[`MaterialApp` constructor][].

In non-Material applications, you can achieve a similar
effect by using a [`GridPaper`][] widget directly.

[Debugger]: {{site.url}}/tools/devtools/debugger
[Debugging]: {{site.url}}/testing/debugging
[DevTools]: {{site.url}}/tools/devtools
[DiagnosticsProperty]: {{site.api}}/flutter/foundation/DiagnosticsProperty-class.html
[Flutter inspector]: {{site.url}}/tools/devtools/inspector
[Inspector view]: {{site.url}}/tools/devtools/inspector
[Logging view]: {{site.url}}/tools/devtools/logging
[Material Design baseline grid]: {{site.material}}/foundations/layout/understanding-layout/spacing
[Profiling Flutter performance]: {{site.url}}/perf/ui-performance
[The performance overlay]: {{site.url}}/perf/ui-performance#the-performance-overlay
[Timeline events tab]: {{site.url}}/tools/devtools/performance#timeline-events-tab
[Timeline]: {{site.dart.api}}/stable/dart-developer/Timeline-class.html
[`Center`]: {{site.api}}/flutter/widgets/Center-class.html
[`CupertinoApp`]: {{site.api}}/flutter/cupertino/CupertinoApp-class.html
[`Focus`]: {{site.api}}/flutter/widgets/Focus-class.html
[`GridPaper`]: {{site.api}}/flutter/widgets/GridPaper-class.html
[`MaterialApp` constructor]: {{site.api}}/flutter/material/MaterialApp/MaterialApp.html
[`MaterialApp`]: {{site.api}}/flutter/material/MaterialApp/MaterialApp.html
[`Material`]: {{site.api}}/flutter/material/Material-class.html
[`PerformanceOverlay.allEnabled()`]: {{site.api}}/flutter/widgets/PerformanceOverlay/PerformanceOverlay.allEnabled.html
[`RenderConstrainedBox`]: {{site.api}}/flutter/rendering/RenderConstrainedBox-class.html
[`RenderPadding`]: {{site.api}}/flutter/rendering/RenderPadding-class.html
[`RenderParagraph`]: {{site.api}}/flutter/rendering/RenderParagraph-class.html
[`RenderPositionedBox`]: {{site.api}}/flutter/rendering/RenderPositionedBox-class.html
[`TextButton`]: {{site.api}}/flutter/material/TextButton-class.html
[`WidgetsApp`]: {{site.api}}/flutter/widgets/WidgetsApp-class.html
[`_InkFeatures`]: {{site.api}}/flutter/material/InkFeature-class.html
[`debugDumpApp()`]: {{site.api}}/flutter/widgets/debugDumpApp.html
[`debugDumpFocusTree()`]: {{site.api}}/flutter/widgets/debugDumpFocusTree.html
[`debugDumpLayerTree()`]: {{site.api}}/flutter/rendering/debugDumpLayerTree.html
[`debugDumpRenderTree()`]: {{site.api}}/flutter/rendering/debugDumpRenderTree.html
[`debugDumpSemanticsTree()`]: {{site.api}}/flutter/rendering/debugDumpSemanticsTree.html
[`debugFocusChanges`]: {{site.api}}/flutter/widgets/debugFocusChanges.html
[`debugLabel`]: {{site.api}}/flutter/widgets/Focus/debugLabel.html
[`debugPaintBaselinesEnabled`]: {{site.api}}/flutter/rendering/debugPaintBaselinesEnabled.html
[`debugPaintLayerBordersEnabled`]: {{site.api}}/flutter/rendering/debugPaintLayerBordersEnabled.html
[`debugPaintPointersEnabled`]: {{site.api}}/flutter/rendering/debugPaintPointersEnabled.html
[`debugPaintSizeEnabled`]: {{site.api}}/flutter/rendering/debugPaintSizeEnabled.html
[`debugPrint()`]: {{site.api}}/flutter/foundation/debugPrint.html
[`debugPrintBeginFrameBanner`]: {{site.api}}/flutter/scheduler/debugPrintBeginFrameBanner.html
[`debugPrintEndFrameBanner`]: {{site.api}}/flutter/scheduler/debugPrintEndFrameBanner.html
[`debugPrintMarkNeedsLayoutStacks`]: {{site.api}}/flutter/rendering/debugPrintMarkNeedsLayoutStacks.html
[`debugPrintMarkNeedsPaintStacks`]: {{site.api}}/flutter/rendering/debugPrintMarkNeedsPaintStacks.html
[`debugPrintScheduleFrameStacks`]: {{site.api}}/flutter/scheduler/debugPrintScheduleFrameStacks.html
[`debugRepaintRainbowEnabled`]: {{site.api}}/flutter/rendering/debugRepaintRainbowEnabled.html
[`log()`]: {{site.api}}/flutter/dart-developer/log.html
[`setState()`]: {{site.api}}/flutter/widgets/State/setState.html
[`timeDilation`]: {{site.api}}/flutter/scheduler/timeDilation.html
[debug mode]: {{site.url}}/testing/build-modes#debug
[file an issue]: {{site.github}}/flutter/devtools/issues
[frame callback]: {{site.api}}/flutter/scheduler/SchedulerBinding/addPersistentFrameCallback.html
[profile mode]: {{site.url}}/testing/build-modes#profile
[render-fill]: {{site.api}}/flutter/rendering/Layer/debugFillProperties.html
[rendering library]: {{site.api}}/flutter/rendering/rendering-library.html
[systrace]: {{site.android-dev}}/studio/profile/systrace
[widget-fill]: {{site.api}}/flutter/widgets/Widget/debugFillProperties.html
