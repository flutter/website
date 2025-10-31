---
title: Widget catalog
description: A catalog of some of Flutter's rich set of widgets.
shortTitle: Widgets
showToc: false
---

Create beautiful apps faster with Flutter's collection of visual, structural,
platform, and interactive widgets. In addition to browsing widgets by category,
you can also see all the widgets in the [widget index][].

## Design systems

Flutter ships with two design systems as part of the SDK.

<div class="card-grid">
{% assign categories = catalog.index | sortBy: 'name' -%}
{% for section in categories %}
  {%- if section.name == "Cupertino" or section.name == "Material components" -%}
    <a class="card outlined-card" href="{{page.url}}/{{section.id}}">
      <div class="card-header">
        <span class="card-title">{{section.name}}</span>
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
{% assign categories = catalog.index | sortBy: 'name' -%}
{% for section in categories %}
  {%- if section.name != "Cupertino" and section.name != "Material components" and section.name != "Material 2 components" -%}
    <a class="card outlined-card" href="{{page.url}}/{{section.id}}">
      <div class="card-header">
        <span class="card-title">{{section.name}}</span>
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
  <div class="card wrapped-card outlined-card">
    <div class="card-content">
      <YouTubeEmbed id="D0xwcz2IqAY" title="CupertinoRadio - Flutter widget of the week"></YouTubeEmbed>
    </div>
  </div>
  <div class="card wrapped-card outlined-card">
    <div class="card-content">
      <YouTubeEmbed id="5H-WvH5O29I" title="CupertinoSheetRoute - Flutter widget of the week"></YouTubeEmbed>
    </div>
  </div>
  <div class="card wrapped-card outlined-card">
    <div class="card-content">
      <YouTubeEmbed id="esnBf6V4C34" title="CupertinoSlidingSegmentedControl - Flutter widget of the week"></YouTubeEmbed>
    </div>
  </div>
  <div class="card wrapped-card outlined-card">
    <div class="card-content">
      <YouTubeEmbed id="ua54JU7k1Us" title="CupertinoCheckbox - Flutter widget of the week"></YouTubeEmbed>
    </div>
  </div>
  <div class="card wrapped-card outlined-card">
    <div class="card-content">
      <YouTubeEmbed id="24tg_N4sdMQ" title="CupertinoSwitch - Flutter widget of the week"></YouTubeEmbed>
    </div>
  </div>
  <div class="card wrapped-card outlined-card">
    <div class="card-content">
      <YouTubeEmbed id="GQ8ajYVF0bo" title="CarouselView - Flutter widget of the week"></YouTubeEmbed>
    </div>
  </div>
</div>

<a class="filled-button" target="_blank" href="{{site.yt.playlist}}PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG">Watch more widget of the week videos</a>

[widget index]: /reference/widgets
