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
  <a class="card outlined-card install-card card-windows" id="install-{{target | downcase}}" href="{{targetLink}}">
    {% assign icon = target | downcase -%}
    <div class="card-leading">
      {% case icon %}
      {% when 'android' -%}
        <span class="material-symbols" aria-hidden="true">phone_android</span>
      {% when 'web' -%}
        <span class="material-symbols" aria-hidden="true">web</span>
      {% endcase -%}
      <span class="material-symbols" aria-hidden="true">add</span>
      <span class="material-symbols" aria-hidden="true">desktop_windows</span>
    </div>
    <div class="card-header text-center">
      <header class="card-title">Make Windows desktop and {{ target }} apps</header>
    </div>
  </a>
{% endfor %}
</div>

[Getting Started path]: /get-started/install
