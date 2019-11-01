---
title: Desktop support for Flutter
description: "Announcing the alpha release of Flutter for desktop."
---

With desktop support, you can compile Flutter code to a native macOS Desktop
app, complete with all of Flutter's features and editor tooling. You can also
use some existing plugins, as well as create your own. As of 1.12, desktop
support is available as an alpha release. The Objective-C API layer is largely
stable, and breaking changes should be rare.

{{site.alert.warning}}
The Flutter desktop APIs are still in early stages of development, and are subject to change without warning. No backwards compatibility, either API or ABI, will be provided. Expect any code using these libraries to need to be updated and recompiled after any Flutter update.
{{site.alert.end}}

## Getting Started

Before you begin, make sure you have completed the [steps to install Flutter].

### Create a Flutter desktop app (summary)
The following commands demonstrate how to create and run a new Flutter desktop
app:

```terminal
$ flutter channel master
$ flutter upgrade
$ flutter config --enable-macos-desktop
$ cd <into project directory>
$ flutter create --macos .
$ flutter run -d macOS
```

To generate a release build:
```terminal
$ flutter build macos
```

To use any of the support, you must be on the master Flutter channel, and you
must enable the feature for your platform:

## Tools
Desktop support includes features for running and building your code using the
flutter CLI as well as IDEs.

### Flutter CLI
As shown in the preceding example, Flutter Desktop supports the `create` and
`build` commands as well as the `run` command in [debug mode] with [hot reload].
Flutter Desktop does not currently support profile or release mode.

### VSCode

**Supported:**
- flutter `create`, `run`, and `build` commands
- hot restart
- debug mode with hot reload

**Not supported:**
- profile mode
- release mode

### Android Studio + Intellij
**Supported:**
- flutter `create`, `run`, and `build` commands
- hot restart
- debug mode with hot reload

**Not supported:**
- profile mode
- release mode

## Plugin Support
### Using Plugins
- Nothing different about using plugins in MacOS
- There are a limited number of plugins available:

To create a plugin, pass the --macos flag when you flutter create your plugin.
To use a plugin with macOS support, add it to pubspec.yaml; flutter will automatically add the necessary native code to your project, as with iOS or Android.

### Creating Plugins
- Nothing different about creating plugins
- Use the Federated Plugin Spec

## Samples
You can learn from existing samples to get started with Flutter desktop support.

### Flutter Gallery

### TreeView
- File Tree Widget

## What's Next
- Windows & Linux: tech preview

## More
- Wiki
- FDE links

## Feedback & Questions

[steps to install Flutter]: /docs/get-started/install/macos