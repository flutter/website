---
layout: page
title: Flutter Widget Index
sidebar: home_sidebar
permalink: widgets/widgetindex/
---
{% assign sorted = site.data.catalog.widgets | sort:'name' %}
<div class="catalog">
    <ul class="cards">
        {% for comp in sorted %}
        <li class="cards__item">
            <div class="catalog-entry">
                <div class="catalog-image-holder">{{comp.image}}</div>
                <h3>{{comp.name}}</h3>
                <p> {{comp.description}} </p>
                <p><a href="{{comp.link}}">Documentation</a></p><div class="clear"></div>
            </div>
        </li>
        {% endfor %}
    </ul>
</div>