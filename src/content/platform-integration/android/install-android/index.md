---
title: Add Android as a target platform for Flutter
description: Configure your system to develop Flutter for Android.
short-title: Set up Android development
target-list: [Windows, 'web on Windows', Linux, 'web on Linux', macOS, 'web on macOS', iOS, 'web on ChromeOS']
---

To set up your development environment for targeting Android,
choose the guide that corresponds to the [Getting Started path][] you followed,
or the platform you already have set up.

<div class="card-grid">
{% for target in target-list %}
{% assign targetLink = '/platform-integration/android/install-android/install-android-from-' | append: target | downcase | replace: " ", "-" %}

  {% if target contains 'macOS' or target contains 'iOS' %}
    {% assign bug = 'card-macos' %}
  {% elsif target contains 'Windows' %}
    {% assign bug = 'card-windows' %}
  {% elsif target contains 'Linux' %}
    {% assign bug = 'card-linux' %}
  {% elsif target contains 'ChromeOS' %}
    {% assign bug = 'card-chromeos' %}
  {% endif %}

  <a class="card outlined-card install-card {{bug}}" id="install-{{target | downcase}}" href="{{targetLink}}">
    {% assign icon = target | downcase | replace: " ", "-" -%}
    <div class="card-leading">
      {% case icon %}
      {% when 'macos' -%}
        <span class="material-symbols" aria-hidden="true">laptop_mac</span>
      {% when 'windows','linux' -%}
        <span class="material-symbols" aria-hidden="true">desktop_windows</span>
      {% when 'ios' -%}
        <span class="material-symbols" aria-hidden="true">phone_iphone</span>
      {% else -%}
        <span class="material-symbols" aria-hidden="true">web</span>
      {% endcase -%}
      <span class="material-symbols" aria-hidden="true">add</span>
      <span class="material-symbols" aria-hidden="true">phone_android</span>
    </div>
    <div class="card-header text-center">
      <span class="card-title">
        Make Android and
        {% if target contains "iOS" -%}
        {{target}} apps on macOS
        {%- elsif target contains "on" -%}
        {{ target | replace: "on", "apps on" }}
        {%- else -%}
        {{target}} desktop apps
        {%- endif -%}
      </span>
    </div>
  </a>
{% endfor %}
</div>

[Getting Started path]: /get-started/install
