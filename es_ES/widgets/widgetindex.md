---
layout: page
title: Índice de widgets en Flutter
permalink: widgets/widgetindex/
---
{% assign sorted = site.data.catalog.widgets | sort:'name' %}
<div class="catalog">
    <div class="category-description"><p>Esta es una lista alfabética de casi todos los widgets que están incluidos con Flutter. También puedes <a href="/widgets">buscar widgets por categoría.</a></p></div>
    <ul class="cards">
        {% for comp in sorted %}
        <li class="cards__item">
            <div class="catalog-entry">
                <div class="catalog-image-holder">{{comp.image}}</div>
                <h3>{{comp.name}}</h3>
                <p class="scrollable-description"> {{comp.description}} </p>
                <p><a href="{{comp.link}}">Documentación</a></p><div class="clear"></div>
            </div>
        </li>
        {% endfor %}
    </ul>
</div>