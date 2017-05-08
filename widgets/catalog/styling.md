---
layout: page
title: Styling
sidebar: home_sidebar
permalink: widgets/catalog/styling/
extra_css:
  - /css/catalog.css
---

<div class="catalog">
{% for section in site.data.catalog.index %}
 {% if section.name contains 'Styling' %}
 <div class="category-description"><p>{{section.description}}</p></div>
 {% endif %}
{% endfor %}


{% for comp in site.data.catalog.widgets %}
 {% if comp.categories contains 'Styling' %}
 <div class="catalog-entry">
  <h3>{{comp.name}}</h3>
  {% if comp.image contains '<svg' %}{{comp.image}}{% else %}{% if comp.image contains 'https://' %}<img alt="" src="{{comp.image}}" />{% endif %}{% endif %}
  <p> {{comp.description}} </p>
  <p><a href="{{comp.link}}">Documentation</a></p><div class="clear"></div>
 </div>
 {% endif %}
{% endfor %}

<ul>
{% for category in site.data.catalog.index %}
   {% if category.name == 'Styling' %}
    {% for sub in category.subcategories %}
        <a href="#{{sub.name}}"><li>{{sub.name}}</li></a>
    {% endfor %}
   {% endif %}
{% endfor %}
</ul>


{% for category in site.data.catalog.index %}
   {% if category.name == 'Styling' %}
    {% for sub in category.subcategories %}
        <h1 id="{{sub.name}}">{{sub.name}}</h1>
        {% for comp in site.data.catalog.widgets %}
         {% if comp.subcategories contains sub.name %}
         <div class="catalog-entry">
          <h3>{{comp.name}}</h3>
          {% if comp.image contains '<svg' %}{{comp.image}}{% else %}{% if comp.image contains 'https://' %}<img alt="" src="{{comp.image}}" />{% endif %}{% endif %}
          <p> {{comp.description}} </p>
          <p><a href="{{comp.link}}">Documentation</a></p><div class="clear"></div>
         </div>
         {% endif %}
        {% endfor %}
    {% endfor %}
   {% endif %}
{% endfor %}
</div>
   