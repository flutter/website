---
title: Visual Studio Code
short-title: VS Code
description: How to develop Flutter apps in Visual Studio Code.
---

<ul class="nav nav-tabs" id="ide" role="tablist">
  <li class="nav-item">
    <a class="nav-link" href="/docs/development/tools/android-studio" role="tab" aria-selected="false">Android Studio / IntelliJ</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active" role="tab" aria-selected="true">Visual Studio Code</a>
  </li>
</ul>

## Installation and setup

Follow the [Set up an editor](/docs/get-started/editor?ide=vscode) instructions to
install the Dart and Flutter extensions (also called plugins).

### Updating the extension {#updating}

Updates to the extensions are shipped on a regular basis. By default,
VS Code automatically updates extensions when updates are available.

To install updates manually:

 1. Click on the Extensions button in the Side Bar
 1. If the Flutter extension is shown with an available update, click the update button and then
    the reload button

## Creating projects

### Creating a new project

To create a new Flutter project from the Flutter starter app template:

 1. Open the Command Palette (`Ctrl`+`Shift`+`P` (`Cmd`+`Shift`+`P` on macOS)).
 1. Select the **Flutter: New Project** command and press `Enter`.
 1. Enter your desired **Project name**.
 1. Select a **Project location**.

### Opening a project from existing source code

To open an existing Flutter project:

 1. Click **File > Open** from the main IDE window.
 1. Browse to the directory holding your existing Flutter source code files.
 1. Click **Open**.

## Editing code and viewing issues

The Flutter extension performs code analysis that enables:

* Syntax highlighting.
* Code completions based on rich type analysis.
* Navigating to type declarations (**Go to Definition** or `F12`), and finding type
  usages (**Find All References** or `Shift`+`F12`).
* Viewing all current source code problems
  (**View > Problems** or `Ctrl`+`Shift`+`M` (`Cmd`+`Shift`+`M` on macOS)).
  Any analysis issues are shown in the Problems pane:<br>
  ![Problems pane]({% asset tools/vs-code/problems.png @path %}){:width="660px"}

## Running and Debugging

Start debugging by clicking **Debug > Start Debugging** from the main IDE window or
press `F5`.

### Selecting a target device

When a Flutter project is open in VS Code, you should see a set of Flutter
specific entries in the status bar, including a Flutter SDK version and a
device name (or the message **No Devices**).

![Flutter device]({% asset tools/vs-code/device_status_bar.png @path %}){:width="450px"}

{{site.alert.note}}
  - If you do not see a Flutter version number or device info your project may
    not have been detected as a Flutter project. Please ensure the folder that
    contains your `pubspec.yaml` is inside a VS Code **Workspace Folder**
  - If the status bar reads **No Devices** Flutter has not been
    able to discover any connected iOS or Android devices or simulators.
    You need to connect a device, or start a simulator, to proceed.
{{site.alert.end}}

The Flutter extension automatically selects the last device connected.
However, if you have multiple devices/simulators connected, click
**device** in the status bar to see a pick-list
at the top of the screen. Select the device you want to use for
running or debugging.

### Run app without breakpoints

 1. Click **Debug > Start Without Debugging** in the main IDE window, or
    press `Ctrl`+`F5`.
    The status bar turns orange to show you are in a debug session.<br>
    ![Debug Console]({% asset tools/vs-code/debug_console.png @path %}){:width="490px"}

### Run app with breakpoints

 1. If desired, set breakpoints in your source code.
 1. Click **Debug > Start Debugging** in the main IDE window, or press `F5`.
    * The left **Debug Sidebar** shows stack frames and variables.
    * The bottom **Debug Console** pane shows detailed logging output.
    * Debugging is based on a default launch configuration. To customize,
      click the cog at the top of the **Debug Sidebar** to create a `launch.json`
      file. You can then modify the values.

## Fast edit and refresh development cycle

Flutter offers a best-in-class developer cycle enabling you to see the effect
of your changes almost instantly with the _hot reload_ feature. See
[Using hot reload](hot-reload) for details.

