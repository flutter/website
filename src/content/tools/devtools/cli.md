---
title: Run DevTools from the command line
description: Learn how to launch and use DevTools from the command line.
---

To run DevTools from the CLI,
you must have `dart` on your path.
Then to launch DevTools, run the `dart devtools` command.

To upgrade DevTools, upgrade Flutter.
If a newer Dart SDK
(which is included in the Flutter SDK)
includes a newer version of DevTools,
running `dart devtools` automatically launches this version.
If `which dart` points to a Dart SDK _not_
included in your Flutter SDK, updating that
Dart SDK won't update the Flutter version.

When you run DevTools from the command line,
you should see output that looks something like:

```plaintext
Serving DevTools at http://127.0.0.1:9100
```

## Start an application to debug

Next, start an app to connect to.
This can be either a Flutter application
or a Dart command-line application.
The command below specifies a Flutter app:

```console
cd path/to/flutter/app
flutter run
```

You need to have a device connected, or a simulator open,
for `flutter run` to work. Once the app starts, you'll see a
message in your terminal that looks like the following:

```console
An Observatory debugger and profiler on macOS is available at:
http://127.0.0.1:52129/QjqebSY4lQ8=/
The Flutter DevTools debugger and profiler on macOS is available at:
http://127.0.0.1:9100?uri=http://127.0.0.1:52129/QjqebSY4lQ8=/
```

Open the DevTools instance connected to your app
by opening the second link in Chrome.

This URL contains a security token, 
so it's different for each run of your app. 
This means that if you stop your application and re-run it, 
you need to connect to DevTools again with the new URL.

## Connect to a new app instance

If your app stops running
or you opened DevTools manually,
you should see a **Connect** dialog:

![Screenshot of the DevTools connect dialog](/assets/images/docs/tools/devtools/connect_dialog.png){:width="100%"}

You can manually connect DevTools to a new app instance
by copying the Observatory link you got from running your app,
such as `http://127.0.0.1:52129/QjqebSY4lQ8=/`
and pasting it into the connect dialog:
