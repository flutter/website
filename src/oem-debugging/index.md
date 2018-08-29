---
layout: page
title: Using OEM Debuggers

permalink: /oem-debugging/
---

If you are exclusively writing Flutter apps with Dart code and not using
platform-specific libraries, or otherwise accessing platform-specific
features, you can debug your code using your IDE's debugger.
Only the first section of this guide, Debugging Dart code, is relevant for you.

If you're writing a platform-specific plugin or using platform-specific
libraries written in Swift, ObjectiveC, Java, or Kotlin, you can debug
that portion of your code using XCode (for iOS) or Android Gradle (for Android).
This guide shows you how you can connect _two_ debuggers to your Dart app,
one for Dart, and one for the OEM code.

* TOC Placeholder
{:toc}

# Debugging Dart code

Use your IDE for standard Dart debugging. These instructions describe Android
Studio, but you can use your preferred IDE with the Flutter and Dart
plugins installed and configured.

<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip:**
Connect to a physical device when debugging, rather than an emulator or
simulator, which don't support profile mode. For more information, see
[Flutter's modes](https://github.com/flutter/flutter/wiki/Flutter's-modes).
</aside>

## Dart debugger

* Open your project in Android Studio. If you don't have a project yet,
  create one using the instructions in [Test drive](/get-started/test-drive).

* Simultaneously bring up the Debug pane and run the app in the Console
  view by clicking the bug icon.
  <img src="images/debug-run.png" style="border: 1px solid #ccc;"
   alt="looks like a bug superimposed with a tiny green run button">

  The first time you launch the app is the slowest.
  You should see the Debug pane appear at the bottom of the window that
  looks something like the following:

  <img src="images/debug-pane.png" style="border: 1px solid #ccc;"
   alt="the debug pane showing that it's connected to the debugger and running the app">

  You can configure where the debug pane appears, or even tear it off to its own
  window using the gear to the right in the Debug pane bar.
  This is true for any inspector in Android Studio.

* Add a breakpoint on the `counter++` line.

* Hot reload the app.
  <img src="images/hot-reload-button.png" alt="looks like a lightning bolt">

* In the app, click the **+** button (FloatingActionButton, or FAB, for short)
  to increment the counter. The app pauses.

* The following screenshot shows:
  * Breakpoint in the edit pane.
  * State of the app in the debug pane, when paused at the breakpoint.
  * `this` variable expanded to display its values.

  <img src="images/debug-pane-action.png" style="border: 1px solid #ccc;"
   alt="the status of the app when hitting the set breakpoint">

You can step in, out, and over Dart statements, hot reload or resume the app,
and use the debugger in the same way you'd use any debugger.
The **5: Debug** button toggles display of the debug pane.

## Flutter inspector

There are two other features provided by the Flutter plugin that you may
find useful.  The Flutter inspector is a tool for visualizing and exploring
the Flutter widget tree and helps you:

* Understand existing layouts
* Diagnose layout issues

Toggle display of the inspector using the vertical button to the
right of the Android Studio window.

  <img src="images/flutter-inspector.png" style="border: 1px solid #ccc;"
   alt="screenshot showing the Flutter inspector">

## Flutter outline

The Flutter Outline displays the current state of the widget tree.
Toggle display of the outline using the vertical button to the
right of the AS window.

  <img src="images/flutter-outline.png" style="border: 1px solid #ccc;"
   alt="screenshot showing the Flutter inspector">

{% comment %}
TODO:
Android Tips - How to assign a keyboard shortcut on the Mac?
{% endcomment %}

The rest of this guide shows how to set up your environment to debug OEM
code. As you'd expect, the process works differently for iOS and Android.

<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip:**
Become a pro user of Android Studio by installing the **Presentation Assistant**
plugin. You can find and install this plugin using
**Preferences** > **Browsing repositories...** and start entering _Presen_ in
the search field.

Once installed and AS is relaunched, this plugin helps you to become a
pro user by:
* Showing the name and Windows/Linux/Mac shortcuts of any action you invoke.
* Allowing you to search and find available actions, settings, docs, and so on.
* Allowing you to toggle preferences, open up views, or run actions.
* Allowing you to assign keyboard shortcuts (?? Can't make this work on Mac.)

For example, try this:

* While focus is in the Edit pane, enter **command-Shift-A** (Mac) or
**shift-control-A** (Windows and Linux).
The plugin simultaneously brings up the Find panel and shows a hint for
performing this same operation on all three platforms.

<center><img src="images/presentation-assistant-find-pane.png" style="border: 1px solid #ccc;"
 alt="example of presentation assistant's Find panel"></center>
<center>Presentation assistant's Find panel</center>

<center><img src="images/presentation-assistant-teaches.png" style="border: 1px solid #ccc;"
 alt="example of presentation assistant's find pane"></center>
<center>Presentation assistant's action hint for opening its Find panel on Mac, Windows and Linux</center>

* Enter _attach_ to see the following:

<center><img src="images/presentation-assistant-search-results.png" style="border: 1px solid #ccc;"
 alt="example of presentation assistant's Find panel"></center>

* After an update, you might enter _Flutter_ or _Dart_ to see if new actions
  are available.

Hide the Presentation Assistant's Find panel by using **Escape**.
</aside>


# Debugging with XCode (iOS)

[PENDING]

# Debugging with Android Gradle (Android)

[PENDING]
