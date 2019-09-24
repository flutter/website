---
title: Try & Install
next:
  title: Set up an editor
  path: /docs/get-started/editor

js:
- url: /assets/dash/js/dartpad_picker_main.dart.js
  defer: true
---

<div>
<h2 class="install text-center">Try Flutter in your browser</h2>
  <div class="dash-dartpad">
    <a name="try-dart"></a>
    <select id="dartpad-select"></select>
    <div id="dartpad-host"></div><br>
    {% include dartpad_warning.md %}
    <h4>Want more practice? <a href="/codelabs">Try a codelab</a>.</h4>
  </div>
</div>

<h2 class="text-center">Install Flutter now</h2>
<h4>Select the operating system on which you are installing Flutter:</h4><br>
<div class="card-deck mb-8">
  {% for os in site.os-list %}
    <a class="card" href="/docs/get-started/install/{{os | downcase | remove: ' ' }}">
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
