---
title: Install
next:
  title: Set up an editor
  path: /docs/get-started/editor

js:
- url: /assets/dash/js/dartpad_picker_main.dart.js
  defer: true
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

{{site.alert.note}}
  **Are you on Chrome OS?**

  If so, see the official [Chrome OS Flutter installation docs!](/docs/get-started/install/chromeos)
{{site.alert.end}}

{{site.alert.important}}
  If you're in China, first read [Using Flutter in China](/community/china).
{{site.alert.end}}

<section class="landing-page__cta card text-center">
    <div class="dash-dartpad">
        <a name="try-dart"></a>
        <h2>Try Flutter in your browser</h2>
        <select id="dartpad-select"></select>
        <div id="dartpad-host"></div>
        <h3>Want more practice? <a href="/codelabs">Try a codelab</a>.</h3>
    </div>
</section><br>

