---
title: Widget catalog
description: A catalog of some of Flutter's rich set of widgets.
short-title: Widgets
toc: false
---

Create beautiful apps faster with Flutter's collection of visual, structural,
platform, and interactive widgets. In addition to browsing widgets by category,
you can also see all the widgets in the [widget index][].

## Design systems

Flutter ships with two design systems as part of the SDK.
You can find many more designs systems created by the Flutter community
on [pub.dev]({{site.pub}}), the package repository for Dart and Flutter.

<div class="card-grid">
{% assign categories = catalog.index | sort: 'name' -%}
{% for section in categories %}
    {%- if section.name == "Cupertino" or section.name == "Material components" -%}
        <a class="card" href="{{page.url}}{{section.id}}">
            <div class="card-body">
                <header class="card-title">{{section.name}}</header>
                <p class="card-text">{{section.description}}</p>
            </div>
        </a>
    {% endif -%}
{% endfor %}
</div>

## Base widgets

Base widgets support a range of common rendering options
like input, layout, and text.

<div class="card-grid">
{% assign categories = catalog.index | sort: 'name' -%}
{% for section in categories %}
    {%- if section.name != "Cupertino" and section.name != "Material components" and section.name != "Material 2 components" -%}
        <a class="card" href="{{page.url}}{{section.id}}">
            <div class="card-body">
                <header class="card-title">{{section.name}}</header>
                <p class="card-text">{{section.description}}</p>
            </div>
        </a>
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

<a class="filled-button full-width" target="_blank" href="{{site.yt.playlist}}PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG">Watch more widget of the week videos</a>

[widget index]: /reference/widgets
