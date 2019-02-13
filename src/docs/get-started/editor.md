---
title: Set up an editor
prev:
  title: Install
  path: /docs/get-started/install
next:
  title: Test drive
  path: /docs/get-started/test-drive
toc: false
---

You can build apps with Flutter using any text editor combined with our
command-line tools. However, we recommend using one of our editor plugins for an
even better experience. These plugins provide you with code completion, syntax
highlighting, widget editing assists, run & debug support, and more.

Follow the steps below to add an editor plugin for Android Studio, IntelliJ, or
VS Code. If you want to use a different editor, that's OK, skip ahead to the
[next step: Test drive](/docs/get-started/test-drive).

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="editor-setup" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="androidstudio-tab" href="#androidstudio" role="tab" aria-controls="androidstudio" aria-selected="true">Android Studio / IntelliJ</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="vscode-tab" href="#vscode" role="tab" aria-controls="vscode" aria-selected="false">Visual Studio Code</a>
  </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">

<div class="tab-pane active" id="androidstudio" role="tabpanel" aria-labelledby="androidstudio-tab" markdown="1">

## Install Android Studio

Android Studio offers a complete, integrated IDE experience for Flutter.

* [Android Studio]({{site.android-dev}}/studio), version 3.0 or later

Alternatively, you can also use IntelliJ:

* [IntelliJ IDEA Community](https://www.jetbrains.com/idea/download/), version 2017.1 or later
* [IntelliJ IDEA Ultimate](https://www.jetbrains.com/idea/download/), version 2017.1 or later

## Install the Flutter and Dart plugins

To install these:

 1. Start Android Studio.
 1. Open plugin preferences (**Preferences > Plugins** on macOS,
    **File > Settings > Plugins** on Windows & Linux).
 1. Select **Browse repositories**,  select the Flutter plugin and click
    **Install**.
 1. Click **Yes** when prompted to install the Dart plugin.
 1. Click **Restart** when prompted.

</div>
<div class="tab-pane" id="vscode" role="tabpanel" aria-labelledby="vscode-tab" markdown="1">

## Install VS Code

VS Code is a light-weight editor with Flutter app execution and debug support.

* [VS Code](https://code.visualstudio.com/), latest stable version

## Install the Flutter and Dart plugins

 1. Start VS Code.
 1. Invoke **View > Command Palette...**.
 1. Type "install", and select **Extensions: Install Extensions**.
 1. Type "flutter" in the extensions search field, select **Flutter** in the list,
    and click **Install**. This also installs the required Dart plugin.

## Validate your setup with the Flutter Doctor

 1. Invoke **View > Command Palette...**.
 1. Type "doctor", and select the **Flutter: Run Flutter Doctor**.
 1. Review the output in the **OUTPUT** pane for any issues.

</div>

</div>{% comment %} End: Tab panes. {% endcomment -%}

## Next step

Take Flutter for a test drive: create a first project, run it, and experience
"hot reload".
