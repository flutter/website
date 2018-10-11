---
title: Widget catalog
toc: false
---

Create beautiful apps faster with Flutter's collection of visual, structural,
platform, and interactive widgets.

In addition to browsing widgets by category,
you can also see all the widgets in the [Flutter widget index](/api-and-reference/widgets).

<div>
{% for section in site.data.catalog.index %}
    {% capture modulo3 %}{{ forloop.index0 | modulo:3 }}{% endcapture %}
    {% if modulo3 == '0' %}
        <div class="card-deck">
    {% endif %}
            <a class="card" href="/development/ui/widgets/{{section.id}}">
                <div class="card-body">
                    <header class="card-title">{{section.name}}</header>
                    <p class="card-text">{{section.description}}</p>
                </div>
            </a>
    {% if modulo3 == '2' or forloop.last %}
        </div>
    {% endif %}
{% endfor %}
</div>
