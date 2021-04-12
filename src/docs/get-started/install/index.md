---
title: Install
description: Install Flutter and get started. Downloads available for Windows, macOS, Linux, and Chrome OS operating systems.
next:
  title: Set up an editor
  path: /docs/get-started/editor
os-list: [Windows, macOS, Linux, "Chrome OS"]
---

Select the operating system on which you are installing Flutter:

<div class="card-deck mb-8">
{% for os in page.os-list %}
  <a class="card" id="install-{{os | remove: ' ' | downcase}}" href="/docs/get-started/install/{{os | remove: ' ' | downcase}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        <span class="d-block h1">
          <i class="fab fa-{{os | downcase}}"></i>
        </span>
        <span class="text-muted text-nowrap">{{os}}</span>
      </header>
    </div>
  </a>
{% endfor %}
</div>

{{site.alert.important}}
  If you're in China, first read [Using Flutter in China][].
{{site.alert.end}}

[Using Flutter in China]: /community/china
