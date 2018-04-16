---
layout: page
title: Widget 目录
permalink: /widgets/
---

使用 Flutter 提供的视觉、结构、平台以及可交互的 Widgets 来更快的构建出一个美观的应用程序。

<p>除了按照分类来浏览这些 Widget，你也可以在 <a href="/widgets/widgetindex/">Flutter Widget 索引页面</a> 看到所有的 Widget。</p>

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
