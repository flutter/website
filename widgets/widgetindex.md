---
layout: page
title: Flutter Widget Index
permalink: widgets/widgetindex/
---
{% assign sorted = site.data.catalog.widgets | sort:'name' %}
<div class="catalog">
    <div class="category-description"><p>This is an alphabetical list of nearly every widget that is bundled with Flutter. You can also <a href="/widgets">browse widgets by category.</a></p></div>
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