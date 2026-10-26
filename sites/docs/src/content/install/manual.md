---
title: Install Flutter manually
shortTitle: Install manually
breadcrumb: Manually
description: >-
  Learn how to install and set up the Flutter SDK manually.
---

Learn how to manually download and set up the Flutter SDK
and configure your development environment.

For a faster, automated setup in VS Code (or any Code OSS-based editor),
follow [Install Flutter with VS Code][with-vs-code] instead.
To download a specific Flutter version or release channel,
visit the [SDK archive][], or manage an existing installation in
[Install and set up Flutter][].

[with-vs-code]: /install/quick
[SDK archive]: /install/archive
[Install and set up Flutter]: /install

## Confirm your development platform {: #dev-platform}

These instructions are configured for **Windows**{:.selected-os-text}.
If you're using a different operating system, select it below:

<OSSelector />

## Download prerequisite software {: #download-prerequisites}

Before installing the Flutter SDK,
first complete the following setup.

 1. <h3>Install Git for Windows</h3>

    Download and install the latest version of [Git for Windows][].

    For help installing or troubleshooting Git,
    reference the [Git documentation][git-install].

 1. <h3>Set up an editor or IDE</h3>

    For the best experience developing Flutter apps,
    consider installing and setting up an
    [editor or IDE with Flutter support][editors]{: target="_blank"}.

{: .steps .windows-only}

 1. <h3>Install the Xcode command-line tools</h3>

    **If you already have Git installed,**
    you can skip to the next step: Set up an editor or IDE.

    Download the Xcode command-line tools to get access to
    the command-line tools that Flutter relies on, including Git.

    To download the tools, run the following command in your preferred terminal:

    ```console
    $ xcode-select --install
    ```

    If you haven't installed the tools already,
    a dialog should open that confirms you'd like to install them.
    Click **Install**, then once the installation is complete, click **Done**.

 1. <h3>Set up an editor or IDE</h3>

    For the best experience developing Flutter apps,
    consider installing and setting up an
    [editor or IDE with Flutter support][editors]{: target="_blank"}.

{: .steps .macos-only}

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

1. <h3>Set up an editor or IDE</h3>

   For the best experience developing Flutter apps,
   consider installing and setting up an
   [editor or IDE with Flutter support][editors]{: target="_blank"}.

{: .steps .linux-only}

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

 1. <h3>Set up an editor or IDE</h3>

    For the best experience developing Flutter apps,
    consider installing and setting up an
    [editor or IDE with Flutter support][editors]{: target="_blank"}.

{: .steps .chromeos-only}

[editors]: /tools/editors
[Git for Windows]: https://git-scm.com/downloads/win
[git-install]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
[chromeos-linux]: https://support.google.com/chromebook/answer/9145439
[chromeos-linux-update]: https://support.google.com/chromebook/answer/9145439?hl=en#:~:text=Fix%20problems%20with%20Linux

## Install and set up Flutter {: #install-flutter}

To install the Flutter SDK,
download the latest bundle from the SDK archive,
then extract the SDK to where you want it stored.

 1. <h3>Download the Flutter SDK bundle</h3>

    Download the following installation bundle to get the
    latest stable release of the Flutter SDK.

    <DownloadLatestButton os="windows" />

 1. <h3>Create a folder to store the SDK</h3>

    Create or find a folder to store the extracted SDK in.
    Consider creating and using a directory at
    `%USERPROFILE%\develop` (`C:\Users\{username}\develop`).

    :::note
    Select a location that
    doesn't have special characters or spaces in its path and
    doesn't require elevated privileges.
    :::

 1. <h3>Extract the SDK</h3>

    Extract the downloaded `.zip` archive into your chosen directory
    (for example, from `Downloads` into `develop`,
    adjusting the filename and paths as needed):

    <Tabs key="windows-terminal">
    <Tab name="PowerShell">

    ```powershell
    Expand-Archive `
      -Path "$env:USERPROFILE\Downloads\flutter_windows_3.47.5-stable.zip" `
      -DestinationPath "$env:USERPROFILE\develop"
    ```

    </Tab>
    <Tab name="Command prompt">

    ```bat
    tar -xf "%USERPROFILE%\Downloads\flutter_windows_3.47.5-stable.zip" -C "%USERPROFILE%\develop"
    ```

    </Tab>
    </Tabs>

    :::note
    If the `flutter.bat` file is missing from the `bin` directory
    after extraction, your antivirus software might have quarantined it.
    If this happens, configure your antivirus to trust the Flutter SDK directory,
    then extract the bundle again.
    :::

