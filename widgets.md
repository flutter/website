---
layout: page
title: Widgets Overview
sidebar: home_sidebar
permalink: /widgets/
---

## Introduction

This page describes some of the widgets available in Flutter.

Flutter uses a layered approach. At the highest level we provide
[Material components](/widgets/catalog/material). These are implemented
in the [`material`
library](https://docs.flutter.io/flutter/material/material-library.html).
The `material` library is implemented in terms of the [`widgets`
library](https://docs.flutter.io/flutter/widgets/widgets-library.html).
That library in turn is implemented in terms of the [`rendering`
library](https://docs.flutter.io/flutter/rendering/rendering-library.html),
and so forth.

Even within each library, we use a layered approach. For example, the
`widgets` library's
[`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html)
widget is implemented in terms of lower-level widgets from the same
library, such as
[`Padding`](https://docs.flutter.io/flutter/widgets/Padding-class.html)
and
[`ConstrainedBox`](https://docs.flutter.io/flutter/widgets/ConstrainedBox-class.html).

<ul class="cards">
{% for section in site.data.catalog.index %}
         <li class="cards__item">
            <a href="/widgets/catalog/{{section.id}}">
             <div class="card">
             <h3>{{section.name}}</h3>
             <p>{{section.description}}</p>
             </div>
             </a>
         </li>
 {% endfor %}
</ul>