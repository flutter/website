---
layout: page
title: Flutter Widget 索引
permalink: widgets/widgetindex/
---
{% assign sorted = site.data.catalog.widgets | sort:'name' %}
<div class="catalog">
    <div class="category-description"><p>下面是一个几乎包含了所有被打包进 Flutter 的 Widget 列表，它们按照字母表的顺序进行排序。你也可以 <a href="/widgets">点击这里</a> 按照不同的分类来浏览这些 Widgets。</p></div>
    <ul class="cards">
        {% for comp in sorted %}
        <li class="cards__item">
            <div class="catalog-entry">
                <div class="catalog-image-holder">{{comp.image}}</div>
                <h3>{{comp.name}}</h3>
                <p class="scrollable-description"> {{comp.description}} </p>
                <p><a href="{{comp.link}}">Documentation</a></p><div class="clear"></div>
            </div>
        </li>
        {% endfor %}
    </ul>
</div>