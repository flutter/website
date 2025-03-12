---
title: Flutter tutorials and sample code
description: A catalog of Flutter sample applications.
short-title: Samples
toc: false
js: [ { url: '/assets/js/samples.js', defer: true } ]
---

<div id="samples-filter-group" class="chip-filters-group" style="margin-bottom:20px"> 
<div id="chip-set" class="chip-set">
    <div class="button-menu-wrapper">
      <button class="chip select-chip" data-menu="type-menu" data-title="Type" aria-controls="type-menu" aria-expanded="false">
        <span class="label">Type</span>
        <svg class="chip-icon trailing-icon" width="24" height="24" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M7 10l5 5 5-5H7z"></path>
        </svg>
      </button>
        <div id="type-menu" class="select-menu">
            <ul role="listbox">
                <li><button class='selected' data-filter="all" role="option" aria-selected="true">
                  <span class="label">All</span>
                </button></li>
                <li><button data-filter="codelab" role="option" aria-selected="false">
                  <span class="label">Codelab</span>
                </button></li>
                <li><button data-filter="recipe" role="option" aria-selected="false">
                  <span class="label">Cookbook Recipe</span>
                </button></li>
                <li><button data-filter="sample" role="option" aria-selected="false">
                  <span class="label">Sample code</span>
                </button></li>
            </ul>
        </div>
    </div>
</div>
    <div class="search-row">
        <div class="search-wrapper">
          <span class="material-symbols leading-icon" aria-hidden="true">search</span>
          <input type="search" placeholder="Search resources..." aria-label="Search learning resources by name and category">
        </div>
    </div>
 <button class="text-button" id="reset-filters">Clear filters</button>
</div>

<section id="all-samples-tables">
{% for type in samples -%}
        <table id="table-{{type.type}}" class="samples-table table" style="border-bottom:1px #DADCE0 solid;" >
            <tr class="tr-main-head tr-head" style="text-align: left" id="tr-header-{{item.type}}">
                <th></th>
                <th colspan="3">
                    <div class="th-section-head">{{type.name}}</div>
                    <label>{{type.description}}</label>
                </th>
            </tr>
            <tr class="tr-sub-head tr-head" style="text-align: left">
                <th style="width: 5%"></th>
                <th style="width: 30%">Title</th>
                <th style="width: 40%">Description</th>
                <th align="center" style="width: 10%">Link</th>
            </tr>
            {% for item in type.items -%}
                    <tr class='table-row' id="{{item.name}}" data-type="{{item.type}}" data-categories='{{item.categories | join: ", "}}'>
                        <td>
                            {%- if item.sdk == "dart" -%}
                                <img src='/assets/images/branding/dart/64.png' alt="Dart icon" width="24px"/>
                            {%- else -%}
                                <img src='/assets/images/branding/flutter/icon/1080.png' alt="Flutter icon" width="24px"/>
                            {% endif %}
                        </td>
                        <td>
                            <p>{{item.name}}</p>
                        </td>
                        <td>
                            <p>{{item.description}}</p>
                        </td>
                        <td align="center">
                            <a class="td-icon" href="{{item.source-link.url}}" target="_blank" rel="noopener" title="{{item.source-link.label}}">
                            {%- if item.type == "sample" -%}
                            <svg width="24px" height="24px"><use href="/assets/images/social/github.svg#github"></use></svg>
                            {%- elsif item.type == "codelab" -%}
                                <svg width="24px" height="24px"><use href="/assets/images/social/google-developers.svg#google-developers"></use></svg>
                            {%- endif -%}
                            </a>
                        </td>
                    </tr>
            {% endfor -%}
        </table>

{% endfor %}
</section>
