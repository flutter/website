---
layout: page
title: "Get Started: Setup Flutter"
permalink: /get-started/setup-flutter/
---

This page describes how to setup your development environment to run Flutter
apps on Android.

A [later step](/get-started/setup-ios/) will detail how to run Flutter apps on iOS.

Flutter is a flexible toolkit, so please start by selecting your development
tool of choice for writing, building, and running your Flutter app.

<ul class="tabs__top-bar">
    <li class="tab-link current" data-tab="tab-install-androidsstudio">Android Studio</li>
    <li class="tab-link" data-tab="tab-install-vscode">VS Code</li>
    <li class="tab-link" data-tab="tab-install-terminal">Terminal + editor</li>
</ul>

<div id="tab-install-androidsstudio" class="tabs__content current" markdown="1">

*Android Studio:* A complete, integrated IDE experience for Flutter. 

## Install the Flutter SDK

{% include /get-started/install_flutter_sdk.md %}

## Android Studio setup

### Install Android Studio:

   * Download and install Android Studio 3.0 or later from the the [Android
     Studio site](https://developer.android.com/studio/index.html)

### Install the Flutter and Dart plugins

Flutter is supported by two plugins:

   * The `Flutter` plugin powers Flutter developer workflows (running,
     debugging, hot reload, etc.).
   * The `Dart` plugin offers code analysis (code validation as you type, code
     completions, etc.).

To install these:

   1. Start Android Studio.
   1. Open plugin preferences (**Preferences>Plugins** on macOS,
      **File>Settings>Plugins** on Windows & Linux).
   1. Select **Browse repositories…**,  select the Flutter plug-in and click
      `install`.
   1. Click `Yes` when prompted to install the Dart plugin.
   1. Click `Restart` when prompted.

{% include /get-started/android_device.md %}

## Validate your setup with the flutter doctor

</div>

<div id="tab-install-vscode" class="tabs__content" markdown="1">

*VS Code:* A light-weight editor with Flutter run and debug support.

## Install the Flutter SDK

{% include /get-started/install_flutter_sdk.md %}

## Android Studio setup

**TODO TODO TODO TODO TODO TODO TODO.**

</div>

<div id="tab-install-terminal" class="tabs__content" markdown="1">

*Terminal + editor:* Your editor-of-choice combined with Flutter's terminal tool
for running and building.

## Install the Flutter SDK

{% include /get-started/install_flutter_sdk.md %}

## Android Studio setup

<aside id="note" class="alert alert-info" markdown="1">
**Note** Android Studio must be installed and initialized to get all required
Android components. Once they have been installed, you can continue to developer
Flutter apps in your editor of choice.
</aside>

   1. Download and install Android Studio 3.0 or later from the the [Android
      Studio site](https://developer.android.com/studio/index.html)
   1. Start Android Studio, and go through the 'Android Studio Setup Wizard'.
      This will install the latest Android SDK, Android SDK Platform-Tools, and
      Android SDK Build-Tools, which are required by Flutter when developing for
      Android.
   1. Select **File>New Project** to create a regular Android project, and wait
      for it to initialize. Then select **Tools>Android>AVD Manager** make sure
      at least one Emulator image has been defined.
   1. Start the Emulator image.

## Validate your setup with the flutter doctor

   1. Run the following command to see if there are any dependencies you need to
      install to complete the setup:
   {% commandline %}
   flutter doctor
   {% endcommandline %}

This command checks your environment and displays a report to the terminal window.
The Dart SDK is bundled with Flutter; it is not necessary to install Dart separately.
Check the output carefully for other software you may need to install or further 
tasks to perform (shown in **bold** text).

For example:
```
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/obiwan/Library/Android/sdk
    ✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ
    • Try re-installing or updating your Android SDK,
      visit https://flutter.io/setup/#android-setup for detailed instructions.
```

The first time you run a flutter command (such as `flutter doctor`), it downloads its own dependencies and compiles
itself. Subsequent runs should be much faster.

</div>

## Next step

Now that you have the Flutter framework setup, select an editor.

[Next step: Setup Editor](/get-started/setup-editor/)