## Advanced debugging

### Debugging visual layout issues

During a debug session, several additional debugging commands are added to the
[Command Palette][], including:

* **Toggle Baseline Painting**: Causes each RenderBox to paint a line at each of its
  baselines.
* **Toggle Repaint Rainbow**: Show rotating colors on layers when repainting.
* **Toggle Slow Animations**: Slow down animations to enable visual inspection.
* **Toggle Slow-Mode Banner**: Hide the slow mode banner even when running a
  debug build.

### Debugging with Observatory

Observatory is an additional debugging and profiling tool presented with an
html-based UI. For details see the [Observatory page](https://dart-lang.github.io/observatory/).

To open Observatory:

 1. Run your app in debug mode.
 1. Run the **Open Observatory** command from the [Command Palette][].

## Editing tips for Flutter code

### Assists & Quick Fixes

Assists are code changes related to a certain code identifier. A number of these
are available when the cursor is placed on a Flutter widget identifier, as
indicated by the yellow lightbulb icon. The assist can be invoked by clicking
the lightbulb, or by using the keyboard shortcut `Ctrl`+`.` (`Cmd`+`.` on Mac), as
illustrated here:

![Code Assists]({% asset tools/vs-code/assists.png @path %}){:width="467px"}

Quick Fixes are similar, only they are shown with a piece of code has an error and they
can assist in correcting it.

**Wrap with new widget assist**
: This can be used when you have a widget that you want to wrap in a surrounding widget,
  for example if you want to wrap a widget in a `Row` or `Column`.

**Wrap widget list with new widget assist**
: Similar to the assist above, but for wrapping an existing list of widgets rather than an
individual widget.

**Convert child to children assist**
: Changes a child argument to a children argument, and wraps the argument value in a list.

### Snippets

Snippets can be used to speed up entering typical code structures. They
are invoked by typing their prefix, and then selecting from the code
completion window:

![Snippets]({% asset tools/vs-code/snippets.png @path %}){:width="700px"}

The Flutter extension includes the following snippets:

* Prefix `stless`: Create a new subclass of `StatelessWidget`.
* Prefix `stful`: Create a new subclass of `StatefulWidget` and it's associated
  State subclass.
* Prefix `stanim`: Create a new subclass of `StatefulWidget`, and it's
  associated State subclass including a field initialized with an
  `AnimationController`.

You can also define custom snippets by executing **Configure User Snippets** from
the [Command Palette][].

### Keyboard Shortcuts

**Hot Reload**
: During a debug session, clicking the **Restart** button on the **Debug
  Toolbar**, or pressing `Ctrl`+`Shift`+`F5` (`Cmd`+`Shift`+`F5` on macOS)
  performs a hot reload.

  Keyboard mappings can be changed by executing the **Open Keyboard Shortcuts**
  command from the [Command Palette][].

**Hot Restart**

### Hot reloads vs. Hot restarts

Hot Reload works by injecting updated source code files into the running Dart VM
(Virtual Machine). This includes not only adding new classes, but also adding
methods and fields to existing classes, and changing existing functions. A few
types of code changes cannot be hot reloaded though:

* Global variable initializers.
* Static field initializers.
* The `main()` method of the app.

For these changes, fully restart your application without having to end your
debugging session. To perform a hot restart, run the **Flutter: Hot Restart**
command from the [Command Palette][], or press `Ctrl`+`F5`.

## Troubleshooting

### Known issues and feedback

All known bugs are tracked in the issue tracker: [Dart and Flutter extensions GitHub issue
tracker](https://github.com/Dart-Code/Dart-Code/issues).

We very much welcome feedback, both on bugs/issues and feature requests. Prior
to filing new issues:

* Do a quick search in the issue trackers to see if the issue is already
  tracked.
* Make sure you have [updated](#updating) to the most recent version of the
  plugin.

When filing new issues, include [flutter doctor][] output.

[Command Palette]: https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette
[flutter doctor]: {{site.url}}/bug-reports/#provide-some-flutter-diagnostics
