---
layout: page
title: Developing apps in the IntelliJ IDE
sidebar: home_sidebar
permalink: /intellij-ide/
---

Our custom [IntelliJ IDEA](https://www.jetbrains.com/idea/) plugins provides a
fully integrated development experience in the IntelliJ IDE.

* TOC Placeholder
{:toc}

## Installation and setup

Please follow the [Flutter setup](/setup/) instructions to install IntelliJ and
the Dart and Flutter plugins.

### Updating the plugins<a name="updating"/>

Updates to the plugins will be shipped on a regular basis. You should get
prompted in IntelliJ when an update is available.

To check for updates manually:

1. Open preferences (**IntelliJ IDEA>Check for Updates...** on macOS, **Help>Check for Updates...** on Linux)
1. If `dart` or `flutter-intellij` are listed, update them

## Creating projects

### Creating a new project from templates

To create a new Flutter IntelliJ project with a fresh set of Flutter template
files:

1. In IntelliJ, click **Create New Project** from the 'Welcome' window or
**File>New>Project...** from the main IDE window
1. Select **Flutter** in the menu, and click **Next**
1. Enter your desired **Project name** and **Project location**
1. Click **Finish**

### Creating a new projects from existing source code

To create a new Flutter IntelliJ project containing existing Flutter source code
files:

1. In IntelliJ, click **Create New Project** from the 'Welcome' window or
**File>New>Project...** from the main IDE window
  - **Note**: Do *not* use the **New>Project from existing sources...** option for Flutter projects
1. Select **Flutter** in the menu, and click **Next**
1. Under **Project location** enter, or browse to, the directory holding your existing Flutter source code files
1. Click **Finish**

## Editing code, and viewing code problems

The Dart plugin has performs code analysis that enables:

* Syntax highlighting

* Code completions based on rich type analysis

* Navigating to type declarations (**Navigate>Declaration**), and finding type
 usages (**Edit>Find>Find Usages**)

* Viewing all current source code problems (**View>Tool Windows>Dart Analysis**)

## Running and Debugging

### Selecting a target

When a Flutter project is open in IntelliJ, you should see a set of Flutter
specific buttons on the right-hand side of the toolbar.

* Locate the **Flutter Device Selection** drop-down button. This will show a
 list of available targets. The current selection determines which target your
 app will be started on.

* When you connect devices, or start simulators, additional entries will appear.

### Run app in release mode

* Click the **Play icon** in the toolbar, or invoke **Run>Run**
* The bottom **Run** pane will show logs output

### Run app in debug mode

* If desired, set breakpoints in your source code
* Click the **(De)bug) icon** in the toolbar, or invoke **Run>Debug**
* The bottom **Debugger** pane will show Stack Frames and Variables
* The bottom **Console** pane will show detailed logs output
* Debugging is based on a default launch configuration. To customize this, click
 the drop-down button to the right of the device selector, and select **Edit configuration**

### Advanced debugging with Observatory

Observatory is an additional debugging and profiling tool presented with an
html-based UI. For details see the [Observatory page](https://dart-lang.github.io/observatory/).

To open Observatory:

* Run your app in debug mode

* In the Debug panel at the bottom, click the **Arrow icon** ('Open Observatory')

## Fast edit and refresh development cycle

Flutter offers a best-in-class developer cycle enabling you to see the effect of
your changes near instantly!

* Run your app in debug mode

* Make desired changes in your source code (without stopping the debugger!)

* In the Debug panel at the bottom, click the **Hot Reload button** (shown with
 an icon containing a lightning bolt, and a play symbol)

### 'Hot Reloads' vs 'Full Application Restarts'

Hot Reload works by injecting updated source code files into the running Dart VM
(Virtual Machine). This includes not only adding new classes, but also adding
methods and fields to existing classes, and changing existing functions. A few
types of code changes cannot be hot reloaded though:

* Global variable initializers

* Static field initializers

* The `main()` method of the app

For these changes you can fully restart your application, without having to end
your debugging session:

* In the Debug panel at the bottom, click the **Full Application Restart button**
(shown with an icon containing a circular arrow)

## Troubleshooting

### Known issues and feedback

Important known issues that may impact your experience are documented in the
[Flutter plugin
README](https://github.com/flutter/flutter-intellij/blob/master/README.md) file.

All known bugs are tracked in the issue trackers:

  * Flutter plugin: [GitHub issue
   tracker](https://github.com/flutter/flutter-intellij/issues)

  * Dart plugin: [JetBrains
   YouTrack](https://youtrack.jetbrains.com/issues?q=%23dart%20%23Unresolved)

We very much welcome feedback, both on bugs/issues and feature requests. Prior
to filing new issues, please:

  * do a quick search in the issue trackers to see if the issue is already
   tracked.

  * make sure you have [updated](#updating) to the most recent version of the
   plugin.

When filing new issues, please include the output of [`flutter
doctor`](https://flutter.io/bug-reports/#provide-some-flutter-diagnostics).
