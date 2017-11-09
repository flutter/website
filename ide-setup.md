---
layout: page
title: IDE Setup

permalink: /ide-setup/
---

This page describes how to set up an IDE to develop Flutter apps.

* TOC Placeholder
{:toc}

## Flutter IDE plugins

You can write Flutter apps in a text editor, but if you desire a rich IDE experience we recommend 
using Android Studio or IntelliJ IDEA. Our Flutter and Dart plugins for these IDEs support
editing, running, and debugging Flutter apps.

### Installation

You can use the plugins with the following IntelliJ platform IDEs:

* [IntelliJ CE](https://www.jetbrains.com/idea/download/) IDEA Community Edition (CE), version 2017.1 or later.
* [IntelliJ IDEA](https://www.jetbrains.com/idea/download/) IDEA Ultimate edition, version 2017.1 or later.
* [Android Studio](https://developer.android.com/studio/index.html), version 3.0 or later.

Both IntelliJ CE and Android Studio are free to use and supported for Flutter development.

### Installing the plugins

To use these IDEs with Flutter, you need two plugins:

  * The `Flutter` plugin powers Flutter developer workflows (running, debugging, hot reload, etc.).
  * The `Dart` plugin offers code analysis (code validation as you type, code completions, etc.).

When you install the Flutter plugin, if the Dart plugin is not already present IntelliJ
installs it for you.

To install the plugins:

1. Start IntelliJ IDEA or Android Studio.
1. Open plugin preferences (**Preferences>Plugins** on macOS, **File>Settings>Plugins** on Windows & Linux).
1. Select **Browse repositories…**,  select the Flutter plug-in and click `install`.
1. Click `Yes` when prompted to install the Dart plugin.
1. Click `Restart` when prompted.

### Configuring the Flutter plugin

1. Open preferences (**Preferences** on macOS, **File>Settings** on Windows & Linux).
1. Select **Languages & Frameworks>Flutter**.
1. Enter or browse to your Flutter SDK directory in **Flutter SDK path**. This is the top-level `flutter`
   directory, without the `bin` subdirectory. For example, `c:\Users\obiwan\flutter` / `/Users/obiwan/flutter`.
1. Click **OK**

*Note*: Flutter is only shown under 'Languages & Frameworks' when you have a project opened.

## Using the IDEs for Flutter

See our [additional documentation](/intellij-ide/) for tips on developing Flutter apps with
Android Studio or IntelliJ IDEA.
