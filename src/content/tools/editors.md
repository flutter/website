---
title: Flutter editor support
shortTitle: Editors
description: >-
  Editor support for Dart and Flutter.
showToc: false
---

You can build apps with Flutter using any text editor or
integrated development environment (IDE)
combined with Flutter's command-line tools.

The Flutter team recommends using an editor that supports
a Flutter extension or plugin, like VS Code and Android Studio.
These plugins provide code completion, syntax highlighting,
widget editing assists, debug support, and much more.

## Local editors

The Flutter team supports plugins for VS Code, Android Studio, and IntelliJ.
The plugins provide extensive development and debugging support as well as
deep integrations with the [Dart analyzer][] and [Dart and Flutter DevTools][].

<div class="card-grid">
  <a class="card outlined-card" href="/tools/vs-code">
    <div class="card-header">
      <span class="card-title">Visual Studio Code</span>
    </div>
    <div class="card-content">
      <p>Develop and debug Flutter apps in a streamlined and customizable code editor.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/tools/android-studio">
    <div class="card-header">
      <span class="card-title">Android Studio and IntelliJ</span>
    </div>
    <div class="card-content">
      <p>Develop and debug Flutter apps in an IDE with rich language support and integrated tooling.</p>
    </div>
  </a>
</div>

[Dart analyzer]: {{site.dart-site}}/tools/analysis
[Dart and Flutter DevTools]: /tools/devtools

## Online editors

You can quickly try Flutter online without any local setup
with one of the following editors.

<div class="card-grid">
  <a class="card outlined-card" href="{{site.dartpad}}" target="_blank">
    <div class="card-header">
      <span class="card-title">
        <span>DartPad</span>
        <span class="material-symbols" aria-hidden="true" style="font-size: 1rem;" translate="no">open_in_new</span>
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
        <span class="material-symbols" aria-hidden="true" style="font-size: 1rem;" translate="no">open_in_new</span>
      </span>
    </div>
    <div class="card-content">
      <p>Develop complex Flutter apps in an AI-assisted workspace in the cloud.</p>
    </div>
  </a>
</div>

## Other editors

You can develop Dart and Flutter apps using any other text editor and terminal.

Depending on the editor, you can integrate the Dart SDK's support for the
[Language Server Protocol][lsp] and the [Debug Adapter Protocol][dap] to
enable rich code editing and debugging features for both Dart and Flutter.

[lsp]: https://github.com/dart-lang/sdk/tree/main/pkg/analysis_server/tool/lsp_spec/README.md
[dap]: https://github.com/dart-lang/sdk/blob/main/third_party/pkg/dap/tool/README.md
