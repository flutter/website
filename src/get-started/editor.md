---
title: Set up an editor
description: Configuring an IDE for Flutter.
prev:
  title: Install
  path: /get-started/install
next:
  title: Test drive
  path: /get-started/test-drive
toc: false
---

You can build apps with Flutter using any text editor or
integrated development environment (IDE)
combined with Flutter's command-line tools.
The Flutter team recommends using an editor that supports
a Flutter extension, like VS Code, or plugin, like Android Studio.
These plugins provide code completion, syntax highlighting,
widget editing assists, run & debug support, and more.

You can add a supported plugin for Visual Studio Code,
Android Studio, or IntelliJ IDEA Community, Educational,
and Ultimate editions.
The [Flutter plugin from JetBrains][] _only_ works with
Android Studio and IntelliJ IDEA.

(The [JetBrains' Dart plugin][] supports eight additional IDEs.)

[Flutter plugin from JetBrains]: https://plugins.jetbrains.com/plugin/9212-flutter/versions
[JetBrains' Dart plugin]: https://plugins.jetbrains.com/plugin/6351-dart

Follow these procedures to add the Flutter plugin to VS Code,
Android Studio, or IntelliJ.

If you choose another IDE, skip ahead to the [next step: Test drive][].

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="editor-setup" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" id="vscode-tab" href="#vscode" role="tab" aria-controls="vscode" aria-selected="true">Visual Studio Code</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" id="androidstudio-tab" href="#androidstudio" role="tab" aria-controls="androidstudio" aria-selected="false">Android Studio and IntelliJ</a>
  </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">
<div class="tab-pane active" id="vscode" role="tabpanel" aria-labelledby="vscode-tab" markdown="1">

## Install VS Code

[VS Code][] is a code editor to build and debug apps.
With the Flutter plugin installed, you can compile, deploy, and debug
Flutter apps.

To install the latest version of VS Code,
follow Microsoft's instructions for the relevant platform:

- [Install on macOS][]
- [Install on Windows][]
- [Install on Linux][]

[VS Code]: https://code.visualstudio.com/
[Install on macOS]: https://code.visualstudio.com/docs/setup/mac
[Install on Windows]: https://code.visualstudio.com/docs/setup/windows
[Install on Linux]: https://code.visualstudio.com/docs/setup/linux

## Install the VS Code Flutter plugin

1. Start **VS Code**.

1. Go to **View** <span aria-label="and then">></span>
   **Command Palette...**.

   You can also press <kbd>Control</kbd> / <kbd>Command</kbd> +
   <kbd>Shift</kbd> + <kbd>P</kbd>.

1. Type `install`.

1. Select **Extensions: Install Extensions**.

1. Type `flutter` in the extensions search field.

1. Select **Flutter** in the list.

1. Click **Install**.
   Installing the Flutter plugin also installs the Dart plugin.

## Validate your VS Code setup with the Flutter Doctor

1. Go to **View** <span aria-label="and then">></span>
   **Command Palette...**.

   You can also press <kbd>Control</kbd> / <kbd>Command</kbd> +
   <kbd>Shift</kbd> + <kbd>P</kbd>.

1. Type `doctor`.

1. Select the **Flutter: Run Flutter Doctor**.

1. Review the output in the **OUTPUT** pane for any issues.
   Make sure to select Flutter from the dropdown
   in the different Output Options.

</div>
<div class="tab-pane" id="androidstudio" role="tabpanel" aria-labelledby="androidstudio-tab" markdown="1">

## Install Android Studio or IntelliJ IDEA

Android Studio and IntelliJ IDEA offer complete,
integrated IDE experience once you install the Flutter plugin.

To install of the following IDEs, follow their instructions:

- [Android Studio][], version 2020.3.1 (Arctic Fox) or later
- [IntelliJ IDEA Community][], version 2021.2 or later
- [IntelliJ IDEA Ultimate][], version 2021.2 or later

## Install the Flutter plugin

The installation instructions vary by platform.

### macOS

Use the following instructions for macOS:

1. Start Android Studio.

1. Go to **App menu** <span aria-label="and then">></span>
   **Settings**.

   You can also press <kbd>Command</kbd> + <kbd>,</kbd>.

   The **Preferences** dialog opens.

1. From the list at the left, select **Plugins**.

1. From the top of this panel, select **Marketplace**.

1. Type `flutter` in the plugins search field.

1. Select the **Flutter** plugin.

1. Click **Install**.

1. Click **Yes** when prompted to install the plugin.

1. Click **Restart** when prompted.

### Linux or Windows

Use the following instructions for Linux or Windows:

1. Go to **File** <span aria-label="and then">></span> **Settings**.

   You can also press <kbd>Control</kbd> + <kbd>Alt</kbd> + <kbd>S</kbd>.

   The **Preferences** dialog opens.

1. From the list at the left, select **Plugins**.

1. From the top of this panel, select **Marketplace**.

1. Type `flutter` in the plugins search field.

1. Select the **Flutter** plugin.

1. Click **Install**.

1. Click **Yes** when prompted to install the plugin.

1. Click **Restart** when prompted.

</div>
</div>{% comment %} End: Tab panes. {% endcomment -%}

[Android Studio]: {{site.android-dev}}/studio/install
[IntelliJ IDEA Community]: https://www.jetbrains.com/idea/download/
[IntelliJ IDEA Ultimate]: https://www.jetbrains.com/idea/download/
[next step: Test drive]: {{site.url}}/get-started/test-drive
