---
title: Flutter learning resources
description: A catalog of Flutter sample applications, codelabs, and tutorials.
short-title: Learning resources
show_breadcrumbs: false
layout: wide
toc: false
js: [ { url: '/assets/js/learning-resources-index.js', defer: true } ]
---

<div id="resource-index-page">

:::secondary
This page lists all of our additional learning resources:
* Cookbook recipes that demonstrate how to solve common problems with Flutter.
* Guided Codelabs and tutorials that walk you through building features and applications.
* Working sample applications that show how to use Flutter.
* Feature-rich demo applications that show how larger applications are built.
:::

<div id="resource-index-content">
    <div class="left-col">
        <div 
            id="resource-search-group" 
            class="chip-filters-group" 
            style="margin-bottom:20px"
        >
            <div class="top-row">
                <div class="search-wrapper" id="resource-search">
                    <span class="material-symbols leading-icon" aria-hidden="true">search</span>
                    <input type="search" placeholder='Try "button" or "networking"...'
                        aria-label="Search learning resources by name and category">
                </div>
                {% comment -%}This dropdown is shown on narrow screens{% endcomment -%}
                <button class="dropdown-button">
                    <span class="material-symbols" aria-hidden="true">filter_list</span>
                </button>
                <div class="dropdown-position">
                    <div class="dropdown-content">
                        {%- render docs/learning-resources-index/side-filters.liquid filters:learning-resources-index.filters -%}
                    </div>
                </div>
            </div>
            <label for="resource-search">
                Showing <span id="displayed-resource-card-count">0</span> / <span id="total-resource-card-count">0</span>
            </label>
        </div>
        {% assign resources = learning-resources-index.codelabs | concat: learning-resources-index.cookbook | concat: learning-resources-index.demos | concat: learning-resources-index.quickstarts | sort: 'name' -%}
        {%- render docs/learning-resources-index/grid.liquid resources:resources -%}
    </div>
    <div class="right-col">
        {%- render docs/learning-resources-index/side-filters.liquid filters:learning-resources-index.filters -%}
    </div>
</div>
</div>