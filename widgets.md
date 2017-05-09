---
layout: page
title: Widgets Catalog
sidebar: home_sidebar
permalink: /widgets/
---

Flutter includes many different widgets, including
low-level widgets such as painting, and high-level widgets
such as Material Design and Cupertino (iOS-style).

<ul class="cards">
{% for section in site.data.catalog.index %}
	<li class="cards__item">
		<a href="/widgets/{{section.id}}">
			<div class="card">
			<h3>{{section.name}}</h3>
			<p>{{section.description}}</p>
			</div>
		</a>
	</li>
 {% endfor %}
</ul>