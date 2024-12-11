---
title: Architecture design patterns
short-title: Design patterns
description: >-
  A collection of articles about useful design patterns for
  building Flutter applications.
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

{% assign recipes = collections.design-patterns | sort: "data.order" -%}
{% render expansion-list.html, list: recipes, baseId: 'design-patterns' %}

[architecture guide]: /app-architecture/guide
