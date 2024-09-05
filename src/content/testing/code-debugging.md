---
title: Debug Flutter apps from code
description: >
  How to enable various debugging tools from
  your code and at the command line.
---

<?code-excerpt path-base="testing/code_debugging"?>

This guide describes which debugging features you can enable in your code.
For a full list of debugging and profiling tools, check out the
[Debugging][] page.

:::note
If you are looking for a way to use GDB to remotely debug the
Flutter engine running within an Android app process,
check out [`flutter_gdb`][].
:::

[`flutter_gdb`]: {{site.repo.engine}}/blob/main/sky/tools/flutter_gdb

## Add logging to your application

:::note
You can view logs in DevTools' [Logging view][]
or in your system console. This sections
shows how to set up your logging statements.
:::

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

### Example 1 {:.no_toc}

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

### Example 2 {:.no_toc}

<?code-excerpt "lib/app_data.dart (pass-data)"?>
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

## Set breakpoints

You can set breakpoints in DevTools' [Debugger][] or
in the built-in debugger of your IDE.

To set programmatic breakpoints:

1. Import the `dart:developer` package into the relevant file.
1. Insert programmatic breakpoints using the `debugger()` statement.
   This statement takes an optional `when` argument.
   This boolean argument sets a break when the given condition resolves to true.

   **Example 3** illustrates this.

### Example 3 {:.no_toc}

<?code-excerpt "lib/debugger.dart"?>
```dart
import 'dart:developer';

void someFunction(double offset) {
  debugger(when: offset > 30);
  // ...
}
```

## Debug app layers using flags

Each layer of the Flutter framework provides a function to dump its
current state or events to the console using the `debugPrint` property.

:::note
All of the following examples were run as macOS native apps on
a MacBook Pro M1. These will differ from any dumps your
development machine prints.
:::

{% include docs/admonitions/tip-hashCode-tree.md %}

### Print the widget tree

To dump the state of the Widgets library,
call the [`debugDumpApp()`][] function.

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

* All the widgets projected through their various build functions.
* Many widgets that don't appear in your app's source.
  The framework's widgets' build functions insert them during the build.

  The following tree, for example, shows [`_InkFeatures`][].
  That class implements part of the [`Material`][] widget.
  It doesn't appear anywhere in the code in **Example 4**.

<details>
<summary><strong>Expand to view the widget tree for Example 4</strong></summary>

{% render docs/testing/trees/widget-tree.md -%}

</details>

When the button changes from being pressed to being released,
this invokes the `debugDumpApp()` function.
It also coincides with the [`TextButton`][] object calling [`setState()`][]
and thus marking itself dirty.
This explains why a Flutter marks a specific object as "dirty".
When you review the widget tree, look for a line that resembles the following:

```plaintext
└TextButton(dirty, dependencies: [MediaQuery, _InheritedTheme, _LocalizationsScope-[GlobalKey#5880d]], state: _ButtonStyleState#ab76e)
```

If you write your own widgets, override the
[`debugFillProperties()`][widget-fill] method to add information.
Add [DiagnosticsProperty][] objects to the method's argument
and call the superclass method.
The `toString` method uses this function to fill in the widget's description.

### Print the render tree

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

<details>
<summary><strong>Expand to view the render tree for Example 5</strong></summary>

{% render docs/testing/trees/render-tree.md -%}

</details>

In the render tree for **Example 5**:

* The `RenderView`, or window size, limits all render objects up to and
  including [`RenderPositionedBox`][]`#dc1df` render object
  to the size of the screen.
  This example sets the size to `Size(800.0, 600.0)`

* The `constraints` property of each render object limits the size
  of each child. This property takes the [`BoxConstraints`][] render object as a value.
  Starting with the `RenderSemanticsAnnotations#fe6b5`, the constraint equals
  `BoxConstraints(w=800.0, h=600.0)`.

* The [`Center`][] widget created the `RenderPositionedBox#dc1df` render object
  under the `RenderSemanticsAnnotations#8187b` subtree.

