---
layout: page
title: "Get Started: Configure Editor"
permalink: /get-started/editor/
---

You can build apps with Flutter using any text editor combined with our
command-line tools. However, we recommend using one of our editor plugins for an
even better experience. With our editor plugins, you get code completion, syntax
highlighting, widget edditing assists, run & debug support, and more.

Follow the steps before to add an editor plugin for Android Studio, IntelliJ, or
VS Code. If you want to use a different editor, that's OK, simply skip ahead to
[Next step: Create and run your first app](/get-started/test-drive/).

<ul class="tabs__top-bar">
    <li class="tab-link current" data-tab="tab-install-androidsstudio">Android Studio</li>
    <li class="tab-link" data-tab="tab-install-vscode">VS Code</li>
</ul>

<div id="tab-install-androidsstudio" class="tabs__content current" markdown="1">

## Android Studio setup

*Android Studio:* A complete, integrated IDE experience for Flutter. 

### Install Android Studio

   * [Android Studio](https://developer.android.com/studio/index.html), version 3.0 or later.

Alternatively, you can also use IntelliJ:

   * [IntelliJ IDEA Community](https://www.jetbrains.com/idea/download/), version 2017.1 or later.
   * [IntelliJ IDEA Ultimate](https://www.jetbrains.com/idea/download/), version 2017.1 or later.

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

</div>

<div id="tab-install-vscode" class="tabs__content" markdown="1">

## Visual Studio Code (VS Code) setup

*VS Code:* A light-weight editor with Flutter run and debug support.

### Install VS Code

  * [VS Code](https://code.visualstudio.com/), version 1.20.1 or later.

### Install the Dart Code plugin

  1. Start VS Code
  1. Invoke **View>Command Palette...**
  1. Type 'install', and select the **'Extensions: Install Extension'** action
  1. Enter `dart code` in the search field, select 'Dart Code' in the list, and
     click **Install**
  1. Select 'OK' to reload VS Code

## Validate your setup with the Flutter Doctor

  1. Invoke **View>Command Palette...**
  1. Type 'doctor', and select the **'Flutter: Run Flutter Doctor'** action
  1. Review the output in the 'OUTPUT' pane for any issues

</div>

## Next step

Let's take Flutter for a test drive: create a first project, run it, and
experience 'hot reload'.

[Next step: Test drive Flutter](/get-started/test-drive/)
