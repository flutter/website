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

Use the `flutter run` command to run your Flutter app on a connected
device or simulator.

To run your app from the command-line:

1. Open a terminal and change directories to the root of your app (the same directory that
contains the `pubspec.yaml` file for your project).
2. Run the following command. Once the `flutter` tool is running, if you change the app's
source code, you can hit `r` to hot-reload your application (updating the source on the fly
without actually restarting the entire app).

  ```
  $ flutter run
  ```

If more than one device is connected, use the `flutter devices` command
to get their IDs, and then `flutter run -d deviceID` to run your app.

Alternatively, if you are using the [IntelliJ
IDEA](https://www.jetbrains.com/idea/) IDE with the [Flutter
plugins](/setup/#plugins), you can start your Flutter app from there:

1. In IntelliJ, click **Create New Project** from the Welcome window or
**File > New > Project...** from the main IDE window.
1. Select **Flutter** in the menu, and click **Next**.
1. Under **Project location** enter, or browse to, the directory holding your new Flutter app.
1. Click **Finish**.
1. Click the **Debug icon** in the toolbar, or invoke the menu item **Run > Debug**.

![Main IntelliJ toolbar](/images/intellij/main-toolbar.png)

If everything works, you should see your starter app on your device or simulator.

<div id="starter-app-screenshots">
  <div class="box2">
    <figure>
      <img src="/images/flutter-starter-app-ios.png">
      <figcaption>Figure 1. iOS (iPhone 6s Plus)</figcaption>
    </figure>
  </div>
  <div class="box2">
    <figure>
      <img src="/images/flutter-starter-app-android.png">
      <figcaption>Figure 2. Android (Nexus 6P)</figcaption>
    </figure>
  </div>
</div>

## Next steps

Please reach out to us at our [mailing list][mailinglist]. We'd love
to hear from you!

You might also want to check out our
[Introduction to Flutter's Widget Framework](/widgets-intro/)
and our [Debugging guide](/debugging).

Happy Fluttering!


[mailinglist]: mailto:flutter-dev@googlegroups.com
