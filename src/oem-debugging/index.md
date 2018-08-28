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
This guide shows you how.

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
  <img src="images/debug-run.png" alt="run-app-in-debug-mode button">

  You should see something like the following:

  <img src="images/debug-pane.png" border-width="2px" border-color="black"
   alt="the debug pane showing that it's connected to the debugger and running the app">

# Debugging with XCode (iOS)

# Debugging with Android Gradle
