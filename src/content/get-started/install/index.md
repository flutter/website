---
title: Choose your development platform to get started
short-title: Install
description: Install Flutter and get started. Downloads available for Windows, macOS, Linux, and ChromeOS operating systems.
os-list: [Windows, macOS, Linux, ChromeOS]
js: [{url: '/assets/js/page/install-current.js'}]
---

<div class="card-grid narrow">
{% for os in os-list %}
  <a class="card" id="install-{{os | remove: ' ' | downcase}}" href="/get-started/install/{{os | remove: ' ' | downcase}}">
    <div class="card-body">
      <header class="card-title card-center">
        <span>
          {% assign icon = os | downcase -%}
          <img src="/assets/images/docs/brand-svg/{{icon}}.svg" width="72" height="72" aria-hidden="true" alt="{{os}} logo"> 
        </span>
        <span class="card-muted">{{os}}</span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

{% render docs/china-notice.md %}
