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

Mobile devices offer many capabilities to your app which can be accessed through
platform-specific APIs, or APIs from third-party vendors. Flutter offers the following ways to 
integrate these platform services to extend your Flutter app.

+ **First-party services for Flutter:** For frequently used services, the Flutter SDK provides APIs 
to access first-party services that are supported across platforms. You can call these APIs 
directly in your Dart code by importing the 
['flutter/services'](http://docs.flutter.io/flutter/services/services-library.html) package. 
+ **Platform and Third-party Services for Flutter:** Flutter provides the
[`HostMessages`](http://docs.flutter.io/flutter/services/HostMessages-class.html) class which 
allows the Flutter framework to asynchronously exchange application-specific messages with a host 
application running on an iOS or Android device. This flexible approach lets you invoke 
platform-specific and third-party services on iOS and Android devices, while keeping a common user 
interface (UI) codebase.

You can use the [`HostMessages`](http://docs.flutter.io/flutter/services/HostMessages-class.html) 
class to build your own integrations with platform-specific services. The 
services that you invoke using the 
[`HostMessages`](http://docs.flutter.io/flutter/services/HostMessages-class.html) class must return 
non-graphical, data-only information. Examples include:

*   Geolocation
*   Contacts
*   File system
*   Network information
*   Sensors

You can also use the [`HostMessages`](http://docs.flutter.io/flutter/services/HostMessages-class.html) 
class to invoke APIs from third-party SDKs that run on iOS and Android devices.

## Understand How Flutter's Host Message Passing Works {#understand-how-flutters-host-message-passing-works}

Message passing with the [`HostMessages`](http://docs.flutter.io/flutter/services/HostMessages-class.html) 
class is asynchronous, bi-directional, and supports optional reply routing. Your messages must 
consist of strings encoded in JSON format; there is no facility for transferring handles to other 
objects along with messages. You are responsible for encoding and decoding messages that your app 
exchanges using this class.

To use the [`HostMessages`](http://docs.flutter.io/flutter/services/HostMessages-class.html), you 
must add a platform-specific Flutter component into the platform’s view hierarchy. For example, on 
iOS, you add a `FlutterViewController` object to interact with a `UIView`.  Similarly, on Android, 
you add a `FlutterView` object to your app’s `android.view.View` hierarchy. Your app can then 
communicate between the Dart and platform-specific parts of the app by using a simple 
message-passing interface.

## Download the hello_services example code {#the-hello_services-example}

The Flutter SDK comes with a reference example project called
[`hello_services`](https://github.com/flutter/flutter/tree/master/examples/hello_services)
that demonstrates how to connect to the geolocation service within an iOS or Android application
by using the [`HostMessages`](http://docs.flutter.io/flutter/services/HostMessages-class.html) class. 
The example comes with helper code to handle the passing of JSON-formatted messages to invoke 
platform services. 

{% include tip.html content="If your app needs to access platform-specific APIs on iOS or Android, we strongly encourage you to download the <code>hello_services</code> example and use it as the starter code to build your own Flutter app." %}

The following diagram shows how the `hello_services` app accesses the platform-specific geolocation 
services on iOS and Android by using the 
[`HostMessages`](http://docs.flutter.io/flutter/services/HostMessages-class.html) class.

 ![hello_services architecture](/images/hello_services.png)

**Fig 1.** Architecture of the `hello_services` sample.

The Dart, iOS, and Android-specific components are related as follows:

* In the Dart code, the sample app imports the
[`flutter/services.dart`](http://docs.flutter.io/flutter/services/services-library.html)
package. This package defines the
[`HostMessages`](http://docs.flutter.io/flutter/services/HostMessages-class.html) class,
which provides a bridge to send and listen for JSON-encoded messages exchanged with a platform
service on a <em>host</em> app (that is, the iOS or Android-specific parts of your app). The
<code>hello_services</code> app uses the static methods of the
[`HostMessages`](http://docs.flutter.io/flutter/services/HostMessages-class.html) class
in the [`State`](http://docs.flutter.io/flutter/material/State-class.html) object of a
stateful widget to make services requests, then updates the UI accordingly.

* On iOS, the sample app imports the Flutter framework library (`Flutter.h`) as a
dependency. The library defines the <code>FlutterViewController</code> class, which is a
[`UIViewController`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIViewController_Class/)
that provides a bridge from the
[`UIKit`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIKit_Framework/)
view hierarchy to the Flutter app. The `hello_services` app sets an instance of
[`FlutterViewController`](https://github.com/flutter/engine/blob/master/sky/shell/platform/ios/framework/Headers/FlutterViewController.h)
as the root view controller of its [`UIWindow`](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIWindow_Class/).

* On Android, the sample imports the `flutter.jar` file as a dependency. This JAR
defines the [`FlutterView`](https://github.com/flutter/engine/blob/master/sky/shell/platform/android/io/flutter/view/FlutterView.java)
class, which is an [`android.view.View`](https://developer.android.com/reference/android/view/View.html)
subclass that provides a bridge from the Android view hierarchy to the Flutter app. The
`hello_services` app creates an instance of [`FlutterView`](https://github.com/flutter/engine/blob/master/sky/shell/platform/android/io/flutter/view/FlutterView.java)
in its main activity.

## Modify key files for services {#modify-key-files-for-services}

To call platform-specific services using message passing, you may need to modify these key files 
and folders in the `hello_services` project:

* [`android/app/src/main/java/`](https://github.com/flutter/flutter/tree/master/examples/hello_services/android/app/src/main/java):
This folder contains the Java source files for the Android-specific part of your app. The file
organization in this folder conforms to the Android app module format for Gradle. The main activity
file
([`ExampleActivity.java`](https://github.com/flutter/flutter/blob/master/examples/hello_services/android/app/src/main/java/com/example/flutter/ExampleActivity.java))
contains the code that queries the Android system location API
([`android.location.LocationManager`](https://developer.android.com/reference/android/location/LocationManager.html)),
and returns the location data to the Flutter app.

* [`android/app/src/main/AndroidManifest.xml`](https://github.com/flutter/flutter/blob/master/examples/hello_services/android/app/src/main/AndroidManifest.xml):
The manifest file lists the Android activities that perform the services calls and any permissions
that your app needs to access the services.

* `android/local.properties`: Contains the configuration settings to build your Android app. See
the `hello_services` [README](https://github.com/flutter/flutter/blob/master/examples/hello_services/README.md)
to learn more about the properties you can configure.

* [`ios/HelloServices/`](https://github.com/flutter/flutter/tree/master/examples/hello_services/ios/HelloServices):
This folder contains the Objective-C source files for the iOS-specific part of your app. The
[`AppDelegate.m`](https://github.com/flutter/flutter/blob/master/examples/hello_services/ios/HelloServices/AppDelegate.m)
file handles message passing between iOS and the Flutter app, while the [`LocationProvider.m`](https://github.com/flutter/flutter/blob/master/examples/hello_services/ios/HelloServices/LocationProvider.m)
file implements the code that queries the iOS system location API
([`CLLocationManager`](https://developer.apple.com/library/ios/documentation/CoreLocation/Reference/CLLocationManager_Class/)).

* `ios/Flutter/Generated.xcconfig`: Contains the configuration settings to build your iOS app. See
the `hello_services` [README](https://github.com/flutter/flutter/blob/master/examples/hello_services/README.md)
to learn more about the properties you can configure.

* [`lib/main.dart`](https://github.com/flutter/flutter/blob/master/examples/hello_services/lib/main.dart):
The main entry point for your Flutter app. This source file is written in Dart syntax. The main
function uses the [`HostMessages`](http://docs.flutter.io/flutter/services/HostMessages-class.html)class,
which provides a high-level abstraction for passing messages to “hosts” of platform-specific
services.

## Add a service to your app {#add-a-service-to-your-app}

In your Dart code (`lib/main.dart` file):

1. Define a method to send a request to your target service (e.g. `_getLocation()`). You must encode
the request as a JSON message. You’ll typically invoke this method in a
[`State`](http://docs.flutter.io/flutter/material/State-class.html) object, when the user performs
an operation on the UI.
2. Define a messageHandler to process the messages returned by the target service
(e.g. `handleGetRandom()`), then add this handler to the
[`HostMessages`](http://docs.flutter.io/flutter/services/HostMessages-class.html) object.

In your iOS code:

1. In Xcode, open the `HelloServices` iOS project.
2. Implement a service provider (e.g. `LocationProvider`). The provider class must conform to the
`FlutterMessageListener` protocol (specifically, you must implement the
`(NSString*)didReceiveString:(NSString*)` function). If your app wants to connect asynchronously to
the service, use the [`FlutterAsyncMessageListener`](https://github.com/flutter/engine/blob/master/sky/shell/platform/ios/framework/Headers/FlutterAsyncMessageListener.h)
class. Your provider is where you put the business logic for your service calls.
3. In your [`AppDelegate`](https://github.com/flutter/flutter/blob/master/examples/hello_services/ios/HelloServices/AppDelegate.m),
initialize the service provider you defined earlier then add a message listener to that provider.

In your Android code:

1. In your main activity (e.g.
[`ExampleActivity.java`](https://github.com/flutter/flutter/blob/master/examples/hello_services/android/app/src/main/java/com/example/flutter/ExampleActivity.java)),
add a message listener to listen for your service calls.
2. Add the code to marshal and unmarshal the JSON messages for your service calls.
3. Add code to handle the business logic for your service calls.
4. In the AndroidManifest.xml, make sure to add permissions for your target service
(e.g. [`ACCESS_FINE_LOCATION`](https://developer.android.com/reference/android/Manifest.permission.html#ACCESS_FINE_LOCATION)).

## Build your app {#build-your-app}

If you are using the `hello_services` sample as your starting point, you should build your app
directly from the platform-specific tools.  Specifically, on iOS, you build your app using
Xcode and, on Android, you  build your app using
[Android Studio](https://developer.android.com/studio/index.html) (recommended) or
[Gradle from the command-line](https://developer.android.com/studio/build/building-cmdline.html).
To learn how to build the app for a specific platform, see the `hello_services`
[README](https://github.com/flutter/flutter/blob/master/examples/hello_services/README.md).

The platform-specific build system creates the application package in the normal way. This approach
eases the integration of third-party SDKs, which are designed to be integrated into the normal
build process for each platform they support.
