---
layout: page
title: Sample Catalog
permalink: /sample_catalog/
---


This page lists all the sample apps in the Sample Catalog.

{% assign sorted = site.data.samples.widgets | sort:'name' %}
        {% for comp in sorted %}
<div class="media">
  <div class="media-left">
    <a href="{{comp.link}}">
       {{comp.image}}
   </a>
</div>
  <div class="media-body media-right">
    <a href="{{comp.detail-page}}">
      <h4 class="media-heading">{{comp.name}}</h4>
        <p>{{comp.description}}</p>
    </a>
  </div>
</div>
        {% endfor %}
