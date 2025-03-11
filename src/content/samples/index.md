---
title: Flutter tutorials and sample code
description: A catalog of Flutter sample applications. 
short-title: Samples
toc: false
---


<div class="dropdown-group">
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
</div>


{% for section in samples %}
<h2>{{section.category}}</h2>
<p>{{section.description}}</p>
<table class="table table-striped" style="border-bottom:1px #DADCE0 solid">
        <tr class="tr-main-head" style="text-align: left">
            <th style="width: 8%"></th>
            <th style="width: 15%">Title</th>
            <th style="width: 22%">Features</th>
            <th style="width: 50%">Description</th>
            <th style="width: 10%">Link</th>
        </tr>
        {% for sample in section.samples %}
            <tr>
                <td>
                    {%- if sample.platform == "dart" -%}
                    <img src='/assets/images/branding/dart/64.png' alt="Dart icon" width="24px"/>
                    {%- else -%}
                    <img src='/assets/images/branding/flutter/icon/1080.png' alt="Flutter icon" width="24px"/>
                    {% endif %}
                </td>
                <td>
                    <p>{{sample.title}}</p>
                </td>
                <td>
                    <p>{{sample.features}}</p>
                </td>
                <td>
                    <p>{{sample.description}}</p>
                </td>
                <td>
                    <a href="{{sample.link}}">Source</a>
                </td>
            </tr>
        {% endfor %}
</table>
{% endfor %}