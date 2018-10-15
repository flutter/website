---
title: Widget catalog
toc: false
---

Create beautiful apps faster with Flutter's collection of visual, structural,
platform, and interactive widgets. In addition to browsing widgets by category,
you can also see all the widgets in the [Flutter widget index](/api-and-reference/widgets).

<div class="card-deck card-deck--responsive">
{% for section in site.data.catalog.index %}
    <div class="card">
        <div class="card-body">
            <a href="/api-and-reference/widgets/{{section.id}}"><header class="card-title">{{section.name}}</header></a>
            <p class="card-text">{{section.description}}</p>
        </div>
        <div class="card-footer card-footer--transparent">
            <a href="/api-and-reference/widgets/{{section.id}}">Visit</a>
        </div>
    </div>
{% endfor %}
</div>
