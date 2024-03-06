---
title: Add Android devtools for Flutter
description: Configure your system to develop Flutter for Android.
short-title: Add Android to possible Flutter SDK targets
target-list: [macOS, Windows, iOS, Web]
---

<div class="card-deck mb-8">
{% for target in page.target-list %}
{% assign targetlink='/platform-integration/android/install-android/install-android-from-' | append: target | downcase %}
  <a class="card card-app-type"
     id="install-{{target | downcase}}"
     href="{{targetlink}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        <span class="d-block h1">
          {% assign icon = target | downcase -%}
          {% case icon %}
          {% when 'macos' -%}
            <span class="material-symbols">laptop_mac</span>
          {% when 'windows' -%}
            <span class="material-symbols">desktop_windows</span>
          {% when 'ios' -%}
            <span class="material-symbols">phone_iphone</span>
          {% when 'web' -%}
            <span class="material-symbols">open_in_browser</span>
          {% endcase -%}
        </span>
        <span class="text-muted text-nowrap">
        {{ target }}
        </span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

{% include docs/china-notice.md %}
