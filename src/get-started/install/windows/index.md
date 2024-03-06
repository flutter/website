---
title: Choose your first type of app
description: Configure your system to develop Flutter on Windows.
short-title: Windows
target-list: [Desktop, Android, Web]
js: [{url: '/assets/js/temp/windows-install-redirector.js'}]
---

{% assign os = 'windows' -%}
{% assign recommend = 'Android' %}
{% capture rec-target -%}
[{{recommend}}](/get-started/install/{{os | downcase}}/{{recommend | downcase}})
{%- endcapture %}

<div class="card-deck mb-8">
{% for target in page.target-list %}
{% case target %}
{% when "Android" %}
{% assign targetlink = target | downcase | replace: 'android', 'mobile' %}
{% else %}
{% assign targetlink = target | downcase %}
{% endcase %}
  <a class="card card-app-type"
     id="install-{{os | downcase}}"
     href="{{site.url}}/get-started/install/{{os | downcase}}/{{targetlink}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        <span class="d-block h1">
          {% assign icon = target | downcase -%}
          {% case icon %}
          {% when 'desktop' -%}
            <span class="material-symbols">desktop_windows</span>
          {% when 'android' -%}
            <span class="material-symbols">phone_android</span>
          {% when 'web' -%}
            <span class="material-symbols">open_in_browser</span>
          {% endcase -%}
        </span>
        <span class="text-muted text-nowrap">{{target}}</span>
        {% if icon == 'android' -%}
          <div class="card-subtitle">Recommended</div>
        {% endif %}
      </header>
    </div>
  </a>
{% endfor %}
</div>

Your choice informs which parts of Flutter tooling you configure
to run your first Flutter app.
You can set up additional platforms later.
_If you don't have a preference, choose **{{rec-target}}**._

{% include docs/china-notice.md %}
