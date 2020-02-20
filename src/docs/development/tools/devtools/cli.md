---
title: Install and run DevTools from the command line
Description: Learn how to install and use DevTools from the command line.
---

## Install DevTools

If you have `pub` on your path, you can run:

```
pub global activate devtools
```

If you have `flutter` on your path, you can run:

```
flutter pub global activate devtools
```

That command installs (or updates) DevTools on your machine.

## Launch the DevTools application server

Next, run the local web server, which serves the DevTools
application itself. To do that, run one of the following
two commands:

```
pub global run devtools   # If you have `pub` on your path.
```

OR

```
flutter pub global run devtools   # If you have `flutter` on your path.
```

On the command line, you should see output that looks something like:

```
Serving DevTools at http://127.0.0.1:9100
```

## Start an application to debug

Next, start an app to connect to. This can be either a Flutter application
or a Dart command-line application. The command below uses a Flutter app:

```
cd path/to/flutter/app
flutter run
```

You need to have a device connected, or a simulator open, for
`flutter run` to work. Once the app starts, you'll see a
message in your terminal that looks like:

```
An Observatory debugger and profiler on iPhone X is available
at: http://127.0.0.1:50976/Swm0bjIe0ks=/
```

Keep note this URL, as you will use it to connect your app to
DevTools.

## Open DevTools and connect to the target app

Once it's set up, using DevTools is as simple as opening a
Chrome browser window and navigating to `http://localhost:9100`.

Once DevTools opens, you should see a connect dialog:

![Screenshot of a logging view]({% asset tools/devtools/connect_dialog.png @path %}){:width="100%"}

Paste the URL you got from running your app (in this example,
`http://127.0.0.1:50976/Swm0bjIe0ks=/`) into the connect dialog
to connect your app to DevTools.

This URL contains a security token, so it will be different
for each run of your app. This means that if you stop your
application and re-run it, you need to connect to DevTools
with the new URL.

