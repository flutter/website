---
title: Uninstall Flutter
shortTitle: Uninstall
description: >-
    How to remove the Flutter SDK and clean up its configuration files.
showToc: false
---

To remove the Flutter SDK from your development machine,
delete the directories that store Flutter and its configuration files.

## Choose your development platform {: #dev-platform }

The instructions on this page are configured to cover
uninstall Flutter on a **Windows**{:.selected-os-text} device.

If you'd like to follow the instructions for a different OS,
please select one of the following.

<OSSelector />

## Uninstall the Flutter SDK {: #uninstall }

 1. <h3>Determine your Flutter SDK installation location</h3>

    Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

 1. <h3>Remove the installation directory</h3>

    To uninstall the Flutter SDK,
    delete the `flutter` directory you installed Flutter to.

    For example, if you downloaded Flutter into a
    `develop\flutter` folder inside your user directory,
    run the following command to delete the SDK:

    ```ps
    $ Remove-Item -Recurse -Force -Path (Join-Path $env:USERPROFILE "develop\flutter")
    ```

{: .steps .windows-only}

 1. <h3>Determine your Flutter SDK installation location</h3>

    Copy the absolute path to the directory that you
    downloaded and extracted the Flutter SDK into.

 1. <h3>Remove the installation directory</h3>

    To uninstall the Flutter SDK,
    delete the `flutter` directory you installed Flutter to.

    For example, if you downloaded Flutter into a
    `develop/flutter` folder inside your user directory,
    run the following command to delete the SDK:

    ```console
    $ rm -rf ~/develop/flutter
    ```

{: .steps .macos-only .linux-only .chromeos-only }

## Clean up installation and configuration files {: #cleanup }

Flutter and Dart add to additional directories in your home directory.
These contain configuration files and package downloads.
The following cleanup is optional.

 1. <h3>Remove Flutter configuration directories</h3>

    If you don't want to preserve your Flutter tooling configuration,
    remove the following directories from your device.

    <div class="windows-only">

    - `%APPDATA%\.flutter-devtools`

    To remove these directories, run the following command:

    ```ps
    $ Remove-Item -Recurse -Force -Path (Join-Path $env:APPDATA ".flutter-devtools")
    ```

    </div>

    <div class="macos-only linux-only chromeos-only">

    - `~/.flutter`
    - `~/.flutter-devtools`
    - `~/.flutter_settings`

    To remove these directories, run the following command:

    ```ps
    $ rm -rf  ~/.flutter ~/.flutter-devtools ~/.flutter_settings
    ```

    </div>

 1. <h3>Remove Dart configuration directories</h3>

    If you don't want to preserve your Dart tooling configuration,
    remove the following directories from your device.

    <div class="windows-only">

    - `%APPDATA%\.dart`
    - `%APPDATA%\.dart-tool`
    - `%LOCALAPPDATA%\.dartServer`

    To remove these directories, run the following command:

    ```console
    $ Remove-Item -Recurse -Force -Path (Join-Path $env:APPDATA ".dart"), (Join-Path $env:APPDATA ".dart-tool"), (Join-Path $env:LOCALAPPDATA ".dartServer")
    ```

    </div>

    <div class="macos-only linux-only chromeos-only">

    - `~/.dart`
    - `~/.dart-tool`
    - `~/.dartServer`

    To remove these directories, run the following command:

    ```console
    $ rm -rf  ~/.dart ~/.dart-tool ~/.dartServer
    ```

    </div>

 1. <h3>Remove pub package directories</h3>

    If you don't want to preserve your locally installed pub packages,
    remove the [pub system cache][] directory from your device.

    <div class="windows-only">

    If you didn't change the location of the pub system cache,
    run the following command to
    delete the `%LOCALAPPDATA%\Pub\Cache` directory:

    ```ps
    $ Remove-Item -Recurse -Force -Path (Join-Path $env:LOCALAPPDATA "Pub\Cache")
    ```

    </div>

    <div class="macos-only linux-only chromeos-only">

    If you didn't change the location of the pub system cache,
    run the following command to delete the `~/.pub-cache` directory:

    ```console
    $ rm -rf ~/.pub-cache
    ```

    </div>

{: .steps }

[pub system cache]: {{site.dart-site}}/tools/pub/glossary#system-cache

## Reinstall Flutter {: #reinstall }

You can [reinstall Flutter][flutter-install] or
[just Dart][dart-install] at any time.
If you removed any configuration directories,
reinstalling Flutter restores them to default settings.

[flutter-install]: /install
[dart-install]: {{site.dart-site}}/get-dart
