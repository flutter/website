---
title: Install
description: Install Flutter and get started. Downloads available for Windows, macOS, Linux, and ChromeOS operating systems.
next:
  title: Set up an editor
  path: /get-started/editor
os-list: [Windows, macOS, Linux, ChromeOS]
---

Select the operating system on which you are installing Flutter:

<div class="card-deck mb-8">
{% for os in page.os-list %}
  <a class="card" id="install-{{os | remove: ' ' | downcase}}" href="{{site.url}}/get-started/install/{{os | remove: ' ' | downcase}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        <span class="d-block h1">
          {% assign icon = os | downcase -%}
            <img src="/assets/images/docs/brand-svg/{{icon}}.svg" width="72" height="72" aria-hidden="true" alt="{{os}} logo"> 
        </span>
        <span class="text-muted text-nowrap">{{os}}</span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

{% include docs/china-notice.md %}
