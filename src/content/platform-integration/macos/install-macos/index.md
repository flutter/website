---
title: Add macOS as a target platform for Flutter
description: Configure your system to develop Flutter for macOS.
short-title: Set up macOS development
target-list: [iOS, Android, web]
---

To set up your development environment for targeting macOS,
choose the guide that corresponds to the [Getting Started path][] you followed,
or the platform you already have set up.

<div class="card-grid">
{% for target in target-list %}
{% assign targetLink = '/platform-integration/macos/install-macos/install-macos-from-' | append: target | downcase %}
  <a class="card card-app-type card-macos" id="install-{{target | downcase}}" href="{{targetLink}}">
    <div class="card-body">
      <header class="card-title card-center">
        <span>
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
        <span class="card-muted">
        Make {{ target }} and macOS desktop apps
        </span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

[Getting Started path]: /get-started/install
