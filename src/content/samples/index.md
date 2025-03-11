---
title: Flutter tutorials and sample code
description: A catalog of Flutter sample applications.
short-title: Samples
toc: false
js: [ { url: '/assets/js/samples.js', defer: true } ]
---

<div id="samples-filters" class="dropdown-group">
    <button class="chip filter-chip" data-filter="isCodelab" role="checkbox" aria-checked="false" aria-label="Show only Codelabs.">
      <svg class="chip-icon leading-icon" viewBox="0 0 18 18" aria-hidden="true">
        <path d="M6.75012 12.1274L3.62262 8.99988L2.55762 10.0574L6.75012 14.2499L15.7501 5.24988L14.6926 4.19238L6.75012 12.1274Z"></path>
      </svg>
      <span class="label">Codelabs</span>
    </button>
    {% comment %}
    <select class='dropdown-select' name="type" id="type">
        <option value="codelabs">All types</option>
        <option value="codelabs">Codelab</option>
        <option value="samples">Sample code</option>
        <option value="recipes">Cookbook recipes</option>
    </select>
    <select class='dropdown-select' name="feature" id="type">
        <option value="codelabs">All features</option>
        <option value="codelabs">Animations</option>
        <option value="samples">Layout</option>
        <option value="recipes">Cookbook recipes</option>
    </select>
    {% endcomment %}
</div>

{% assign categories = samples_data.categories -%} 
{%- assign samples = samples_data.items -%}

<section id="all-samples-tables">

{% for category in categories -%}
    <h2>{{category.name}}</h2>
    <p>{{category.description}}</p>
        {% assign type_samples = samples | where: "type", category.type %}
        {% render docs/samples/sample-table.md, samples:type_samples %}
{% endfor %}
</section>
