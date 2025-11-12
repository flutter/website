---
title: Install Flutter manually
shortTitle: Install manually
breadcrumb: Manually
description: >-
  Learn how to install and set up the Flutter SDK manually.
---

Learn how to install and manually set up
your Flutter development environment.

:::tip
If you've never set up or developed an app with Flutter before,
follow [Get started with Flutter][] instead.

If you're just looking to quickly install Flutter,
consider [installing Flutter with VS Code][with-vs-code] for
a streamlined setup experience.
:::

[Get started with Flutter]: /get-started
[with-vs-code]: /install/with-vs-code

## Choose your development platform {: #dev-platform}

The instructions on this page are configured to cover
installing Flutter on a **Windows**{:.selected-os-text} device.

If you'd like to follow the instructions for a different OS,
please select one of the following.

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

    Extract the SDK bundle you downloaded into
    the directory you want to store the Flutter SDK in.

    1. Copy the following command.
    1. Replace `<sdk_zip_path>` with the path to the bundle you downloaded.
    1. Replace `<destination_directory_path>` with the path to the
       folder you want the extracted SDK to be in.
    1. Run the edited command in your preferred terminal.

    ```console
    $ Expand-Archive –Path <sdk_zip_path> -Destination <destination_directory_path>
    ```

    For example, if you downloaded the bundle for Flutter 3.29.3 into
    the `%USERPROFILE%\Downloads` directory and want to
    store the extracted SDK in the `%USERPROFILE%\develop` directory:

    ```console
    $ Expand-Archive `
      -Path $env:USERPROFILE\Downloads\flutter_windows_3.29.3-stable.zip `
      -Destination $env:USERPROFILE\develop\
    ```

{: .steps .windows-only}

 1. <h3>Download the Flutter SDK bundle</h3>

    Depending on your macOS device's cpu architecture,
    download one of the following installation bundles to get the
    latest stable release of the Flutter SDK.

    | Apple Silicon (ARM64)                            | Intel                                          |
    |--------------------------------------------------|------------------------------------------------|
    | <DownloadLatestButton os="macos" arch="arm64" /> | <DownloadLatestButton os="macos" arch="x64" /> |

 1. <h3>Create a folder to store the SDK</h3>

    Create or find a folder to store the extracted SDK in.
    Consider creating and using a directory at `~/develop/`.

 1. <h3>Extract the SDK</h3>

    Extract the SDK bundle you downloaded into
    the directory you want to store the Flutter SDK in.

    1. Copy the following command.
    1. Replace `<sdk_zip_path>` with the path to the bundle you downloaded.
    1. Replace `<destination_directory_path>` with the path to the
       folder you want the extracted SDK to be in.
    1. Run the edited command in your preferred terminal.

    ```console
    $ unzip <sdk_zip_path> -d <destination_directory_path>
    ```

    For example, if you downloaded the bundle for Flutter 3.29.3 into
    the `~/Downloads` directory and want to
    store the extracted SDK in the `~/develop` directory:

    ```console
    $ unzip ~/Downloads/flutter_macos_3.29.3-stable.zip -d ~/develop/
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

    Extract the SDK bundle you downloaded into
    the directory you want to store the Flutter SDK in.

    1. Copy the following command.
    1. Replace `<sdk_zip_path>` with the path to the bundle you downloaded.
    1. Replace `<destination_directory_path>` with the path to the
       folder you want the extracted SDK to be in.
    1. Run the edited command in your preferred terminal.

    ```console
    $ tar -xf <sdk_zip_path> -C <destination_directory_path>
    ```

    For example, if you downloaded the bundle for Flutter 3.29.3 into
    the `~/Downloads` directory and want to
    store the extracted SDK in the `~/develop` directory:

    ```console
    $ tar -xf ~/Downloads/flutter_linux_3.29.3-stable.tar.xz -C ~/develop/
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

## Continue your Flutter journey {: #next-steps}

Now that you've successfully installed Flutter,
set up development for at least one target platform
to continue your journey with Flutter.

:::recommend
If you don't yet have a preferred platform
to target during development,
the Flutter team recommends you first try out
[developing on the web][web-setup]!
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
