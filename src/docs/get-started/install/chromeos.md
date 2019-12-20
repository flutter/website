---
title: Chrome OS install
short-title: Chrome OS
next:
  title: Set up an editor
  path: /docs/get-started/editor
---

{% assign os = 'linux' -%}

## System requirements

To install and run Flutter, your development environment
must meet these minimum requirements:

* **Operating Systems**: Linux (64-bit)
* **Disk Space**: 600 MB (does not include disk space for IDE/tools).
* **Tools**: Flutter depends on these command-line
  tools being available in your environment.
  * `bash`
  * `curl`
  * `git` 2.x
  * `mkdir`
  * `rm`
  * `unzip`
  * `which`
  * `xz-utils`
* **Shared libraries**: Flutter `test` command depends on
  this library being available in your environment.
  * `libGLU.so.1` - provided by mesa packages such as `libglu1-mesa` on
     Ubuntu/Debian

For the best experience right now, you should put your
Chrome OS Device into developer mode (this is necessary
to push apps on the Chrome OS Device).  For more information,
see [how to enable developer mode on your Chromebook][].

{% include_relative _get-sdk.md %}

{% include_relative _path-linux-chromeos.md %}

{% include_relative _chromeos-android-sdk-setup.md %}

## Next step

Set up your preferred editor.

## Flutter & Chrome OS tips & tricks

Wondering how to run your app? On Chrome OS,
you can either connect your phone
or push directly to the Android container on device.
To do that you must enable Developer mode on your machine,
and then connect to the local container with ADB:

```terminal
$ adb connect 100.115.92.2:5555
```

Want to build your first app optimized for Chrome OS?
Clone the flutter-samples repo and build our specific Chrome
OS Best Practices example:

```terminal
$ git clone https://github.com/flutter/samples
$ cd samples/chrome-os-best-practices
$ flutter run
```

Wondering how to access your favorite F-Key shortcuts
on the Chrome OS keyboard?

* Press the search key along with 1 through = to access F1–F12.

For the current versions of Chrome OS, only certain ports from
Crostini are exposed to the rest of the environments.
Here’s an example of how to launch
Flutter DevTools for an Android app with ports
that will work:

```terminal
$ flutter pub global run devtools -p 8000
$ cd path/to/your/app
$ flutter run --observatory-port=8080
```

Then, navigate to http://localhost:8000/?port=8080
in your Chrome browser.

#### Flutter Chrome OS lint analysis

The Flutter team is adding Chrome OS specific
Lint Analysis checks that are available to make
sure that the app that you're building is going
to work well on Chrome OS. It looks for things
like required hardware in your Android Manifest
that aren’t available on Chrome OS devices,
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

```terminal
$ flutter analyze
```

Sample output for this command might look like:

```terminal
Analyzing ...
warning • This hardware feature is not supported on Chrome OS •
android/app/src/main/AndroidManifest.xml:4:33 • unsupported_chrome_os_hardware
```

This functionality is still under development,
but check back for instructions on how you can make
this functionality work with your Chrome OS
targeted Flutter app.


[how to enable developer mode on your Chromebook]: https://www.androidcentral.com/how-enable-developer-mode-chrome-os

