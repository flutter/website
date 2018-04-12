---
layout: page
title: Developing Flutter apps in an IDE

permalink: /using-ide/
---

<div id="tab-set-install">

<ul class="tabs__top-bar">
    <li class="tab-link current" >Android Studio / IntelliJ</li>
    <li class="tab-link" data-tab-href="/using-ide-vscode/">VS Code</li>
</ul>

<div class="tabs__content current" markdown="1">

The Flutter plugin provides a fully integrated development experience in the
Android Studio or IntelliJ IDEs.

* TOC Placeholder
{:toc}

## Installation and setup

Please follow the [Editor Setup](/get-started/editor/) instructions to install
the Dart and Flutter plugins.

### Updating the plugins<a name="updating"/>

Updates to the plugins will be shipped on a regular basis. You should get
prompted in IntelliJ when an update is available.

To check for updates manually:

1. Open preferences (**IntelliJ IDEA>Check for Updates...** on macOS,
**Help>Check for Updates...** on Linux).
1. If `dart` or `flutter` are listed, update them.

## Creating projects

### Creating a new project

To create a new Flutter IntelliJ project from the Flutter starter app template:

1. In IntelliJ, click **Create New Project** from the 'Welcome' window or
**File>New>Project...** from the main IDE window.
1. Select **Flutter** in the menu, and click **Next**.
1. Enter your desired **Project name** and **Project location**.
1. Click **Finish**.

### Creating a new project from existing source code

To create a new Flutter IntelliJ project containing existing Flutter source code
files:

1. In IntelliJ, click **Create New Project** from the 'Welcome' window or
**File>New>Project...** from the main IDE window.
  - **Note**: Do *not* use the **New>Project from existing sources...** option for Flutter projects.
1. Select **Flutter** in the menu, and click **Next**.
1. Under **Project location** enter, or browse to, the directory holding your
existing Flutter source code files.
1. Click **Finish**.

## Editing code, and viewing code problems

The Dart plugin performs code analysis that enables:

* Syntax highlighting.
* Code completions based on rich type analysis.
* Navigating to type declarations (**Navigate>Declaration**), and finding type
  usages (**Edit>Find>Find Usages**).
* Viewing all current source code problems (**View>Tool Windows>Dart Analysis**).
  Any analysis issues will be shows in the Dart Analysis pane:<br>
  ![Dart Analysis pane](/images/intellij/dart-analysis.png)

## Running and Debugging

Running and Debugging is controlled from the main toolbar:

![Main IntelliJ toolbar](/images/intellij/main-toolbar.png)

### Selecting a target

When a Flutter project is open in IntelliJ, you should see a set of Flutter
specific buttons on the right-hand side of the toolbar.

*Note*: If the Run & Debug buttons are disabled, and no targets are listed, Flutter
has not been able to discover any connected iOS or Android devices or simulators.
You need to connect a device, or start a simulator, to proceed.

1. Locate the **Flutter Target Selector** drop-down button. This will show a
 list of available targets. Select the target you want your app to started on.
* When you connect devices, or start simulators, additional entries will appear.

### Run app without breakpoints

1. Click the **Play icon** in the toolbar, or invoke **Run>Run**.
* The bottom **Run** pane will show logs output:<br>
![Log pane](/images/intellij/log.png)

### Run app with breakpoints

1. If desired, set breakpoints in your source code.
1. Click the **Debug icon** in the toolbar, or invoke **Run>Debug**.
* The bottom **Debugger** pane will show Stack Frames and Variables.
* The bottom **Console** pane will show detailed logs output.
* Debugging is based on a default launch configuration. To customize this,
  click. the drop-down button to the right of the device selector, and select
  **Edit configuration**.

## Fast edit and refresh development cycle

Flutter offers a best-in-class developer cycle enabling you to see the effect
of your changes almost instantly with the 'hot reload' feature. See
[Hot reloading Flutter Apps](/hot-reload/) for details.

## Advanced debugging

### Debugging visual layout issues

To debug a visual issue, start the app with 'Debug', and then open the Flutter
inspector tool window using 'View > Tool Windows > Flutter Inspector'.

![IntelliJ Flutter Inspector Window](/images/intellij/visual-debugging.png)

