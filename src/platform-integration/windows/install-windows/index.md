---
title: Add Windows devtools for Flutter
description: Configure your system to develop Flutter for Windows.
short-title: Add Windows to possible Flutter SDK targets
target-list: [Android, Web]
---

<div class="card-deck mb-8">
{% for target in page.target-list %}
{% assign targetlink='/platform-integration/windows/install-windows/install-windows-from-' | append: target | downcase %}
  <a class="card card-app-type"
     id="install-{{target | downcase}}"
     href="{{targetlink}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        <span class="d-block h1">
          {% assign icon = target | downcase -%}
          {% case icon %}
          {% when 'android' -%}
            <span class="material-symbols">phone_android</span>
          {% when 'web' -%}
            <span class="material-symbols">open_in_browser</span>
          {% endcase -%}
        </span>
        <span class="text-muted text-nowrap">
        {{ target }}
        </span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

{% include docs/china-notice.md %}
