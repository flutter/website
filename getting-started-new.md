---
layout: page
title: Getting Started with Flutter
permalink: /getting-started-new/
---

This page describes how to prepare your development environment to run Flutter
apps on Android. A [later step](todo) will detail how to run Flutter apps on iOS.

## 1: Select your preferences

Flutter is a flexible toolkit, so please start by selecting your development
tool of choice for writing, building, and running your Flutter app.

<ul class="tabs__top-bar">
    <li class="tab-link current" data-tab="tab-install-androidsstudio">Android Studio</li>
    <li class="tab-link" data-tab="tab-install-vscode">VS Code</li>
    <li class="tab-link" data-tab="tab-install-terminal">Terminal + editor</li>
</ul>

<div id="tab-install-androidsstudio" class="tabs__content current" markdown="1">

*Android Studio:* A complete, integrated IDE experience for Flutter. 

## 2: Android Studio setup

<aside id="note" class="alert alert-info" markdown="1">
**Note** you can also use other IntelliJ IDEs such as [IntelliJ
IDEA](https://www.jetbrains.com/idea/download/), however you still need Android
Studio installed to aquire needed Android components.)
</aside>

### 2a. Install Android Studio:

   * Download and install Android Studio 3.0 or later from the the [Android
     Studio site](https://developer.android.com/studio/index.html)

### 2b. Install the Flutter and Dart plugins:

   * The `Flutter` plugin powers Flutter developer workflows (running,
     debugging, hot reload, etc.).
   * The `Dart` plugin offers code analysis (code validation as you type, code
     completions, etc.).

Installation steps:

   1. Start IntelliJ IDEA or Android Studio.
   1. Open plugin preferences (**Preferences>Plugins** on macOS,
      **File>Settings>Plugins** on Windows & Linux).
   1. Select **Browse repositories…**,  select the Flutter plug-in and click
      `install`.
   1. Click `Yes` when prompted to install the Dart plugin.
   1. Click `Restart` when prompted.

## 3: Installing the Flutter SDK, and creating your first Flutter app

   1. Select **File>New Flutter Project**
   1. Under **Flutter SDK path**, select **Install SDK...**, and enter the
      location where you want to install the Flutter SDK
   1. Click **OK**
   1. Wait for Android Studio to install the SDK, and create the project.

## 4: Run the Flutter app

   1. Locate the main Android Studio toolbar:<br>
      ![Main IntelliJ toolbar](/images/intellij/main-toolbar.png)
   1. In the **target selector**, select an Android device for running the app.
      If none are listed as available, select **Tools>Android>AVD Manager** and
      create one there. For details, see [Managing
      AVDs](https://developer.android.com/studio/run/managing-avds.html).
   1. Click the **Run icon** in the toolbar, or invoke the menu item **Run >
      Run**.
   1. If everything works, you should see your starter app on your device or
      simulator:<br>
      ![Starter App on Android](/images/flutter-starter-app-android.png)

## 5: Try a hot reload

Flutter offers a fast development cycle with _hot reload_, the ability to reload
the code of a live running app without restarting or losing app state. Simply
make a change to your source code, tell your IDE or command-line tool that you
want to hot reload, and see the change in your simulator, emulator, or device.

  1. Change the string `'Hello from Flutter!'` to `'Hello from my app!'`
  1. Do not press the 'Stop' button; let your app continue to run.
  1. To see your changes invoke **Save All** (`cmd-s` / `ctrl-s`), or click the
     **Hot Reload button** (the button with the lightning bolt icon).

You should see the updated string in the running app almost immediately.

</div>

<div id="tab-install-vscode" class="tabs__content" markdown="1">

*VS Code:* A light-weight editor with Flutter run and debug support.

## 2: Android Studio setup

**TODO TODO TODO TODO TODO TODO TODO.**

</div>

<div id="tab-install-terminal" class="tabs__content" markdown="1">

*Terminal + editor:* Your editor-of-choice combined with Flutter's terminal tool
for running and building.

## 2: Android Studio setup

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

## 3: Installing the Flutter SDK

   1. Download the latest beta SDK from the [Flutter download page](todo).
   1. Select the desired installation location, and unzip the downloaded SDK:
   {% commandline %}
   cd /users/Obiwan/development/
   unzip /users/Obiwan/downloads/flutter-sdk.zip
   cd flutter
   export PATH=`pwd`/flutter/bin:$PATH
   {% endcommandline %}

## 4: Validate your setup with the flutter doctor

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

## 4: Creating your first Flutter app

   1. Use the `flutter create` command to create a new project:
   {% commandline %}
   cd /users/Obiwan/projects/
   flutter create hello_flutter
   cd hello_flutter
   {% endcommandline %}

## 5: Run the Flutter app

   1. Check that an Android device is running. If none is shown, go back to step 2.
   {% commandline %}
   flutter devices
   {% endcommandline %}
   1. Run the app with the `flutter run command`:
   {% commandline %}
   flutter run
   {% endcommandline %}

   1. If everything works, after the app has been built, you should see your
      starter app on your device or simulator:<br>
      ![Starter App on Android](/images/flutter-starter-app-android.png)

## 6: Try a hot reload

Flutter offers a fast development cycle with _hot reload_, the ability to reload
the code of a live running app without restarting or losing app state. Simply
make a change to your source code, tell your IDE or command-line tool that you
want to hot reload, and see the change in your simulator, emulator, or device.

  1. Open the file `lib/main.dart` in your favorite Dart code editor
  1. Change the string `'Hello from Flutter!'` to `'Hello from my app!'`
  1. Do not press the 'Stop' button; let your app continue to run.
  1. To see your changes invoke **Save All** (`cmd-s` / `ctrl-s`), or click the
     **Hot Reload button** (the button with the lightning bolt icon).

You should see the updated string in the running app almost immediately.

<ul class="ostabs__top-bar">Current development OS:
    <li class="ostab-link" data-tab="tab-install-windows">Windows</li>
    <li class="ostab-link" data-tab="tab-install-linux">Linux</li>
    <li class="ostab-link" data-tab="tab-install-mac">Mac</li>
</ul>

</div>

## Next steps

Now that you have your first Flutter app running, and have experienced 'hot
reload', let's learn some core Flutter concepts, and [extend the 'Hello from
Flutter'-app](/getting-started/app/) to a more complete app.