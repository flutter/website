---
layout: page
title: Plugins -- Integrate with platform-specific APIs
permalink: /platform-plugins/
---

This guide describes how to connect your Flutter app to platform-specific
services available on iOS and Android devices. This includes both device APIs
(like `Clipboard` and `BatteryState`) and third-party platform SDKs (like
Google Analytics).

* TOC
{:toc}

## Options for integrating with platform-specific APIs

Mobile devices offer many options to extend your app through platform-specific
APIs. These are critical to the completeness of most mobile apps. Flutter offers
the following ways to integrate with these via 'plugins', packages that contain
an API definition written in Dart, coupled with a platform-specific
implementation for Android, for iOS, or for both.

There are two ways you can use plugins:

* **Use existing platform plugins:** For frequently used APIs and SDKs, use
 existing platform plugins, with no need to write any platform-specific code.
 [See details below](#use).

* **Create a platform plugin:** Write your own platform-specific code using
 Flutter's platform channels. This can be used for private APIs, or for cases
 where a suitable platform plugin is not yet available. [See details below](#create).

And, if desired, you can share plugins with others:

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

* [pathProvider](https://docs.flutter.io/flutter/services/PathProvider-class.html):
Returns commonly used locations on the filesystem.

See the [services library](https://docs.flutter.io/flutter/services/services-library.html)
for full details.

**Example: Using the Flutter platform plugin to read the contents of the Clipboard**

The core Flutter platform plugin is available through the [services
library](https://docs.flutter.io/flutter/services/services-library.html), as
illustrated in this example:

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
 ...
}
```

### Platform plugins from the Flutter ecosystem

{% include note.html content="Sharing of platform plugins is currently not
supported, but Flutter is expected to support this in the future." %}

## Create a platform plugin {#create}

Flutter uses a flexible system that allows you to call platform-specific APIs
whether available in Java code on Android, or in ObjectiveC or Swift code on
iOS.

Flutter's platform-specific API support does not rely on code generation, but
rather on a flexible message passing style:

* The Flutter portion of your app sends messages to it's *host*, the iOS or
 Android portion of your app, over a platform channel.

* The *host* listens on the platform channel, and receives the message. It then
 calls into any number of platform-specific APIs -- using their native
 programming language -- and sends back a response to the *client*, the Flutter
 portion.

### Architectural overview: platform channels

Messages are passed between the client (UI) and host (platform) using platform
channels as illustrated in this diagram:

![Platform channels architecture](/images/PlatformChannels.png)

Messages and responses are passed asynchronously, to ensure the user interface
remains responsive.

On the client side, `PlatformMessageChannel` ([API][PlatformMessageChannel])
enables sending general purpose messages, and `PlatformMethodChannel`
([API][PlatformMethodChannel]) enables sending messages that correspond to
method calls.

On the platform side, the class `FlutterMessageChannel` ([Android
API][FlutterMessageChannelAndroid], [iOS API][FlutterChanneliOS]) enables
receiving messages from the client, and responding with a result, and the class
`FlutterMethodChannel` ([Android API][FlutterMethodChannelAndroid], [iOS
API][FlutterChanneliOS]) enables receiving method calls and sending back a
result. These classes allow you to develop a platform plugin with very little
'boilerplate' code.

*Note*: If desired, method calls can also be sent from the host to the client.

[PlatformMessageChannel]: https://docs.flutter.io/flutter/services/PlatformMessageChannel-class.html
[PlatformMethodChannel]: https://docs.flutter.io/flutter/services/PlatformMethodChannel-class.html
[FlutterMessageChannelAndroid]: https://docs.flutter.io/javadoc/io/flutter/plugin/common/FlutterMessageChannel.html
[FlutterMethodChannelAndroid]: https://docs.flutter.io/javadoc/io/flutter/plugin/common/FlutterMethodChannel.html
[FlutterChanneliOS]: https://github.com/flutter/engine/blob/master/shell/platform/darwin/ios/framework/Source/FlutterChannels.mm

### Platform channel data types support and codecs

The standard platform channels use a standard message codec that supports
efficient binary serialization of simple JSON-like values, such as booleans,
numbers, Strings, and List and Maps of these (see
[`StandardMessageCodec`](https://docs.flutter.io/flutter/services/StandardMessageCodec-class.html))
for details). The serialization and deserialization of these values to and from
messages happens automatically when you send and receive values.

For more specialized use cases, you may also use the
[`BinaryCodec`](https://docs.flutter.io/flutter/services/BinaryCodec-class.html),
[`StringCodec`](https://docs.flutter.io/flutter/services/StringCodec-class.html),
or
[`JSONMessageCodec`](https://docs.flutter.io/flutter/services/JSONMessageCodec-class.html).

### Example: Calling platform-specific iOS and Android code using platform channels

The following example demonstrates how to call a new platform-specific API,
through a concrete example that retrieves and displays the current battery level
by calling into the Android `BatteryManager` API, and the iOS
`device.batteryLevel` API, via a single platform message, `getBatteryLevel`.

The standard app template created when you create a new Flutter app can be used.

*Note*: The full source-code for this example is available in
[`/samples/platform-services/`](https://github.com/flutter/flutter/tree/master/examples/platform_services).

**Step 1: Create the Flutter platform client**

We start by adding support for updating our app's `State` class with the current
battery state.

First, we construct the channel. Since we need just a single platform message,
`getBatteryLevel`, representing a platform method call, we will use a
`PlatformMethodChannel`.

The client and host sides of a channel are connected through a channel name
passed in the channel constructor. In this example we are using `battery`. Note
that all channel names used in a single app must be unique; we recommend using a
naming pattern *TODO*.

```dart
class _PlatformServicesState extends State<PlatformServices> {
  // Construct platform channel inside State class.
  static const PlatformMethodChannel platform = const PlatformMethodChannel('battery');
  ...
  // TODO: Get battery level.
}
```

Next, we invoke a method on the method channel, specifying the concrete method
to call via a String `method` argument. We then use the returned result to update
our user interface:

```dart
  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Future<Null> _getBatteryLevel() async {
    final int result = await platform.invokeMethod('getBatteryLevel');
    batteryLevel = 'Battery level at $result % .';

    setState(() {
      _batteryLevel = batteryLevel;
    });
}
```

The call may fail -- for example if the platform does not support the platform
API (such as when running in a simulator), so next we add exception handling by
wrapping our `invokeMethod` call from the previous step in a try-catch
statement:

```dart
  try {
    final int result = await platform.invokeMethod('getBatteryLevel');
    batteryLevel = 'Battery level at $result % .';
  } on PlatformException catch (e) {
    batteryLevel = "Failed to get battery level: '${e.message}'.";
  }
```

**Step 2a: Add an iOS platform-specific implementation**

*TODO*

**Step 2b: Add an Android platform-specific implementation**

Start by opening the Android host portion of your Flutter app in Android Studio:

1. Start Android Studio

1. Invoke File > Open...

1. Navigate to the directory holding your Flutter app, and select the `android`
folder inside it. Click OK.

1. Open the file `MainActivity.java` located in the `java` folder in the Project
view.

Next, create a `FlutterMethodChannel` and set a `MethodCallHandler` inside the
`onCreate` method. Make sure to use the same channel name as was used on the
Flutter client side.

```java
private static final String CHANNEL = "battery";

@Override
public void onCreate(Bundle savedInstanceState) {

  super.onCreate(savedInstanceState);

  new FlutterMethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
      new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, Response response) {
          // TODO
        }
  });
}
```

Next, we add the actual Android Java code that uses the Android battery APIs to
retrieve the battery level. This code is exactly the same you would have written
in a native Android app.

Add the following as a new method in the activity class, below the `onCreate`
method:

```java
private int getBatteryLevel() {
  int batteryLevel = -1;
  if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
    BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
    batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
  } else {
    Intent intent = new ContextWrapper(getApplicationContext()).
        registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
    batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
        intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
  }

  return batteryLevel;
}
```

Finally, we complete the `onMethodCall` method we added earlier. We need to
handle a single platform method, `getBatteryLevel`, so we test for that in the
`call` argument. The implementation of this platform method simply calls the
Android code we wrote in the previous step, passes back a response for both the
success and error cases using the `response` argument.

```java
       @Override
       public void onMethodCall(MethodCall call, Response response) {
         if (call.method.equals("getBatteryLevel")) {
           int batteryLevel = getBatteryLevel();

           if (batteryLevel != -1) {
             response.success(batteryLevel);
           } else {
             response.error("UNAVAILABLE", "Battery level not available.", null);
           }

         } else {
           response.error("UNKNOWN_METHOD", call.method);
         }
       }
```

### Separate platform plugin code from UI code

If you expect to use your platform-specific code in multiple Flutter apps, it
can be useful to separate the code into a platform plugin located in a directory
outside your main application.

{% include note.html content="Separating platform plugins code from UI code is
currently not supported, but Flutter is expected to support this in the future." %}

## Publish a platform plugin {#publish}

{% include note.html content="Sharing of platform plugins is currently not
supported, but Flutter is expected to support this in the future." %}