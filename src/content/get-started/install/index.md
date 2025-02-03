---
title: Choose your development platform to get started
short-title: Install
description: Install Flutter and get started. Downloads available for Windows, macOS, Linux, and ChromeOS operating systems.
os-list: [Windows, macOS, Linux, ChromeOS]
js: [{url: '/assets/js/page/install-current.js'}]
---

<div class="card-grid narrow">
{% for os in os-list %}
  <a class="card outlined-card install-card" id="install-{{os | remove: ' ' | downcase}}" href="/get-started/install/{{os | remove: ' ' | downcase}}">
    <div class="card-leading">
      <img src="/assets/images/docs/brand-svg/{{os | downcase}}.svg" width="72" height="72" aria-hidden="true" alt="{{os}} logo">
    </div>
    <div class="card-header text-center">
      <header class="card-title">{{os}}</header>
    </div>
  </a>
{% endfor %}
</div>

{% render docs/china-notice.md %}
