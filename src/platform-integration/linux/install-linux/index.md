---
title: Add Linux devtools for Flutter
description: Configure your system to develop Flutter for Linux.
short-title: Add Linux to possible Flutter SDK targets
target-list: [Android, Web]
---

To choose the guide to add Linux devtools to your Flutter configuration,
click the [Getting Started path][] you followed.

<div class="card-deck mb-8">
{% for target in page.target-list %}
{% assign targetlink='/platform-integration/linux/install-linux/install-linux-from-' | append: target | downcase %}
  <a class="card card-app-type card-linux"
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
        </span>
        <span class="text-muted">
        Make {{ target }} and Linux desktop apps
        </span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

[Getting Started path]: /get-started/install
