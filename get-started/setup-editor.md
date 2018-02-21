---
layout: page
title: "Get Started: Setup Editor"
permalink: /get-started/setup-editor/
---

This page describes how to setup your development environment to edit Flutter
apps.

Flutter is a flexible toolkit, so please start by selecting your development
tool of choice for writing, building, and running your Flutter app.

<ul class="tabs__top-bar">
    <li class="tab-link current" data-tab="tab-install-androidsstudio">Android Studio</li>
    <li class="tab-link" data-tab="tab-install-vscode">VS Code</li>
    <li class="tab-link" data-tab="tab-install-terminal">Terminal + editor</li>
</ul>

<div id="tab-install-androidsstudio" class="tabs__content current" markdown="1">

*Android Studio:* A complete, integrated IDE experience for Flutter. 

## Android Studio setup

### Install Android Studio:

   * Verify that you have already downloaded and installed Android Studio 3.0 or
     later from the the [Android Studio
     site](https://developer.android.com/studio/index.html)

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


### Install Visual Studio Code

  1. Install VS Code from the main [VS Code site](https://code.visualstudio.com/)

### Install the Dart Code plugin

  1. Start VS Code
  1. Invoke **View>Command Palette...**
  1. Type 'install', and select the **'Extensions: Install Extension'** action
  1. Enter `dart code` in the search field, select 'Dart Code' in the list, and
     click **Install**
  1. Select 'OK' to reload VS Code

</div>

<div id="tab-install-terminal" class="tabs__content" markdown="1">

*Terminal + editor:* Your editor-of-choice combined with Flutter's terminal tool
for running and building.

## Add the `flutter` command to path

If you wish to run Flutter from the Terminal / Command Prompt, you need to add
`<Flutter SDK dir>/bin/flutter` to Path ([detailed
instructions](/get-started/setup-path/)).


## Select a Dart editor

Flutter programs are written using the Dart programming langauge. For a
selection of editors that have dedicated Dart support, see the [Dart tools
page](https://www.dartlang.org/tools).

</div>

## Next step

Now that you have the Flutter editor configured, let create a first project,
run it, and experiencee 'hot reload'.

[Next step: Create and run your first app](/get-started/create-and-run/)

