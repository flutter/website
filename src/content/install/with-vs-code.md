---
title: Install Flutter using VS Code
shortTitle: Install with VS Code
breadcrumb: With VS Code
description: >-
  Learn how to use VS Code to quickly install and set up the Flutter SDK.
---

Learn how to install and set up Flutter in a Code OSS-based editor.
This includes (but is not limited to), [VS Code][], [Cursor][], and [Windsurf][].

[VS Code]: https://code.visualstudio.com
[Cursor]: https://cursor.com/
[Windsurf]: https://windsurf.com/

:::tip
If you've never set up or developed an app with Flutter before,
follow [Set up and test drive Flutter][] instead.
:::

[Set up and test drive Flutter]: /get-started/quick

## Choose your development platform {: #dev-platform}

The instructions on this page are configured to cover
installing Flutter on a **Windows**{:.selected-os-text} device.

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

{: .steps .chromeos-only}

 1. <h3>Install the Xcode command-line tools</h3>

    Download the Xcode command-line tools to get access to
    the command-line tools that Flutter relies on, including Git.

    To download the tools, run the following command in your preferred terminal:

    ```console
    $ xcode-select --install
    ```

    If you haven't installed the tools already,
    a dialog should open that confirms you'd like to install them.
    Click **Install**, then once the installation is complete, click **Done**.

 1. <h3>Download and install Visual Studio Code</h3>

    To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code][vscode-install].

{: .steps .macos-only}

 1. <h3>Install Git for Windows</h3>

    Download and install the latest version of [Git for Windows][].

    For help installing or troubleshooting Git,
    reference the [Git documentation][git-install].

 1. <h3>Download and install Visual Studio Code</h3>

    To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code][vscode-install].

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

{: .steps .linux-only}

[chromeos-linux]: https://support.google.com/chromebook/answer/9145439
[chromeos-linux-update]: https://support.google.com/chromebook/answer/9145439?hl=en#:~:text=Fix%20problems%20with%20Linux
[Git for Windows]: https://git-scm.com/downloads/win
[git-install]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
[vscode-install]: https://code.visualstudio.com/docs/setup/setup-overview

## Install and set up Flutter {: #install-flutter}

Now that you've installed Git and VS Code,
follow these steps to use VS Code to install and set up Flutter.

 1. <h3>Launch VS Code</h3>

    If not already open, open VS Code by searching for it with Spotlight
    or opening it manually from the directory where it's installed.

 1. <h3>Add the Flutter extension to VS Code</h3>

    To add the Dart and Flutter extensions to VS Code,
    visit the [Flutter extension's marketplace page][flutter-vscode],
    and click **Install**.
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

 1. <h3>Validate your setup</h3>

    To ensure you installed Flutter correctly,
    run `flutter doctor -v` in your preferred terminal.

    If the command isn't found or there's an error,
    check out [Flutter installation troubleshooting][troubleshoot].

{:.steps}

[Install Flutter manually]: /install/manual
[flutter-vscode]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[troubleshoot]: /install/troubleshoot

## Continue your Flutter journey {: #next-steps}

Now that you've successfully installed Flutter,
set up development for at least one target platform
to continue your journey with Flutter.

:::recommend
If you don't yet have a preferred platform
to target during development,
the Flutter team recommends you first try out
[developing for the web][web-setup]!
:::

[web-setup]: /platform-integration/web/setup

<div class="card-grid link-cards">
  <div class="card filled-card list-card">
    <div class="card-leading">
      <img src="/assets/images/decorative/flutter-on-phone.svg" height="160" aria-hidden="true" alt="A representation of Flutter on multiple devices.">
    </div>
    <div class="card-header">
      <span class="card-title">Set up a target platform</span>
    </div>
    <div class="card-content">
      <ul>
        <li>
          <a class="text-button" href="/platform-integration/web/setup">Target the web</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/android/setup">Target Android</a>
        </li>
        <li class="macos-only">
          <a class="text-button" href="/platform-integration/ios/setup">Target iOS</a>
        </li>
        <li class="macos-only">
          <a class="text-button" href="/platform-integration/macos/setup">Target macOS</a>
        </li>
        <li class="windows-only">
          <a class="text-button" href="/platform-integration/windows/setup">Target Windows</a>
        </li>
        <li class="linux-only">
          <a class="text-button" href="/platform-integration/linux/setup">Target Linux</a>
        </li>
      </ul>
    </div>
  </div>

  <div class="card filled-card list-card">
    <div class="card-leading">
      <img src="/assets/images/decorative/pointing-the-way.png" height="160" aria-hidden="true" alt="Dash helping you explore Flutter learning resources.">
    </div>
    <div class="card-header">
      <span class="card-title">Learn Flutter development</span>
    </div>
    <div class="card-content">
      <ul>
        <li>
          <a class="text-button" href="/get-started/codelab">Write your first app</a>
        </li>
        <li>
          <a class="text-button" href="/get-started/fundamentals">Learn the fundamentals</a>
        </li>
        <li>
          <a class="text-button" href="https://www.youtube.com/watch?v=b_sQ9bMltGU&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG">Explore Flutter widgets</a>
        </li>
      </ul>
    </div>
  </div>

  <div class="card filled-card list-card">
    <div class="card-leading">
      <img src="/assets/images/decorative/up-to-date.png" height="160" aria-hidden="true" alt="Keep up to date with Flutter">
    </div>
    <div class="card-header">
      <span class="card-title">Stay up to date with Flutter</span>
    </div>
    <div class="card-content">
      <ul>
        <li>
          <a class="text-button" href="/install/upgrade">Update Flutter</a>
        </li>
        <li>
          <a class="text-button" href="/release/release-notes">Find out what's new</a>
        </li>
        <li>
          <a class="text-button" href="{{site.social.youtube}}">Subscribe on YouTube</a>
        </li>
      </ul>
    </div>
  </div>
</div>
