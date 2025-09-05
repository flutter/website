---
title: Choose your development platform to get started
shortTitle: Install
description: >-
  Install Flutter and get started developing!
  Downloads available for Windows, macOS, Linux, and ChromeOS operating systems.
os-list: [Windows, macOS, Linux, ChromeOS]
js: [{url: '/assets/js/page/install-current.js'}]
---

<div class="card-grid narrow">
{% for os in os-list %}
  <a class="card outlined-card install-card" id="install-{{os | remove: ' ' | downcase}}" href="/get-started/install/{{os | remove: ' ' | downcase}}" aria-label="{{os}} setup instructions">
    <div class="card-leading">
      <img src="/assets/images/docs/brand-svg/{{os | downcase}}.svg" width="72" height="72" aria-hidden="true" alt="{{os}} logo">
    </div>
    <div class="card-header text-center">
      <span class="card-title">{{os}}</span>
    </div>
  </a>
{% endfor %}
</div>

:::tip Planning to use VS Code?
Are you planning to use VS Code to develop Flutter apps?

Try out the streamlined getting-started experience
outlined in [Set up and test drive Flutter][]!

[Set up and test drive Flutter]: /get-started/quick
:::

{% render docs/china-notice.md %}
