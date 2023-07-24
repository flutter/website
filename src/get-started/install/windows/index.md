---
title: Choose your first type of app
description: Configure your system to develop Flutter on Windows.
short-title: Windows
target-list: [Web, Mobile, Desktop]
---

{% assign os = 'windows' -%}

<div class="card-deck mb-8">
{% for target in page.target-list %}
  <a class="card" id="install-{{os | remove: ' ' | downcase}}" href="{{site.url}}/get-started/install/{{os | remove: ' ' | downcase}}/{{target | downcase}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        <span class="d-block h1">
          {% assign icon = target | downcase -%}
          {% if icon == 'desktop' -%}
            <span class="material-icons">desktop_windows</span>
          {% elsif icon == 'mobile' -%}
            <span class="material-icons">phone_android</span>
          {% else -%}
            <span class="material-icons">open_in_browser</span>
          {% endif -%}
        </span>
        <span class="text-muted text-nowrap">{{target}}</span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

{% include docs/china-notice.md %}
