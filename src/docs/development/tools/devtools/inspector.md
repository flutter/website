---
title: Using the Flutter inspector
description: Learn how to use the Flutter inspector to explore a Flutter app's widget tree.
---

{{site.alert.note}}
  The inspector works with all Flutter applications.
{{site.alert.end}}

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
  in a browser.
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
<dt markdown="1">**Slow Animations** ![Slow animations icon]({% asset tools/devtools/slow-animations-icon.png @path %}){:width="20px"}</dt>
<dd>Slow down animations to enable visual inspection.</dd>
<dt markdown="1">**Debug Paint** ![Debug paint mode icon]({% asset tools/devtools/debug-paint-mode-icon.png @path %}){:width="20px"}</dt>
<dd>Add visual debugging hints to the rendering
    that display borders, padding, alignment, and spacers.</dd>
<dt markdown="1">**Paint Baselines** ![Baseline painting icon]({% asset tools/devtools/paint-baselines-icon.png @path %}){:width="20px"}</dt>
<dd>Cause each RenderBox to paint a line at each
    of its text baselines.</dd>
<dt markdown="1">**Repaint Rainbow** ![Repaint rainbow icon]({% asset tools/devtools/repaint-rainbow-icon.png @path %}){:width="20px"}</dt>
<dd>Shows rotating colors on layers when repainting.</dd>
<dt markdown="1">**Invert Oversized Images** ![Invert oversized images icon]({% asset tools/devtools/invert_oversized_images_icon.png @path %}){:width="20px"}</dt>
<dd>Inverts oversized images in your running application.</dd>

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
and the sizes flow back up. For more information on how this works,
see [Understanding constraints][].

## Flutter Layout Explorer

The Flutter Layout Explorer helps you to better understand
Flutter layouts.

For an overview of what you can do with this tool, see
the Flutter Explorer video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/Jakrc3Tn_y4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

You might also find the following step-by-step article useful:

* [How to debug layout issues with the Flutter Inspector][debug-article]

[debug-article]: {{site.medium}}/flutter/how-to-debug-layout-issues-with-the-flutter-inspector-87460a7b9db

### Using the Layout Explorer

From the Flutter Inspector, select a widget. The Layout Explorer
supports both [flex layouts][] and fixed size layouts, and has
specific tooling for both kinds.

#### Flex layouts
When you select a flex widget (for example, [`Row`][], [`Column`][], [`Flex`][])
or a direct child of a flex widget, the flex layout tool will
appear in the Layout Explorer.

The Layout Explorer visualizes how [`Flex`][] widgets and their
children are laid out. The explorer identifies the main axis
and cross axis, as well as the current alignment for each
(for example, start, end, and spaceBetween).
It also shows details like flex factor, flex fit, and layout
constraints.

Additionally, the explorer shows layout constraint violations
and render overflow errors. Violated layout constraints
are colored red, and overflow errors are presented in the
standard  "yellow-tape" pattern, as you might see on a running
device. These visualizations aim to improve understanding of
why overflow errors occur as well as how to fix them.

![The Layout Explorer showing errors and device inspector]({% asset tools/devtools/layout_explorer_errors_and_device.gif @path %}){:width="100%"}

Clicking a widget in the layout explorer mirrors
the selection on the on-device inspector. **Select Widget Mode**
needs to be enabled for this. To enable it,
click on the **Select Widget Mode** button in the inspector.

![The Select Widget Mode button in the inspector]({% asset tools/devtools/select_widget_mode_devtools_alpha.png @path %})

For some properties, like flex factor, flex fit, and alignment,
you can modify the value via dropdown lists in the explorer.
When modifying a widget property, you see the new value reflected
not only in the Layout Explorer, but also on the
device running your Flutter app. The explorer animates
on property changes so that the effect of the change is clear.
Widget property changes made from the layout explorer don't
modify your source code and are reverted on hot reload.

##### Interactive Properties

Layout Explorer supports modifying [`mainAxisAlignment`][],
[`crossAxisAlignment`][], and [`FlexParentData.flex`][].
In the future, we may add support for additional properties
such as [`mainAxisSize`][], [`textDirection`][], and
[`FlexParentData.fit`][].

###### mainAxisAlignment

![The Layout Explorer changing main axis alignment]({% asset tools/devtools/layout_explorer_main_axis_alignment.gif @path %}){:width="100%"}

Supported values:

