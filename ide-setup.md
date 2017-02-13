---
layout: page
title: IDE Setup
sidebar: home_sidebar
permalink: /ide-setup/
---

This page describes how to set up IntelliJ IDE to develop Flutter apps.

* TOC Placeholder
{:toc}

## Flutter IntelliJ IDE plugins

You can write Flutter apps in a text editor, but if you choose to work in an IDE we recommend 
IntelliJ for a [rich IDE experience](/intellij-ide/). Our Flutter and Dart plug-ins support 
editing, running, and debugging Flutter apps.

### Installing IntelliJ

The IntelliJ plug-ins require JetBrains [IntelliJ IDEA](https://www.jetbrains.com/idea/download/),
either Community (free) or Ultimate edition. Version 2016.2 or later is supported.

Note that the current version of the Flutter plugin for IntelliJ is not compatible with Android 
Studio and Webstorm (and various other JetBrains editors).

### Installing the plugins

We provide two plugins:

  * The `Dart` plugin offers code analysis (code validation as you type, code completions, etc.)
  * The `Flutter` plugin powers Flutter developer workflows (running, debugging, hot reload, etc.)

To install the plugins:

1. Open plugin preferences (**Preferences>Plugins** on macOS, **File>Settings>Plugins** on Linux)
1. Select **"Browse repositories…"**
1. Search for `'dart'`, select the Dart plug-in and click `install` (do not restart yet).
1. Search for `'flutter'`,  select the Flutter plug-in and click `install`. 
1. Click `Restart IntelliJ IDEA`.

### Configure the plugins

1. Open preferences (**Preferences** on macOS, **File>Settings** on Linux)
1. Select **Languages & Frameworks>Flutter**
1. Enter, or browse to, your Flutter SDK directory path in **Flutter SDK path**
1. Click **OK**
