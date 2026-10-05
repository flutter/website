---
title: Install Flutter
shortTitle: Install
description: >-
  Download and install the Flutter SDK and set up your development
  environment for Android, iOS, web, and desktop.
---

<a id="get-started" aria-hidden="true"></a>

## Choose an installation method {: #install}

To start building multiplatform apps from a single codebase,
choose how you'd like to install the Flutter SDK:

<div class="card-grid very-wide">
  <div class="card filled-card outlined-card">
    <div class="card-header">
      <span class="card-title">
        <Icon id="rocket_launch" filled="true" size="1.675rem" />
        <span>Install with VS Code</span>
      </span>
      <span class="card-subtitle" style="margin-top: 0.1rem;">Recommended</span>
    </div>
    <div class="card-content" style="flex-direction: column; align-items: flex-start;">
      <p>Use the Flutter extension in VS Code or another Code OSS-based editor
        to automatically download and install the Flutter SDK, set up your
        environment, and run your first app.</p>
      <a class="filled-button" href="/install/quick">Install with VS Code</a>
    </div>
  </div>
  <div class="card outlined-card">
    <div class="card-header">
      <span class="card-title">
        <Icon id="download" filled="true" size="1.675rem" />
        <span>Download and install manually</span>
      </span>
      <span class="card-subtitle" style="margin-top: 0.1rem;">Windows, macOS, Linux, and ChromeOS</span>
    </div>
    <div class="card-content" style="flex-direction: column; align-items: flex-start;">
      <p>Download the latest stable Flutter SDK bundle for your operating
        system, extract the archive, and add Flutter to your
        <code>PATH</code>.</p>
      <a class="outlined-button" href="/install/manual">Download SDK and install</a>
    </div>
  </div>
</div>

## Set up target platforms and IDEs {: #target-platforms}

After you install the Flutter SDK, set up the tools for your target platforms
and configure your preferred editor:

- **Target platforms:** Set up development tools for [Android][], [iOS][],
  [web][], [Windows][], [macOS][], or [Linux][].
- **IDEs and editors:** Configure [VS Code][], [Android Studio, or IntelliJ][],
  or view all environment options in [Custom setup][].
- **Next steps:** Follow the [Flutter learning pathway][] to build your first
  Flutter app.

[Android]: /platform-integration/android/setup
[iOS]: /platform-integration/ios/setup
[web]: /platform-integration/web/setup
[Windows]: /platform-integration/windows/setup
[macOS]: /platform-integration/macos/setup
[Linux]: /platform-integration/linux/setup
[VS Code]: /tools/vs-code#setup
[Android Studio, or IntelliJ]: /tools/android-studio#setup
[Custom setup]: /install/custom
[Flutter learning pathway]: /learn/pathway

## Try Flutter online {:#try}

You can also try Flutter in your browser without any local setup.

<div class="card-grid">
  <a class="card outlined-card" href="{{site.dartpad}}" target="_blank">
    <div class="card-header">
      <span class="card-title">
        <span>DartPad</span>
        <Icon id="open_in_new" size="1rem" />
      </span>
    </div>
    <div class="card-content">
      <p>Build and run single-file Flutter apps on the web.</p>
    </div>
  </a>
</div>

## Update Flutter {: #update}

If you already have Flutter installed and want to
upgrade your Flutter SDK installation or switch to a different release channel,
consult [Upgrading Flutter][].

When upgrading, also review the published list of
[breaking changes and migration guides][].

[Upgrading Flutter]: /install/upgrade
[breaking changes and migration guides]: /release/breaking-changes

## Download previous releases {: #previous-releases}

If you want to download and install a previous release of Flutter,
visit the [SDK archive][].

:::note
We recommend keeping your apps and development environments
up to date with the **latest** `stable` or `beta` releases.
To download the latest stable release of the Flutter SDK,
visit [Install Flutter manually][].
:::

[SDK archive]: /install/archive
[Install Flutter manually]: /install/manual#install-flutter

## Troubleshoot and uninstall Flutter {: #uninstall}

Use the following guides to resolve common setup issues or uninstall Flutter:

<div class="card-list">
  <a class="card outlined-card" href="/install/add-to-path">
    <div class="card-header">
      <span class="card-title">Add Flutter to PATH</span>
    </div>
    <div class="card-content">
      <p>Using Flutter on the command line requires that the Flutter SDK is
        added to your system's <code>PATH</code> environment variable.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/install/troubleshoot">
    <div class="card-header">
      <span class="card-title">Troubleshoot SDK</span>
    </div>
    <div class="card-content">
      <p>Resolve common issues with your Flutter development environment.</p>
    </div>
  </a>
  <a class="card outlined-card" href="/install/uninstall">
    <div class="card-header">
      <span class="card-title">Uninstall SDK</span>
    </div>
    <div class="card-content">
      <p>Remove the Flutter SDK and related configuration files from your
        system.</p>
    </div>
  </a>
</div>
