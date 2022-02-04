---
title: Install and run DevTools from the command line
Description: Learn how to install and use DevTools from the command line.
---

To run Dart DevTools from the CLI, you must have `dart` on your path. Then
you can simply run the following command to launch DevTools:

```
dart devtools
```

To upgrade DevTools, simply upgrade your Dart SDK. If a newer Dart SDK
includes a newer version of DevTools, `dart devtools` will automatically
launch this version. If `which dart` points to the Dart SDK included in
your Flutter SDK, then DevTools will be upgraded when you upgrade your
Flutter SDK to a newer version.

When you run DevTools from the command line, you should see output that
looks something like:

```
Serving DevTools at http://127.0.0.1:9100
```

## Start an application to debug

Next, start an app to connect to.
This can be either a Flutter application
or a Dart command-line application.
The command below specifies a Flutter app:

```
cd path/to/flutter/app
flutter run
```

You need to have a device connected, or a simulator open,
for `flutter run` to work. Once the app starts, you'll see a
message in your terminal that looks like the following:

```
An Observatory debugger and profiler on iPhone X is available
at: http://127.0.0.1:50976/Swm0bjIe0ks=/
```

Keep note of this URL,
as you will use it to connect your app to DevTools.

## Open DevTools and connect to the target app

Once it's set up, using DevTools is as simple as opening a
Chrome browser window and navigating to `http://localhost:9100`.

Once DevTools opens, you should see a connect dialog:

![Screenshot of a logging view]({{site.url}}/assets/images/docs/tools/devtools/connect_dialog.png){:width="100%"}

Paste the URL you got from running your app (in this example,
`http://127.0.0.1:50976/Swm0bjIe0ks=/`) into the connect dialog
to connect your app to DevTools.

This URL contains a security token, so it's different
for each run of your app. This means that if you stop your
application and re-run it, you need to connect to DevTools
with the new URL.