{: .steps .windows-only}

<div class="macos-only">

:::warning
**Note for Intel Macs:**
Flutter is deprecating support for Intel-based Macs (x64).
Future Flutter releases will require Apple Silicon.
For details, check out the
[macOS Intel deprecation strategy](https://docs.google.com/document/d/1ty3js_Eg2sNIbDuyYS_aV7h4jYdx1hEpX_mV135gO4s/edit?tab=t.0#heading=h.cx7d8y57ce6p).
:::

</div>

 1. <h3>Download the Flutter SDK bundle</h3>

    To choose the correct bundle,
    you need to know your Mac's processor type.
    *(To check, go to **Apple menu () > About This Mac**
    and look at the **Processor** or **Chip** section.)*

    Depending on your macOS device's cpu architecture,
    download one of the following installation bundles to get the
    latest stable release of the Flutter SDK.

    | Apple Silicon (ARM64)                                                 | Intel                                                               |
    |-----------------------------------------------------------------------|---------------------------------------------------------------------|
    | <DownloadLatestButton os="macos" arch="arm64"></DownloadLatestButton> | <DownloadLatestButton os="macos" arch="x64"></DownloadLatestButton> |

 1. <h3>Create a folder to store the SDK</h3>

    Create or find a folder to store the extracted SDK in.
    Consider creating and using a directory at `~/develop/`.

 1. <h3>Extract the SDK</h3>

    Extract the downloaded `.zip` archive into your chosen directory
    (for example, from `~/Downloads` into `~/develop/`,
    adjusting the filename and paths as needed):

    ```console
    $ unzip ~/Downloads/flutter_macos_3.47.5-stable.zip -d ~/develop/
    ```

{: .steps .macos-only}

 1. <h3>Download the Flutter SDK bundle</h3>

    Download the following installation bundle to get the
    latest stable release of the Flutter SDK.

    <DownloadLatestButton os="linux" />

 1. <h3>Create a folder to store the SDK</h3>

    Create or find a folder to store the extracted SDK in.
    Consider creating and using a directory at `~/develop/`.

 1. <h3>Extract the SDK</h3>

    Extract the downloaded `.tar.xz` archive into your chosen directory
    (for example, from `~/Downloads` into `~/develop/`,
    adjusting the filename and paths as needed):

    ```console
    $ tar -xf ~/Downloads/flutter_linux_3.47.5-stable.tar.xz -C ~/develop/
    ```

{: .steps .linux-only .chromeos-only}

## Add Flutter to your PATH {: #add-to-path}

Now that you've downloaded the SDK,
add the Flutter SDK's `bin` directory to your `PATH` environment variable.
Adding Flutter to your `PATH` allows you to use the
`flutter` and `dart` command-line tools in terminals and IDEs.

<div class="windows-only">

{% render "docs/install/path/windows.md" %}

</div>

<div class="macos-only">

{% render "docs/install/path/macos.md" %}

</div>

<div class="linux-only">

{% render "docs/install/path/linux.md" %}

</div>

<div class="chromeos-only">

{% render "docs/install/path/chromeos.md" %}

</div>

## Validate your setup {: #validate-setup}

To verify your Flutter installation, run `flutter doctor` in your terminal:

```console
$ flutter doctor
```

:::note What to expect in `flutter doctor`
You only need checkmarks (`[✓]`) for **Flutter**, your preferred editor,
and the platforms you plan to target
(for example, **Chrome** lets you build for the web immediately).
You can safely ignore `[!]` or `[✗]` warnings for tools like
Android Studio or Xcode until you're ready to target those platforms.
:::

If you encounter any issues during installation,
consult [Flutter installation troubleshooting][troubleshoot].

[troubleshoot]: /install/troubleshoot

## Continue your Flutter journey {: #next-steps}

Now that you've successfully installed Flutter,
set up development for a target platform or start learning
to continue your journey with Flutter.

{% render "docs/get-started/setup-next-steps.html", site: site %}
