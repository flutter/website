---
title: Widget catalog
description: A catalog of some of Flutter's rich set of widgets.
short-title: Widgets
---

Create beautiful apps faster with Flutter's collection of visual, structural,
platform, and interactive widgets. In addition to browsing widgets by category,
you can also see all the widgets in the [widget index][].

<div class="card-deck card-deck--responsive">
{% assign categories = site.data.catalog.index | sort: 'name' -%}
{% for section in categories %}
    <div class="card">
        <div class="card-body">
            <a href="{{page.url}}{{section.id}}"><header class="card-title">{{section.name}}</header></a>
            <p class="card-text">{{section.description}}</p>
        </div>
        <div class="card-footer card-footer--transparent">
            <a href="{{page.url}}{{section.id}}">Visit</a>
        </div>
    </div>
{% endfor %}
</div>


[widget index]: /docs/reference/widgets
