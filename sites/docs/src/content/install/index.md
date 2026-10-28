---
title: Install and set up Flutter
shortTitle: Install
description: >-
  Download and install the Flutter SDK, configure your IDE and target
  platforms, or update and troubleshoot an existing Flutter installation.
---

<a id="get-started" aria-hidden="true"></a>

## Choose an installation method {: #install}

To start building multiplatform apps from a single codebase,
choose how you'd like to install the Flutter SDK:

<div class="card-grid wide">
  <div class="card filled-card outlined-card">
    <div class="card-header">
      <span class="card-title">
        <Icon id="rocket_launch" filled="true" size="1.675rem" />
        <span>Install with VS Code</span>
      </span>
      <span class="card-subtitle" style="margin-top: 0.1rem;">Recommended</span>
    </div>
    <div class="card-content" style="flex-direction: column; align-items: flex-start; justify-content: space-between; flex: 1;">
      <p>Use the Flutter extension in VS Code or another Code OSS-based editor
        to download and install the Flutter SDK, add it to your
        <code>PATH</code>, and validate your setup.</p>
      <a class="filled-button" style="padding: 0.55rem 1.15rem; margin-top: 0.5rem;" href="/install/with-vs-code">Install with VS Code</a>
    </div>
  </div>
  <div class="card outlined-card">
    <div class="card-header">
      <span class="card-title">
        <Icon id="download" filled="true" size="1.675rem" />
        <span>Download and install manually</span>
      </span>
      <span class="card-subtitle" style="margin-top: 0.1rem;">Set up without VS Code</span>
    </div>
    <div class="card-content" style="flex-direction: column; align-items: flex-start; justify-content: space-between; flex: 1;">
      <p>Download the latest stable Flutter SDK bundle for your operating
        system, extract the archive, and add Flutter to your
        <code>PATH</code>.</p>
      <a class="outlined-button" style="padding: 0.55rem 1.15rem; margin-top: 0.5rem;" href="/install/manual">Download SDK and install</a>
    </div>
  </div>
</div>

<a id="editor" aria-hidden="true"></a>

## Set up target platforms and editors {: #target-platform}

After you install the Flutter SDK,
set up the tools for your target platforms and configure your preferred editor:

- **Target platforms:** Set up development tools for [Android][], [iOS][],
  [web][] (requires only a supported browser), [Windows][], [macOS][], or
  [Linux][].
- **IDEs and editors:** Configure Flutter support in [VS Code][] or
  [Android Studio and IntelliJ][].

[Android]: /platform-integration/android/setup
[iOS]: /platform-integration/ios/setup
[web]: /platform-integration/web/setup
[Windows]: /platform-integration/windows/setup
[macOS]: /platform-integration/macos/setup
[Linux]: /platform-integration/linux/setup
[VS Code]: /tools/vs-code#setup
[Android Studio and IntelliJ]: /tools/android-studio#setup

<a id="try" aria-hidden="true"></a>
<a id="update" aria-hidden="true"></a>
<a id="previous-releases" aria-hidden="true"></a>

<a id="uninstall" aria-hidden="true"></a>

## Manage or troubleshoot your installation {: #manage}

If you already have Flutter installed,
use the following guides to update, configure,
troubleshoot, or remove your installation:

<div class="card-grid">
  <Card title="Upgrade Flutter" link="/install/upgrade" outlined="true">
    Upgrade the Flutter SDK to the latest release or switch release channels.
  </Card>
  <Card title="SDK archive" link="/install/archive" outlined="true">
    Download and install previous releases of the Flutter SDK.
  </Card>
  <Card title="Add Flutter to PATH" link="/install/add-to-path" outlined="true">
    Configure your system's PATH environment variable to run
    Flutter on the command line.
  </Card>
  <Card title="Troubleshoot SDK" link="/install/troubleshoot" outlined="true">
    Resolve common issues with your Flutter development environment.
  </Card>
  <Card title="Uninstall SDK" link="/install/uninstall" outlined="true">
    Remove the Flutter SDK and related configuration files from your system.
  </Card>
</div>

<a id="next-steps" aria-hidden="true"></a>

:::tip Ready to start building?
Once your environment is set up,
follow the [Flutter learning pathway][] to build your first Flutter app.
:::

[Flutter learning pathway]: /learn/pathway
