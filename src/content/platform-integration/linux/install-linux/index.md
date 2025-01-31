---
title: Add Linux as a target platform for Flutter
description: Configure your system to develop Flutter for Linux.
short-title: Set up Linux development
target-list: [Android, web]
---

To set up your development environment for targeting Linux,
choose the guide that corresponds to the [Getting Started path][] you followed,
or the platform you already have set up.

<div class="card-grid">
{% for target in target-list %}
{% assign targetLink = '/platform-integration/linux/install-linux/install-linux-from-' | append: target | downcase %}
  <a class="card outlined-card install-card card-linux" id="install-{{target | downcase}}" href="{{targetLink}}">
    {% assign icon = target | downcase -%}
    <div class="card-leading">
      {% case icon %}
      {% when 'android' -%}
        <span class="material-symbols" aria-hidden="true">phone_android</span>
      {% when 'web' -%}
        <span class="material-symbols" aria-hidden="true">web</span>
      {% endcase -%}
    </div>
    <div class="card-header text-center">
      <header class="card-title">Make {{ target }} and Linux desktop apps</header>
    </div>
  </a>
{% endfor %}
</div>

[Getting Started path]: /get-started/install
