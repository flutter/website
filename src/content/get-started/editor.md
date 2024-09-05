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
a Flutter extension or plugin, like VS Code and Android Studio.
These plugins provide code completion, syntax highlighting,
widget editing assists, run & debug support, and more.

You can add a supported plugin for Visual Studio Code,
Android Studio, or IntelliJ IDEA Community, Educational,
and Ultimate editions.
The [Flutter plugin][] _only_ works with
Android Studio and the listed editions of IntelliJ IDEA.

(The [Dart plugin][] supports eight additional JetBrains IDEs.)

[Flutter plugin]: https://plugins.jetbrains.com/plugin/9212-flutter
[Dart plugin]: https://plugins.jetbrains.com/plugin/6351-dart

Follow these procedures to add the Flutter plugin to VS Code,
Android Studio, or IntelliJ.

If you choose another IDE, skip ahead
to the [next step: Test drive](/get-started/test-drive).

{% tabs %}
{% tab "Visual Studio Code" %}

## Install VS Code

[VS Code][] is a code editor to build and debug apps.
With the Flutter extension installed, you can compile, deploy, and debug
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

## Install the VS Code Flutter extension

1. Start **VS Code**.

1. Open a browser and go to the [Flutter extension][] page
   on the Visual Studio Marketplace.

1. Click **Install**.
   Installing the Flutter extension also installs the Dart extension.

[Flutter extension]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter

## Validate your VS Code setup

1. Go to **View** <span aria-label="and then">></span>
   **Command Palette...**.

   You can also press <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> +
   <kbd>Shift</kbd> + <kbd>P</kbd>.

1. Type `doctor`.

1. Select the **Flutter: Run Flutter Doctor**.

   Once you select this command, VS Code does the following.

   - Opens the **Output** panel.
   - Displays **flutter (flutter)** in the dropdown on the upper right
     of this panel.
   - Displays the output of Flutter Doctor command.

{% endtab %}
{% tab "Android Studio and IntelliJ" %}

## Install Android Studio or IntelliJ IDEA

Android Studio and IntelliJ IDEA offer a complete,
IDE experience once you install the Flutter plugin.

To install the latest version of the following IDEs, follow their instructions:

- [Android Studio][]
- [IntelliJ IDEA Community][]
- [IntelliJ IDEA Ultimate][]

[Android Studio]: {{site.android-dev}}/studio/install
[IntelliJ IDEA Community]: https://www.jetbrains.com/idea/download/
[IntelliJ IDEA Ultimate]: https://www.jetbrains.com/idea/download/

## Install the Flutter plugin

The installation instructions vary by platform.

### macOS

Use the following instructions for macOS:

1. Start Android Studio or IntelliJ.

1. From the macOS menu bar, go to **Android Studio** (or **IntelliJ**)
   <span aria-label="and then">></span> **Settings...**.

   You can also press <kbd>Cmd</kbd> + <kbd>,</kbd>.

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

1. Go to **File** <span aria-label="and then">></span>
   **Settings**.

   You can also press <kbd>Ctrl</kbd> + <kbd>Alt</kbd> +
   <kbd>S</kbd>.

   The **Preferences** dialog opens.

1. From the list at the left, select **Plugins**.

1. From the top of this panel, select **Marketplace**.

1. Type `flutter` in the plugins search field.

1. Select the **Flutter** plugin.

1. Click **Install**.

1. Click **Yes** when prompted to install the plugin.

1. Click **Restart** when prompted.

{% endtab %}
{% endtabs %}

