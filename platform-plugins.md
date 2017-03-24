---
layout: page
title: Plugins&#58; Integrating with platform-specific code
permalink: /platform-plugins/
---

This guide describes how Flutter apps can integrate with platform-specific code
available on iOS and Android devices. This includes both device APIs (like
`Clipboard` and `BatteryState`) and third-party platform SDKs (like Google
Analytics).

* TOC
{:toc}

## Options for integrating with platform-specific code

Mobile devices offer many options to extend your app through platform-specific
APIs. These are critical to the completeness of most mobile apps. Flutter offers
the following ways to integrate with these via 'plugins'.

There are two ways you can use platform-specific code:

* **Use existing platform plugins:** For frequently used APIs and SDKs, use
 existing platform plugins, with no need to write any platform-specific code.
 [See details below](#use).

* **Write custom platform code:** Write your own platform-specific code using
 Flutter's platform channels. This can be used for private APIs, or for cases
 where a suitable platform plugin is not yet available. See the [platform channels](/platform-channels/)
 page for details.

And, if desired, you can create and share plugins:

* **Create a platform plugin** If you wish to use your platform-specific code in
 multiple Flutter apps, or share it with others, then you can wrap it in a
 plugin. [See details below](#create)

* **Publish a platform plugin:** Publish custom platform-specific code as a
 plugin. This enables other developers to use it by simply declaring a
 dependency on the plugin. [See details below](#publish).

## Use existing platform plugins {#use}

{% include note.html content="The following content presents a potential future
for Flutter." %}

A Flutter plugin is a special kind of
[package](https://www.dartlang.org/tutorials/libraries/shared-pkgs). Similar to
a regular package it contains an API definition written in Dart, but then in
addition contains a platform-specific implementation for Android, for iOS, or
for both.

### Searching for plugins

Flutter plugins are shared on the [pub repository](https://pub.dartlang.org/)
along with regular packages. To search explicitly for plugins, use the following
[search link](https://pub.dartlang.org/search?type=plugin).

### Declaring a plugin dependency

To use a plugin, use these simple steps:

1. Open the `pubspec.yaml` file located inside your app folder
1. Add a dependency line

### Example: Using the Flutter URLLauncher plugin to launch the browser

The [URLLauncher](https://pub.dartlang.org/plugins/urllauncher) plugin enables
you to open the mobile platforms default browser to display a given URL. It is
supported on both Android and iOS.

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
      urllauncher:
    ```

1. Open `lib/main.dart` and replace it full contents with:
    ```dart
    import 'package:flutter/material.dart';
    import 'package:flutter/services.dart';

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
        UrlLauncher.launch('https://flutter.io');
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

1. Add Android registration

    {% include note.html content="This manual step is expected to no longer be
    necessary in a future version of Flutter" %}

    * 

1. Add iOS registration

1. Build your app

## Create a platform plugin {#create}

If you expect to use your platform-specific code in multiple Flutter apps, it
can be useful to separate the code into a platform plugin located in a directory
outside your main application. Optionally, this also enables you to
[publish](#publish) the plugin.

{% include note.html content="Creating platform plugins is currently not
supported, but Flutter is expected to support this in the future." %}

## Publish a platform plugin {#publish}

{% include note.html content="Sharing of platform plugins is currently not
supported, but Flutter is expected to support this in the future." %}
