---
title: Add Android devtools for Flutter
description: Configure your system to develop Flutter for Android.
short-title: Add Android to possible Flutter SDK targets
target-list: [Windows, 'Web on Windows', Linux, 'Web on Linux', macOS, 'Web on macOS', iOS, Web on ChromeOS]
---

To choose the guide to add Android Studio to your Flutter configuration,
click the [Getting Started path][] you followed.

{% for target in page.target-list %}
{% capture index0Modulo2 %}{{ forloop.index0 | modulo:2 }}{% endcapture %}
{% capture indexModulo2 %}{{ forloop.index | modulo:2 }}{% endcapture %}
{% assign
targetlink='/platform-integration/android/install-android/install-android-from-'
| append: target | downcase | replace: " ", "-" %}
  {% if index0Modulo2 == '0' %}
  <div class="card-deck mb-8">
  {% endif %}

  {% if target contains 'macOS' or target contains 'iOS' %}
    {% assign bug = 'card-macos' %}
  {% elsif target contains 'Windows' %}
    {% assign bug = 'card-windows' %}
  {% elsif target contains 'Linux' %}
    {% assign bug = 'card-linux' %}
  {% elsif target contains 'ChromeOS' %}
    {% assign bug = 'card-chromeos' %}
  {% endif %}

  <a class="card card-app-type {{bug}}"
     id="install-{{target | downcase}}"
     href="{{targetlink}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        <span class="d-block h1">
          {% assign icon = target | downcase | replace: " ", "-" -%}
          {% case icon %}
          {% when 'macos' -%}
            <span class="material-symbols">laptop_mac</span>
          {% when 'windows','linux' -%}
            <span class="material-symbols">desktop_windows</span>
          {% when 'ios' -%}
            <span class="material-symbols">phone_iphone</span>
          {% else -%}
            <span class="material-symbols">web</span>
          {% endcase %}
          <span class="material-symbols">add</span>
          <span class="material-symbols">phone_android</span>
        </span>
        <span class="text-muted">
        Make Android and
        {% if target contains "iOS" %}
        {{target}} apps on macOS
        {% elsif target contains "on" %}
        {{ target | replace: "on", "apps on" }}
        {% else %}
        {{target}} desktop apps
        {% endif %}
        </span>
      </header>
    </div>
  </a>
  {% if indexModulo2 == '0' %}
  </div>
  {% endif %}
{% endfor %}

[Getting Started path]: /get-started/install
