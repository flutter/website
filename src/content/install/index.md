---
title: Install Flutter
short-title: Install
description: Learn how to install and set up Flutter.
os-list: [Windows, macOS, Linux, ChromeOS]
js: [{url: '/assets/js/page/install-current.js'}]
---

## Try Flutter {:#try}

You can quickly try Flutter online without any local setup.

<div class="card-grid">
  <a class="card outlined-card" href="{{site.dartpad}}" target="_blank">
    <div class="card-header">
      <span class="card-title">
        <span>DartPad</span>
        <span class="material-symbols" aria-hidden="true" style="font-size: 1rem;">open_in_new</span>
      </span>
    </div>
    <div class="card-content">
      <p>Quickly build and run simple single-file Flutter apps on the web.</p>
    </div>
  </a>
  <a class="card outlined-card" href="https://firebase.studio" target="_blank">
    <div class="card-header">
      <span class="card-title">
        <span>Firebase Studio</span>
        <span class="material-symbols" aria-hidden="true" style="font-size: 1rem;">open_in_new</span>
      </span>
    </div>
    <div class="card-content">
      <p>Develop complex Flutter apps in an AI-assisted workspace in the cloud.</p>
    </div>
  </a>
</div>

## Install and get started {: #get-started}

To get started installing, setting up, and trying out Flutter,
choose your development platform from the following options.

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

## Update Flutter {: #update}

If you already have Flutter installed and would like to
upgrade your Flutter SDK installation or change to a different release channel,
check out [Upgrading Flutter][].

When upgrading, also remember to check out the published list of
[breaking changes and migration guides][].

[Upgrading Flutter]: /install/upgrade
[breaking changes and migration guides]: /release/breaking-changes

## Download previous releases {: #previous-releases}

If you're looking to download and install previous releases of Flutter,
check out the [SDK archive][].

:::note
We recommend keeping your apps and development environments
up to date with the **latest** `stable` or `beta` releases.
:::

[SDK archive]: /release/archive
