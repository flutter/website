---
layout: page
title: Plugins&#58; Integrating with platform-specific code
permalink: /platform-plugins/
---

This guide describes how Flutter apps can integrate with platform-specific code
available on iOS and Android devices. This includes both device APIs (like
`URLLauncher` and `BatteryState`) and third-party platform SDKs (like Google
Analytics).

* TOC
{:toc}

## Options for integrating with platform-specific code

Mobile devices offer many options to extend your app through platform-specific
APIs. These are critical to the completeness of most mobile apps.

Flutter supports two mechanisms for using platform-specific code:

* **Use existing platform plugins:** For frequently used APIs and SDKs, use
 existing platform plugins, with no need to write any platform-specific code
 yourself. [See details below](#use).

* **Write custom platform code:** Write custom platform-specific code using
 Flutter's platform channels. This can be used for private APIs, or for cases
 where a suitable plugin is not yet available. See the [platform channels](/platform-channels/)
 page for details.

And, if desired, you can create and share plugins:

* **Create a platform plugin** If you wish to use your platform-specific code in
 multiple Flutter apps, or share it with others, then you can wrap it in a
 plugin. [See details below](#create)

* **Publish a platform plugin:** Publish custom platform-specific code as a
 plugin. This enables other developers to use it by simply declaring a
 dependency on the plugin. [See details below](#publish).

## Use existing platform plugins {#use}

A Flutter _plugin_ is a special kind of
[package](https://www.dartlang.org/tutorials/libraries/shared-pkgs). A plugin
consists of an API definition written in Dart, combined with a platform-specific
implementation for Android, for iOS, or for both.

### Searching for plugins

Flutter plugins are shared on the [pub repository](https://pub.dartlang.org/)
along with regular (pure-Dart) packages.

### Adding a plugin to an app

To add a plugin 'plugin1' to an app:

1. Open the `pubspec.yaml` file located inside your app folder, and add
`plugin1:` under `dependencies`

1. Get the plugin:
   * From the terminal: Run `flutter packages get`
   * From IntelliJ: Click 'Packages Get' in the action ribbon at the top of `pubspec.yaml`

1. Build or run your app. As part of this, Flutter will 'inject' the
platform-specific code from the plugin into your app.

### Example: Using the Flutter URLLauncher plugin to launch the browser {#example}

The [URL Launcher](https://pub.dartlang.org/packages/url_launcher) plugin
enables you to open the default browser on the mobile platform to display a
given URL. It is supported on both Android and iOS.

To use this plugin:

1. Create a new project called 'launchdemo'

1. Open `pubspec.yaml`, and replace:
    ```dart
    dependencies:
      flutter:
        sdk: flutter
    ```
    with:

    ```dart
    dependencies:
      flutter:
        sdk: flutter
      url_launcher: ^0.1.0
    ```

1. Open `lib/main.dart` and replace its full contents with:
    ```dart
    import 'package:flutter/material.dart';
    import 'package:url_launcher/url_launcher.dart';

    void main() {
      runApp(new MyApp());
    }

    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return new MaterialApp(
          title: 'Flutter Demo',
          home: new DemoPage(),
        );
      }
    }

    class DemoPage extends StatelessWidget {
      launchURL() {
        launch('https://flutter.io');
      }

      @override
      Widget build(BuildContext context) {
        return new Scaffold(
          body: new Center(
            child: new RaisedButton(
              onPressed: launchURL,
              child: new Text('Show Flutter homepage'),
            ),
          ),
        );
      }
    }
    ```

1. Run the app. When you click the 'Show Flutter homepage' you should see the
phone's default browser open, and the Flutter homepage appear.

## Create a platform plugin {#create}

If you expect to use your platform-specific code in multiple Flutter apps, it
can be useful to separate the code into a platform plugin located in a directory
outside your main application. Optionally, this also enables you to
[publish](#publish) the plugin.

You can create a 'plugin' using the `--plugin` flag with `flutter create`:
```
flutter create --plugin myplugin
```

This creates a plugin project with the following content:

* `lib/myplugin.dart`:
   - The Dart API for the plugin.
* `android/src/main/java/com/mycompany/testplugin/TestpluginPlugin.java`:
   - The Android platform specific implementation of the plugin API.
* `ios/Classes/TestpluginPlugin.m`: 
   - The iOS platform specific implementation of the plugin API.
* `example/`:
   - A Flutter app that depends on the plugin, and illustrates how to use it. 

### Managing dependencies from a Flutter app to a Flutter plugin

Once a plugin has been [published](#publish), you can depend on it by simply
listing it's name in `pubspec.yaml` as illustrated by the [example (#example)
above.

During development of a plugin that has not yet been published, or for private
plugins not intended for public publishing, the following additional way of
depending on a plugin can be useful:

* **Path** dependency: A Flutter app can depend on a plugin via a file system
 `path:` dependency. The path can be either relative, or absolute. For example, to
 depend on a plugin 'plugin1' located in a directory next to the app, use this
 syntax:
```
dependencies:
    flutter:
      sdk: flutter
    plugin1:
      path: ../plugin1/
```

* **Git** dependency: You can also depend on a package stored in a Git
 repository. The package must be located in the root of the repo. Use this
 syntax:
 ```
 dependencies:
     flutter:
       sdk: flutter
     plugin1:
       git:
         url: git://github.com/flutter/plugin1.git
 ```

For more details, see the [Pub Dependencies article](https://www.dartlang.org/tools/pub/dependencies).
   
## Publish a platform plugin {#publish}

Once you have implemented the plugin, you can publish it on
[Pub](https://pub.dartlang.org/). This enables other developers to easily use it
as illustrated in the above UrlLauncher example.

For details on how to publish, see the [Pub publishing docs](https://www.dartlang.org/tools/pub/publishing). 

Note: The `pub` tool is available in the Dart SDK located inside the Flutter
SDK: `<flutter sdk dir>/bin/cache/dart-sdk/bin/pub`.
