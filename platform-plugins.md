---
layout: page
title: Plugins&#58; Integrating with platform-specific code
permalink: /platform-plugins/
---

This guide describes how Flutter apps can integrate with platform-specific code
available on iOS and Android devices. This includes both device APIs (like
[`url_launcher`](https://pub.dartlang.org/packages/url_launcher) and
[`battery`](https://pub.dartlang.org/packages/battery)) and third-party platform SDKs 
(like [Firebase](https://github.com/flutter/plugins/blob/master/FlutterFire.md)).

* TOC
{:toc}

## Options for integrating with platform-specific code

Mobile devices offer many options to extend your app through platform-specific
APIs. These are critical to the completeness of most mobile apps.

Flutter supports two mechanisms for using platform-specific code:

* **Use existing platform plugins:** For frequently used APIs and SDKs, use
 [existing platform plugins](https://pub.dartlang.org/flutter/plugins), with no
 need to write any platform-specific code yourself. [See details below](#use).

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

The list [Flutter plugins](https://pub.dartlang.org/flutter/plugins) displays plugins
which are shared on the [pub](https://pub.dartlang.org/) repository.

{% include note.html content="Flutter is still a young platform, and only a
fairly small set of plugins are currently available on pub. We encourage all
Flutter developers to develop and [publish](#publish) new plugins!" %}

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
      url_launcher:
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

You can create a plugin project using the `--plugin` flag with `flutter create`:
```
flutter create --plugin hello
```

This creates a plugin project in the `hello/` folder with the following content:

* `lib/hello.dart`:
   - The Dart API for the plugin.
* `android/src/main/java/com/yourcompany/hello/HelloPlugin.java`:
   - The Android platform specific implementation of the plugin API.
* `ios/Classes/HelloPlugin.m`: 
   - The iOS platform specific implementation of the plugin API.
* `example/`:
   - A Flutter app that depends on the plugin, and illustrates how to use it.

By default, the plugin project will be set up to use Objective-C for iOS code and
Java for Android code. If you prefer to use Swift or Kotlin, you can specify your
preferred iOS language using `-i` and/or your preferred Android language using
`-a`. For example:
```
flutter create --plugin -i swift -a kotlin hello
```

### Editing plugin source code {#edit-code}

#### Plugin API code (.dart)

To edit the Dart plugin API code, open `hello/` in IntelliJ IDEA (or your
favorite Dart editor). The plugin API is located in `lib/main.dart` shown in the 
Project view.

To run the plugin, you need to launch the plugin example app, which requires
defining a launch configuration:

1. Select 'Run > Edit Configurations...'.
1. Select '+' and then 'Flutter'.
1. In 'Dart entrypoint', enter `<plugin folder>/example/lib/main.dart`.
1. Select 'OK'.
1. Launch the example app with 'Run' or 'Debug'.

*Note*: [Hot reload](https://flutter.io/faq/#hot-reload) is only supported for changes to Dart code, not for Android and iOS code. 

#### Android platform code (.java/.kt)

Before editing the Android platform code in Android Studio, first make sure that
the code has been built at least once (i.e., run the example app from IntelliJ, 
or in a terminal execute `cd hello/example; flutter build apk`). 

Next,

1. Launch Android Studio
1. Select 'Import project' in 'Welcome to Android Studio' dialog, or select 
'File > New > Import Project...'' in the menu, and select the
`hello/example/android/build.gradle` file.
1. In the 'Gradle Sync' dialog, select 'OK'.
1. In the 'Android Gradle Plugin Update' dialog, select 'Don't remind me again for this project'. 

The Android platform code of your plugin is located in `hello/java/com.yourcompany.hello/HelloPlugin`.

You can run the example app from Android Studio by pressing the &#9654; button.

#### iOS platform code (.h+.m/.swift)

Before editing the iOS platform code in Xcode, first make sure that
the code has been built at least once (i.e., run the example app from IntelliJ, 
or in a terminal execute `cd hello/example; flutter build ios`).

Next,

1. Launch Xcode
1. Select 'File > Open', and select the `hello/example/ios/Runner.xcworkspace` file.

The iOS platform code of your plugin is located in `Pods/Development Pods/hello/Classes/` in the Project Navigator.

You can run the example app by pressing the &#9654; button.

### Managing dependencies from a Flutter app to a Flutter plugin

Once a plugin has been [published](#publish), you can depend on it by simply
listing it's name in `pubspec.yaml` as illustrated by the [example](#example)
above.

During development of a plugin that has not yet been published, or for private
plugins not intended for public publishing, an additional way of
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