* Each child under this render object has `BoxConstraints` with both
  minimum and maximum values. For example, `RenderSemanticsAnnotations#a0a4b`
  uses `BoxConstraints(0.0<=w<=800.0, 0.0<=h<=600.0)`.

* All children of the `RenderPhysicalShape#8e171` render object use
  `BoxConstraints(BoxConstraints(56.0<=w<=800.0, 28.0<=h<=600.0))`.

* The child `RenderPadding#8455f` sets a `padding` value of
  `EdgeInsets(8.0, 0.0, 8.0, 0.0)`.
  This sets a left and right padding of 8 to all subsequent children of
  this render object.
  They now have new constraints:
  `BoxConstraints(40.0<=w<=784.0, 28.0<=h<=600.0)`.

This object, which the `creator` field tells us is
probably part of the [`TextButton`][]'s definition,
sets a minimum width of 88 pixels on its contents and a
specific height of 36.0. This is the `TextButton` class implementing
the Material Design guidelines regarding button dimensions.

`RenderPositionedBox#80b8d` render object loosens the constraints again
to center the text within the button.
The [`RenderParagraph`][]#59bc2 render object picks its size based on
its contents.
If you follow the sizes back up the tree,
you see how the size of the text influences the width of all the boxes
that form the button.
All parents take their child's dimensions to size themselves.

Another way to notice this is by looking at the `relayoutBoundary`
attribute of in the descriptions of each box.
This tells you how many ancestors depend on this element's size.

For example, the innermost `RenderPositionedBox` line has a `relayoutBoundary=up13`.
This means that when Flutter marks the `RenderConstrainedBox` as dirty,
it also marks box's 13 ancestors as dirty because the new dimensions
might affect those ancestors.

To add information to the dump if you write your own render objects,
override [`debugFillProperties()`][render-fill].
Add [DiagnosticsProperty][] objects to the method's argument
then call the superclass method.

### Print the layer tree

To debug a compositing issue, use [`debugDumpLayerTree()`][].

