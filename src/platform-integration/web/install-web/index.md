---
title: Add Web devtools for Flutter
description: Configure your system to develop Flutter for Web.
short-title: Add Web to possible Flutter SDK targets
target-list: [macos-desktop, windows-desktop, ios-on-macos,
android-on-macos, android-on-windows]
---

<div class="card-deck mb-8">
{% for target in page.target-list %}
{% assign targetlink='/platform-integration/web/install-web/install-web-from-' | append: target | downcase %}
  <a class="card card-app-type"
     id="install-{{target | downcase}}"
     href="{{targetlink}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        <span class="d-block h1">
          {% assign icon = target | downcase -%}
          {% case icon %}
          {% when 'macos-desktop' -%}
            <span class="material-symbols">laptop_mac</span>
          {% when 'ios-on-macos' -%}
          <span class="material-symbols">laptop_mac</span><br>
          <span class="material-symbols-outlined">arrow_downward</span><br>
          <span class="material-symbols">phone_iphone</span>
          {% when 'windows-desktop' -%}
          <span class="material-symbols">desktop_windows</span>
          {% when 'android-on-macos' -%}
          <span class="material-symbols">laptop_mac</span><br>
          <span class="material-symbols-outlined">arrow_downward</span><br>
          <span class="material-symbols">phone_android</span>
            {% when 'android-on-windows' -%}
            <span class="material-symbols">desktop_windows</span><br>
            <span class="material-symbols-outlined">arrow_downward</span><br>
            <span class="material-symbols">phone_android</span>
          {% endcase -%}
        </span>
        <span class="text-muted d-block">
        {{ target | replace: "-", " " | capitalize | replace: "Macos", "macOS" | replace: "macos", "macOS" | replace: "Ios", "iOS" | replace: "windows", "Windows" }}
        </span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

{% include docs/china-notice.md %}
