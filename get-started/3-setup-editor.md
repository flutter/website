---
layout: page
title: "Get Started: Setup Editor"
permalink: /get-started/setup-editor/
---

Flutter is a flexible toolkit, which supports writing Flutter apps using a
number of editors. The previous [setup step](/get-started/setup/)
installed the `flutter` terminal/command-line tool, which combined with a
[Dart-enabled code editor](https://www.dartlang.org/tools) is enough to
developer Flutter apps.

Should you desire a more intergrated experience, follow the steps below to
configure a fully Flutter-enabled editor. If not, you can skip directly to
[Next step: Create and run your first app](/get-started/create-and-run/).

<ul class="tabs__top-bar">
    <li class="tab-link current" data-tab="tab-install-androidsstudio">Android Studio</li>
    <li class="tab-link" data-tab="tab-install-vscode">VS Code</li>
</ul>

<div id="tab-install-androidsstudio" class="tabs__content current" markdown="1">

## Android Studio setup

*Android Studio:* A complete, integrated IDE experience for Flutter. 

### Install Android Studio:

   * Downloaded and installed Android Studio 3.0 or later from the the [Android
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

</div>

<div id="tab-install-vscode" class="tabs__content" markdown="1">

## Visual Studio Code (VS Code) setup

*VS Code:* A light-weight editor with Flutter run and debug support.

### Install VS Code

  * Install VS Code from the main [VS Code site](https://code.visualstudio.com/)

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

Now that you have the Flutter editor configured, let create a first project,
run it, and experiencee 'hot reload'.

[Next step: Create and run your first app](/get-started/create-and-run/)
