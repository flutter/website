---
title: Set up web development for Flutter
description: Configure your system to develop Flutter for the web.
short-title: Set up web development
target-list: [windows-desktop, android-on-windows, linux-desktop, android-on-linux, macos-desktop, android-on-macos, ios-on-macos, android-on-chromeos]
---

To set up your development environment for targeting the web,
choose the guide that corresponds to the [Getting Started path][] you followed,
or the platform you already have set up.

<div class="card-grid">
{% for target in target-list %}
{% assign targetLink = '/platform-integration/web/install-web/install-web-from-' | append: target | downcase %}
  {% if target contains 'macos' or target contains 'ios' %}
    {% assign bug = 'card-macos' %}
  {% elsif target contains 'windows' %}
    {% assign bug = 'card-windows' %}
  {% elsif target contains 'linux' %}
    {% assign bug = 'card-linux' %}
  {% elsif target contains 'chrome' %}
    {% assign bug = 'card-chromeos' %}
  {% endif %}

  <a class="card card-app-type {{bug}}" id="install-{{target | downcase}}" href="{{targetLink}}">
    <div class="card-body">
      <header class="card-title card-center">
        <span>
          {% assign icon = target | downcase -%}
          {% case icon %}
          {% when 'macos-desktop' -%}
            <span class="material-symbols">laptop_mac</span>
          {% when 'ios-on-macos' -%}
            <span class="material-symbols">phone_iphone</span>
          {% when 'windows-desktop','linux-desktop' -%}
            <span class="material-symbols">desktop_windows</span>
          {% else -%}
            <span class="material-symbols">phone_android</span>
          {% endcase -%}
          <span class="material-symbols">add</span>
          <span class="material-symbols">web</span>
        </span>
        <span class="card-muted">
        Make web and
        {{ target | replace: "-", " " | capitalize | replace: "Macos",
        "macOS" | replace: "macos", "macOS" | replace: "Ios", "iOS" |
        replace: "windows", "Windows" | replace: "linux", "Linux" |
        replace: "on", "apps on" | replace: "desktop", "desktop apps" }}
        </span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

[Getting Started path]: /get-started/install
