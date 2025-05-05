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

  <a class="card outlined-card install-card card-macos" id="install-{{os | downcase}}" href="/get-started/install/{{os | downcase}}/{{targetlink}}" aria-label="macOS setup instructions for first deploying to {{target}}">
    {% assign icon = target | downcase -%}
    <div class="card-leading">
      {% case icon %}
      {% when 'desktop' -%}
        <span class="material-symbols" aria-hidden="true">laptop_mac</span>
      {% when 'ios' -%}
        <span class="material-symbols" aria-hidden="true">phone_iphone</span>
      {% when 'android' -%}
        <span class="material-symbols" aria-hidden="true">phone_android</span>
      {% when 'web' -%}
        <span class="material-symbols" aria-hidden="true">web</span>
      {% endcase -%}
    </div>
    <div class="card-header text-center">
      <span class="card-title">{{target}}</span>
      {% if icon == 'ios' -%}
        <span class="card-subtitle">Recommended</span>
      {% endif -%}
    </div>
  </a>

{% endfor %}
</div>

Your choice informs which parts of Flutter tooling you configure
to run your first Flutter app.
You can set up additional platforms later.
_If you don't have a preference, choose **{{rec-target}}**._

{% render docs/china-notice.md %}
