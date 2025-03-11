---
title: Choose your first type of app
description: Configure your system to develop Flutter on ChromeOS.
short-title: ChromeOS
target-list: [Android, Web]
js: [{url: '/assets/js/temp/chromeos-install-redirector.js'}]
---

{% assign os = 'chromeos' -%}
{% assign recommend = 'Android' %}
{% capture rec-target -%}
[{{recommend}}](/get-started/install/{{os | downcase}}/{{recommend | downcase}})
{%- endcapture %}

<div class="card-grid narrow">
{% for target in target-list %}
  <a class="card outlined-card install-card card-chromeos" id="install-{{os | remove: ' ' | downcase}}" href="/get-started/install/{{os | remove: ' ' | downcase}}/{{target | downcase}}" aria-label="ChromeOS setup instructions for first deploying to {{target}}">
    {% assign icon = target | downcase -%}
    <div class="card-leading">
      {% if icon == 'android' -%}
        <span class="material-symbols" aria-hidden="true">phone_android</span>
      {% else -%}
        <span class="material-symbols" aria-hidden="true">web</span>
      {% endif -%}
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
