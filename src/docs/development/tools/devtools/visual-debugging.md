---
title: Visual debugging
description: A guide to Flutter's visual debugging functionality.
---

The Flutter Inspector provides several options for visually debugging your app.
These are the options available from the inspector within the DevTools.

## Slow Animations

When enabled, this option runs animations 5 times slower for easier visual
inspection.
This can be useful if you want to carefully observe and tweak an animation that
doesn’t look quite right.

This can also be set in code:

```dart
import 'package:flutter/scheduler.dart' 

timeDilation = 5.0;
```
 
This will slow the animations by 5x.

### See also

* [Flutter documentation: timeDilation property](https://api.flutter.dev/flutter/scheduler/timeDilation.html) 

### Example

![Screen recording showing normal animation speed]({% asset tools/devtools/debug-toggle-slow-animations-disabled.gif @path %})
![Screen recording showing slowed animation speed]({% asset tools/devtools/debug-toggle-slow-animations-enabled.gif @path %})

## Show Guidelines

This option draws guidelines on your app which show render boxes, alignments,
paddings, scroll views, clippings and spacers.

This tool can be used for better understanding your layout, for instance
finding unwanted paddings or understanding how widgets are being aligned.

You can also enable this in code:

```dart
debugPaintSizeEnabled = true;
```

### Render Boxes

Widgets that draw to the screen create a [render box][]; they’re the 
building blocks of Flutter layouts. They’re shown with a bright blue border:

![Screenshot of render box guidelines]({% asset tools/devtools/debug-toggle-guideline-render-box.png @path %})


### Alignments

Alignments are shown with yellow arrows. These arrows show the vertical
and horizontal offsets of a widget relative to its parent.
For example this button’s icon is shown as being centered by the four arrows:

![Screenshot of alignment guidelines]({% asset tools/devtools/debug-toggle-guidelines-alignment.png @path %})

### Paddings

Paddings are shown with a semi-transparent blue background:

![Screenshot of padding guidelines]({% asset tools/devtools/debug-toggle-guidelines-padding.png @path %})

### Scroll views

Widgets with scrolling contents such as list views are shown with green arrows:

![Screenshot of scroll view guidelines]({% asset tools/devtools/debug-toggle-guidelines-scroll.png @path %})

### Clipping

Clippings, such as when using the [ClipRect widget][], are shown
with a dashed pink line with a scissors icon:

[ClipRect widget]: https://api.flutter.dev/flutter/widgets/ClipRect-class.html

![Screenshot of clip guidelines]({% asset tools/devtools/debug-toggle-guidelines-clip.png @path %})

### Spacers

Spacer widgets are shown with a grey background,
such as this SizedBox without a child:

![Screenshot of spacer guidelines]({% asset tools/devtools/debug-toggle-guidelines-spacer.png @path %})

## Show Baselines

This option makes all baselines visible.
Baselines are horizontal lines that are used to position text.

This can be useful for checking whether text is precisely aligned vertically.
For example, here the text baselines are slightly misaligned:

![Screenshot with show baselines enabled]({% asset tools/devtools/debug-toggle-guidelines-baseline.png @path %})

The [Baseline][] widget can be used to adjust baselines.

[Baseline]: https://api.flutter.dev/flutter/widgets/Baseline-class.html

A line will be drawn on any [render box][] which has a baseline set.
Alphabetic baselines are shown as green and ideographic as yellow.

You can also enable this in code:

```dart
debugPaintBaselinesEnabled = true;
```
## Highlight Repaints

This option draws a border around all [render boxes][]
which changes color every time that box repaints.

[render boxes]: https://api.flutter.dev/flutter/rendering/RenderBox-class.html

This rotating rainbow of colors is useful for finding parts of your app
that are repainting too often and potentially harming performance.

For example, one small animation could be causing an entire page
to repaint on every frame.
Wrapping the animation in a [RepaintBoundary widget][] would limit
the repainting to just the animation.

[RepaintBoundary widget]: https://api.flutter.dev/flutter/widgets/RepaintBoundary-class.html

Here the progress indicator causing its container to repaint:

```dart
Scaffold(
  appBar: AppBar(title: Text('Repaint Example')),
  body: Center(child: CircularProgressIndicator()),
);
```

![Screen recording of a whole screen repainting]({% asset tools/devtools/debug-toggle-guidelines-repaint-1.gif @path %})

Wrapping the progress indicator in a `RepaintBoundary` causes
only that section of the screen to repaint:

```dart
Scaffold(
  appBar: AppBar(title: Text('Repaint Example')),
  body: Center(
    child: RepaintBoundary(
      child: CircularProgressIndicator(),
    ),
  ),
);
```

![Screen recording of a just a progress indicator repainting]({% asset tools/devtools/debug-toggle-guidelines-repaint-2.gif @path %})

`RepaintBoundary` widgets have tradeoffs. They can help with performance,
but they also have an overhead of creating a new canvas,
which uses additional memory.

You can also enable this option in code:

```dart
debugRepaintRainbowEnabled = true;
```

## Highlight Oversized Images

This option highlights images that are too large by both inverting their colors
and flipping them vertically:

![A highlighted oversized image]({% asset tools/devtools/debug-toggle-guidelines-oversized.png @path %})

These are images that are unnecessarily using more memory than required.
For example, if a large 5MB image is being displayed at 100 width and height. 

Such images can cause poor performance, especially on lower-end devices
and when you have many images, such as in a list view.
Information about each image is printed in the debug console:

```console
dash.png has a display size of 213×392 but a decode size of 2130×392, which uses an additional 2542KB.
```

Images that are deemed too large if they use at least 128KB more than required.

### Fixing images

Wherever possible, the best way to fix this problem is resizing
the image asset file so it’s smaller.

If this isn’t possible, you can use the `cacheHeight` and `cacheWidth`
parameters on the `Image` constructor:

```dart
Image.asset(
  'dash.png',
  cacheHeight: 213, 
  cacheWidth: 392
)
```

These make the engine decode this image at the specified size,
and help reduce memory usage (decoding and storage will still be more expensive
than if the image asset itself was shrunk).
The image will be rendered to the constraints of the layout or width and height
regardless of these parameters. 

This property can also be set in code:

```dart
debugInvertOversizedImage = true;
```

### Learn more:

- [Flutter documentation: debugInvertOversizedImages](https://api.flutter.dev/flutter/painting/debugInvertOversizedImages.html)

[render box]: https://api.flutter.dev/flutter/rendering/RenderBox-class.html