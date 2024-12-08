---
title: Architecture design patterns
short-title: Design patterns
description: >
  TODO
prev:
  title: Recommendations
  path: /app-architecture/recommendations
toc: false
---

If you've already read through the [architecture guide][] page,
or if you're comfortable with Flutter and the MVVM pattern,
the following articles are for you.

These articles aren't about high-level app architecture,
rather they're about solving specific design problems that improve your 
application's code base regardless of how you've architected your app.
That said, the articles do assume the MVVM pattern laid out on the 
previous pages in the code examples.

{% assign recipes = cookbook.design_patterns | sort: 'name' -%}
{% render expansion-list.html, list: recipes, base_id: 'design-patterns' %}

[architecture guide]: /app-architecture/guide
