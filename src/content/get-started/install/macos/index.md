---
title: Choose your first type of app
description: Configure your system to develop Flutter on macOS.
short-title: macOS
target-list: [iOS, Android, Web, Desktop]
js: [{url: '/assets/js/temp/macos-install-redirector.js'}]
---

{% assign os = 'macos' -%}
{% assign recommend = 'iOS' %}
{% capture rec-target -%}
[{{recommend | strip}}](/get-started/install/{{os | downcase}}/mobile-{{recommend | downcase}})
{%- endcapture %}

<div class="card-grid narrow">
{% for target in target-list %}
  {% case target %}
  {% when "iOS", "Android" %}
  {% assign targetlink = target | downcase | prepend: 'mobile-' %}
  {% else %}
  {% assign targetlink = target | downcase %}
  {% endcase %}

  <a class="card card-app-type card-macos" id="install-{{os | downcase}}" href="/get-started/install/{{os | downcase}}/{{targetlink}}">
    <div class="card-body">
      <header class="card-title card-center">
        {% assign icon = target | downcase -%}
        {% case icon %}
        {% when 'desktop' -%}
          <span class="material-symbols">laptop_mac</span>
        {% when 'ios' -%}
          <span class="material-symbols">phone_iphone</span>
        {% when 'android' -%}
          <span class="material-symbols">phone_android</span>
        {% when 'web' -%}
          <span class="material-symbols">web</span>
        {% endcase -%}
        <span class="card-muted">{{ target }}</span>
        {% if icon == 'ios' -%}
          <div class="card-subtitle">Recommended</div>
        {% endif -%}
      </header>
    </div>
  </a>

{% endfor %}
</div>

Your choice informs which parts of Flutter tooling you configure
to run your first Flutter app.
You can set up additional platforms later.
_If you don't have a preference, choose **{{rec-target}}**._

{% render docs/china-notice.md %}
