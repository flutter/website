---
layout: page
title: Cupertino (iOS-style widgets)
sidebar: home_sidebar
permalink: widgets/catalog/cupertino/
extra_css:
  - /css/catalog.css
---

<div class="catalog">
{% for section in site.data.catalog.index %}
 {% if section.name contains 'Cupertino (iOS-style widgets)' %}
 <div class="category-description"><p>{{section.description}}</p></div>
 {% endif %}
{% endfor %}


{% for comp in site.data.catalog.widgets %}
 {% if comp.categories contains 'Cupertino (iOS-style widgets)' %}
 <div class="catalog-entry">
  <h3>{{comp.name}}</h3>
  {% if comp.image contains '<svg' %}{{comp.image}}{% else %}<img alt="" src="{{comp.image}}" />{% endif %}
  <p> {{comp.description}} </p>
  <p><a href="{{comp.link}}">Documentation</a></p><div class="clear"></div>
 </div>
 {% endif %}
{% endfor %}

<ul>
{% for category in site.data.catalog.index %}
   {% if category.name == 'Cupertino (iOS-style widgets)' %}
    {% for sub in category.subcategories %}
        <a href="#{{sub.name}}"><li>{{sub.name}}</li></a>
    {% endfor %}
   {% endif %}
{% endfor %}
</ul>


{% for category in site.data.catalog.index %}
   {% if category.name == 'Cupertino (iOS-style widgets)' %}
    {% for sub in category.subcategories %}
        <h1 id="{{sub.name}}">{{sub.name}}</h1>
        <ul class="cards">
        {% for comp in site.data.catalog.widgets %}
         {% if comp.subcategories contains sub.name %}
         <li class="cards__item">
             <div class="catalog-entry" >
                  {% if comp.image contains '<svg' %}{{comp.image}}{% else %}<img alt="" src="{{comp.image}}" />{% endif %}
                  <h3>{{comp.name}}</h3>
                  <p> {{comp.description}} </p>
                  <p><a href="{{comp.link}}">Documentation</a></p><div class="clear"></div>
                 </div>
             </li>
         {% endif %}
        {% endfor %}
        </ul>
    {% endfor %}
   {% endif %}
{% endfor %}
</div>