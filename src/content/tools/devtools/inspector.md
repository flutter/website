---
title: Use the Flutter inspector
description: Learn how to use the Flutter inspector to explore a Flutter app's widget tree.
---

<?code-excerpt path-base="visual_debugging/"?>

:::note
The inspector works with all Flutter applications.
:::

## What is it?

The Flutter widget inspector is a powerful tool for visualizing and
exploring Flutter widget trees. The Flutter framework uses widgets
as the core building block for anything from controls
(such as text, buttons, and toggles),
to layout (such as centering, padding, rows, and columns).
The inspector helps you visualize and explore Flutter widget
trees, and can be used for the following:

* understanding existing layouts
* diagnosing layout issues

![Screenshot of the Flutter inspector window](/assets/images/docs/tools/devtools/inspector_screenshot.png){:width="100%"}

## Get started

To debug a layout issue, run the app in [debug mode][] and
open the inspector by clicking the **Flutter Inspector**
tab on the DevTools toolbar.

:::note
You can still access the Flutter inspector directly from
Android Studio/IntelliJ, but you might prefer the
more spacious view when running it from DevTools
in a browser.
:::

### Debugging layout issues visually

The following is a guide to the features available in the
inspector's toolbar. When space is limited, the icon is
used as the visual version of the label.

![Select widget mode icon](/assets/images/docs/tools/devtools/select-widget-mode-icon.png){:width="20px"} **Select widget mode**
: Enable this button in order to select
  a widget on the device to inspect it. To learn more,
  check out [Inspecting a widget](#inspecting-a-widget).

![Refresh tree icon](/assets/images/docs/tools/devtools/refresh-tree-icon.png){:width="20px"} **Refresh tree**
: Reload the current widget info.

![Slow animations icon](/assets/images/docs/tools/devtools/slow-animations-icon.png){:width="20px"} **[Slow animations][]**
: Run animations 5 times slower to help fine-tune them.

![Show guidelines mode icon](/assets/images/docs/tools/devtools/debug-paint-mode-icon.png){:width="20px"} **[Show guidelines][]**
: Overlay guidelines to assist with fixing layout issues.

![Show baselines icon](/assets/images/docs/tools/devtools/paint-baselines-icon.png){:width="20px"} **[Show baselines][]**
: Show baselines, which are used for aligning text.
  Can be useful for checking if text is aligned.

![Highlight repaints icon](/assets/images/docs/tools/devtools/repaint-rainbow-icon.png){:width="20px"} **[Highlight repaints][]**
: Show borders that change color when elements repaint.
  Useful for finding unnecessary repaints.

![Highlight oversized images icon](/assets/images/docs/tools/devtools/invert_oversized_images_icon.png){:width="20px"} **[Highlight oversized images][]**
: Highlights images that are using too much memory
  by inverting colors and flipping them.

[Slow animations]: #slow-animations
[Show guidelines]: #show-guidelines
[Show baselines]: #show-baselines
[Highlight repaints]: #highlight-repaints
[Highlight oversized images]: #highlight-oversized-images

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

{% ytEmbed 'Jakrc3Tn_y4', 'DevTools Layout Explorer' %}

You might also find the following step-by-step article useful:

* [How to debug layout issues with the Flutter Inspector][debug-article]

[debug-article]: {{site.flutter-medium}}/how-to-debug-layout-issues-with-the-flutter-inspector-87460a7b9db

### Use the Layout Explorer

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

![The Layout Explorer showing errors and device inspector](/assets/images/docs/tools/devtools/layout_explorer_errors_and_device.gif){:width="100%"}

Clicking a widget in the layout explorer mirrors
the selection on the on-device inspector. **Select Widget Mode**
needs to be enabled for this. To enable it,
click on the **Select Widget Mode** button in the inspector.

![The Select Widget Mode button in the inspector](/assets/images/docs/tools/devtools/select_widget_mode_button.png)

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

![The Layout Explorer changing main axis alignment](/assets/images/docs/tools/devtools/layout_explorer_main_axis_alignment.gif){:width="100%"}

Supported values:

* `MainAxisAlignment.start`
* `MainAxisAlignment.end`
* `MainAxisAlignment.center`
* `MainAxisAlignment.spaceBetween`
* `MainAxisAlignment.spaceAround`
* `MainAxisAlignment.spaceEvenly`

###### crossAxisAlignment

![The Layout Explorer changing cross axis alignment](/assets/images/docs/tools/devtools/layout_explorer_cross_axis_alignment.gif){:width="100%"}

Supported values:

* `CrossAxisAlignment.start`
* `CrossAxisAlignment.center`
* `CrossAxisAlignment.end`
* `CrossAxisAlignment.stretch`

###### FlexParentData.flex

![The Layout Explorer changing flex factor](/assets/images/docs/tools/devtools/layout_explorer_flex.gif){:width="100%"}

Layout Explorer supports 7 flex options in the UI
(null, 0, 1, 2, 3, 4, 5), but technically the flex
factor of a flex widget's child can be any int.

###### Flexible.fit

![The Layout Explorer changing fit](/assets/images/docs/tools/devtools/layout_explorer_fit.gif){:width="100%"}

Layout Explorer supports the two different types of
[`FlexFit`][]: `loose` and `tight`.

#### Fixed size layouts

When you select a fixed size widget that is not a child
of a flex widget, fixed size layout information will appear
in the Layout Explorer. You can see size, constraint, and padding
information for both the selected widget and its nearest upstream
RenderObject.

![The Layout Explorer fixed size tool](/assets/images/docs/tools/devtools/layout_explorer_fixed_layout.png){:width="100%"}

## Visual debugging

The Flutter Inspector provides several options for visually debugging your app.

![Inspector visual debugging options](/assets/images/docs/tools/devtools/visual_debugging_options.png){:width="100%"}

### Slow animations

When enabled, this option runs animations 5 times slower for easier visual
inspection.
This can be useful if you want to carefully observe and tweak an animation that
doesn't look quite right.

This can also be set in code:

<?code-excerpt "lib/slow_animations.dart"?>
```dart
import 'package:flutter/scheduler.dart';

void setSlowAnimations() {
  timeDilation = 5.0;
}
```

This slows the animations by 5x.

#### See also

The following links provide more info.

* [Flutter documentation: timeDilation property]({{site.api}}/flutter/scheduler/timeDilation.html)

The following screen recordings show before and after slowing an animation.

![Screen recording showing normal animation speed](/assets/images/docs/tools/devtools/debug-toggle-slow-animations-disabled.gif)
![Screen recording showing slowed animation speed](/assets/images/docs/tools/devtools/debug-toggle-slow-animations-enabled.gif)

### Show guidelines

This feature draws guidelines over your app that display render boxes, alignments,
paddings, scroll views, clippings and spacers.

This tool can be used for better understanding your layout. For instance,
by finding unwanted padding or understanding widget alignment.

You can also enable this in code:

<?code-excerpt "lib/layout_guidelines.dart"?>
```dart
import 'package:flutter/rendering.dart';

void showLayoutGuidelines() {
  debugPaintSizeEnabled = true;
}
```

#### Render boxes

Widgets that draw to the screen create a [render box][], the
building blocks of Flutter layouts. They're shown with a bright blue border:

![Screenshot of render box guidelines](/assets/images/docs/tools/devtools/debug-toggle-guideline-render-box.png)

#### Alignments

Alignments are shown with yellow arrows. These arrows show the vertical
and horizontal offsets of a widget relative to its parent.
For example, this button's icon is shown as being centered by the four arrows:

![Screenshot of alignment guidelines](/assets/images/docs/tools/devtools/debug-toggle-guidelines-alignment.png)

#### Padding

Padding is shown with a semi-transparent blue background:

![Screenshot of padding guidelines](/assets/images/docs/tools/devtools/debug-toggle-guidelines-padding.png)

#### Scroll views

Widgets with scrolling contents (such as list views) are shown with green arrows:

![Screenshot of scroll view guidelines](/assets/images/docs/tools/devtools/debug-toggle-guidelines-scroll.png)

#### Clipping

Clipping, for example when using the [ClipRect widget][], are shown
with a dashed pink line with a scissors icon:

[ClipRect widget]: {{site.api}}/flutter/widgets/ClipRect-class.html

![Screenshot of clip guidelines](/assets/images/docs/tools/devtools/debug-toggle-guidelines-clip.png)

#### Spacers

Spacer widgets are shown with a grey background,
such as this `SizedBox` without a child:

![Screenshot of spacer guidelines](/assets/images/docs/tools/devtools/debug-toggle-guidelines-spacer.png)

### Show baselines

This option makes all baselines visible.
Baselines are horizontal lines used to position text.

This can be useful for checking whether text is precisely aligned vertically.
For example, the text baselines in the following screenshot are slightly misaligned:

![Screenshot with show baselines enabled](/assets/images/docs/tools/devtools/debug-toggle-guidelines-baseline.png)

The [Baseline][] widget can be used to adjust baselines.

[Baseline]: {{site.api}}/flutter/widgets/Baseline-class.html

A line is drawn on any [render box][] that has a baseline set;
alphabetic baselines are shown as green and ideographic as yellow.

You can also enable this in code:

<?code-excerpt "lib/show_baselines.dart"?>
```dart
import 'package:flutter/rendering.dart';

void showBaselines() {
  debugPaintBaselinesEnabled = true;
}
```

### Highlight repaints

This option draws a border around all [render boxes][]
that changes color every time that box repaints.

[render boxes]: {{site.api}}/flutter/rendering/RenderBox-class.html

This rotating rainbow of colors is useful for finding parts of your app
that are repainting too often and potentially harming performance.

For example, one small animation could be causing an entire page
to repaint on every frame.
Wrapping the animation in a [RepaintBoundary widget][] limits
the repainting to just the animation.

[RepaintBoundary widget]: {{site.api}}/flutter/widgets/RepaintBoundary-class.html

Here the progress indicator causes its container to repaint:

<?code-excerpt "lib/highlight_repaints.dart (everything-repaints)"?>
```dart
class EverythingRepaintsPage extends StatelessWidget {
  const EverythingRepaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repaint Example')),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
```

![Screen recording of a whole screen repainting](/assets/images/docs/tools/devtools/debug-toggle-guidelines-repaint-1.gif)

Wrapping the progress indicator in a `RepaintBoundary` causes
only that section of the screen to repaint:

<?code-excerpt "lib/highlight_repaints.dart (area-repaints)"?>
```dart
class AreaRepaintsPage extends StatelessWidget {
  const AreaRepaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repaint Example')),
      body: const Center(
        child: RepaintBoundary(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
```

![Screen recording of a just a progress indicator repainting](/assets/images/docs/tools/devtools/debug-toggle-guidelines-repaint-2.gif)

`RepaintBoundary` widgets have tradeoffs. They can help with performance,
but they also have an overhead of creating a new canvas,
which uses additional memory.

You can also enable this option in code:

<?code-excerpt "lib/highlight_repaints.dart (toggle)"?>
```dart
import 'package:flutter/rendering.dart';

void highlightRepaints() {
  debugRepaintRainbowEnabled = true;
}
```

### Highlight oversized images

This option highlights images that are too large by both inverting their colors
and flipping them vertically:

![A highlighted oversized image](/assets/images/docs/tools/devtools/debug-toggle-guidelines-oversized.png)

The highlighted images use more memory than is required;
for example, a large 5MB image displayed at 100 by 100 pixels.

Such images can cause poor performance, especially on lower-end devices
and when you have many images, as in a list view,
this performance hit can add up.
Information about each image is printed in the debug console:

```console
dash.png has a display size of 213×392 but a decode size of 2130×392, which uses an additional 2542KB.
```

Images are deemed too large if they use at least 128KB more than required.

#### Fixing images

Wherever possible, the best way to fix this problem is resizing
the image asset file so it's smaller.

If this isn't possible, you can use the `cacheHeight` and `cacheWidth`
parameters on the `Image` constructor:

<?code-excerpt "lib/oversized_images.dart (resized-image)"?>
```dart
class ResizedImage extends StatelessWidget {
  const ResizedImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'dash.png',
      cacheHeight: 213,
      cacheWidth: 392,
    );
  }
}
```

This makes the engine decode this image at the specified size,
and reduces memory usage (decoding and storage is still more expensive
than if the image asset itself was shrunk).
The image is rendered to the constraints of the layout or width and height
regardless of these parameters.

This property can also be set in code:

<?code-excerpt "lib/oversized_images.dart (toggle)"?>
```dart
void showOversizedImages() {
  debugInvertOversizedImages = true;
}
```

#### More information

You can learn more at the following link:

* [Flutter documentation: debugInvertOversizedImages]({{site.api}}/flutter/painting/debugInvertOversizedImages.html)

[render box]: {{site.api}}/flutter/rendering/RenderBox-class.html

## Details Tree

Select the **Widget Details Tree** tab to display the details tree for the
selected widget. From here, you can gather useful information about a
widget's properties, render object, and children.

![The Details Tree view](/assets/images/docs/tools/devtools/inspector_details_tree.png){:width="100%"}

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

![The widget tree with track widget creation enabled](/assets/images/docs/tools/devtools/track_widget_creation_enabled.png){:width="100%"}

Track widget creation disabled (not recommended):

![The widget tree with track widget creation disabled](/assets/images/docs/tools/devtools/track_widget_creation_disabled.png){:width="100%"}

This feature prevents otherwise-identical `const` Widgets from
being considered equal in debug builds. For more details, see
the discussion on [common problems when debugging][].

## Inspector settings

![The Flutter Inspector Settings dialog](/assets/images/docs/tools/devtools/flutter_inspector_settings.png){:width="100%"}

### Enable hover inspection

Hovering over any widget displays its properties and values.

Toggling this value enables or disables the hover inspection functionality.

### Package directories

By default, DevTools limits the widgets displayed in the widget tree
to those from the project's root directory, and those from Flutter. This
filtering only applies to the widgets in the Inspector Widget Tree (left side
of the Inspector)—not the Widget Details Tree (right side of the Inspector
in the same tab view as the Layout Explorer).
In the Widget Details Tree,
you can see all widgets in the tree from all packages.

In order to show other widgets,
a parent directory of theirs must
be added to the Package Directories.

For example, consider the following directory structure:

```plaintext
project_foo
  pkgs
    project_foo_app
    widgets_A
    widgets_B
```

Running your app from `project_foo_app` displays only widgets from
`project_foo/pkgs/project_foo_app` in the widget inspector tree.

To show widgets from `widgets_A` in the widget tree,
add `project_foo/pkgs/widgets_A` to the package directories.

To display _all_ widgets from your project root in the widget tree,
add `project_foo` to the package directories.

Changes to your package directories persist the next time the
widget inspector is opened for the app.

## Other resources

For a demonstration of what's generally possible with the inspector,
see the [DartConf 2018 talk][] demonstrating the IntelliJ version
of the Flutter inspector.

To learn how to visually debug layout issues
using DevTools, check out a guided
[Flutter Inspector tutorial][inspector-tutorial].

[`Column`]: {{site.api}}/flutter/widgets/Column-class.html
[common problems when debugging]: /testing/debugging
[`crossAxisAlignment`]: {{site.api}}/flutter/widgets/Flex/crossAxisAlignment.html
[DartConf 2018 talk]: {{site.yt.watch}}?v=JIcmJNT9DNI
[debug mode]: /testing/build-modes#debug
[`Flex`]: {{site.api}}/flutter/widgets/Flex-class.html
[flex layouts]: {{site.api}}/flutter/widgets/Flex-class.html
[`FlexFit`]: {{site.api}}/flutter/rendering/FlexFit.html
[`FlexParentData.fit`]: {{site.api}}/flutter/rendering/FlexParentData/fit.html
[`FlexParentData.flex`]: {{site.api}}/flutter/rendering/FlexParentData/flex.html
[`mainAxisAlignment`]: {{site.api}}/flutter/widgets/Flex/mainAxisAlignment.html
[`mainAxisSize`]: {{site.api}}/flutter/widgets/Flex/mainAxisSize.html
[`Row`]: {{site.api}}/flutter/widgets/Row-class.html
[`textDirection`]: {{site.api}}/flutter/widgets/Flex/textDirection.html
[Understanding constraints]: /ui/layout/constraints
[inspector-tutorial]: {{site.medium}}/@fluttergems/mastering-dart-flutter-devtools-flutter-inspector-part-2-of-8-bbff40692fc7
