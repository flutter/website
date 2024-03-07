---
title: Add macOS devtools for Flutter
description: Configure your system to develop Flutter for macOS.
short-title: Add macOS to possible Flutter SDK targets
target-list: [iOS, Android, Web]
---

To choose the guide to add macOS devtools to your Flutter configuration,
click the [Getting Started path][] you followed.

<div class="card-deck mb-8">
{% for target in page.target-list %}
{% assign targetlink='/platform-integration/macos/install-macos/install-macos-from-' | append: target | downcase %}
  <a class="card card-app-type"
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

[Getting Started path]: /get-started/install
