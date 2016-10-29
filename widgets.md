---
layout: page
title: Basic Widgets Overview
sidebar: home_sidebar
permalink: /widgets/
---

* TOC Placeholder
{:toc}

## Introduction

This page describes some of the widgets available in Flutter.

See also:

* [The API reference for the `widgets` library](https://docs.flutter.io/flutter/widgets/widgets-library.html).
* [The API reference for the `material` library](https://docs.flutter.io/flutter/material/material-library.html).


Layout models
-------------

The following widgets allow you to arrange a series of children next
to each other:

 - [`Row`](https://docs.flutter.io/flutter/widgets/Row-class.html): Layout a
   list of child widgets in the horizontal direction.

 - [`Column`](https://docs.flutter.io/flutter/widgets/Column-class.html): Layout
   a list of child widgets in the vertical direction.

The direction along which the widgets are laid out is called the
*main* axis and the other axis is called the *cross* axis. These
widgets size themselves to the maximum size permitted by its parent,
unless that would be infinite size, in which case they shrink-wrap
their children. This is discussed in more detail on our page about
[box constraints](../layout/#flex).

Each child of a flex widget is either *flexible* or *inflexible*.
The flex first lays out its inflexible children and subtracts their
total length along the main direction to determine how much free space
is available. The flex then divides this free space among the flexible
children in a ratio determined by their `flex` properties.

The `crossAxisAlignment` property determines how children are positioned in
the cross direction. The `mainAxisAlignment` property determines how the
remaining free space (if any) in the main direction is allocated.

 - [`Flexible`](https://docs.flutter.io/flutter/widgets/Flexible-class.html):
   Mark this child as being flexible with the given `flex` ratio.

There is also a stacking layout model:

 - [`Stack`](https://docs.flutter.io/flutter/widgets/Stack-class.html): Layout a
   list of child widgets on top of each other from back to
   front. Each child of a `Stack` widget is either *positioned* or
   *non-positioned*. The stack sizes itself to contain all the
   non-positioned children, which are located at the top-left corner of the
   stack. The *positioned* children are then located relative to the stack
   according to their `top`, `right`, `bottom`, and `left` properties.

    - [`Positioned`](https://docs.flutter.io/flutter/widgets/Positioned-class.html):
      Mark this child as *positioned*. If the `top` property is
      non-null, the top edge of this child will be positioned `top` layout units
      from the top of the stack widget. The `right`, `bottom`, and `right`
      properties work analogously. Note that if the both the `top` and `bottom`
      properties are non-null, then the child will be forced to have exactly the
      height required to satisfy both constraints. Similarly, setting the
      `right` and `left` properties to non-null values will force the child to
      have a particular width.

Scrolling
---------

If you have a group of widgets that you wish to make scrollable, then
the following widgets may be of use. (The "Lazy" variants are more
performant, at the cost of slightly more complexity.)

 - [`Block`](https://docs.flutter.io/flutter/widgets/Block-class.html) and
   [`LazyBlock`](https://docs.flutter.io/flutter/widgets/LazyBlock-class.html):
   Arranges children one after the other, and scrolls if necessary.

 - [`ScrollableList`](https://docs.flutter.io/flutter/widgets/ScrollableList-class.html) and
   [`ScrollableLazyList`](https://docs.flutter.io/flutter/widgets/ScrollableList-class.html):
   A scrollable list of children that have equal size.

Container
---------

[`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html)
is a general-purpose widget that combines several of the basic widgets
from the following sections in order to make them easier to use.

It takes a single child, and embellishes it according to its
arguments:

 - `BoxDecoration decoration` Draw the given decoration below this container.
 - `BoxDecoration foregroundDecoration` Draw the given decoration above this container.
 - `double width` Forces the container to have the given width.
 - `double height` Force the container to have the given height.
 - `BoxConstraints constraints` Force the width and height of the container to
    respect the given constraints.
 - `EdgeInsets margin` Surrounds the container (i.e., outside the container's
    decoration) on the top, right, bottom, and left with the given amount of
    space.
 - `EdgeInsets padding` Surrounds the container's child (i.e., inside the
    container's decoration) on the top, right, bottom, and left with the given
    amount of space.
 - `FractionalOffset alignment` Align the child within the container.
 - `Matrix4 transform` Apply the given matrix before painting the container.

Positioning and sizing
----------------------

[`Padding`](https://docs.flutter.io/flutter/widgets/Padding-class.html)
: Surround the child with empty space on the top, right, bottom, and
  left according to the given `EdgeInsets`.

[`Center`](https://docs.flutter.io/flutter/widgets/Center-class.html)
: Center the child widget both horizontally and vertically within the
 space occupied by this widget.

[`SizedBox`](https://docs.flutter.io/flutter/widgets/SizedBox-class.html)
: Force the child widget to have a particular `width` or `height`
 (or both).

[`ConstrainedBox`](https://docs.flutter.io/flutter/widgets/ConstrainedBox-class.html)
: Apply the given `BoxConstraints` to the child widget as
  additional constraints during layout. This widget is a generalization of
  `SizedBox`.

[`AspectRatio`](https://docs.flutter.io/flutter/widgets/AspectRatio-class.html)
: Force the child widget's width and height to have the given
  `aspectRatio`, expressed as a ratio of width to height.

[`Transform`](https://docs.flutter.io/flutter/widgets/Transform-class.html)
: Apply the given matrix to the child before painting the child.
  This widget is useful for adjusting the visual size and position of a widget
  without affecting layout.

[`Viewport`](https://docs.flutter.io/flutter/widgets/Viewport-class.html)
: Layout the child widget at a larger size than fits in this widget
  and render only the portion of the child that is visually contained by this
  widget. When rendering, add `offset` to the child's vertical position to
  control which part of the child is visible through the viewport.

[`Align`](https://docs.flutter.io/flutter/widgets/Align-class.html)
: Aligns its child box within itself.

[`Baseline`](https://docs.flutter.io/flutter/widgets/Baseline-class.html)
: If the child widget has a `TextBaseline` of the given
  `baselineType`, position the child such that its baseline is at `baseline`
  layout units from the top of this widget.

Painting effects
----------------

[`Opacity`](https://docs.flutter.io/flutter/widgets/Opacity-class.html)
: Adjusts the opacity of the child widget, making the child partially
  transparent. The amount of transparency is controlled by `opacity`, with 0.0
  0.0 is fully transparent and 1.0 is fully opaque.

[`ClipRect`](https://docs.flutter.io/flutter/widgets/ClipRect-class.html)
: Apply a rectangular clip to the child widget. The dimensions of
  the clip match the dimensions of the child.

[`ClipRRect`](https://docs.flutter.io/flutter/widgets/ClipRRect-class.html)
: Apply a rounded-rect clip the child widget. The bounds of the
  clip match the bounds of the child widget with `xRadius` and `yRadius`
  controlling the x and y radius of the rounded corner, respectively.

[`ClipOval`](https://docs.flutter.io/flutter/widgets/ClipOval-class.html)
: Apply an oval clip to the child widget. The oval will be
  axis-aligned, with its horizontal and vertical bounds matching the bounds of
  the child widget.

[`DecoratedBox`](https://docs.flutter.io/flutter/widgets/DecoratedBox-class.html)
: Draw the given `BoxDecoration` surrounding the child widget.

[`CustomPaint`](https://docs.flutter.io/flutter/widgets/CustomPaint-class.html)
: Uses the given [`CustomPainter`](https://docs.flutter.io/flutter/material/CustomPainter-class.html)
  (which you implement and provide) during the paint phase, providing it with the current
  [`Canvas`](https://docs.flutter.io/flutter/dart-ui/Canvas-class.html) and
  [`Size`](https://docs.flutter.io/flutter/dart-ui/Size-class.html).
  The widget occupies the region of the canvas starting at
  the origin (i.e., `x = 0.0` and `y = 0.0`) and of the given size (i.e.,
  `x = size.width` and `y = size.height`).


Material design widgets
-----------------------

Flutter implementats many of the UI components from Google’s [Material Design Specification](https://material.google.com/).
You can see many of the material design widgets in action in our [Flutter Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery) demo app.

To lay widgets out within your application, use the layout widgets
described above, such as
[Row](https://docs.flutter.io/flutter/widgets/Row-class.html),
[Column](https://docs.flutter.io/flutter/widgets/Column-class.html),
[Stack](https://docs.flutter.io/flutter/widgets/Stack-class.html), or
[Block](https://docs.flutter.io/flutter/widgets/Block-class.html).

<!-- Data for the catalog comes from catalog.csv in the _data folder -->
{% for comp in site.data.catalog %}
<div class="comp-entry">
  <h3>{{comp.comp_name}}</h3>
  <img class="comp-img" src="{{comp.img_link}}"/>
  <p>
   {{comp.comp_desc}}
   {% if comp.widget_name != '' %}
     The <a href="{{comp.dartdocs_link}}">{{comp.widget_name}}</a> widget implements this component.
   {% endif %}
   {{comp.extra_html}}
  </p>
  <p><a href="https://github.com/flutter/flutter/search?utf8=%E2%9C%93&q=path%3Aexamples+{{comp.sample_keywords}}&type=Code">Sample usage</a>
  | <a href="{{comp.dartdocs_link}}">Documentation</a>
  | <a href="{{comp.material_spec_link}}">Interface design guidelines</a></p>
</div>
{% endfor %}

<div class="catalog-end"></div>
