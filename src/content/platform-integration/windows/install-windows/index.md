---
title: Add Windows devtools for Flutter
description: Configure your system to develop Flutter for Windows.
short-title: Add Windows desktop DevTools
target-list: [Android, Web]
---

To choose the guide to add Visual Studio to your Flutter configuration,
click the [Getting Started path][] you followed.

<div class="card-deck mb-8">
{% for target in target-list %}
{% assign targetlink='/platform-integration/windows/install-windows/install-windows-from-' | append: target | downcase %}
  <a class="card card-app-type card-windows"
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
            <span class="material-symbols">web</span>
          {% endcase -%}
          <span class="material-symbols">add</span>
          <span class="material-symbols">desktop_windows</span>
        </span>
        <span class="text-muted text-nowrap">
        Make Windows desktop and {{ target }} apps
        </span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

[Getting Started path]: /get-started/install
