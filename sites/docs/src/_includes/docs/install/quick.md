Learn how to use [Visual Studio Code (VS Code)][VS Code] or any compatible
Code OSS-based editor to quickly install and set up your
Flutter development environment.

If you prefer a different editor or IDE,
you can [install Flutter manually][].

[VS Code]: https://code.visualstudio.com
[install Flutter manually]: /install/manual

## Confirm your development platform {: #dev-platform}

These instructions are configured for **Windows**{:.selected-os-text}.
If you're using a different operating system,
select it from one of the following:

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
    [install and set up Visual Studio Code][vscode-install]
    (or your preferred Code OSS-based editor).

{: .steps .chromeos-only}

<div class="macos-only">

:::warning
**Note for Intel Macs:**
Flutter is deprecating support for Intel-based Macs (x64).
Future Flutter releases will require Apple Silicon.
For details, check out the
[macOS Intel deprecation strategy](https://docs.google.com/document/d/1ty3js_Eg2sNIbDuyYS_aV7h4jYdx1hEpX_mV135gO4s/edit?tab=t.0#heading=h.cx7d8y57ce6p).
:::

</div>

 1. <h3>Install the Xcode command-line tools</h3>

    **If you already have Git installed,**
    you can skip to the next step: Download and install Visual Studio Code.

    Download the Xcode command-line tools to get access to
    the command-line tools that Flutter relies on, including Git.
    This is also required when you target your builds for iOS or macOS.

    To download the tools, run the following command in your preferred terminal:

    ```console
    $ xcode-select --install
    ```

    If you haven't installed the tools already,
    a dialog should open that confirms you'd like to install them.
    Click **Install**, then once the installation is complete, click **Done**.

 1. <h3>Download and install Visual Studio Code</h3>

    To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code][vscode-install]
    (or your preferred Code OSS-based editor).

{: .steps .macos-only}

 1. <h3>Install Git for Windows</h3>

    Download and install the latest version of [Git for Windows][].

    For help installing or troubleshooting Git,
    reference the [Git documentation][git-install].

 1. <h3>Download and install Visual Studio Code</h3>

    To quickly install Flutter, then edit and debug your apps,
    [install and set up Visual Studio Code][vscode-install]
    (or your preferred Code OSS-based editor).

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
    [install and set up Visual Studio Code][vscode-install]
    (or your preferred Code OSS-based editor).

{: .steps .linux-only}

[chromeos-linux]: https://support.google.com/chromebook/answer/9145439
[chromeos-linux-update]: https://support.google.com/chromebook/answer/9145439?hl=en#:~:text=Fix%20problems%20with%20Linux
[Git for Windows]: https://git-scm.com/downloads/win
[git-install]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
[vscode-install]: https://code.visualstudio.com/docs/setup/setup-overview

<a id="install-flutter" aria-hidden="true"></a>

## Install and set up Flutter {: #install}

Now that you've installed the prerequisites,
use VS Code to download and set up the Flutter SDK:

 1. <h3>Install the Flutter extension</h3>

    Open VS Code, then install the
    [Flutter extension from the VS Code Marketplace][flutter-vscode]
    or press <kbd class="special-key">Cmd/Ctrl</kbd> +
    <kbd>Shift</kbd> + <kbd>X</kbd> to open the **Extensions** view,
    search for `Flutter`, and click **Install**.
    Installing the Flutter extension also installs the Dart extension.

 1. <h3>Install Flutter with VS Code</h3>

    1. Open the Command Palette in VS Code.

       Go to **View** <span aria-label="and then">></span> **Command Palette**
       or press <kbd class="special-key">Cmd/Ctrl</kbd> +
       <kbd>Shift</kbd> + <kbd>P</kbd>.

    1. In the Command Palette, type `flutter` and select
       **Flutter: New Project**.

    1. VS Code prompts you to locate the Flutter SDK on your computer.
       Select **Download SDK**.

    1. When the **Select Folder for Flutter SDK** dialog displays,
       choose where you want to install Flutter and click **Clone Flutter**.

       While downloading Flutter, VS Code displays this pop-up notification:

       ```console
       Downloading the Flutter SDK. This may take a few minutes.
       ```

       This download takes a few minutes.
       If you suspect that the download has hung, click **Cancel** then
       start the installation again.

    1. Once the download finishes, click **Add SDK to PATH**.

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

    To verify your installation, open the Command Palette
    (<kbd class="special-key">Cmd/Ctrl</kbd> +
    <kbd>Shift</kbd> + <kbd>P</kbd>) and select
    **Flutter: Run Flutter Doctor**, or run `flutter doctor`
    in your terminal.

    In the output, you only need checkmarks (`[✓]`) for **Flutter**
    and the platforms you plan to target
    (for example, **Chrome** lets you build for the web immediately).
    You can safely ignore `[!]` or `[✗]` warnings for tools like
    Android Studio or Xcode until you're ready to target those platforms.

    If you encounter any issues during installation,
    consult [Flutter installation troubleshooting][troubleshoot].

{:.steps}

[flutter-vscode]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[troubleshoot]: /install/troubleshoot
