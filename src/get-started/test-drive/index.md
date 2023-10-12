---
title: Test drive
description: How to create a templated Flutter app and use hot reload.
prev:
  title: Set up an editor
  path: /get-started/editor
next:
  title: Write your first Flutter app
  path: /get-started/codelab
toc: false
---

This page describes the following tasks:

1. How to create a new Flutter app from templates.
1. How to run the created Flutter app.
1. How to use "hot reload" after you make changes to the app.

Details for these tasks depend on the integrated development environment
(IDE) you use.

The first two options listed rely on the Flutter plugin for
the respective IDE.
Visual Studio Code, Android Studio, and IntelliJ IDEA Community,
Educational, and Ultimate editions support Flutter development
through plugins.

The third option explains how to use an editor of your choice and
the terminal to run the commands.

Select your preferred IDE for Flutter apps.

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="editor-setup" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="vscode-tab" href="#vscode" role="tab" aria-controls="vscode" aria-selected="true">Visual Studio Code</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="androidstudio-tab" href="#androidstudio" role="tab" aria-controls="androidstudio" aria-selected="false">Android Studio and IntelliJ</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="terminal-tab" href="#terminal" role="tab" aria-controls="terminal" aria-selected="false">Terminal & editor</a>
  </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">
  {% include_relative _vscode.md %}
  {% include_relative _androidstudio.md %}
  {% include_relative _terminal.md %}
</div>
