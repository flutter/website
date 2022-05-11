---
title: Happy paths recommendations
description: Recommended packages and plugins for adding functionality to your app.
---


## Ads ![Ads happy path image](/assets/images/docs/happy-paths/HappyPaths_Icon_Ad_3d_001.png){:width="20%"}  

Are you looking to monetize your mobile app? You can do that by adding in-app 
ads using the `google_mobile_ads` package. You’ll need to register a free 
account with [AdMob](https://developers.google.com/admob/flutter/quick-start) 
and you can then leverage one or more AdMob features, including the following:  

* Several ad formats: Banner, full-screen, native, and rewarded.
* Control over when ads display. For example, in between levels of a game, 
  after completing a task, or before starting a new game 
* Monetization reports to help you make decisions about your app. 

#### Useful links
{:.no_toc}

* [Get started with the AdMob](https://developers.google.com/admob/flutter/quick-start) guide
* [Create an AdMob account](https://admob.google.com/home/get-started/) tutorial
* [`google_mobile_ads`]({{site.pub-pkg}}/google_mobile_ads/install) package on pub.dev


## Background processing ![Background processing happy path image](/assets/images/docs/happy-paths/HappyPaths_Icon_Processing_3d_001.png){:width="20%"}

The background processing path shows you how to run a Dart function 
in the background on mobile devices. With background processing, 
you can perform tasks like making an HTTP request, running an 
expensive calculation, or displaying a notification in another isolate
(similar to a lightweight thread).  

One way to incorporate background processing in your mobile app is through the 
[WorkManager]({{site.pub-pkg}}/workmanager) plugin. 
This plugin enables headless execution of Dart code in the background. 

{{site.alert.secondary}}
  **Is there a difference between a package and a plugin?** Yes, there is! 
  Both are packages, but a plugin is a type of package that contains 
  platform-specific code (such as Kotlin, Java, Swift, Objective C) that 
  communicates with the underlying platform. For more information, see 
  [Using packages]({{site.url}}/development/packages-and-plugins/using-packages).
{{site.alert.end}}  
  
Some features of WorkManager include:
* Control over how many times a job should run: once or periodically
* Ability to apply constraints on jobs like checking for a network connection, 
  only running when the device is charging, or only running when a device is 
  idle (Android only)  
 
#### Useful links
{:.no_toc}

* [Android setup]({{site.github}}/fluttercommunity/flutter_workmanager/blob/main/ANDROID_SETUP.md)
* [iOS setup]({{site.github}}/fluttercommunity/flutter_workmanager/blob/main/IOS_SETUP.md)


## Geolocation ![Geolocation happy path image](/assets/images/docs/happy-paths/HappyPaths_Icon_Geolocation_3d_001.png){:width="20%"}

Geolocation, the ability to determine where in the world a user is located, is 
critical functionality for many applications; for example, shopping apps need 
to calculate shipping, fitness apps need to track distance traveled, and so on. 
The plugins in Flutter's ecosystem offer a number of features to help build 
these experiences.  

A plugin that provides this functionality is the 
[`geolocator`]({{site.pub-pkg}}/geolocator) plugin, rated as a
[Flutter favorite]({{site.url}}/development/packages-and-plugins/favorites). 
With this plugin, you can check and request permission, fetch a one-time location, 
and even provide a stream of constantly updated values as a user moves about.  

Features include:
* Ability to get a device's current location
* Receive location updates
* Ability to determine whether a devices's location services are enabled  

#### Useful links
{:.no_toc}

* [How to get a user's location with the geolocator plugin](https://www.digitalocean.com/community/tutorials/flutter-geolocator-plugin) tutorial
* [`geolocator`]({{site.pub-pkg}}/geolocator) plugin

## Immutable data  ![Immutable data happy path image](/assets/images/docs/happy-paths/HappyPaths_Icon_ImmutableData_3d_001.png){:width="20%"}

For an easy way to represent immutable application data, 
check out two plugins that provide ways to handle and manipulate 
immutable data: [`freezed`]({{site.pub-pkg}}/freezed) and 
[`json_serializable`]({{site.pub-pkg}}/json_serializable), both rated as 
[Flutter favorites]({{site.url}}/development/packages-and-plugins/favorites). 

These plugins can be used independently, 
but are also great when used together. 
The `freezed` package handles in-memory objects 
and `json_serializable` maps those immutable 
objects to and from the JSON format.   

#### Useful links
{:.no_toc}

* Freezed
  * [`freezed` package]({{site.pub-pkg}}/freezed#how-to-use) video
  * [`freezed`]({{site.pub-pkg}}/freezed#how-to-use) package  
* json_serializable
  * [Serializing JSON using json_serializable]({{site.url}}/development/data-and-backend/json#serializing-json-using-code-generation-libraries)
  * [`json_serializable`]({{site.github}}/google/json_serializable.dart/tree/master/example) 
    example on GitHub
  * [`json_serializable`]({{site.pub-api}}/json_serializable/latest/) package

## Structured local storage ![Structured local storage happy path image](/assets/images/docs/happy-paths/HappyPaths_Icon_Storage_3d_001.png){:width="20%"}

Structured local storage increases app performance and improves the user 
experience by selectively saving expensive or slow data on a user’s device. 
This path suggests two plugins for local persistence: `drift` and `hive`. 
Which plugin you choose depends on your needs.  

Drift, rated a [Flutter favorite]({{site.url}}/development/packages-and-plugins/favorites), offers a fully-typed object relational mapping (ORM) around SQLite, 
with support on all Flutter platforms. Developers who require a fully 
relational database on their users' device will benefit most from this package.

Hive offers a fully-typed object document mapping (ODM) around a custom 
storage solution, with support on all Flutter platforms. Developers who do not 
require a fully relational database, especially if they use document-based storage 
on their server (like Cloud Firestore) will benefit most from this package.

#### Useful links
{:.no_toc}

* Drift:
  * [The boring flutter development show using Drift]({{site.youtube-site}}/watch?v=9o_M-LjO4no) video
  * [Fluent sqlite database]({{site.youtube-site}}/watch?v=zpWsedYMczM&t=9s)
    video that references Drift’s previous name, Moor
  * [`drift`]({{site.pub-pkg}}/drift) package
* Hive:
  * [Hive NoSQL Database IN 16 Minutes]({{site.youtube-site}}/watch?v=w8cZKm9s228) video
  * [`hive`]({{site.pub-pkg}}/hive) package  

  
## Web sockets ![Web Sockets Happy path image](/assets/images/docs/happy-paths/HappyPaths_Icon_WebSockets_3d_001.png){:width="20%"}

Web sockets enable communication between Flutter clients and servers. 
This path suggests two packages to use when installing and using web sockets.

Use the [`web_socket_channel`]({{site.pub-pkg}}/web_socket_channel) 
package for client-side web socket connections, and the 
[`web_socket_connections`]({{site.pub-pkg}}/shelf_web_socket) package 
for server-side Dart web sockets.  

#### Useful links
{:.no_toc}

* web_socket_channel:
  * [`Work with WebSockets`]({{site.url}}/cookbook/networking/web-sockets) 
    cookbook recipe
  * [`web_socket_channel`]({{site.github}}/dart-lang/web_socket_channel/blob/master/example/example.dart) 
    example on GitHub
  * [`web_socket_channel`]({{site.pub-pkg}}/web_socket_channel) package

* shelf_web_socket
  * [`shelf_web_socket`]({{site.github}}/dart-lang/shelf_web_socket#web-socket-handler-for-shelf) 
    example on GitHub
  * [`shelf_web_socket`]({{site.pub-pkg}}/shelf_web_socket) package
