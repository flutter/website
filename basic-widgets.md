---
layout: page
title: Basic Widgets Overview
sidebar: home_sidebar
permalink: /basic-widgets/
---

* TOC Placeholder
{:toc}

## Introduction

This page describes a small subset of basic widgets available in Flutter.
The widgets described on this page are
general-purpose and don't offer an opinion about the visual style of your app.
To see all the basic widgets and related classes, check out the
[API docs for the widgets library](http://docs.flutter.io/flutter/widgets/widgets-library.html).

You may also be interested in Flutter's material design widgets.
You can see many of the Material Design widgets in action in our
[Flutter Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery)
demo app, and you can check out the [Catalog of Material Design widgets](/md-catalog) and
[API docs for the material widgets library](http://docs.flutter.io/flutter/material/material-library.html).

Container
---------

[`Container`](http://docs.flutter.io/flutter/widgets/Container-class.html)
is a general-purpose widget that combines several basic widgets in
order to make them easier to use.

 - `BoxDecoration decoration` Draw the given decoration around this container.
 - `double width` Forces the container to have the given width.
 - `double height` Force the container to have the given height.
 - `EdgeInsets margin` Surrounds the container (i.e., outside the container's
    decoration) on the top, right, bottom, and left with the given amount of
    space.
 - `EdgeInsets padding` Surrounds the container's child (i.e., inside the
    container's decoration) on the top, right, bottom, and left with the given
    amount of space.
 - `Matrix4 transform` Apply the given matrix before painting the container.
 - `BoxConstraints constraints` Force the width and height of the container to
    respect the given constraints.

Layout models
-------------

There are two _flex_ layout models:

 - [`Row`](http://docs.flutter.io/flutter/widgets/Row-class.html): Layout a
   list of child widgets in the horizontal direction.

 - [`Column`](http://docs.flutter.io/flutter/widgets/Column-class.html): Layout
   a list of child widgets in the vertical direction.

The direction along which the widgets are laid out is called the
*main* direction and the other axis is called the *cross* direction.
These flex widgets size themselves to the maximum size permitted by
its parent, unless that would be infinite size, in which case they
shrink-wrap their children. For details, see [layout](../layout/#flex).

Each child of a flex widget is either *flexible* or *inflexible*.
The flex first lays out its inflexible children and subtracts their
total length along the main direction to determine how much free space
is available. The flex then divides this free space among the flexible
children in a ratio determined by their `flex` properties.

The `crossAxisAlignment` property determines how children are positioned in
the cross direction. The `mainAxisAlignment` property determines how the
remaining free space (if any) in the main direction is allocated.

 - [`Flexible`](http://docs.flutter.io/flutter/widgets/Flexible-class.html):
   Mark this child as being flexible with the given `flex` ratio.

There is also a stacking layout model:

 - [`Stack`](http://docs.flutter.io/flutter/widgets/Stack-class.html): Layout a
   list of child widgets on top of each other from back to
   front. Each child of a `Stack` widget is either *positioned* or
   *non-positioned*. The stack sizes itself to contain all the
   non-positioned children, which are located at the top-left corner of the
   stack. The *positioned* children are then located relative to the stack
   according to their `top`, `right`, `bottom`, and `left` properties.

    - [`Positioned`](http://docs.flutter.io/flutter/widgets/Positioned-class.html):
      Mark this child as *positioned*. If the `top` property is
      non-null, the top edge of this child will be positioned `top` layout units
      from the top of the stack widget. The `right`, `bottom`, and `right`
      properties work analogously. Note that if the both the `top` and `bottom`
      properties are non-null, then the child will be forced to have exactly the
      height required to satisfy both constraints. Similarly, setting the
      `right` and `left` properties to non-null values will force the child to
      have a particular width.

Positioning and sizing
----------------------

[`Padding`](http://docs.flutter.io/flutter/widgets/Padding-class.html)
: Surround the child with empty space on the top, right, bottom, and
  left according to the given `EdgeInsets`.

[`Center`](http://docs.flutter.io/flutter/widgets/Center-class.html)
: Center the child widget both horizontally and vertically within the
 space occupied by this widget.

[`SizedBox`](http://docs.flutter.io/flutter/widgets/SizedBox-class.html)
: Force the child widget to have a particular `width` or `height`
 (or both).

[`ConstrainedBox`](http://docs.flutter.io/flutter/widgets/ConstrainedBox-class.html)
: Apply the given `BoxConstraints` to the child widget as
  additional constraints during layout. This widget is a generalization of
  `SizedBox`.

[`AspectRatio`](http://docs.flutter.io/flutter/widgets/AspectRatio-class.html)
: Force the child widget's width and height to have the given
  `aspectRatio`, expressed as a ratio of width to height.

[`Transform`](http://docs.flutter.io/flutter/widgets/Transform-class.html)
: Apply the given matrix to the child before painting the child.
  This widget is useful for adjusting the visual size and position of a widget
  without affecting layout.

[`Viewport`](http://docs.flutter.io/flutter/widgets/Viewport-class.html)
: Layout the child widget at a larger size than fits in this widget
  and render only the portion of the child that is visually contained by this
  widget. When rendering, add `offset` to the child's vertical position to
  control which part of the child is visible through the viewport.
  TODO(abarth): Add support for horizontal viewporting.

[`Align`](http://docs.flutter.io/flutter/widgets/Align-class.html)
: Aligns its child box within itself.

[`Baseline`](http://docs.flutter.io/flutter/widgets/Baseline-class.html)
: If the child widget has a `TextBaseline` of the given
  `baselineType`, position the child such that its baseline is at `baseline`
  layout units from the top of this widget.

Painting effects
----------------

[`Opacity`](http://docs.flutter.io/flutter/widgets/Opacity-class.html)
: Adjusts the opacity of the child widget, making the child partially
  transparent. The amount of transparency is controlled by `opacity`, with 0.0
  0.0 is fully transparent and 1.0 is fully opaque.

[`ClipRect`](http://docs.flutter.io/flutter/widgets/ClipRect-class.html)
: Apply a rectangular clip to the child widget. The dimensions of
  the clip match the dimensions of the child.

[`ClipRRect`](http://docs.flutter.io/flutter/widgets/ClipRRect-class.html)
: Apply a rounded-rect clip the child widget. The bounds of the
  clip match the bounds of the child widget with `xRadius` and `yRadius`
  controlling the x and y radius of the rounded corner, respectively.

[`ClipOval`](http://docs.flutter.io/flutter/widgets/ClipOval-class.html)
: Apply an oval clip to the child widget. The oval will be
  axis-aligned, with its horizontal and vertical bounds matching the bounds of
  the child widget.

[`DecoratedBox`](http://docs.flutter.io/flutter/widgets/DecoratedBox-class.html)
: Draw the given `BoxDecoration` surrounding the child widget.

[`ColorFilter`](http://docs.flutter.io/flutter/dart-ui/ColorFilter-class.html)
: Applies a color filter to the child widget, for example to
  tint the child a given color.

[`CustomPaint`](http://docs.flutter.io/flutter/widgets/CustomPaint-class.html)
: Calls `callback` during the paint phase with the current
  [`Canvas`](http://docs.flutter.io/flutter/dart-ui/Canvas-class.html) and
  [`Size`](http://docs.flutter.io/flutter/dart-ui/Size-class.html). The widget occupies the region of the canvas starting at
  the origin (i.e., `x = 0.0` and `y = 0.0`) and of the given size (i.e.,
  `x = size.width` and `y = size.height`).

  Use the `token` to invalidate the painting. As long as the any new `token`
  is `operator==` the current `token`, the `CustomPaint` widget is permitted
  to retain a recording of the painting produced by the previous `callback`
  call.
