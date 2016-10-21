---
layout: page
title: Material Design Catalog
extra_css:
  - /css/catalog.css
sidebar: home_sidebar
permalink: /material-design-catalog/
---

This page catalogs Flutter’s implementation of UI components from Google’s [Material Design Specification](https://material.google.com/).
You can see many of the material design widgets in action in our [Flutter Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery) demo app.

To lay widgets out within your application, use
[basic widgets](/basic-widgets/) such as
[Row](https://docs.flutter.io/flutter/widgets/Row-class.html),
[Column](https://docs.flutter.io/flutter/widgets/Column-class.html),
[Stack](https://docs.flutter.io/flutter/widgets/Stack-class.html), or
[Block](https://docs.flutter.io/flutter/widgets/Block-class.html).

<!-- Data for the catalog comes from catalog.csv in the _data folder -->
{% for comp in site.data.catalog %}
<div class="comp-entry">
  <h2>{{comp.comp_name}}</h2>
  <img class="comp-img" src="{{comp.img_link}}"/>
  {% if comp.standard == 'TRUE' %}
    <!-- if the component can fit into the standard format -->
    <p>{{comp.comp_desc}} The <a href="{{comp.widget_link}}">{{comp.widget_name}}</a> widget implements this component. {{comp.extra_html}} </p>
    <p><a href="https://github.com/flutter/flutter/search?utf8=%E2%9C%93&q=path%3Aexamples+%22new+{{comp.widget_name}}%22&type=Code">Sample usage</a>
    | <a href="{{comp.comp_link}}">Design spec</a></p>
  {% else %}
    <!-- if the component requires a custom format -->
    {{comp.extra_html}}
  {% endif %}
</div>
{% endfor %}

<div class="catalog-end"></div>
