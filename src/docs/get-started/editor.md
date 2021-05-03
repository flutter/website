---
title: Set up an editor
description: Configuring an IDE for Flutter.
prev:
  title: Install
  path: /docs/get-started/install
next:
  title: Test drive
  path: /docs/get-started/test-drive
toc: false
---

You can build apps with Flutter using any text editor combined with our
command-line tools. However, we recommend using one of our editor
plugins for an even better experience.
These plugins provide you with code completion, syntax
highlighting, widget editing assists, run & debug support, and more.

Follow the steps below to add an editor plugin for Android Studio,
IntelliJ, VS Code, or Emacs. If you want to use a different editor,
that's OK, skip ahead to the [next step: Test drive][].

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="editor-setup" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="androidstudio-tab" href="#androidstudio" role="tab" aria-controls="androidstudio" aria-selected="true">Android Studio and IntelliJ</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="vscode-tab" href="#vscode" role="tab" aria-controls="vscode" aria-selected="false">Visual Studio Code</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="emacs-tab" href="#emacs" role="tab" aria-controls="emacs" aria-selected="false">Emacs</a>
  </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">

<div class="tab-pane active" id="androidstudio" role="tabpanel" aria-labelledby="androidstudio-tab" markdown="1">

## Install Android Studio

Android Studio offers a complete, integrated IDE experience for Flutter.

* [Android Studio][], version 3.0 or later

Alternatively, you can also use IntelliJ:

* [IntelliJ IDEA Community][], version 2017.1 or later
* [IntelliJ IDEA Ultimate][], version 2017.1 or later

## Install the Flutter and Dart plugins

The installation instructions vary by platform.

### Mac

Use the following instructions for macos:

  1. Start Android Studio.
  1. Open plugin preferences (**Preferences > Plugins** as of
     v3.6.3.0 or later).
  1. Select the Flutter plugin and
     click **Install**.
  1. Click **Yes** when prompted to install the Dart plugin.
  1. Click **Restart** when prompted.

### Linux or Windows

Use the following instructions for Linux or WIndows:

   1. Open plugin preferences (**File > Settings > Plugins**).
   1. Select **Marketplace**,  select the Flutter plugin and click
      **Install**.

</div>
<div class="tab-pane" id="vscode" role="tabpanel" aria-labelledby="vscode-tab" markdown="1">

## Install VS Code

VS Code is a lightweight editor with Flutter app execution and debug support.

* [VS Code][], latest stable version

## Install the Flutter and Dart plugins

 1. Start VS Code.
 1. Invoke **View > Command Palette...**.
 1. Type "install", and select **Extensions: Install Extensions**.
 1. Type "flutter" in the extensions search field, select **Flutter** in the list,
    and click **Install**. This also installs the required Dart plugin.

## Validate your setup with the Flutter Doctor

 1. Invoke **View > Command Palette...**.
 1. Type "doctor", and select the **Flutter: Run Flutter Doctor**.
 1. Review the output in the **OUTPUT** pane for any issues. Make sure to select Flutter from the dropdown in the different Output Options.

</div>
<div class="tab-pane" id="emacs" role="tabpanel" aria-labelledby="emacs-tab" markdown="1">

## Install Emacs

Emacs is a lightweight editor with support for Flutter and Dart.

* [Emacs][], latest stable version

## Install the lsp-dart package

For information on how to install and use the package, see the [lsp-dart documentation][].

</div>
</div>{% comment %} End: Tab panes. {% endcomment -%}



[Android Studio]: {{site.android-dev}}/studio
[IntelliJ IDEA Community]: https://www.jetbrains.com/idea/download/
[IntelliJ IDEA Ultimate]: https://www.jetbrains.com/idea/download/
[next step: Test drive]: /docs/get-started/test-drive
[VS Code]: https://code.visualstudio.com/
[Emacs]: https://www.gnu.org/software/emacs/download.html
[lsp-dart documentation]: https://emacs-lsp.github.io/lsp-dart/
