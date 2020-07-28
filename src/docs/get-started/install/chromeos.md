---
title: Chrome OS install
description: How to install on Chrome OS.
short-title: Chrome OS
next:
  title: Set up an editor
  path: /docs/get-started/editor
---

{% assign os = 'linux' -%}

## System requirements

To install and run Flutter, your development environment
must meet these minimum requirements:

* **Operating Systems**: Chrome OS (64-bit) with [Linux (Beta)][] turned on
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

{% include_relative _get-sdk-chromeos.md %}

{% include_relative _path-linux-chromeos.md %}

{% include_relative _android-setup-chromeos.md %}

## Next step

Set up your preferred editor.

## Flutter & Chrome OS tips & tricks

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

Then, navigate to http://127.0.0.1:8000/#
in your Chrome browser and enter the URL to your
application. The last `flutter run` command you
just ran should output a URL similar to the format
of `http://127.0.0.1:8080/auth_code=/`. Use this URL
and select "Connect" to start the Flutter DevTools
for your Android app.

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


[Linux (Beta)]: https://support.google.com/chromebook/answer/9145439
