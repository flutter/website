---
layout: page
title: Developing apps in the IntelliJ IDE
sidebar: home_sidebar
permalink: /intellij-ide/
---

Our custom IntelliJ plugins provides a fully integrated development experience
in the IntelliJ IDE.

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

### Creating a new projects from existing source code

## Editing code, and viewing code problems

### Core editing experience

### Dart Analysis and source code problems

## Running and Debugging

### Selecting a target

### Run app in release mode

### Run app in debug mode

### Viewing logs

### Advanced debugging with Observatory

## Fast edit and refresh development cycle

### Performing a 'hot reload'

### Performing a 'full application restart'

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
