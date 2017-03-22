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
the following ways to integrate with these via 'plugins', packages that contain
an API definition written in Dart, coupled with a platform-specific
implementation for Android, for iOS, or for both.

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

### Core Flutter platform plugin

The Flutter framework includes a core platform plugin for foundational
platform-specific services, such as:

* [Clipboard](https://docs.flutter.io/flutter/services/Clipboard-class.html):
Utility methods for interacting with the system's clipboard.

* [SystemSound](https://docs.flutter.io/flutter/services/SystemSound-class.html):
Provides access to the library of short system specific sounds for common tasks.

* [PathProvider](https://docs.flutter.io/flutter/services/PathProvider-class.html):
Returns commonly used locations on the filesystem.

See the [services library](https://docs.flutter.io/flutter/services/services-library.html)
for full details.

**Example: Using the Flutter platform plugin to read the contents of the Clipboard**

The core Flutter platform plugin is available through the [services
library](https://docs.flutter.io/flutter/services/services-library.html), as
illustrated in this example:

<!-- skip -->
```dart
import 'package:flutter/services.dart';

class _MyHomePageState extends State<MyHomePage> {
 String clipboardContents = 'Unknown';

 getClipboardContents() async {
   var clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
   if (clipboardData != null) {
     setState(() {
       clipboardContents = clipboardData.text;
     });
   }
 }

 // clipboardContents can now be accessed in the build() method.
}
```

### Platform plugins from the Flutter ecosystem

{% include note.html content="Sharing of platform plugins is currently not
supported, but Flutter is expected to support this in the future." %}


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
