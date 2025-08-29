---
title: Flutter widget index
description: An alphabetical list of Flutter widgets.
short-title: Widgets
showBreadcrumbs: false
---

{% assign sorted = catalog.widgets | sort:'name' -%}

This is an alphabetical list of many of the widgets that
are bundled with Flutter.
You can also [browse widgets by category][catalog].

You might also want to check out our Widget of the Week video series
on the [Flutter YouTube channel]({{site.social.youtube}}). Each short
episode features a different Flutter widget. For more video series, see
our [videos](/resources/videos) page.

{% ytEmbed 'b_sQ9bMltGU', 'Introducing the Flutter Widget of the Week' %}

[Widget of the Week playlist]({{site.yt.playlist}}PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)

<div class="card-grid">
{% for comp in sorted -%}
  <a class="card outlined-card" href="{{comp.link}}">
    <div class="card-image-holder">
      {% if comp.vector -%}
        {{comp.vector}}
      {% elsif comp.image -%}
        <img alt="Rendered image or visualization of the {{comp.name}} widget." src="{{comp.image.src}}">
      {% else -%}
        <img alt="Flutter logo for widget missing visualization image." src="/assets/images/docs/catalog-widget-placeholder.png" aria-hidden="true">
      {% endif -%}
    </div>
    <div class="card-header">
      <span class="card-title">{{comp.name}}</span>
    </div>
    <div class="card-content">
      <p class="card-text">{{ comp.description | truncatewords: 25 }}</p>
    </div>
  </a>
{% endfor %}
</div>

[catalog]: /ui/widgets
