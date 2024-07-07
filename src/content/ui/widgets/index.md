---
title: Widget catalog
description: A catalog of some of Flutter's rich set of widgets.
short-title: Widgets
toc: false
---

Create beautiful apps faster with Flutter's collection of visual, structural,
platform, and interactive widgets. In addition to browsing widgets by category,
you can also see all the widgets in the [widget index][].

<div class="card-grid">
{% assign categories = catalog.index | sort: 'name' -%}
{% for section in categories %}
    {%- if section.name != "Material 2 components" -%}
        <div class="card">
            <div class="card-body">
                <a href="{{page.url}}{{section.id}}"><header class="card-title">{{section.name}}</header></a>
                <p class="card-text">{{section.description}}</p>
            </div>
            <div class="card-footer card-footer--transparent">
                <a href="{{page.url}}{{section.id}}" aria-label="Navigate to the {{section.name}} widgets catalog">Visit</a>
            </div>
        </div>
    {% endif -%}
{% endfor %}
</div>

## Widget of the Week

100+ short, 1-minute explainer videos to
help you quickly get started with Flutter widgets.

<div class="card-grid wide">
    <div class="card">
        <div class="card-body">
            {% ytEmbed '1z6YP7YmvwA', 'TextStyle - Flutter widget of the week', true, true %}
        </div>
    </div>
    <div class="card">
        <div class="card-body">
            {% ytEmbed 'VdkRy3yZiPo', 'flutter_rating_bar - Flutter package of the week', true, true %}
        </div>
    </div>
    <div class="card">
        <div class="card-body">
            {% ytEmbed 'VdkRy3yZiPo', 'LinearGradient - Flutter widget of the week', true, true %}
        </div>
    </div>
    <div class="card">
        <div class="card-body">
            {% ytEmbed '-Nny8kzW380', 'AutoComplete - Flutter widget of the week', true, true %}
        </div>
    </div>
    <div class="card">
        <div class="card-body">
            {% ytEmbed 'y9xchtVTtqQ', 'NavigationRail - Flutter widget of the week', true, true %}
        </div>
    </div>
    <div class="card">
        <div class="card-body">
            {% ytEmbed 'qjA0JFiPMnQ', 'mason - Flutter package of the week', true, true %}
        </div>
    </div>
</div>

<a class="btn btn-primary full-width" target="_blank" href="{{site.yt.playlist}}PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG">Watch more widget of the week videos</a>

[widget index]: /reference/widgets
