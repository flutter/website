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
  <a class="card outlined-card install-card card-macos" id="install-{{target | downcase}}" href="{{targetLink}}">
    {% assign icon = target | downcase -%}
    <div class="card-leading">
      {% case icon %}
      {% when 'ios' -%}
        <span class="material-symbols" aria-hidden="true">phone_iphone</span>
      {% when 'android' -%}
        <span class="material-symbols" aria-hidden="true">phone_android</span>
      {% when 'web' -%}
        <span class="material-symbols" aria-hidden="true">web</span>
      {% endcase -%}
      <span class="material-symbols" aria-hidden="true">add</span>
      <span class="material-symbols" aria-hidden="true">laptop_mac</span>
    </div>
    <div class="card-header text-center">
      <header class="card-title">Make {{ target }} and macOS desktop apps</header>
    </div>
  </a>
{% endfor %}
</div>

[Getting Started path]: /get-started/install
