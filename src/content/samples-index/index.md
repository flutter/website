---
title: Flutter tutorials and sample code
description: A catalog of Flutter sample applications.
short-title: Samples
toc: false
js: [ { url: '/assets/js/samples.js', defer: true } ]
---

<div id="samples-filter-group" class="chip-filters-group" style="margin-bottom:20px"> 
{%- comment -%}
<div id="chip-set" class="chip-set">
    <div class="button-menu-wrapper">
      <button class="chip select-chip" data-menu="menu-type" data-title="Type" aria-controls="menu-type" aria-expanded="false">
        <span class="label">Type</span>
        <svg class="chip-icon trailing-icon" width="24" height="24" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M7 10l5 5 5-5H7z"></path>
        </svg>
      </button>
        <div id="menu-type" class="select-menu">
            <ul role="listbox">
                <li><button class='selected' data-filter="all" role="option" aria-selected="true">
                  <span class="label">All</span>
                </button></li>
                {%- for filter in samples_index.filters -%}
                    <li><button data-filter='{{filter.types | join: ","}}' role="option" aria-selected="false">
                        <span class="label">{{filter.label}}</span>
                    </button></li>
                {%- endfor -%}
            </ul>
        </div>
    </div>
</div>
 <button class="text-button" id="reset-filters">Clear filters</button>
{%- endcomment -%}
    <div class="search-row">
        <div class="search-wrapper">
          <span class="material-symbols leading-icon" aria-hidden="true">search</span>
          <input type="search" placeholder='Try "button" or "networking"...' aria-label="Search learning resources by name and category">
        </div>
    </div>
</div>


{% assign samples = samples_index.all | sort: 'name' -%}
<section class="card-grid" id="all-samples-grid">
    {%- for item in samples -%}
        <a class="card outlined-card" href="{{item.source-link.url}}">
            <div class="card-image-holder-material-3">
                {%- if item.imageUrl -%}
                    <img src='{{item.imageUrl}}'>
                {%- endif -%}
            </div>
            <div class="card-leading">
                {%- liquid
                    case item.type
                    when 'codelab'
                      assign pill-color = 'flutter-blue'
                    when 'quickstart'
                      assign pill-color = 'purple'
                    when 'demo'
                      assign pill-color = 'purple'
                    else
                      assign pill-color = 'teal'
                    endcase -%}
                <span class="pill-sm {{pill-color}}">{{item.type | capitalize }}</span>
                {%- if item.source-link.label == "Github" -%}
                    <svg width="24px" height="24px"><use href="/assets/images/social/github.svg#github"></use></svg>
                {%- elsif item.source-link.label == 'Flutter docs' -%}
                    <img src='/assets/images/branding/flutter/icon/1080.png' alt="Flutter icon" width="24px"/>
                {%- elsif item.source-link.label == 'Dart docs' -%}
                    <img src='/assets/images/branding/dart/64.png' alt="Dart icon" width="24px"/>
                {%- elsif item.source-link.label == "Google Codelab" -%}
                    <svg width="24px" height="24px"><use href="/assets/images/social/google-developers.svg#google-developers"></use></svg>
                {%- endif -%}
            </div>
            <div class="card-header">
                <span class="card-title">{{item.name}}</span>
            </div>
            <div class="card-content" style="flex:2;align-self: start">
                <p style="align-self: start">{{item.description}}</p>
            </div>
        </a>
    {%- endfor -%}
</section>

{%- comment -%}
<section id="all-samples-tables">
    {%- render docs/samples/sample-table.md category:samples_index.codelabs -%}
    {%- render docs/samples/sample-table.md category:samples_index.cookbook -%}
    {%- render docs/samples/sample-table.md category:samples_index.quickstarts -%}
    {%- render docs/samples/sample-table.md category:samples_index.demos -%}
</section>
{%- endcomment -%}