* `MainAxisAlignment.start`
* `MainAxisAlignment.end`
* `MainAxisAlignment.center`
* `MainAxisAlignment.spaceBetween`
* `MainAxisAlignment.spaceAround`
* `MainAxisAlignment.spaceEvenly`


###### crossAxisAlignment

![The Layout Explorer changing cross axis alignment]({% asset tools/devtools/layout_explorer_cross_axis_alignment.gif @path %}){:width="100%"}

Supported values:

* `CrossAxisAlignment.start`
* `CrossAxisAlignment.center`
* `CrossAxisAlignment.end`
* `CrossAxisAlignment.stretch`


###### FlexParentData.flex

![The Layout Explorer changing flex factor]({% asset tools/devtools/layout_explorer_flex.gif @path %}){:width="100%"}

Layout Explorer supports 7 flex options in the UI
(null, 0, 1, 2, 3, 4, 5), but technically the flex
factor of a flex widget’s child can be any int.

###### Flexible.fit

![The Layout Explorer changing fit]({% asset tools/devtools/layout_explorer_fit.gif @path %}){:width="100%"}

Layout Explorer supports the two different types of
[`FlexFit`][]: `loose` and `tight`.

#### Fixed size layouts
When you select a fixed size widget that is not a child
of a flex widget, fixed size layout information will appear
in the Layout Explorer. You can see size, constraint, and padding
information for both the selected widget and its nearest upstream
RenderObject.

![The Layout Explorer fixed size tool]({% asset tools/devtools/layout_explorer_fixed_layout.png @path %})

## Details Tree

Select the **Details Tree** tab to display the details tree for the
selected widget.

![The Details Tree tab]({% asset tools/devtools/details_tree_tab.png @path %})

From the details tree, you can gather useful information about a
widget's properties, render object, and children.

![The Details Tree view]({% asset tools/devtools/details_tree.png @path %})


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

You can disable this feature by passing `--no-track-widget-creation` to
the `flutter run` command.

Here are examples of what your widget tree might look like
with and without track widget creation enabled.

Track widget creation enabled (default):

![The widget tree with track widget creation enabled]({% asset tools/devtools/track_widget_creation_enabled.png @path %}){:width="100%"}

Track widget creation disabled (not recommended):

![The widget tree with track widget creation disabled]({% asset tools/devtools/track_widget_creation_disabled.png @path %}){:width="100%"}

This feature prevents otherwise-identical `const` Widgets from
being considered equal in debug builds. For more details, see
the discussion on [common problems when debugging][].

## Other resources

For a demonstration of what's generally possible with the inspector,
see the [DartConf 2018 talk][] demonstrating the IntelliJ version
of the Flutter inspector.


[`Column`]: {{site.api}}/flutter/widgets/Column-class.html
[common problems when debugging]: /docs/testing/debugging#common-problems
[core building block]: /docs/development/ui/widgets-intro
[`crossAxisAlignment`]: {{site.api}}/flutter/widgets/Flex/crossAxisAlignment.html
[DartConf 2018 talk]: https://www.youtube.com/watch?v=JIcmJNT9DNI
[debug mode]: /docs/testing/build-modes#debug
[Debugging Flutter apps]: /docs/testing/debugging
[DevTools written in Flutter]: /docs/development/tools/devtools/overview#how-do-i-try-devtools-written-in-flutter
[`Flex`]: {{site.api}}/flutter/widgets/Flex-class.html
[flex layouts]: {{site.api}}/flutter/widgets/Flex-class.html
[`FlexFit`]: {{site.api}}/flutter/widgets/FlexFit-class.html
[`FlexParentData.fit`]: {{site.api}}/flutter/rendering/FlexParentData/fit.html
[`FlexParentData.flex`]: {{site.api}}/flutter/rendering/FlexParentData/flex.html
[Flutter performance profiling]: /docs/perf/rendering/ui-performance
[`mainAxisAlignment`]: {{site.api}}/flutter/widgets/Flex/mainAxisAlignment.html
[`mainAxisSize`]: {{site.api}}/flutter/widgets/Flex/mainAxisSize.html
[`Row`]: {{site.api}}/flutter/widgets/Row-class.html
[`textDirection`]: {{site.api}}/flutter/widgets/Flex/textDirection.html
[the performance overlay]: /docs/perf/rendering/ui-performance#the-performance-overlay
[Understanding constraints]: /docs/development/ui/layout/constraints
