---
title: Android Studio / IntelliJ
description: How to develop Flutter apps in Android Studio or other IntelliJ products.
---

<ul class="nav nav-tabs" id="ide" role="tablist">
  <li class="nav-item">
    <a class="nav-link active" role="tab" aria-selected="true">Android Studio / IntelliJ</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="/docs/development/tools/vs-code" role="tab" aria-selected="false">Visual Studio Code</a>
  </li>
</ul>

## Installation and setup

Follow the [Set up an editor](/get-started/editor?ide=androidstudio)
instructions to install the Dart and Flutter plugins.

### Updating the plugins<a name="updating"/>

Updates to the plugins are shipped on a regular basis. You should get
prompted in IntelliJ when an update is available.

To check for updates manually:

 1. Open preferences (**Android Studio > Check for Updates** on macOS,
    **Help > Check for Updates** on Linux).
 1. If `dart` or `flutter` are listed, update them.

## Creating projects

### Creating a new project

To create a new Flutter project from the Flutter starter app template:

 1. In the IDE, click **Create New Project** from the **Welcome** window or
    **File > New > Project** from the main IDE window.
 1. Select **Flutter** in the menu, and click **Next**.
 1. Enter your desired **Project name** and **Project location**.
 1. If you might publish this app, [set the company domain](#note).
 1. Click **Finish**.

<aside class="alert alert-info" markdown="1">
  <h4 id="note" class="no_toc">Setting the company domain</h4>

  When creating a new app, some Flutter IDE plugins ask for an
  organization name in reverse domain order,
  something like `com.example`. Along with the name of the app,
  this is used as the package name for Android, and the Bundle ID for iOS
  when the app is released. If you think you might ever release this app,
  it is better to specify these now. They cannot be changed once the app
  is released. Your organization name should be unique.
</aside>

### Creating a new project from existing source code

To create a new Flutter project containing existing Flutter source code
files:

 1. In the IDE, click **Create New Project** from the **Welcome** window or
    **File > New > Project** from the main IDE window.

    {{site.alert.important}}
      Do *not* use the **New > Project from existing sources** option for Flutter projects.
    {{site.alert.end}}
 1. Select **Flutter** in the menu, and click **Next**.
 1. Under **Project location** enter, or browse to, the directory holding your
    existing Flutter source code files.
 1. Click **Finish**.

## Editing code, and viewing code problems

The Dart plugin performs code analysis that enables:

* Syntax highlighting.
* Code completions based on rich type analysis.
* Navigating to type declarations (**Navigate > Declaration**), and finding type
  usages (**Edit > Find > Find Usages**).
* Viewing all current source code problems (**View > Tool Windows > Dart Analysis**).
  Any analysis issues are shown in the Dart Analysis pane:<br>
  ![Dart Analysis pane]({% asset tools/android-studio/dart-analysis.png @path %})

## Running and debugging

Running and debugging are controlled from the main toolbar:

![Main IntelliJ toolbar]({% asset tools/android-studio/main-toolbar.png @path %})

### Selecting a target

When a Flutter project is open in the IDE, you should see a set of Flutter
specific buttons on the right-hand side of the toolbar.

{{site.alert.note}}
  If the Run and Debug buttons are disabled, and no targets are listed,
  Flutter has not been able to discover any connected iOS or Android devices or
  simulators.  You need to connect a device, or start a simulator, to proceed.
{{site.alert.end}}

 1. Locate the **Flutter Target Selector** drop-down button. This shows a
    list of available targets.
 2. Select the target you want your app to be started on.
    When you connect devices, or start simulators, additional entries appear.

### Run app without breakpoints

 1. Click the **Play icon** in the toolbar, or invoke **Run > Run**.
    The bottom **Run** pane shows logs output:<br>
    ![Log pane]({% asset tools/android-studio/log.png @path %})

### Run app with breakpoints

 1. If desired, set breakpoints in your source code.
 1. Click the **Debug icon** in the toolbar, or invoke **Run > Debug**.
    * The bottom **Debugger** pane shows Stack Frames and Variables.
    * The bottom **Console** pane shows detailed logs output.
    * Debugging is based on a default launch configuration. To customize this,
      click the drop-down button to the right of the device selector, and select
      **Edit configuration**.

## Fast edit and refresh development cycle

Flutter offers a best-in-class developer cycle enabling you to see the effect
of your changes almost instantly with the _hot reload_ feature. See
[Using hot reload](hot-reload) for details.

## Advanced debugging

### Debugging visual layout issues

To debug a visual issue, start the app with **Debug**, and then open the Flutter
inspector tool window using **View > Tool Windows > Flutter Inspector**.

![Flutter Inspector Window]({% asset tools/android-studio/visual-debugging.png @path %})

This offers many debugging tools; for details on these see
[Debugging Flutter Apps](/docs/testing/debugging).

* **Toggle Select Widget Mode**: Select a widget on the device to inspect it in the
  [Flutter Inspector](/docs/development/tools/inspector).
* **Toggle Debug Paint**: Add visual debugging hints to the rendering displaying
   borders, padding, alignment, and spacers.
* **Toggle Platform Mode**: Toggle between rendering for Android or iOS.
* **Toggle Performance Overlay**: Show performance graphs for the GPU & CPU threads.
* **Open Timeline View**: Analyze activity of the application as it runs.
* **Open Observatory**: A profiler for Dart applications.

Also available in the additional actions menu:

* **Show Paint Baselines**: Causes each RenderBox to paint a line at each of its
  baselines.
* **Enable Repaint Rainbow**: Shows rotating colors on layers when repainting.
* **Enable Slow Animations**: Slows down animations to enable visual inspection.
* **Hide Debug Banner**: Hides the debug banner even when running a debug build.


### Debugging with Observatory

Observatory is an additional debugging and profiling tool presented with an
html-based UI. For details see the [Observatory
page](https://dart-lang.github.io/observatory/).

To open Observatory:

 1. Run your app in debug mode.
 1. Select the **Open Observatory** action from the Debug panel.
 1. Click the **Stopwatch icon**:<br>
    ![Debugging panel]({% asset tools/android-studio/debug-panel.png @path %}){:width="700px"}

## Editing tips for Flutter code

### Assists & Quick Fixes

Assists are code changes related to a certain code identifier. A number of these
are available when the cursor is placed on a Flutter widget identifier, as
indicated by the yellow lightbulb icon. The assist can be invoked by clicking
the lightbulb, or by using the keyboard shortcut
(`Alt`+`Enter` on Linux and Windows, `Option`+`Return` on macOS),
as illustrated here:

![IntelliJ editing assists]({% asset tools/android-studio/assists.gif @path %})

Quick Fixes are similar, only they are shown with a piece of code has an error
and they can assist in correcting it. They are indicated with a red lightbulb.

#### Wrap with new widget assist

This can be used when you have a widget that you want to wrap in a surrounding
widget, for example if you want to wrap a widget in a `Row` or `Column`.

####  Wrap widget list with new widget assist

Similar to the assist above, but for wrapping an existing list of widgets rather
than an individual widget.

#### Convert child to children assist
Changes a child argument to a children argument, and wraps the argument value in a list.

### Live templates

Live templates can be used to speed up entering typical code structures. They
are invoked by typing their prefix, and then selecting it in the code
completion window:

![IntelliJ live templates]({% asset tools/android-studio/templates.gif @path %})

The Flutter plugin includes the following templates:

* Prefix `stless`: Create a new subclass of `StatelessWidget`.
* Prefix `stful`: Create a new subclass of `StatefulWidget` and it's associated
 State subclass.
* Prefix `stanim`: Create a new subclass of `StatefulWidget`, and it's
 associated State subclass including a field initialized with an
 `AnimationController`.

You can also define custom templates in **Settings > Editor > Live Templates**.

### Keyboard shortcuts

**Hot Reload**

On Linux (keymap _Default for XWin_) and Windows the keyboard shortcuts
are `Controle`+`Alt`+`;` and `Control`+`Backslash`.

On macOS (keymap _Mac OS X 10.5+ copy_) the keyboard shortcuts are
`Command`+`Option`;` and `Command`+`Backslash`.

Keyboard mappings can be changed in the IDE Preferences/Settings: Select
*Keymap*, then enter _flutter_ into the search box in the upper right corner.
Right click the binding you want to change and _Add Keyboard Shortcut_.

![IntelliJ Settings Keymap]({% asset tools/android-studio/keymap-settings-flutter-plugin.png @path %})

### Hot reload vs. Full app restart

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

 1. In **Preferences > Plugins**, enable **Android Support** if you haven't already.
 1. Right-click the **android** folder in the Project view, and select **Open
    Module Settings**.
 1. In the **Sources** tab, locate the **Language level** field, and select level 8
    or later.
 1. In the **Dependencies** tab, locate the **Module SDK** field, and select an
    Android SDK. If no SDK is listed, click **New** and specify the location of
    the Android SDK. Make sure to select an Android SDK matching the one used by
    Flutter (as reported by `flutter doctor`).
 1. Click **OK**.

## Tips and tricks

* [Flutter IDE cheat sheet, MacOS
  version](/docs/resources/Flutter-IntelliJ-cheat-sheet-MacOS.pdf)
* [Flutter IDE cheat sheet, Windows & Linux
  version](/docs/resources/Flutter-IntelliJ-cheat-sheet-WindowsLinux.pdf)

## Troubleshooting

### Known issues and feedback

Important known issues that may impact your experience are documented in the
[Flutter plugin
README]({{site.repo.flutter}}-intellij/blob/master/README.md) file.

All known bugs are tracked in the issue trackers:

* Flutter plugin: [GitHub issue
  tracker]({{site.repo.flutter}}-intellij/issues).
* Dart plugin: [JetBrains
  YouTrack](https://youtrack.jetbrains.com/issues?q=%23dart%20%23Unresolved).

We very much welcome feedback, both on bugs/issues and feature requests. Prior
to filing new issues:

* Do a quick search in the issue trackers to see if the issue is already
  tracked.
* Make sure you have [updated](#updating) to the most recent version of the
  plugin.

When filing new issues, include the output of [`flutter
doctor`](/docs/resources/bug-reports#provide-some-flutter-diagnostics).
