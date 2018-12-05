---
title: Flutter widget index
short-title: Widgets
show_breadcrumbs: false
toc: false
---

{% assign sorted = site.data.catalog.widgets | sort:'name' -%}

This is an alphabetical list of nearly every widget that is bundled with
Flutter. You can also [browse widgets by category][catalog].

<div class="card-deck card-deck--responsive">
{% for comp in sorted %}
    <div class="card">
        <a href="{{comp.link}}">
            <div class="card-image-holder">
                {{comp.image}}
            </div>
        </a>
        <div class="card-body">
            <a href="{{comp.link}}"><header class="card-title">{{comp.name}}</header></a>
            <p class="card-text">{{comp.description}}</p>
        </div>
        <div class="card-footer card-footer--transparent">
            <a href="{{comp.link}}">Documentation</a>
        </div>
    </div>
{% endfor %}
</div>

[catalog]: /docs/development/ui/widgets
