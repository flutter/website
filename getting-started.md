---
layout: page
title: Getting Started with Flutter
sidebar: home_sidebar
permalink: /getting-started/
---

This quickstart guide describes how to create and run your first Flutter app on iOS or Android.

* Placeholder for TOC
{:toc}

## Before you begin

To write Flutter apps, you will need to install the Flutter SDK. You also need to set up a Linux or
Mac development machine to run and test your apps on Android or iOS. See
[Flutter Setup](../setup) for instructions on how to set up your development environment.

## Creating your first Flutter app

To create a starter project, open a terminal and run the `flutter create <project name>` command .

Here is an example:

```
$ flutter create myapp
```

The above command creates a Flutter project directory called `myapp` that contains a simple demo
app that uses [Material Design](https://www.google.com/design/spec/material-design/introduction.html).

In the project directory, the code for your app is in `myapp/lib/main.dart`.

## Running your Flutter app

Use the `flutter run` command to run your Flutter app on a connected
device or simulator.

To run your app from the command-line:

1. Open a terminal and change directories to the root of your app (the same directory that
contains the `pubspec.yaml` file for your project).
2. Run the following command. Once the `flutter` tool is running, if you change the app's
source code, you can hit `r` to hot-reload your application (updating the source on the fly
without actually restarting the entire app).

```
$ cd myapp
$ flutter run
```

If more than one device is connected, use the `flutter devices` command
to get their IDs, and then `flutter run -d deviceID` to run your app.

Alternatively, if you are using the [IntelliJ
IDEA](https://www.jetbrains.com/idea/) IDE with the [Flutter
plugins](/intellij-setup/), you can start your Flutter app from there:

1. In IntelliJ, click **Create New Project** from the Welcome window or
**File > New > Project...** from the main IDE window.
1. Select **Flutter** in the menu, and click **Next**.
1. Under **Project location** enter, or browse to, the directory holding your new Flutter app.
1. Click **Finish**.
1. Click the **Run icon** in the toolbar, or invoke the menu item **Run > Run**.

![Main IntelliJ toolbar](/images/intellij/main-toolbar.png)

If everything works, you should see your starter app on your device or simulator.

<div id="starter-app-screenshots">
  <figure style='display: inline-block'>
    <img src="/images/flutter-starter-app-ios.png" alt="Starter App on iOS">
    <figcaption>Figure 1. iOS (iPhone 6s Plus)</figcaption>
  </figure>
  <figure style='display: inline-block'>
    <img src="/images/flutter-starter-app-android.png" alt="Starter App on Android">
    <figcaption>Figure 2. Android (Nexus 6P)</figcaption>
  </figure>
</div>

## Viewing source code changes with 'hot reload'

_Hot reload_ reloads your app very quickly
after a change to your source code,
offering a best-in-class development cycle.

![Hot reload in IntelliJ](/images/intellij/hot-reload.gif)

To edit your code and hot reload changes:

1. Run your app with 'Run' or 'Debug'.
1. Make desired changes in your source code (without stopping the app).
1. Click the Hot Reload button.

A more detailed detailed description on how to use the IntelliJ plugin and which
changes are supported by the hot reload feature can be found on the page
[Developing apps in the IntelliJ IDE](../intellij-ide/).

## Next steps

Please reach out to us at our [mailing list][mailinglist]. We'd love
to hear from you!

You might also want to check out our
[Introduction to Flutter's Widget Framework](/widgets-intro/)
and our [Debugging guide](/debugging).

Happy Fluttering!


[mailinglist]: mailto:flutter-dev@googlegroups.com
