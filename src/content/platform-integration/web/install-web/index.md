---
title: Add Web devtools for Flutter
description: Configure your system to develop Flutter for Web.
short-title: Add Chrome DevTools
target-list: [windows-desktop, android-on-windows, linux-desktop, android-on-linux, macos-desktop, android-on-macos, ios-on-macos, android-on-chromeos]
---

To choose the guide to add Web devtools to your Flutter configuration,
click the [Getting Started path][] you followed.

{% for target in target-list %}
{% capture index0Modulo2 %}{{ forloop.index0 | modulo:2 }}{% endcapture %}
{% capture indexModulo2 %}{{ forloop.index | modulo:2 }}{% endcapture %}
{% assign targetlink='/platform-integration/web/install-web/install-web-from-' | append: target | downcase %}
  {% if index0Modulo2 == '0' %}
  <div class="card-deck mb-8">
  {% endif %}
  
  {% if target contains 'macos' or target contains 'ios' %}
    {% assign bug = 'card-macos' %}
  {% elsif target contains 'windows' %}
    {% assign bug = 'card-windows' %}
  {% elsif target contains 'linux' %}
    {% assign bug = 'card-linux' %}
  {% elsif target contains 'chrome' %}
    {% assign bug = 'card-chromeos' %}
  {% endif %}

  <a class="card card-app-type {{bug}}"
     id="install-{{target | downcase}}"
     href="{{targetlink}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        <span class="d-block h1">
          {% assign icon = target | downcase %}
          {% case icon %}
          {% when 'macos-desktop' %}
            <span class="material-symbols">laptop_mac</span>
          {% when 'ios-on-macos' %}
            <span class="material-symbols">phone_iphone</span>
          {% when 'windows-desktop','linux-desktop' %}
            <span class="material-symbols">desktop_windows</span>
          {% else %}
            <span class="material-symbols">phone_android</span>
          {% endcase %}
          <span class="material-symbols">add</span>
          <span class="material-symbols">web</span>
        </span>
        <span class="text-muted d-block">
        Make web and
        {{ target | replace: "-", " " | capitalize | replace: "Macos",
        "macOS" | replace: "macos", "macOS" | replace: "Ios", "iOS" |
        replace: "windows", "Windows" | replace: "linux", "Linux" |
        replace: "on", "apps on" | replace: "desktop", "desktop apps"}}
        </span>
      </header>
    </div>
  </a>
  {% if indexModulo2 == '0' %}
  </div>
  {% endif %}
{% endfor %}

[Getting Started path]: /get-started/install
