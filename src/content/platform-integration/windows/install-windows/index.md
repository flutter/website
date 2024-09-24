---
title: Add Windows as a target platform for Flutter
description: Configure your system to develop Flutter for Windows.
short-title: Set up Windows development
target-list: [Android, web]
---

To set up your development environment for targeting Windows,
choose the guide that corresponds to the [Getting Started path][] you followed,
or the platform you already have set up.

<div class="card-grid">
{% for target in target-list %}
{% assign targetLink = '/platform-integration/windows/install-windows/install-windows-from-' | append: target | downcase %}
  <a class="card card-app-type card-windows" id="install-{{target | downcase}}" href="{{targetLink}}">
    <div class="card-body">
      <header class="card-title card-center">
        <span>
          {% assign icon = target | downcase -%}
          {% case icon %}
          {% when 'android' -%}
            <span class="material-symbols">phone_android</span>
          {% when 'web' -%}
            <span class="material-symbols">web</span>
          {% endcase -%}
          <span class="material-symbols">add</span>
          <span class="material-symbols">desktop_windows</span>
        </span>
        <span class="card-muted">
        Make Windows desktop and {{ target }} apps
        </span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

[Getting Started path]: /get-started/install
