---
title: Targeting ChromeOS with Android
description: Platform-specific considerations for building for ChromeOS with Flutter.
---

This page discusses considerations unique to building
Android apps that support ChromeOS with Flutter.

## Flutter & ChromeOS tips & tricks

For the current versions of ChromeOS, only certain ports from
Linux are exposed to the rest of the environment.
Here's an example of how to launch
Flutter DevTools for an Android app with ports
that will work:

```console
$ flutter pub global run devtools --port 8000
$ cd path/to/your/app
$ flutter run --observatory-port=8080
```

Then, navigate to http://127.0.0.1:8000/#
in your Chrome browser and enter the URL to your
application. The last `flutter run` command you
just ran should output a URL similar to the format
of `http://127.0.0.1:8080/auth_code=/`. Use this URL
and select "Connect" to start the Flutter DevTools
for your Android app.

#### Flutter ChromeOS lint analysis

Flutter has ChromeOS-specific lint analysis checks
to make sure that the app that you're building
works well on ChromeOS. It looks for things
like required hardware in your Android Manifest
that aren't available on ChromeOS devices,
permissions that imply requests for unsupported
hardware, as well as other properties or code
that would bring a lesser experience on these devices.

To activate these,
you need to create a new analysis_options.yaml
file in your project folder to include these options.
(If you have an existing analysis_options.yaml file,
you can update it)

```yaml
include: package:flutter/analysis_options_user.yaml
analyzer:
 optional-checks:
   chrome-os-manifest-checks
```

To run these from the command line, use the following command:

```console
$ flutter analyze
```

Sample output for this command might look like:

```console
Analyzing ...
warning • This hardware feature is not supported on ChromeOS •
android/app/src/main/AndroidManifest.xml:4:33 • unsupported_chrome_os_hardware
```
