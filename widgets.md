---
layout: page
title: Widgets Overview
sidebar: home_sidebar
permalink: /widgets/
extra_css:
  - /css/catalog.css
---

* TOC Placeholder
{:toc}

## Introduction

This page describes some of the widgets available in Flutter.

Flutter uses a layered approach. At the highest level we provide
[Material components](#material-design-widgets). These are implemented
in the [`material`
library](https://docs.flutter.io/flutter/material/material-library.html).
The `material` library is implemented in terms of the [`widgets`
library](https://docs.flutter.io/flutter/widgets/widgets-library.html).
That library in turn is implemented in terms of the [`rendering`
library](https://docs.flutter.io/flutter/rendering/rendering-library.html),
and so forth.

Even within each library, we use a layered approach. For example, the
`widgets` library's
[`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html)
widget is implemented in terms of lower-level widgets from the same
library, such as
[`Padding`](https://docs.flutter.io/flutter/widgets/Padding-class.html)
and
[`ConstrainedBox`](https://docs.flutter.io/flutter/widgets/ConstrainedBox-class.html).


Layout models
-------------

The following widgets allow you to arrange a series of children:

[`Row`](https://docs.flutter.io/flutter/widgets/Row-class.html)
: Layout a list of child widgets in the horizontal direction.

[`Column`](https://docs.flutter.io/flutter/widgets/Column-class.html)
: Layout a list of child widgets in the vertical direction.

[`Stack`](https://docs.flutter.io/flutter/widgets/Stack-class.html)
: Layout a list of child widgets on top of each other from back to front.

[`Block`](https://docs.flutter.io/flutter/widgets/Block-class.html) and [`LazyBlock`](https://docs.flutter.io/flutter/widgets/LazyBlock-class.html)
: Arranges children one after the other, and scrolls if necessary.

[`ScrollableList`](https://docs.flutter.io/flutter/widgets/ScrollableList-class.html) and [`ScrollableLazyList`](https://docs.flutter.io/flutter/widgets/ScrollableList-class.html)
: A scrollable list of children that have equal size.

Container
---------

[`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html)
: A general-purpose widget that combines several of the basic widgets
  from the following sections in order to make them easier to use.

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
