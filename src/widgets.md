---
title: Widgets Catalog
---

Create beautiful apps faster with Flutter's
collection of visual, structural, platform,
and interactive widgets.

<p>In addition to browsing widgets by category,
you can also see all the widgets in the <a href="/widgets/widgetindex">Flutter widget index</a>.</p>

<ul class="cards">
{% for section in site.data.catalog.index %}
	<li class="cards__item">
	    <div class="card">
		    <h3 class="catalog-category-title"><a class="action-link" href="/widgets/{{section.id}}">{{section.name}}</a></h3>
		    <p>{{section.description}}</p>
		    <div class="card-action">
		        <a class="action-link" href="/widgets/{{section.id}}">VISIT</a>
		    </div>
		</div>

	</li>
 {% endfor %}
</ul>
