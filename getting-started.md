---
layout: page
title: Getting Started with Flutter
sidebar: home_sidebar
permalink: /getting-started/
---

<link rel="stylesheet" href="/css/styles.css" />

This quickstart guide describes how to create and run your first Flutter app on iOS or Android.

* Placeholder for TOC
{:toc}

## Before you begin

To write Flutter apps, you will need to install the Flutter SDK. You also need to set up a Linux or
Mac development machine to run and test your apps on Android or iOS. See
[Flutter Setup](../setup) for instructions on how to set up your development environment.

## Create your first Flutter app

To create a starter project, open a terminal and run the `flutter` command .

Here is an example:

```
$ flutter create myapp
```

The above command creates a Flutter project directory called `myapp` that contains a simple demo
app that uses [Material Design](https://www.google.com/design/spec/material-design/introduction.html).

In the project directory, the code for your app is in `myapp/lib/main.dart`.

## Run your Flutter app

Use the `flutter run` command to run your Flutter app on all connected
devices and simulators. (The `flutter devices` command will list connected devices and
simulators.)

To run your app from the command-line:

1. Open a terminal and change directories to the root of your app (the same directory that
contains the `pubspec.yaml` file for your project).
2. Run the following command.

  ```
  $ flutter run
  ```

Alternatively, if you are using the [Atom editor](https://atom.io/) with the
[Flutter package](https://atom.io/packages/flutter), you can start your Flutter app by selecting
the `/lib/main.dart` file in the project and pressing the Run App shortcut in the main editor
screen. The shortcut depends on the operating system of the development machine you are using:

* **Linux**: `Ctrl+R`
* **Mac**: `Command+R`


If everything works, you should see your starter app on your Android device or iOS Simulator.

<div id="starter-app-screenshots">
  <div class="box2">
    <figure>
      <img src="/images/flutter-starter-app-ios.png">
      <figcaption>Figure 1. iOS Simulator (iPhone 6s Plus)</figcaption>
    </figure>
  </div>
  <div class="box2">
    <figure>
      <img src="/images/flutter-starter-app-android.png">
      <figcaption>Figure 2. Android (Nexus 6)</figcaption>
    </figure>
  </div>
</div>


## View the logs

The `flutter logs` command lets you see textual output from your app, including `print`
statements and unhandled exceptions.

To start streaming the logs when your Flutter app is running on an Android device or on the iOS
Simulator, run this command:

```
$ flutter logs
```

To avoid confusion from old log messages, you can use the `flutter logs --clear` option to clear
the logs between runs.

## Next steps

Please reach out to us at our [mailing list][mailinglist]. We'd love
to hear from you!

You might also want to check out our
[Introduction to Flutter's Widget Framework](/widgets-intro/)
and our [Debugging guide](/debugging).

Happy Fluttering!


[mailinglist]: mailto:flutter-dev@googlegroups.com