#### Example 6: Call `debugDumpLayerTree()`

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
            debugDumpLayerTree();
          },
          child: const Text('Dump Layer Tree'),
        ),
      ),
    );
  }
}
```

<details>
<summary><strong>Expand to view the output of layer tree for Example 6</strong></summary>

{% render docs/testing/trees/layer-tree.md -%}

</details>

The `RepaintBoundary` widget creates:

1. A `RenderRepaintBoundary` RenderObject in the render tree
   as shown in the **Example 5** results.

   ```plaintext
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

   ```plaintext
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

### Print the focus tree

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

<details>
<summary><strong>Expand to view the focus tree for Example 7</strong></summary>

{% render docs/testing/trees/focus-tree.md -%}

</details>

### Print the semantics tree

The `debugDumpSemanticsTree()` function prints the semantic tree for the app.

The Semantics tree is presented to the system accessibility APIs.
To obtain a dump of the Semantics tree:

1. Enable accessibility using a system accessibility tool
   or the `SemanticsDebugger`
1. Use the [`debugDumpSemanticsTree()`][] function.

#### Example 8: Call `debugDumpSemanticsTree()`

<?code-excerpt "lib/dump_semantic_tree.dart"?>
```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
                if (kDebugMode) {
                  print('Clicked!');
                }
              },
              child: const Text('Click Me!', style: TextStyle(fontSize: 56))),
        ),
      ),
    );
  }
}
```

<details>
<summary><strong>Expand to view the semantic tree for Example 8</strong></summary>

{% render docs/testing/trees/semantic-tree.md -%}

</details>

### Print event timings

If you want to find out where your events happen relative to the frame's
begin and end, you can set prints to log these events.
To print the beginning and end of the frames to the console,
toggle the [`debugPrintBeginFrameBanner`][]
and the [`debugPrintEndFrameBanner`][].

**The print frame banner log for Example 1**

```plaintext
I/flutter : ▄▄▄▄▄▄▄▄ Frame 12         30s 437.086ms ▄▄▄▄▄▄▄▄
I/flutter : Debug print: Am I performing this work more than once per frame?
I/flutter : Debug print: Am I performing this work more than once per frame?
I/flutter : ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
```

To print the call stack causing the current frame to be scheduled,
use the [`debugPrintScheduleFrameStacks`][] flag.

## Debug layout issues

To debug a layout problem using a GUI, set
[`debugPaintSizeEnabled`][] to `true`.
This flag can be found in the `rendering` library.
You can enable it at any time and affects all painting while `true`.
Consider adding it to the top of your `void main()` entry point.

#### Example 9

See an example in the following code:

<?code-excerpt "lib/debug_flags.dart (debug-paint-size-enabled)"?>
```dart
// Add import to the Flutter rendering library.
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(const MyApp());
}
```

When enabled, Flutter displays the following changes to your app:

* Displays all boxes in a bright teal border.
* Displays all padding as a box with a faded blue fill and blue border
  around the child widget.
* Displays all alignment positioning with yellow arrows.
* Displays all spacers in gray, when they have no child.

The [`debugPaintBaselinesEnabled`][] flag
does something similar but for objects with baselines.
The app displays the baseline for alphabetic characters in bright green
and the baseline for ideographic characters in orange.
Alphabetic characters "sit" on the alphabetic baseline,
but that baseline "cuts" through the bottom of [CJK characters][cjk].
Flutter positions the ideographic baseline at the very bottom of the text line.

The [`debugPaintPointersEnabled`][] flag turns on a special mode that
highlights any objects that you tap in teal.
This can help you determine if an object fails to hit test.
This might happen if the object falls outside the bounds of its parent
and thus not considered for hit testing in the first place.

If you're trying to debug compositor layers, consider using the following flags.

* Use the [`debugPaintLayerBordersEnabled`][] flag to find the boundaries
  of each layer. This flag results in outlining each layer's bounds in orange.

* Use the [`debugRepaintRainbowEnabled`][] flag to display a repainted layer.
  Whenever a layer repaints, it overlays with a rotating set of colors.

Any function or method in the Flutter framework that starts with
`debug...` only works in [debug mode][].

[cjk]: https://en.wikipedia.org/wiki/CJK_characters

## Debug animation issues

:::note
To debug animations with the least effort, slow them down.
To slow down the animation,
click **Slow Animations** in DevTools' [Inspector view][].
This reduces the animation to 20% speed.
If you want more control over the amount of slowness,
use the following instructions.
:::

Set the [`timeDilation`][] variable (from the `scheduler`
library) to a number greater than 1.0, for instance, 50.0.
It's best to only set this once on app startup. If you
change it on the fly, especially if you reduce it while
animations are running, it's possible that the framework
will observe time going backwards, which will probably
result in asserts and generally interfere with your efforts.

## Debug performance issues

:::note
You can achieve similar results to some of these debug
flags using [DevTools][]. Some of the debug flags provide little benefit.
If you find a flag with functionality you would like to add to [DevTools][],
[file an issue][].
:::

Flutter provides a wide variety of top-level properties and functions
to help you debug your app at various points along the
development cycle.
To use these features, compile your app in debug mode.

The following list highlights some of flags and one function from the
[rendering library][] for debugging performance issues.

[`debugDumpRenderTree()`][]
: To dump the rendering tree to the console,
  call this function when not in a layout or repaint phase.

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
: To display the boundaries of each layer, set this property to `true`.
  When set, each layer paints a box around its boundary.

[`debugRepaintRainbowEnabled`][]
: To display a colored border around each widget, set this property to `true`.
  These borders change color as the app user scrolls in the app.
  To set this flag, add `debugRepaintRainbowEnabled = true;` as a top-level
  property in your app.
  If any static widgets rotate through colors after setting this flag,
  consider adding repaint boundaries to those areas.

[`debugPrintMarkNeedsLayoutStacks`][]
: To determine if your app creates more layouts than expected,
  set this property to `true`.
  This layout issue could happen on the timeline, on a profile,
  or from a `print` statement inside a layout method.
  When set, the framework outputs stack traces to the console
  to explain why your app marks each render object to be laid out.

[`debugPrintMarkNeedsPaintStacks`][]
: To determine if your app paints more layouts than expected,
  set this property to `true`.

You can generate stack traces on demand as well.
To print your own stack traces, add the `debugPrintStack()`
function to your app.

### Trace Dart code performance

:::note
You can use the DevTools [Timeline events tab][] to perform traces.
You can also import and export trace files into the Timeline view,
but only files generated by DevTools.
:::

To perform custom performance traces and
measure wall or CPU time of arbitrary segments of Dart code
like Android does with [systrace][],
use `dart:developer` [Timeline][] utilities.

1. Open your source code.
1. Wrap the code you want to measure in `Timeline` methods.

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

### Add performance overlay

:::note
You can toggle display of the performance overlay on
your app using the **Performance Overlay** button in the
[Flutter inspector][]. If you prefer to do it in code,
use the following instructions.
:::

To enable the `PerformanceOverlay` widget in your code,
set the `showPerformanceOverlay` property to `true` on the
[`MaterialApp`][], [`CupertinoApp`][], or [`WidgetsApp`][]
constructor:

#### Example 10

<?code-excerpt "lib/performance_overlay.dart (show-overlay)"?>
```dart
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: true,
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
check out [The performance overlay][] in
[Profiling Flutter performance][].

