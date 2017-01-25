---
layout: page
title: Accessing Platform and Third-Party Services in Flutter
sidebar: home_sidebar
permalink: /platform-services/
---

This guide describes how to connect your Flutter app to platform-specific or
third-party services that are available on iOS and Android devices.

* TOC
{:toc}

## Introduction

Mobile devices offer many capabilities to extend your app through platform-specific APIs, or APIs
from third-party vendors. Flutter offers the following ways to integrate platform-specific services
when building your app using the Flutter framework.

+ **First-party services for Flutter:** For frequently used services, the Flutter SDK provides
first-party APIs to access system services across platforms. You can call these APIs
directly in your Flutter app by importing the
['flutter/services'](https://docs.flutter.io/flutter/services/services-library.html) package.
+ **Platform and Third-party Services for Flutter:** Flutter provides the
[`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html) class which
allows your Flutter user interface (UI) code to asynchronously exchange application-specific
messages with the portions of your app that run on iOS or Android devices. This flexible approach
lets you invoke platform-specific and third-party APIs on iOS and Android devices, while
keeping a common UI codebase.

## Understand how host message passing works {#understand-how-host-message-passing-works}

You can use the [`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html)
class in the Flutter UI portion of your app to send messages to a *host* (that is, the iOS or
Android portion of your app that uses a shared UI codebase built with Flutter). The [`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html) class lets you implement your own integrations with
platform-specific services; you can send a request message to the host to call a
platform API then asynchronously retrieve the service data via a response message
from that host.

Your message must consist of string values. Message passing with the
[`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html) class is
asynchronous, bi-directional, and supports optional reply routing.

The services that you invoke using the
[`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html) class must return
non-graphical, data-only information. Examples include:

*   Geolocation
*   Contacts
*   File system
*   Network information
*   Sensors

You can also use the [`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html)
class to invoke APIs from third-party SDKs that run on iOS and Android devices.

To communicate between the
[`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html) class and
platform-specific APIs in the host, you must add the following Flutter components into
the host's view hierarchy.

+ **On iOS:** Add a [`FlutterViewController`](https://github.com/flutter/engine/blob/master/shell/platform/darwin/ios/framework/Headers/FlutterViewController.h)
object to interact with a `UIView`.
+ **On Android:** Add a [`FlutterView`](https://github.com/flutter/engine/blob/master/shell/platform/android/io/flutter/view/FlutterView.java) object
to your app’s `android.view.View` hierarchy.

## Add a service to your app {#add-a-service-to-your-app}

To create additional platform-specific or third-party service integrations using message passing,
follow these steps:

1. **Download the hello_services example.** If your app needs to access platform-specific
APIs on iOS or Android, you can download the [`hello_services`](https://github.com/flutter/flutter/tree/master/examples/hello_services) example and use it as the
starter code to build your own service integration. This reference example demonstrates how to
connect to the geolocation service within an iOS or Android application by using the
[`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html)
class.

    The following diagram shows how the `hello_services` app accesses platform-specific
services on iOS and Android.

    ![hello_services architecture](/images/hello_services.png)

    **Fig 1.** Architecture of the `hello_services` example.

    The Flutter UI and host-specific components are related as follows:

    * In the Flutter UI portion of the app, the [main app](https://github.com/flutter/flutter/blob/master/examples/hello_services/lib/main.dart) imports the
[`flutter/services.dart`](https://docs.flutter.io/flutter/services/services-library.html)
package, which defines the
[`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html) class. In the
[`State`](https://docs.flutter.io/flutter/widgets/State-class.html) class, the app makes
a service request by calling the static methods of the [`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html) class. If the service request is successful, the app
updates the UI accordingly with the data that the service returns.
    * On the iOS portion of the app, the [`AppDelegate`](https://github.com/flutter/flutter/blob/master/examples/hello_services/ios/Runner/AppDelegate.m) class sets an
instance of [`FlutterViewController`](https://github.com/flutter/engine/blob/master/shell/platform/darwin/ios/framework/Headers/FlutterViewController.h)
as the root view controller of its [`UIWindow`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIWindow_Class/).
The [`FlutterViewController`](https://github.com/flutter/engine/blob/master/shell/platform/darwin/ios/framework/Headers/FlutterViewController.h)
class provides a bridge connecting the [`UIKit`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIKit_Framework/)
view hierarchy to the Flutter UI code. To use the [`FlutterViewController`](https://github.com/flutter/engine/blob/master/shell/platform/darwin/ios/framework/Headers/FlutterViewController.h)
class, the iOS portion of the app must import the `Flutter.h` library.
    * On the Android portion of the app, the [main activity](https://github.com/flutter/flutter/blob/master/examples/hello_services/android/app/src/main/java/com/example/flutter/ExampleActivity.java) sets as its
content view an instance of the [`FlutterView`](https://github.com/flutter/engine/blob/master/shell/platform/android/io/flutter/view/FlutterView.java)
class, which provides a bridge connecting the Android view hierarchy to the Flutter UI code.
To use the [`FlutterView`](https://github.com/flutter/engine/blob/master/shell/platform/android/io/flutter/view/FlutterView.java)
class, the Android portion of the app must specify the flutter gradle plugin
dependency in its
[`build.gradle`](https://github.com/flutter/flutter/blob/master/examples/hello_services/android/app/build.gradle) file.

2. **Establish the service bindings.** The [`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html)
class establishes connections with services.

   You can register a callback for receiving
   messages through the [`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html)
   class by calling the
   [`setJSONMessageHandler()`](https://docs.flutter.io/flutter/services/PlatformMessages/setJSONMessageHandler.html)
   or [`setStringMessageHandler()`](https://docs.flutter.io/flutter/services/PlatformMessages/setStringMessageHandler.html)
   static methods.

   For example, this snippet shows how you might initialize a service binding
   and register a message handler callback in the `main()` function.

   ```dart
   import 'dart:async';
   import 'dart:math';

   import 'package:flutter/material.dart';
   import 'package:flutter/services.dart';

   final Random random = new Random();

   void main() {
     runApp(new Center(child: new Text('Random Number Generator')));
     PlatformMessages.setJSONMessageHandler('getRandom', handleGetRandom);
   }

   Future<dynamic> handleGetRandom(Map<String, dynamic> message) async {
     final double min = message['min'].toDouble();
     final double max = message['max'].toDouble();

     return <String, double>{
       'value': (random.nextDouble() * (max - min)) + min
     };
   }
   ```

3. **Add a service invocation call in the Flutter UI.** In your
[`State`](https://docs.flutter.io/flutter/widgets/State-class.html) class, use
the [`PlatformMessages`](https://docs.flutter.io/flutter/services/PlatformMessages-class.html)
class to call a target service on the host. You'll typically peform this
operation when the user performs a UI interaction.

   You can construct your service invocation call as a JSON-encoded string,
   then call the [`sendJSON`](https://docs.flutter.io/flutter/services/PlatformMessages/sendJSON.html)
   method and pass this string as a parameter.

   For example, the following snippet shows how you might asynchronously invoke
   the geolocation service.

   ```dart
   class HelloServices extends StatefulWidget {
     @override
     _HelloServicesState createState() => new _HelloServicesState();
   }

   class _HelloServicesState extends State<HelloServices> {
     double _latitude;
     double _longitude;

     Future<Null> _getLocation() async {
       final Map<String, String> message
         = <String, String>{'provider': 'network'};
       final Map<String, dynamic> reply
         = await PlatformMessages.sendJSON('getLocation', message);
       // If the widget was removed from the tree while the message was
       // in flight, we want to discard the reply rather than
       // calling setState to update our non-existant appearance.
       if (!mounted)
         return;
       setState(() {
         _latitude = reply['latitude'].toDouble();
         _longitude = reply['longitude'].toDouble();
       });
     }

     @override
     Widget build(BuildContext context) {
       // ...
       return new Text('Latitude: $latitude, Longitude: $longitude');
     }
   }
   ```

4. **Add a service provider in the host (iOS).** Follow these steps if your
app needs to invoke a platform-specific or third-party API on iOS:

    1. In the example project, the
    [`ios/HelloServices/Runner`](https://github.com/flutter/flutter/tree/master/examples/hello_services/ios/Runner)
    folder contains the Objective-C source files for the iOS-specific part of
    the app. In Xcode, open this folder as an iOS project.
    2. In your iOS project, create a service provider to handle the service request message,
    locally invoke the service, and return a response message to the Flutter UI portion of the app.
    Your service provider should conform to one of these protocols:

       + [`FlutterMessageListener`](https://github.com/flutter/engine/blob/master/shell/platform/darwin/ios/framework/Headers/FlutterMessageListener.h):
       Implement this protocol if the request message does not require a reply, or if the Flutter UI
       portion of your app can reply to the message synchronously.
       + [`FlutterAsyncMessageListener`](https://github.com/flutter/engine/blob/master/shell/platform/darwin/ios/framework/Headers/FlutterAsyncMessageListener.h): Implement this protocol if the request message requires a reply and the code that creates
       the reply is asynchronous.

       For an example of how to implement a service provider, see the [`LocationProvider.m`](https://github.com/flutter/flutter/blob/master/examples/hello_services/ios/Runner/LocationProvider.m) and
       [`AppDelegate.m`](https://github.com/flutter/flutter/blob/master/examples/hello_services/ios/Runner/AppDelegate.m) classes from the example project.
    3. Create or modify a `Flutter/Generated.xcconfig` file to specify the configuration settings
    for building your iOS app. See the project [README](https://github.com/flutter/flutter/blob/master/examples/hello_services/README.md) to learn more about the
    iOS-specific properties you can configure.

5. **Add a service provider in the host (Android).** Follow these steps if your app needs to invoke
a platform-specific or third-party API on Android:

    1. In the example project, the [`android/app`](https://github.com/flutter/flutter/tree/master/examples/hello_services/android/app) folder
    contains the Java source files for the Android-specific portion of the app. The file
organization in this folder conforms to the Android app module format for Gradle. In Android
Studio, open the `app` folder as an Android project.
    2. In your Android project, create a service provider to handle the service request message,
    locally invoke the service, and return a response message to the Flutter UI portion of the app.
    For each service you want to invoke, attach a message listener to the [`FlutterView`](https://github.com/flutter/engine/blob/master/shell/platform/android/io/flutter/view/FlutterView.java)
    object and specify the service provider it calls when the `onReply()` event is triggered.
    For an example of how to implement a service provider, see the
[`ExampleActivity.java`](https://github.com/flutter/flutter/blob/master/examples/hello_services/android/app/src/main/java/com/example/flutter/ExampleActivity.java) class from the example project.
    3. Modify the [`AndroidManifest.xml`](https://github.com/flutter/flutter/blob/master/examples/hello_services/android/app/src/main/AndroidManifest.xml)
    file to add any permissions necessary to invoke your target service
(for example, the geolocation service needs the [`ACCESS_FINE_LOCATION`](https://developer.android.com/reference/android/Manifest.permission.html#ACCESS_FINE_LOCATION) permission).
    4. Create or modify a `local.properties` file to specify the configuration settings for
    building your Android app. See the project [README](https://github.com/flutter/flutter/blob/master/examples/hello_services/README.md) to learn more about the
    Android-specific properties you can configure.

6. **Build your app.** You should build your app directly from the platform-specific tools.

   + **On iOS:** Build your app using Xcode.
   + **On Android:** Build your app using Android Studio or Gradle from the command-line.

   To learn how to build the app for a specific platform, see the `hello_services`
[README](https://github.com/flutter/flutter/blob/master/examples/hello_services/README.md).

    The platform-specific build system creates the application package in the normal way. This approach
eases the integration of third-party SDKs, which are designed to be integrated into the normal
build process for each platform they support.
