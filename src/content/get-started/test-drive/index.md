---
title: Test drive
description: How to create a templated Flutter app and use hot reload.
prev:
  title: Install Flutter
  path: /get-started/install
next:
  title: Write your first Flutter app
  path: /get-started/codelab
toc: false
---

{% case os %}
{% when 'Windows' -%}
   {% assign path='C:\dev\' %}
   {% assign terminal='PowerShell' %}
   {% assign prompt1='D:>' %}
   {% assign prompt2=path | append: '>' %}
   {% assign dirdl='%CSIDL_DEFAULT_DOWNLOADS%\' %}
{% when "macOS" -%}
   {% assign path='~/development/' %}
   {% assign terminal='the Terminal' %}
   {% assign prompt1='$' %}
   {% assign prompt2='$' %}
   {% assign dirdl='~/Downloads/' %}
{% else -%}
   {% assign path='/usr/bin/' %}
   {% assign terminal='a shell' %}
   {% assign prompt1='$' %}
   {% assign prompt2='$' %}
   {% assign dirdl='~/Downloads/' %}
{% endcase -%}

## What you'll learn

1. How to create a new Flutter app from a sample template.
1. How to run the new Flutter app.
1. How to use "hot reload" after you make changes to the app.

## Guide depends on your IDE

These tasks depend on which integrated development environment (IDE) you use.

* **Option 1** explains how to code with Visual Studio Code and
  its Flutter extension.

* **Option 2** explains how to code with Android Studio or IntelliJ IDEA with
  its Flutter plugin.

  Flutter supports IntelliJ IDEA Community, Educational, and Ultimate editions.

* **Option 3** explains how to code with an editor of your choice and use
  the terminal to compile and debug your code.

## Choose your IDE

Select your preferred IDE for Flutter apps. Note that for either one of these you may need to install the relevant Flutter and Dart extensions.

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
  {% include docs/install/test-drive/vscode.md %}
  {% include docs/install/test-drive/androidstudio.md %}
  {% include docs/install/test-drive/terminal.md %}
</div>
