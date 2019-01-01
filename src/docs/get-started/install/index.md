---
title: Install
next:
  title: Set up an editor
  path: /docs/get-started/editor
---

Select the operating system on which you are installing Flutter:

<div class="card-deck mb-8">
{% for os in site.os-list %}
  <a class="card" href="/docs/get-started/install/{{os | downcase}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        {{os}}
        <i class="fab fa-{{os | downcase}}"></i>
      </header>
    </div>
  </a>
{% endfor %}
</div>

{{site.alert.important}}
  If you're in China, first read [Using Flutter in China](/community/china).
{{site.alert.end}}

