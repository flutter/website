---
title: Choose your first type of app
description: Configure your system to develop Flutter on Linux.
short-title: Linux
target-list: [Android, Web, Desktop]
js: [{url: '/assets/js/temp/linux-install-redirector.js'}]
---

{% assign os = 'linux' -%}
{% assign recommend = 'Android' %}
{% capture rec-target -%}
[{{recommend}}](/get-started/install/{{os | downcase}}/{{recommend | downcase}})
{%- endcapture %}

<div class="card-grid narrow">
{% for target in target-list %}
  <a class="card outlined-card install-card card-linux" id="install-{{os | remove: ' ' | downcase}}" href="/get-started/install/{{os | remove: ' ' | downcase}}/{{target | downcase}}">
    {% assign icon = target | downcase -%}
    <div class="card-leading">
      {% if icon == 'desktop' -%}
        <span class="material-symbols" aria-hidden="true">desktop_windows</span>
      {% elsif icon == 'android' -%}
        <span class="material-symbols" aria-hidden="true">phone_android</span>
      {% else -%}
        <span class="material-symbols" aria-hidden="true">web</span>
      {% endif -%}
    </div>
    <div class="card-header text-center">
      <header class="card-title">{{target}}</header>
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
