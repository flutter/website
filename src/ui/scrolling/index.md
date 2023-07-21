---
title: Scrolling
description: Overview of Flutter's scrolling support
---

Flutter has many built-in widgets that automatically
scroll and also offers a variety of widgets
that you can customize to create specific scrolling
behavior.

## Basic scrolling

Many Flutter widgets support scrolling out of the box
and do most of the work for you. For example, 
[`SingleChildScrollView`][] automatically scrolls its
child when necessary. Other useful widgets include
[`ListView`][] and [`GridView`][].
You can check out more of these widgets on the
[scrolling page][] of the Widget catalog.

<iframe width="560" height="315" src="https://www.youtube.com/embed/DbkIQSvwnZc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

<iframe width="560" height="315" src="https://www.youtube.com/embed/KJpkjHGiI5A" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Infinite scrolling

When you have a long list of items
in your `ListView` or `GridView` (including an _infinite_ list),
you can build the items on demand
as they scroll into view. This provides a much
more performant scrolling experience.
For more information, check out
[`ListView.builder`][] or [`GridView.builder`][].

[`ListView.builder`]: {{site.api}}/flutter/widgets/ListView/ListView.builder.html
[`GridView.builder`]: {{site.api}}/flutter/widgets/GridView/GridView.builder.html

### Specialized scrollable widgets

The following widgets provide more specific scrolling
behavior.

A video on using [`DraggableScrollableSheet`][]
<iframe width="560" height="315" src="https://www.youtube.com/embed/Hgw819mL_78" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

Turn the scrollable area into a wheel! [`ListWheelScrollView`][]
<iframe width="560" height="315" src="https://www.youtube.com/embed/dUhmWAz4C7Y" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

[`DraggableScrollableSheet`]: {{site.api}}/flutter/widgets/DraggableScrollableSheet-class.html
[`GridView`]: {{site.api}}/flutter/widgets/GridView-class.html
[`ListView`]: {{site.api}}/flutter/widgets/ListView-class.html
[`ListWheelScrollView`]: {{site.api}}/flutter/widgets/ListWheelScrollView-class.html
[scrolling page]: {{site.url}}/ui/widgets/scrolling
[`SingleChildScrollView`]: {{site.api}}/flutter/widgets/SingleChildScrollView-class.html 

{% comment %}
  Not yet, but coming. Two dimensional scrolling:
  TableView and TreeView.
  Video: https://www.youtube.com/watch?v=UDZ0LPQq-n8
{% endcomment %}

## Fancy scrolling

Perhaps you want to implement _elastic_ scrolling,
also called _scroll bouncing_. Or maybe you want to
implement other dynamic scrolling effects, like parallax scrolling.
Or perhaps you want a scrolling header with very specific behavior,
such as shrinking or disappearing.

You can achieve all this and more using the
Flutter `Sliver*` classes.
A _sliver_ refers to a piece of the scrollable area.
You can define and insert a sliver into a [`CustomScrollView`][]
to have finer-grained control over that area.

For more information, check out
[Using slivers to achieve fancy scrolling][]
and the [Sliver classes][].

[`CustomScrollView`]: {{site.api}}/flutter/widgets/CustomScrollView-class.html
[Sliver classes]: {{site.url}}/ui/widgets/layout#Sliver%20widgets
[Using slivers to achieve fancy scrolling]: {{site.url}}/ui/scrolling/slivers

## Nested scrolling widgets

How do you nest a scrolling widget
inside another scrolling widget
without hurting scrolling performance?
Do you set the `ShrinkWrap` property to true,
or do you use a sliver?

Check out the "ShrinkWrap vs Slivers" video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/LUqDNnv_dh0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
