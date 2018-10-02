---
title: Test drive
prev:
  title: Configure dditor
  path: /get-started/editor
next:
  title: Write your first Flutter app
  path: /get-started/codelab
---

This page describes how to "test drive" Flutter: create a new Flutter app from
our templates, run it, and learn how to make changes with Hot Reload.

Flutter is a flexible toolkit, so please start by selecting your development
tool of choice for writing, building, and running your Flutter app.

<div id="tab-set-install">

<ul class="tabs__top-bar">
    <li class="tab-link current" data-tab="tab-install-androidstudio">Android Studio</li>
    <li class="tab-link" data-tab="tab-install-vscode">VS Code</li>
    <li class="tab-link" data-tab="tab-install-terminal">Terminal + editor</li>
</ul>

<div id="tab-install-androidstudio" class="tabs__content current" markdown="1">

*Android Studio:* A complete, integrated IDE experience for Flutter.
{:id="androidstudio"}

## Create new app {#create-app}

   1. Select **File > New Flutter Project**
   1. Select **Flutter application** as the project type, and press Next
   1. Enter a project name (e.g. `myapp`), and press Next
   1. Click **Finish**
   1. Wait for Android Studio to install the SDK, and create the project.

The above command creates a Flutter project directory called `myapp`
that contains a simple demo
app that uses [Material Components](https://material.io/guidelines/).

In the project directory, the code for your app is in `lib/main.dart`.

## Run the app

   1. Locate the main Android Studio toolbar:<br>
      ![Main IntelliJ toolbar](/development/tools/images/main-toolbar.png)
   1. In the **target selector**, select an Android device for running the app.
      If none are listed as available, select **Tools> Android > AVD Manager** and
      create one there. For details, see [Managing
      AVDs](https://developer.android.com/studio/run/managing-avds.html).
   1. Click the **Run icon** in the toolbar, or invoke the menu item **Run >
      Run**.
   1. If everything works, you should see your starter app on your device or
      simulator:<br>
      ![Starter App on Android](/images/flutter-starter-app-android.png)

## Try a hot reload

Flutter offers a fast development cycle with _hot reload_, the ability to reload
the code of a live running app without restarting or losing app state. Simply
make a change to your source code, tell your IDE or command-line tool that you
want to hot reload, and see the change in your simulator, emulator, or device.

  1. Change the string<br>`'You have pushed the button this many times:'`
     to<br>`'You have clicked the button this many times:'`
  1. Do not press the 'Stop' button; let your app continue to run.
  1. To see your changes invoke **Save All**, or click
     **Hot Reload** (the button with the lightning bolt icon).

You should see the updated string in the running app almost immediately.

</div>

<div id="tab-install-vscode" class="tabs__content" markdown="1">

*VS Code:* A light-weight editor with Flutter run and debug support.

## Create new app

  1. Start VS Code
  1. Invoke **View > Command Palette**
  1. Type "flutter", and select the **Flutter: New Project** action
  1. Enter a project name (such as `myapp`), and press **Enter**
  1. Create or select the parent directory for the new project folder
  1. Wait for project creation to complete and the `main.dart`
     file to appear

The command above creates a Flutter project directory called `myapp` that
contains a simple demo
app that uses [Material Components](https://material.io/guidelines).

In the project directory, the code for your app is in `lib/main.dart`.

## Run the app

 1. Locate the VS Code status bar (the blue bar at the bottom of the window)
 1. Select a device from the **Device Selector** area.
    For details, see [Quickly Switching Between Flutter Devices][].
    - If no device is available and you'd like to use a device simulator,
      click **No Devices** and launch a simulator.
    - To setup a real device, follow the device-specific instructions on the
      [Get Started: Install](/get-started/install) page for your OS.
 1. Invoke **Debug > Start Debugging** or press <kbd>F5</kbd>
 1. Wait for the app to launch &mdash; progress is printed
    in the **Debug Console** view
 1. If everything works, after the app has been built, you'll see the
    starter app on your device:<br>
    ![Starter App on Android](/images/flutter-starter-app-android.png)

[Quickly Switching Between Flutter Devices]: https://dartcode.org/docs/quickly-switching-between-flutter-devices

## Try a hot reload

Flutter offers a fast development cycle with _hot reload_, the ability to reload
the code of a live running app without restarting or losing app state. Simply
make a change to your source code, tell your IDE or command-line tool that you
want to hot reload, and see the change in your simulator, emulator, or device.

 1. Open `lib/main.dart`
 1. Change the string<br>
    `'You have pushed the button this many times:'` to<br>
    `'You have clicked the button this many times:'`<br>
    **Important**: do _not_ press the _Stop_ button; let your app run
 1. Save your changes: invoke **File > Save All**,
    or click **Hot Reload** (the green circular arrow button)

You'll see the updated string in the running app almost immediately.

</div>

<div id="tab-install-terminal" class="tabs__content" markdown="1">

*Terminal + editor:* Your editor-of-choice combined with Flutter's terminal tool
for running and building.

## Create new app

   1. Use the `flutter create` command to create a new project:
   {% commandline %}
   flutter create myapp
   cd myapp
   {% endcommandline %}

The above command creates a Flutter project directory called `myapp` that
contains a simple demo app that uses
[Material Components](https://material.io/guidelines/).

In the project directory, the code for your app is in `lib/main.dart`.

## Run the app

   * Check that an Android device is running. If none are shown, see
     [setup](/get-started/install).
   {% commandline %}
   flutter devices
   {% endcommandline %}
   * Run the app with the `flutter run` command:
   {% commandline %}
   flutter run
   {% endcommandline %}
   * If everything works, after the app has been built, you should see your
      starter app on your device or simulator:<br>
      ![Starter App on Android](/images/flutter-starter-app-android.png)

## Try a hot reload

Flutter offers a fast development cycle with _hot reload_, the ability to reload
the code of a live running app without restarting or losing app state. Simply
make a change to your source code, tell your IDE or command-line tool that you
want to hot reload, and see the change in your simulator, emulator, or device.

  1. Open the file `lib/main.dart`
  1. Change the string<br>`'You have pushed the button this many times:'`
     to<br>`'You have clicked the button this many times:'`
  1. Do not press the 'Stop' button; let your app continue to run.
  1. To see your changes invoke **Save All** (`cmd-s` / `ctrl-s`), or click the
     **Hot Reload button** (the button with the lightning bolt icon).

You should see the updated string in the running app almost immediately.

</div>

</div>

## Next step

Let's learn some core Flutter concepts, by creating a small app.
