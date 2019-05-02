---
title: Chrome OS install
short-title: Chrome OS
# js: [{defer: true, url: /assets/archive.js}]
next:
  title: Set up an editor
  path: /docs/get-started/editor
---

{% assign os = 'chrome' -%}

## System requirements

To install and run Flutter, your development environment must meet these minimum requirements:

- **Operating Systems**: Linux (64-bit)
- **Disk Space**: 600 MB (does not include disk space for IDE/tools).
- **Tools**: Flutter depends on these command-line tools being available in your environment.
  - `bash`
  - `curl`
  - `git` 2.x
  - `mkdir`
  - `rm`
  - `unzip`
  - `which`
  - `xz-utils`
- **Shared libraries**: Flutter `test` command depends on this library being available in your environment.
  - `libGLU.so.1` - provided by mesa packages e.g. `libglu1-mesa` on Ubuntu/Debian

For the best experience right now, you should put your Chrome OS Device into developer mode (this is necessary to push apps on the Chrome OS Device). For more information on how to do this, [click here](https://www.androidcentral.com/how-enable-developer-mode-chrome-os)

{% include_relative _get-sdk.md %}

{% include_relative _path-mac-linux.md %}

{% include_relative _android-sdk-setup.md %}

## Next step

[Next step: Configure Editor](/docs/get-started/editor)

## Flutter & Chrome OS Tips & Tricks

Want to build your first app optimized for Chrome OS? Clone the flutter-samples repo and build our specific Chrome OS Hello-World example:

```terminal
$ git clone https://github.com/flutter/samples
$ cd samples/chrome-os-hello-world
$ flutter run
```

Wondering how to access your favorite F-Key shortcuts on the Chrome OS keyboard?
* Press the search key along with 1 through = to access F1–F12

For the current versions of Chrome OS, only certain ports from Crostini are exposed to the rest of the environments. Here’s an example of how to launch Flutter DevTools for an Android app with ports that will work:

```terminal
$ flutter packages pub global run devtools -p 8000
$ cd path/to/your/app
$ flutter run --observatory-port=8080
```

Then, navigate to http://localhost:8000/?port=8080 in your Chrome browser.

#### Flutter Chrome OS Lint Analysis

The Flutter team has added Chrome OS specific Lint Analysis checks that are available to make sure that the app that your building is going to work well on Chrome OS. It looks for things like required hardware in your Android Manifest that aren’t available on Chrome OS devices, permissions that will imply unsupported hardware, as well as other properties or code that would bring a lesser experience on these devices.
To activate these, you have to create a new/update your analysis_options.yaml file to include these options:

```yaml
include: package:flutter/analysis_options_user.yaml
analyzer:
 optional-checks:
   chrome-os-manifest-checks
```

To run these from the command line:

```terminal
$ flutter analyze
```

Sample output for these may look like:

```terminal
Analyzing ...                                                      
warning • This hardware feature is not supported on Chrome OS • android/app/src/main/AndroidManifest.xml:4:33 • unsupported_chrome_os_hardware
```


The analysis results will also show in the Dart Analysis tab in your IDE (VSCode or Android Studio).