## Add widget alignment grid

To add an overlay to a [Material Design baseline grid][] on your app to
help verify alignments, add the `debugShowMaterialGrid` argument in the
[`MaterialApp` constructor][].

To add an overlay to non-Material applications, add a [`GridPaper`][] widget.

[Debugger]: /tools/devtools/debugger
[Debugging]: /testing/debugging
[DevTools]: /tools/devtools
[DiagnosticsProperty]: {{site.api}}/flutter/foundation/DiagnosticsProperty-class.html
[Flutter inspector]: /tools/devtools/inspector
[Inspector view]: /tools/devtools/inspector
[Logging view]: /tools/devtools/logging
[Material Design baseline grid]: {{site.material}}/foundations/layout/understanding-layout/spacing
[Profiling Flutter performance]: /perf/ui-performance
[The performance overlay]: /perf/ui-performance#the-performance-overlay
[Timeline events tab]: /tools/devtools/performance#timeline-events-tab
[Timeline]: {{site.dart.api}}/stable/dart-developer/Timeline-class.html
[`Center`]: {{site.api}}/flutter/widgets/Center-class.html
[`CupertinoApp`]: {{site.api}}/flutter/cupertino/CupertinoApp-class.html
[`Focus`]: {{site.api}}/flutter/widgets/Focus-class.html
[`GridPaper`]: {{site.api}}/flutter/widgets/GridPaper-class.html
[`MaterialApp` constructor]: {{site.api}}/flutter/material/MaterialApp/MaterialApp.html
[`MaterialApp`]: {{site.api}}/flutter/material/MaterialApp/MaterialApp.html
[`Material`]: {{site.api}}/flutter/material/Material-class.html
[`PerformanceOverlay.allEnabled()`]: {{site.api}}/flutter/widgets/PerformanceOverlay/PerformanceOverlay.allEnabled.html
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
[debug mode]: /testing/build-modes#debug
[file an issue]: {{site.github}}/flutter/devtools/issues
[frame callback]: {{site.api}}/flutter/scheduler/SchedulerBinding/addPersistentFrameCallback.html
[profile mode]: /testing/build-modes#profile
[render-fill]: {{site.api}}/flutter/rendering/Layer/debugFillProperties.html
[rendering library]: {{site.api}}/flutter/rendering/rendering-library.html
[systrace]: {{site.android-dev}}/studio/profile/systrace
[widget-fill]: {{site.api}}/flutter/widgets/Widget/debugFillProperties.html
[`BoxConstraints`]: {{site.api}}/flutter/rendering/BoxConstraints-class.html
