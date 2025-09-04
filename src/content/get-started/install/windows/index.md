---
title: Choose your first type of app
description: Configure your system to develop Flutter on Windows.
shortTitle: Windows
target-list: [Android, Web, Desktop]
js: [{url: '/assets/js/temp/windows-install-redirector.js'}]
---

{% assign os = 'windows' -%}
{% assign recommend = 'Android' %}
{% capture rec-target -%}
[{{recommend}}](/get-started/install/{{os | downcase}}/mobile)
{%- endcapture %}

<div class="card-grid narrow">
{% for target in target-list %}
  {% case target %}
  {% when "Android" %}
  {% assign targetlink = target | downcase | replace: 'android', 'mobile' %}
  {% else %}
  {% assign targetlink = target | downcase %}
  {% endcase %}
  <a class="card outlined-card install-card card-windows" id="install-{{os | downcase}}" href="/get-started/install/{{os | downcase}}/{{targetlink}}" aria-label="Windows setup instructions for first deploying to {{target}}">
    {% assign icon = target | downcase -%}
    <div class="card-leading">
      {% case icon %}
      {% when 'desktop' -%}
        <span class="material-symbols" aria-hidden="true" translate="no">desktop_windows</span>
      {% when 'android' -%}
        <span class="material-symbols" aria-hidden="true" translate="no">phone_android</span>
      {% when 'web' -%}
        <span class="material-symbols" aria-hidden="true" translate="no">web</span>
      {% endcase -%}
    </div>
    <div class="card-header text-center">
      <span class="card-title">{{target}}</span>
      {% if icon == 'android' -%}
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