This offers many debugging tools; for details on these please see
[Debugging Flutter Apps](https://flutter.io/debugging/).

* 'Toggle Select Widget Mode': Select a widget on the device to inspect it in the
  [Flutter Inspector](/inspector/).

* 'Toggle Debug Paint': Add visual debugging hints to the rendering displaying
   borders, padding, alignment, and spacers.

* 'Toggle Platform Mode': Toggle between rendering for Android or iOS.

* 'Toggle Performance Overlay': Show performance graphs for the GPU & CPU threads.

* 'Open Timeline View': Analyze activity of the application as it runs.

* 'Open Observatory': A profiler for Dart applications.

Also available in the additional actions menu:

* 'Show Paint Baselines': Causes each RenderBox to paint a line at each of its
  baselines.

* 'Enable Repaint Rainbow': Show rotating colors on layers when repainting.

* 'Enable Slow Animations': Slow down animations to enable visual inspection.

* 'Hide Slow Mode Banner': Hide the 'slow mode' banner even when running a
  debug build.


### Debugging with Observatory

Observatory is an additional debugging and profiling tool presented with an
html-based UI. For details see the [Observatory page](https://dart-lang.github.io/observatory/).

To open Observatory:

1. Run your app in debug mode.
1. Select the 'open observatory' action from the Debug panel (see screenshot below), click the **Stopwatch icon** ('Open Observatory').

![Debugging panel](/images/intellij/debug-panel.png)

## Editing tips for Flutter code

### Assists & Quick Fixes

Assists are code changes related to a certain code identifier. A number of these
are available when the cursor is placed on a Flutter widget identifier, as
indicated by the yellow lightbulb icon. The assist can be invoked by clicking
the lightbulb, or by using the keyboard shortcut `Alt-Enter`, as illustrated
here:

![IntelliJ editing assists](/images/intellij/assists.gif)

Quick Fixes are similar, only they are shown with a piece of code has an error and they
can assist in correcting it. They are indicated with a red lightbulb.

#### Wrap with new widget assist
This can be used when you have a widget that you want to wrap in a surrounding widget,
for example if you want to wrap a widget in a `Row` or `Column`.
 
####  Wrap widget list with new widget assist
Similar to the assist above, but for wrapping an existing list of widgets rather than an
individual widget.
 
#### Convert child to children assist
Changes a child argument to a children argument, and wraps the argument value in a list.

### Live Templates

Live templates can be used to speed up entering typical code structures. They
are invoked by typing their 'prefix', and then selecting it in the code
completion window:

![IntelliJ live templates](/images/intellij/templates.gif)

The Flutter plugin includes the following templates:

* Prefix `stless`: Create a new subclass of `StatelessWidget`.
* Prefix `stful`: Create a new subclass of `StatefulWidget` and it's associated
 State subclass.
* Prefix `stanim`: Create a new subclass of `StatefulWidget`, and it's
 associated State subclass including a field initialized with an
 `AnimationController`.

You can also define custom templates in **Settings > Editor > Live Templates**.

### IntelliJ keyboard shortcuts

**Hot Reload**

On Linux (IntelliJ keymaps _Default for XWin_) and Windows the keyboard shortcuts
are `ctrl-alt-;` and `ctrl-\`.

On macOS (IntelliJ keymap _Mac OS X 10.5+ copy_) the keyboard shortcuts are `⌘-⌥-;`
and `⌘-\`.

Keyboard mappings can be changed in IntelliJ Preferences/Settings: Select
*Keymap*, then enter _flutter_ into the search box in the upper right corner.
Right click the binding you want to change and _Add Keyboard Shortcut_.

![IntelliJ Settings Keymap](/images/intellij/keymap-settings-flutter-plugin.png)

### 'Hot Reloads' vs 'Full Application Restarts'

Hot Reload works by injecting updated source code files into the running Dart VM
(Virtual Machine). This includes not only adding new classes, but also adding
methods and fields to existing classes, and changing existing functions. A few
types of code changes cannot be hot reloaded though:

* Global variable initializers.
* Static field initializers.
* The `main()` method of the app.

For these changes you can fully restart your application, without having to end
your debugging session:

1. Don't click the Stop button; simply re-click the Run button (if in a run
session) or Debug button (if in a debug session), or shift-click the 'hot
reload' button.

## Editing Android code in IntelliJ IDEA {#edit-android-code}

To enable editing of Android code in IntelliJ IDEA, you need to configure the
location of the Android SDK:

1. In Preferences->Plugins, enable **Android Support** if you haven't already.
1. Right-click the **android** folder in the Project view, and select **Open
Module Settings**.
1. In **Sources** tab, locate the **Language level** field, and select level '8'
or later.
1. In **Dependencies** tab, locate the **Module SDK** field, and select an
Android SDK. If no SDK is listed, click **New...** and specify the location of
the Android SDK. Make sure to select an Android SDK matching the one used by
Flutter (as reported by `flutter doctor`).
1. Click **OK**.

## Tips and tricks

Please checkout these 'cheat sheets':

  * [Flutter IntelliJ cheat sheet, MacOS version](/downloads/Flutter-IntelliJ-cheat-sheet-MacOS.pdf)
  * [Flutter IntelliJ cheat sheet, Windows & Linux version](/downloads/Flutter-IntelliJ-cheat-sheet-WindowsLinux.pdf)

## Troubleshooting

### Known issues and feedback

Important known issues that may impact your experience are documented in the
[Flutter plugin README](https://github.com/flutter/flutter-intellij/blob/master/README.md) file.

All known bugs are tracked in the issue trackers:

  * Flutter plugin: [GitHub issue
   tracker](https://github.com/flutter/flutter-intellij/issues).
  * Dart plugin: [JetBrains
   YouTrack](https://youtrack.jetbrains.com/issues?q=%23dart%20%23Unresolved).

We very much welcome feedback, both on bugs/issues and feature requests. Prior
to filing new issues, please:

  * do a quick search in the issue trackers to see if the issue is already
   tracked.
  * make sure you have [updated](#updating) to the most recent version of the
   plugin.

When filing new issues, please include the output of [`flutter
doctor`](https://flutter.io/bug-reports/#provide-some-flutter-diagnostics).

</div>

</div>
