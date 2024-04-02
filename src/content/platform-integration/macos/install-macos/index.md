---
title: Add macOS devtools for Flutter
description: Configure your system to develop Flutter for macOS.
short-title: Add macOS desktop DevTools
target-list: [iOS, Android, Web]
---

To choose the guide to add macOS devtools to your Flutter configuration,
click the [Getting Started path][] you followed.

<div class="card-deck mb-8">
{% for target in target-list %}
{% assign targetlink='/platform-integration/macos/install-macos/install-macos-from-' | append: target | downcase %}
  <a class="card card-app-type card-macos"
     id="install-{{target | downcase}}"
     href="{{targetlink}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        <span class="d-block h1">
          {% assign icon = target | downcase -%}
          {% case icon %}
          {% when 'ios' -%}
            <span class="material-symbols">phone_iphone</span>
          {% when 'android' -%}
            <span class="material-symbols">phone_android</span>
          {% when 'web' -%}
            <span class="material-symbols">web</span>
          {% endcase -%}
          <span class="material-symbols">add</span>
          <span class="material-symbols">laptop_mac</span>
        </span>
        <span class="text-muted">
        Make {{ target }} and macOS desktop apps
        </span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

[Getting Started path]: /get-started/install
