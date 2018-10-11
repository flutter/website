---
title: Flutter widget index
short-title: Widgets
show_breadcrumbs: false
toc: true
---

{% assign sorted = site.data.catalog.widgets | sort:'name' -%}

This is an alphabetical list of nearly every widget that is bundled with Flutter. You can also <a href="/development/ui/widgets-catalog">browse widgets by category.

<ul class="cards">
  {% for comp in sorted %}
  <li class="cards__item">
      <div class="catalog-entry">
          <div class="catalog-image-holder">{{comp.image}}</div>
          <h3>{{comp.name}}</h3>
          <p class="scrollable-description"> {{comp.description}} </p>
          <p><a href="{{comp.link}}">Documentation</a></p><div class="clear"></div>
      </div>
  </li>
  {% endfor %}
</ul>
