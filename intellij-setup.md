---
layout: page
title: IDE Setup
sidebar: home_sidebar
permalink: /intellij-setup/
---

This page describes how to set up an IntelliJ IDE to develop Flutter apps.

* TOC Placeholder
{:toc}

## FlutterlliJ IDE plugins Inte

You can write Flutter apps in a text editor, but if you choose to work in an IDE we recommend 
IntelliJ for a [rich IDE experience](/intellij-ide/). Our Flutter and Dart plug-ins support 
editing, running, and debugging Flutter apps.

### Installing IntelliJ

You can use the IntelliJ plug-ins with one of the following JetBrains IDEs:

* [IntelliJ IDEA](https://www.jetbrains.com/idea/download/), Community (free) edition, version 2016.3 or 2017.1.
* [IntelliJ IDEA](https://www.jetbrains.com/idea/download/), Ultimate edition, version 2016.3 or 2017.1.
* [IntelliJ WebStorm](https://www.jetbrains.com/webstorm/download), version 2016.3 or 2017.1.

Android Studio (and various other JetBrains editors) is currently not supported.

### Installing the plugins

To use IntelliJ with Flutter, you need two plugins:

  * The `Flutter` plugin powers Flutter developer workflows (running, debugging, hot reload, etc.).
  * The `Dart` plugin offers code analysis (code validation as you type, code completions, etc.).

When you install the Flutter plugin, if the Dart plugin is not already present IntelliJ
installs it for you.

To install the plugins:

1. Start IntelliJ.
1. Open plugin preferences (**Preferences>Plugins** on macOS, **File>Settings>Plugins** on Linux).
1. Select **Browse repositories…**,  select the Flutter plug-in and click `install`.
1. Click `Yes` when prompted to install the Dart plugin.
1. Click `Restart IntelliJ IDEA`.

After restarting, the Dart and Flutter plugins should both display in the left
navigation panel when you create a new project.

### Configuring the Flutter plugin

1. Open preferences (**Preferences** on macOS, **File>Settings** on Linux).
1. Select **Languages & Frameworks>Flutter**.
1. Enter or browse to your Flutter SDK directory in **Flutter SDK path**. This is the top-level `flutter`
   directory, without the `bin` subdirectory. For example, `/Users/obiwan/flutter`.
1. Click **OK**
