---
title: Architecture design patterns
short-title: Design patterns
description: >
  TODO
prev:
  title: Recommendations
  path: /app-architecture/recommendations
---

LOREM IPSUM, BROTHER


{% assign recipes = cookbook.design_patterns | sort: 'name' -%}
{% render expansion-list.html, list: recipes, base_id: 'design-patterns' %}