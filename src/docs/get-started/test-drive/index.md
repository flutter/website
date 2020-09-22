---
title: Test drive
description: How to create a templated Flutter app and use hot reload.
prev:
  title: Set up an editor
  path: /docs/get-started/editor
next:
  title: Write your first Flutter app
  path: /docs/get-started/codelab
toc: false
---

This page describes how to create a new Flutter app from templates, run it,
and experience "hot reload" after you make changes to the app.

Select your development tool of choice for writing, building, and running
Flutter apps.

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="editor-setup" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="androidstudio-tab" href="#androidstudio" role="tab" aria-controls="androidstudio" aria-selected="true">Android Studio and IntelliJ</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="vscode-tab" href="#vscode" role="tab" aria-controls="vscode" aria-selected="false">Visual Studio Code</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="terminal-tab" href="#terminal" role="tab" aria-controls="terminal" aria-selected="false">Terminal & editor</a>
  </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">
  {% include_relative _androidstudio.md %}
  {% include_relative _vscode.md %}
  {% include_relative _terminal.md %}
</div>



[Install]: /docs/get-started/install
[Main IntelliJ toolbar]: {% asset tools/android-studio/main-toolbar.png @path %}
[Managing AVDs]: {{site.android-dev}}/studio/run/managing-avds
[Material Components]: {{site.material}}/guidelines
