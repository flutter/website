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

<section id="all-samples-tables">

{% for type in samples -%}
    <h2>{{type.name}}</h2>
    <p>{{type.description}}</p>
        <table class="samples-table table" style="border-bottom:1px #DADCE0 solid;">
            {% for item in type.items -%}
                {% if item.type == "header" -%}
                    <tr class="tr-main-head" style="text-align: left">
                        <th></th>
                        <th colspan="3">
                            <h3>{{item.name}}</h3>
                            <label>{{item.description}}</label>
                        </th>
                    </tr>
                    <tr class="tr-sub-head" style="text-align: left">
                        <th style="width: 5%"></th>
                        <th style="width: 30%">Title</th>
                        <th style="width: 40%">Description</th>
                        <th align="center" style="width: 10%">Link</th>
                    </tr>
                {% else -%}
                    <tr id="{{item.name}}">
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
               {% endif -%}
            {% endfor -%}
        </table>

{% endfor %}
</section>
