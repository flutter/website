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

<div class="card-grid">
{% assign categories = catalog.index | sort: 'name' -%}
{% for section in categories %}
  {%- if section.name == "Cupertino" or section.name == "Material components" -%}
    <a class="card outlined-card" href="{{page.url}}{{section.id}}">
      <div class="card-header">
        <header class="card-title">{{section.name}}</header>
      </div>
      <div class="card-content">
        <p>{{section.description}}</p>
      </div>
    </a>
  {% endif -%}
{% endfor %}
</div>

You can find many more designs systems created by the Flutter community
on [pub.dev]({{site.pub}}), the package repository for Dart and Flutter,
like for example the Windows-inspired [fluent_ui]({{site.pub-pkg}}/fluent_ui),
macOS-inspired [macos_ui]({{site.pub-pkg}}/macos_ui),
and the Ubuntu-inspired [yaru]({{site.pub-pkg}}/yaru) widgets.

## Base widgets

Base widgets support a range of common rendering options
like input, layout, and text.

<div class="card-grid">
{% assign categories = catalog.index | sort: 'name' -%}
{% for section in categories %}
  {%- if section.name != "Cupertino" and section.name != "Material components" and section.name != "Material 2 components" -%}
    <a class="card outlined-card" href="{{page.url}}{{section.id}}">
      <div class="card-header">
        <header class="card-title">{{section.name}}</header>
      </div>
      <div class="card-content">
        <p>{{section.description}}</p>
      </div>
    </a>
  {% endif -%}
{% endfor %}
</div>

## Widget of the Week

100+ short, 1-minute explainer videos to
help you quickly get started with Flutter widgets.

<div class="card-grid wide">
  <div class="card wrapped-card">
    <div class="card-content">
      {% ytEmbed '1z6YP7YmvwA', 'TextStyle - Flutter widget of the week', true, true %}
    </div>
  </div>
  <div class="card wrapped-card">
    <div class="card-content">
      {% ytEmbed 'VdkRy3yZiPo', 'flutter_rating_bar - Flutter package of the week', true, true %}
    </div>
  </div>
  <div class="card wrapped-card">
    <div class="card-content">
      {% ytEmbed 'gYNTcgZVcWw', 'LinearGradient - Flutter widget of the week', true, true %}
    </div>
  </div>
  <div class="card wrapped-card">
    <div class="card-content">
      {% ytEmbed '-Nny8kzW380', 'AutoComplete - Flutter widget of the week', true, true %}
    </div>
  </div>
  <div class="card wrapped-card">
    <div class="card-content">
      {% ytEmbed 'y9xchtVTtqQ', 'NavigationRail - Flutter widget of the week', true, true %}
    </div>
  </div>
  <div class="card wrapped-card">
    <div class="card-content">
      {% ytEmbed 'qjA0JFiPMnQ', 'mason - Flutter package of the week', true, true %}
    </div>
  </div>
</div>

<a class="filled-button" target="_blank" href="{{site.yt.playlist}}PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG">Watch more widget of the week videos</a>

[widget index]: /reference/widgets
