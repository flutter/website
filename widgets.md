---
layout: page
title: Widgets Catalog
sidebar: home_sidebar
permalink: /widgets/
---

Create beautiful apps faster with Flutter's
collection of visual, structural, platform,
and interactive widgets.

<ul class="cards">
{% for section in site.data.catalog.index %}
	<li class="cards__item">
	    <div class="card">
		    <h3>{{section.name}}</h3>
		    <p>{{section.description}}</p>
		    <div class="card-action">
		        <a class="action-link" href="/widgets/{{section.id}}">VISIT</a>
		    </div>
		</div>
		
	</li>
 {% endfor %}
</ul>