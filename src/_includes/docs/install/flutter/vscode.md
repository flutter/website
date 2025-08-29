{%- if include.os=='macOS' -%}
{% assign special = 'Command' %}
{% else %}
{% assign special = 'Control' %}
{%- endif %}

### Use VS Code to install Flutter {:.no_toc}

To install Flutter using these instructions,
verify that you've installed
[Visual Studio Code][] and the [Flutter extension for VS Code][].

#### Prompt VS Code to install Flutter

1. Launch VS Code.

1. To open the **Command Palette**,
   press <kbd>{{special}}</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>.

1. In the **Command Palette**, type `flutter`.

1. Select **Flutter: New Project**.

1. VS Code prompts you to locate the Flutter SDK on your computer.

   {:type="a"}
   1. If you have the Flutter SDK installed, click **Locate SDK**.

   1. If you don't have the Flutter SDK installed,
      click **Download SDK**.

      This option sends you the Flutter install page if you haven't
      installed Git {% if include.os == "Windows" %}for Windows {% endif %}as
      directed in the [development tools prerequisites][].

1. When prompted **Which Flutter template?**, ignore it.
   Press <kbd>Esc</kbd>.
   You can create a test project after checking your development setup.

#### Download the Flutter SDK

1. When the **Select Folder for Flutter SDK** dialog displays,
   choose where you want to install Flutter.

   VS Code places you in your user profile to start.
   Choose a different location.

   {% if include.os == "Windows" -%}
   Consider `%USERPROFILE%` or `C:\dev`.

   :::warning
   Don't install Flutter to a directory or path that meets
   one or both of the following conditions:

   * The path contains special characters or spaces.
   * The path requires elevated privileges.

   As an example, `C:\Program Files` meets both conditions.
   :::

   {% else -%}
   Consider `~/development/`
   {% endif %}

1. Click **Clone Flutter**.

   While downloading Flutter, VS Code displays these pop-up notifications:

   ```console
   Downloading the Flutter SDK. This may take a few minutes.
   ```

   ```console
   Initializing the Flutter SDK. This may take a few minutes.
   ```

   The download and installation take a few minutes.
   If you suspect that the download has hung, click **Cancel**,
   then start the installation again.

   When the Flutter installation succeeds,
   VS Code displays this pop-up notification:

   ```console
   Do you want to add the Flutter SDK to PATH so it's accessible
   in external terminals?
   ```

1. Click **Add SDK to PATH**.

   When successful, a notification displays:

   ```console
   The Flutter SDK was added to your PATH
   ```

1. VS Code might display a Google Analytics notice.

   If you agree, click **OK**.

1. To enable `flutter` in all {{include.terminal}} windows:

   1. Close, then reopen all {{include.terminal}} windows.
   1. Restart VS Code.

   {:type="a"}

[development tools prerequisites]: #development-tools
[Visual Studio Code]: https://code.visualstudio.com/docs/setup/mac
[Flutter extension for VS Code]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
