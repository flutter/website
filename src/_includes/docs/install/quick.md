Learn how to use any Code OSS-based editor, such as VS Code,
to set up your Flutter development environment and
test drive Flutter's developer experience.

If you've developed with Flutter before,
or you prefer to use a different editor or IDE,
you can follow the [custom setup instructions][] instead.

:::note What you'll achieve

- Install the software prerequisites for Flutter.
- Use VS Code to download and install Flutter.
- Create a new Flutter app from a sample template.
- Try out Flutter development features like stateful hot reload.

:::

[custom setup instructions]: /get-started/custom

## Confirm your development platform {: #dev-platform}

The instructions on this page are configured to cover
installing and trying out Flutter on a **Windows**{:.selected-os-text} device.

If you'd like to follow the instructions for a different OS,
please select one of the following.

<OSSelector />

## Download prerequisite software {: #download-prerequisites}

For the smoothest Flutter setup,
first install the following tools.

 1. <h3>Set up Linux support</h3>

    If you haven't set up Linux support on your Chromebook before,
    [Turn on Linux support][chromeos-linux].

    If you've already turned on Linux support,
    ensure it's up to date following the
    [Fix problems with Linux][chromeos-linux-update] instructions.

 1. <h3>Download and install prerequisite packages</h3>

    Using `apt-get` or your preferred installation mechanism,
    install the latest versions of the following packages:

    - `curl`
    - `git`
    - `unzip`
    - `xz-utils`
    - `zip`
    - `libglu1-mesa`

    If you want to use `apt-get`,
    install these packages using the following commands:

    ```console
    $ sudo apt-get update -y && sudo apt-get upgrade -y
    $ sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa
    ```

 1. <h3>Download and install Visual Studio Code</h3>

    To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code][vscode-install].

    You can instead install and use any other Code OSS-based editor
    that supports VS Code extensions.
    If you choose to do so, for the rest of this article,
    assume VS Code refers to the editor of your choice.

{: .steps .chromeos-only}

 1. <h3>Install git</h3>

    **If you already have git installed, skip to the next
    step: Download and install Visual Studio Code.**

    There are a few ways to install git on your Mac,
    but the way we recommend is by using XCode.
    This will be important when you target your
    builds for iOS or macOS.

    ```console
    $ xcode-select --install
    ```

    If you haven't installed the tools already,
    a dialog should open that confirms you'd like to install them.
    Click **Install**, then once the installation is complete, click **Done**.

 1. <h3>Download and install Visual Studio Code</h3>

    To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code][vscode-install].

    You can instead install and use any other Code OSS-based editor
    that supports VS Code extensions.
    If you choose to do so, for the rest of this article,
    assume VS Code refers to the editor of your choice.

{: .steps .macos-only}

 1. <h3>Install Git for Windows</h3>

    Download and install the latest version of [Git for Windows][].

    For help installing or troubleshooting Git,
    reference the [Git documentation][git-install].

 1. <h3>Download and install Visual Studio Code</h3>

    To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code][vscode-install].

    You can instead install and use any other Code OSS-based editor
    that supports VS Code extensions.
    If you choose to do so, for the rest of this article,
    assume VS Code refers to the editor of your choice.

{: .steps .windows-only}

 1. <h3>Download and install prerequisite packages</h3>

    Using your preferred package manager or mechanism,
    install the latest versions of the following packages:

    - `curl`
    - `git`
    - `unzip`
    - `xz-utils`
    - `zip`
    - `libglu1-mesa`

    On Debian-based distros with `apt-get`, such as Ubuntu,
    install these packages using the following commands:

    ```console
    $ sudo apt-get update -y && sudo apt-get upgrade -y
    $ sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa
    ```

 1. <h3>Download and install Visual Studio Code</h3>

    To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code][vscode-install].

    You can instead install and use any other Code OSS-based editor
    that supports VS Code extensions.
    If you choose to do so, for the rest of this article,
    assume VS Code refers to the editor of your choice.

{: .steps .linux-only}

[chromeos-linux]: https://support.google.com/chromebook/answer/9145439
[chromeos-linux-update]: https://support.google.com/chromebook/answer/9145439?hl=en#:~:text=Fix%20problems%20with%20Linux
[Git for Windows]: https://git-scm.com/downloads/win
[git-install]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
[vscode-install]: https://code.visualstudio.com/docs/setup/setup-overview

## Install and set up Flutter {: #install}

Now that you've installed Git and VS Code,
follow these steps to use VS Code to install and set up Flutter.

:::note Download manually
If you prefer to manually install Flutter,
follow the instructions in [Install Flutter manually][].
:::

 1. <h3>Launch VS Code</h3>

    If not already open, open VS Code by searching for it with Spotlight
    or opening it manually from the directory where it's installed.

 1. <h3>Add the Flutter extension to VS Code</h3>

    To add the Dart and Flutter extensions to VS Code,
    visit the [Flutter extension's marketplace page][flutter-vscode],
    then click **Install**.
    If prompted by your browser, allow it to open VS Code.

 1. <h3>Install Flutter with VS Code</h3>

    1. Open the command palette in VS Code.

       Go to **View** <span aria-label="and then">></span> **Command Palette**
       or press <kbd class="special-key">Cmd/Ctrl</kbd> +
       <kbd>Shift</kbd> + <kbd>P</kbd>.

    1. In the command palette, type `flutter`.

    1. Select **Flutter: New Project**.

    1. VS Code prompts you to locate the Flutter SDK on your computer.
       Select **Download SDK**.

    1. When the **Select Folder for Flutter SDK** dialog displays,
       choose where you want to install Flutter.

    1. Click **Clone Flutter**.

       While downloading Flutter, VS Code displays this pop-up notification:

       ```console
       Downloading the Flutter SDK. This may take a few minutes.
       ```

       This download takes a few minutes.
       If you suspect that the download has hung, click **Cancel** then
       start the installation again.

    1. Click **Add SDK to PATH**.

       When successful, a notification displays:

       ```console
       The Flutter SDK was added to your PATH
       ```

    1. VS Code might display a Google Analytics notice.

       If you agree, click **OK**.

    1. To ensure that Flutter is available in all terminals:

       1. Close, then reopen all terminal windows.
       1. Restart VS Code.

       {:type="a"}

    :::note
    The VS Code setup process might check for Android Studio, which can result in a warning if it's not installed.
    You can safely ignore this if you're targeting other platforms (like web, iOS, or macOS), as the installation will still succeed.
    Afterward, run `flutter doctor` to verify your installation.
    :::

 1. <h3>Troubleshoot installation issues</h3>

    If you encounter any issues during installation,
    check out [Flutter installation troubleshooting][troubleshoot].

{:.steps}

[Install Flutter manually]: /install/manual
[flutter-vscode]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[troubleshoot]: /install/troubleshoot
