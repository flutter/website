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


<!-- Data for the catalog comes from widgets.csv in the _data folder -->
{% for comp in site.data.widgets %}
 {% if comp.section == 'basic' %}
 <div class="comp-entry">
  <h3>{{comp.comp_name}}</h3>
  {{comp.image}}
  <p> {{comp.comp_desc}} </p>
  <p><a href="{{comp.dartdocs_link}}">Documentation</a></p>
 </div>
 {% endif %}
{% endfor %}

Layout models
-------------

The following widgets allow you to arrange a series of children.

<!-- Data for the catalog comes from widgets.csv in the _data folder -->
{% for comp in site.data.widgets %}
 {% if comp.section == 'layout' %}
  <div class="comp-entry">
   <h3>{{comp.comp_name}}</h3>
   {{comp.image}}
   <p> {{comp.comp_desc}} </p>
   <p><a href="{{comp.dartdocs_link}}">Documentation</a></p>
  </div>
 {% endif %}
{% endfor %}

Positioning and sizing
----------------------

The following widgets allow you to position and size other widgets.

<!-- Data for the catalog comes from widgets.csv in the _data folder -->
{% for comp in site.data.widgets %}
 {% if comp.section == 'pos' %}
  <div class="comp-entry">
   <h3>{{comp.comp_name}}</h3>
   {{comp.image}}
   <p> {{comp.comp_desc}} </p>
   <p><a href="{{comp.dartdocs_link}}">Documentation</a></p>
  </div>
 {% endif %}
{% endfor %}

Painting effects
----------------

These widgets apply visual effects to the children without changing their layout, size, or position.

<!-- Data for the catalog comes from widgets.csv in the _data folder -->
{% for comp in site.data.widgets %}
 {% if comp.section == 'paint' %}
  <div class="comp-entry">
   <h3>{{comp.comp_name}}</h3>
   {{comp.image}}
   <p> {{comp.comp_desc}} </p>
   <p><a href="{{comp.dartdocs_link}}">Documentation</a></p>
  </div>
 {% endif %}
{% endfor %}

Material design widgets
-----------------------

Flutter implements many of the UI components from Google’s [Material Design Specification](https://material.google.com/).
You can see many of the material design widgets in action in our [Flutter Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery) demo app.

<!-- Data for the catalog comes from catalog.csv in the _data folder -->
{% for comp in site.data.catalog %}
 <div class="comp-entry">
  <h3>{{comp.comp_name}}</h3>
  <img alt="" class="comp-img" src="{{comp.img_link}}"/>
  <p>
   {{comp.comp_desc}}
   {% if comp.widget_name != '' %} The <a href="{{comp.dartdocs_link}}">{{comp.widget_name}}</a> widget implements this component. {% endif %}
   {{comp.extra_html}}
  </p>
  <p><a href="{{comp.dartdocs_link}}">Documentation</a>
  | <a href="{{comp.material_spec_link}}">Interface design guidelines</a></p>
 </div>
{% endfor %}

<div class="catalog-end"></div>

<small>
The [owl](../images/owl.jpg) image is licensed under the
[Creative Commons Attribution-Share Alike 3.0 Unported license](https://creativecommons.org/licenses/by-sa/3.0/deed.en).
It was [originally](https://commons.wikimedia.org/wiki/File:Athene_noctua_(portrait).jpg)
created by [Trebol-a](https://commons.wikimedia.org/wiki/User:Trebol-a) and
has been modified for this site.
</small>
