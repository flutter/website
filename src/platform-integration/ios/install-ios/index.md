---
title: Add iOS devtools for Flutter
description: Configure your system to develop Flutter for iOS.
short-title: Add iOS to possible Flutter SDK targets
target-list: [macOS, Android, Web]
---

<div class="card-deck mb-8">
{% for target in page.target-list %}
{% assign targetlink='/platform-integration/ios/install-ios/install-ios-from-' | append: target | downcase %}
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
          {% when 'android' -%}
            <span class="material-symbols">phone_android</span>
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
