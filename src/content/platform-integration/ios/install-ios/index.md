---
title: Add iOS as a target platform for Flutter
description: Configure your system to develop Flutter for iOS.
short-title: Set up iOS development
target-list: [macOS, Android, web]
---

To set up your development environment for targeting iOS,
choose the guide that corresponds to the [Getting Started path][] you followed,
or the platform you already have set up.

<div class="card-grid">
{% for target in target-list %}
{% assign targetLink = '/platform-integration/ios/install-ios/install-ios-from-' | append: target | downcase %}
  <a class="card outlined-card install-card card-macos" id="install-{{target | downcase}}" href="{{targetLink}}">
    {% assign icon = target | downcase -%}
    <div class="card-leading">
      {% case icon %}
      {% when 'macos' -%}
        <span class="material-symbols" aria-hidden="true">laptop_mac</span>
      {% when 'android' -%}
        <span class="material-symbols" aria-hidden="true">phone_android</span>
      {% when 'web' -%}
        <span class="material-symbols" aria-hidden="true">web</span>
      {% endcase -%}
      <span class="material-symbols" aria-hidden="true">add</span>
      <span class="material-symbols" aria-hidden="true">phone_iphone</span>
    </div>
    <div class="card-header text-center">
      <header class="card-title">Make iOS and {{ target }}{% if target == 'macOS' %} desktop{% endif %} apps</header>
    </div>
  </a>
{% endfor %}
</div>

[Getting Started path]: /get-started/install
