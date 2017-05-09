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

<ul>
{% for category in site.data.catalog.index %}
   {% if category.name == 'Styling' %}
    {% for sub in category.subcategories %}
        <a href="#{{sub.name}}"><li>{{sub.name}}</li></a>
    {% endfor %}
   {% endif %}
{% endfor %}
</ul>

<p>Back to the <a href="..">Flutter widget catalog</a>.</p>


<ul class="cards">
{% for comp in site.data.catalog.widgets %}
 {% if comp.categories contains 'Styling' %}
 <li class="cards__item">
 <div class="catalog-entry">
  <h3>{{comp.name}}</h3>
  <div class="catalog-image-holder">
    {% if comp.image contains '<svg' %}{{comp.image}}{% else %}<img alt="" src="{{comp.image}}" />{% endif %}
  </div>
  <p> {{comp.description}} </p>
  <p><a href="{{comp.link}}">Documentation</a></p><div class="clear"></div>
 </div>
 </li>
 {% endif %}
{% endfor %}
</ul>


{% for category in site.data.catalog.index %}
   {% if category.name == 'Styling' %}
    {% for sub in category.subcategories %}
        <h1 id="{{sub.name}}">{{sub.name}}</h1>
        <ul class="cards">
        {% for comp in site.data.catalog.widgets %}
         {% if comp.subcategories contains sub.name %}
         <li class="cards__item">
             <div class="catalog-entry" >
                <div class="catalog-image-holder">
                  {% if comp.image contains '<svg' %}{{comp.image}}{% else %}<img alt="" src="{{comp.image}}" />{% endif %}
                </div>
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