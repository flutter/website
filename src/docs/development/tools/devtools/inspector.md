---
title: Using the Flutter inspector
description: Learn how to use the Flutter inspector to explore a Flutter app's widget tree.
---

## What is it?

The Flutter widget inspector is a powerful tool for visualizing and
exploring Flutter widget trees. The Flutter framework uses widgets
as the [core building block][] for anything from controls
(such as text, buttons, and toggles),
to layout (such as centering, padding, rows, and columns).
The inspector helps you visualize and explore Flutter widget
trees, and can be used for the following:

* understanding existing layouts
* diagnosing layout issues

![Screenshot of the Flutter inspector window]({% asset tools/devtools/inspector_screenshot.png @path %}){:width="100%"}

## Get started

To debug a layout issue, run the app in [debug mode][] and
open the inspector by clicking the **Flutter Inspector**
tab on the DevTools toolbar.

{{site.alert.note}}
  You can still access the Flutter inspector directly from
  Android Studio/IntelliJ, but you might prefer the
  more spacious view when running it from DevTools
  in a browser. Also note that the UI for the inspector
  varies slightly between these environments. This page
  describes the UI for the DevTools version of the inspector.
{{site.alert.end}}

### Debugging layout issues visually

The following is a guide to the features available in the
inspector's toolbar. When space is limited, the icon is
used as the visual version of the label.

<dl markdown="1">
<dt markdown="1">**Select widget mode** ![Select widget mode icon]({% asset tools/devtools/select-widget-mode-icon.png @path %}){:width="20px"}</dt>
<dd markdown="1">Enable this button in order to select
    a widget on the device to inspect it. For more information,
    see [Inspecting a widget](#inspecting-a-widget).
<dt markdown="1">**Refresh tree** ![Refresh tree icon]({% asset tools/devtools/refresh-tree-icon.png @path %}){:width="20px"}</dt>
<dd>Reload the current widget info.</dd>
<dt markdown="1">**Performance Overlay** ![Performance overlay icon]({% asset tools/devtools/performance-overlay-icon.png @path %}){:width="20px"}</dt>
<dd markdown="1">Toggle display of performance graphs for the
    GPU & CPU threads. For more information on interpreting
    these graphs, see [The performance overlay][] in
    [Flutter performance profiling][].
<dt markdown="1">**iOS** ![Toggle platform icon]({% asset tools/devtools/toggle-platform-icon.png @path %}){:width="20px"}</dt>
<dd>Toggle rendering and gesture behaviors between Android
    and iOS.</dd>
<dt markdown="1">**Debug Paint** ![Debug paint mode icon]({% asset tools/devtools/debug-paint-mode-icon.png @path %}){:width="20px"}</dt>
<dd>Add visual debugging hints to the rendering
    that display borders, padding, alignment, and spacers.</dd>
<dt markdown="1">**Paint Baselines** ![Baseline painting icon]({% asset tools/devtools/paint-baselines-icon.png @path %}){:width="20px"}</dt>
<dd>Cause each RenderBox to paint a line at each
    of its text baselines.</dd>
<dt markdown="1">**Slow Animations** ![Slow animations icon]({% asset tools/devtools/slow-animations-icon.png @path %}){:width="20px"}</dt>
<dd>Slow down animations to enable visual inspection.</dd>
<dt markdown="1">**Repaint Rainbow** ![Repaint rainbow icon]({% asset tools/devtools/repaint-rainbow-icon.png @path %}){:width="20px"}</dt>
<dd>Shows rotating colors on layers when repainting.</dd>
<dt markdown="1">**Debug Mode Banner** ![Debug mode banner icon]({% asset tools/devtools/debug-mode-banner-icon.png @path %}){:width="20px"}</dt>
<dd>Toggles display of the debug banner even when
    running a debug build.</dd>

## Inspecting a widget

You can browse the interactive widget tree to view nearby
widgets and see their field values.

To locate individual UI elements in the widget tree,
click the **Select Widget Mode** button in the toolbar.
This puts the app on the device into a "widget select" mode.
Click any widget in the app's UI; this selects the widget on the
app's screen, and scrolls the widget tree to the corresponding node.
Toggle the **Select Widget Mode** button again to exit
widget select mode.

When debugging layout issues, the key fields to look at are the
`size` and `constraints` fields. The constraints flow down the tree,
and the sizes flow back up.

## Track widget creation

Part of the functionality of the Flutter inspector is based on
instrumenting the application code in order to better understand
the source locations where widgets are created. The source
instrumentation allows the Flutter inspector to present the
widget tree in a manner similar to how the UI was defined
in your source code. Without it, the tree of nodes in the 
widget tree are much deeper, and it can be more difficult to
understand how the runtime widget hierarchy corresponds to
your application's UI.

When launching an application from an IDE, the source
instrumentation happens by default. For command line launches,
you need to opt-in to the source instrumentation. To do this,
run the app with the `--track-widget-creation` flag:

```
flutter run --track-widget-creation
```

If you launch without the flag, you can still use the
inspector&mdash;you'll see an inline, dismissable reminder
message about using the source instrumentation flag.

Here are examples of what your widget tree might look like
with and without track widget creation enabled.

Track widget creation enabled (**recommended**):

![The widget tree with track widget creation enabled]({% asset tools/devtools/track_widget_creation_enabled.png @path %})

Track widget creation disabled (**not** recommended):

![The widget tree with track widget creation disabled]({% asset tools/devtools/track_widget_creation_disabled.png @path %})

## Other resources

For a demonstration of what's generally possible with the inspector,
see the [DartConf 2018 talk][] demonstrating the IntelliJ version
of the Flutter inspector.


[DartConf 2018 talk]: https://www.youtube.com/watch?v=JIcmJNT9DNI
[core building block]: /docs/development/ui/widgets-intro
[Debugging Flutter apps]: /docs/testing/debugging
[The performance overlay]:/docs/testing/ui-performance#the-performance-overlay
[Flutter performance profiling]: /docs/testing/ui-performance
[debug mode]: /docs/testing/build-modes#debug
