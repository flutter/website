---
title: Choose your first type of app
description: Configure your system to develop Flutter on Windows.
short-title: Windows
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
  <a class="card card-app-type card-windows" id="install-{{os | downcase}}" href="/get-started/install/{{os | downcase}}/{{targetlink}}">
    <div class="card-body">
      <header class="card-title card-center">
        <span>
          {% assign icon = target | downcase -%}
          {% case icon %}
          {% when 'desktop' -%}
            <span class="material-symbols">desktop_windows</span>
          {% when 'android' -%}
            <span class="material-symbols">phone_android</span>
          {% when 'web' -%}
            <span class="material-symbols">web</span>
          {% endcase -%}
        </span>
        <span class="card-muted">{{target}}</span>
        {% if icon == 'android' -%}
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
