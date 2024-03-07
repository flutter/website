---
title: Add Android devtools for Flutter
description: Configure your system to develop Flutter for Android.
short-title: Add Android to possible Flutter SDK targets
target-list: [macOS, Windows, iOS, 'Web on macOS', 'Web on Windows']
---

To choose the guide to add Android Studio to your Flutter configuration,
click the [Getting Started path][] you followed.

<div class="card-deck mb-8">
{% for target in page.target-list %}
{% assign targetlink='/platform-integration/android/install-android/install-android-from-' | append: target | downcase | replace: " ", "-" %}
  <a class="card card-app-type"
     id="install-{{target | downcase}}"
     href="{{targetlink}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        <span class="d-block h1">
          {% assign icon = target | downcase | replace: " ", "-" -%}
          {% case icon %}
          {% when 'macos' -%}
            <span class="material-symbols">laptop_mac</span>
          {% when 'windows' -%}
            <span class="material-symbols">desktop_windows</span>
          {% when 'ios' -%}
            <span class="material-symbols">phone_iphone</span>
          {% when 'web-on-macos' -%}
            <span class="material-symbols">laptop_mac</span><br>
            <span class="material-symbols">add</span><br>
            <span class="material-symbols">open_in_browser</span>
          {% when 'web-on-windows' -%}
            <span class="material-symbols">desktop_windows</span><br>
            <span class="material-symbols">add</span><br>
            <span class="material-symbols">open_in_browser</span>
          {% endcase %}
        </span>
        <span class="text-muted">
        {{ target }}
        </span>
      </header>
    </div>
  </a>
{% endfor %}
  </div>

[Getting Started path]: /get-started/install
