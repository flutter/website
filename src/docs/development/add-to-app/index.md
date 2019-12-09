---
title: Add Flutter to existing app
description: Adding Flutter as a library to an existing Android or iOS app.
---

## Add-to-app

It's sometimes not practical to rewrite your entire application in Flutter all
at once. For those situations, Flutter can be integrated into your existing
application in a piecemeal fashion as a library or module. That module can then
be imported into your Android or iOS (currently supported platforms) app to
render a part of your app's UI in Flutter. Or just to run shared Dart logic.

In a few steps, you can also bring the productivity and the expressiveness of
Flutter into your own app.

<div class="container">
  <div class="row">
    <div class="col-sm text-center">
      <figure class="figure">
        <img src="/images/add-to-app/android-overview.gif" class="figure-img img-fluid" alt="Add-to-app on Android" />
        <figcaption class="figure-caption">
          Android
        </figcaption>
      </figure>
    </div>
    <div class="col-sm">
      <figure class="figure text-center">
        <img src="/images/add-to-app/ios-overview.gif" class="figure-img img-fluid" alt="Add-to-app on iOS" />
        <figcaption class="figure-caption">
          iOS
        </figcaption>
      </figure>
    </div>
  </div>
</div>

As of Flutter release v1.12, add-to-app is supported for the basic scenario of
integrating one fullscreen Flutter instance at a time per app. It presently has
the _**following limitations**_:

- Running multiple Flutter instances or in partial screen views may have
  undefined behaviors.
- Using Flutter in background mode is still WIP.
- Packing a Flutter library into another sharable library or packing multiple
  Flutter libraries into an application is not currently supported.

## Supported features

### Add to Android applications

- Auto-build and import the Flutter module by adding a Flutter SDK hook to
  your Gradle script; or
- Build your Flutter module into a generic [Android Archive (AAR)](https://developer.android.com/studio/projects/android-library)
  for integration into your own build system and for better Jetifier interoperability
  with AndroidX.
- [FlutterEngine]({{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html)
  API for starting and persisting your Flutter environment independently of
  attaching a [FlutterActivity]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterActivity.html)/[FlutterFragment]({{site.api}}/javadoc/io/flutter/embedding/android/FlutterFragment.html) etc.
- Android Studio Android/Flutter co-editing and module creation/import wizard.
- Java and Kotlin host apps supported.
- Flutter modules can use [Flutter plugins](https://pub.dev/flutter) to interact
  with the platform. Android plugins should be [migrated to the V2 plugins APIs](/docs/development/packages-and-plugins/plugin-api-migration)
  for best add-to-app correctness.
- Support for Flutter debugging and stateful hot reload by using `flutter attach`
  from IDEs or the command line to connect to an app containing Flutter.

### Add to iOS applications
- Auto-build and import the Flutter module by adding a Flutter SDK hook to
 your CocoaPods and to your Xcode build phase; or
- Build your Flutter module into a generic [iOS Framework](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFrameworks/Concepts/WhatAreFrameworks.html)
  for integration into your own build system.
- [FlutterEngine]({{site.api}}/objcdoc/Classes/FlutterEngine.html) API for
  starting and persisting your Flutter environment independently of attaching a
  [FlutterViewController]({{site.api}}/objcdoc/Classes/FlutterViewController.html).
- Objective-C and Swift host apps supported.
- Flutter modules can use [Flutter plugins](https://pub.dev/flutter) to interact
  with the platform.
- Support for Flutter debugging and stateful hot reload by using `flutter attach`
  from IDEs or the command line to connect to an app containing Flutter.

See our [add-to-app GitHub Samples repository](https://github.com/flutter/samples/tree/master/experimental/add_to_app)
for sample projects in Android and iOS that import a Flutter module for UI.

## Get started

To get started, see our project integration guide for

<div class="card-deck mb-8">
  <a class="card" href="/docs/development/add-to-app/android/project-setup">
    <div class="card-body">
      <header class="card-title text-center m-0">
        Android
      </header>
    </div>
  </a>
  <a class="card" href="/docs/development/add-to-app/ios/project-setup">
    <div class="card-body">
      <header class="card-title text-center m-0">
        iOS
      </header>
    </div>
  </a>
</div>

## API usage

Once Flutter has been integrated into your project, see our API usage guides for

<div class="card-deck mb-8">
  <a class="card" href="/docs/development/add-to-app/android/add-flutter-screen">
    <div class="card-body">
      <header class="card-title text-center m-0">
        Android
      </header>
    </div>
  </a>
  <a class="card" href="/docs/development/add-to-app/ios/add-flutter-screen">
    <div class="card-body">
      <header class="card-title text-center m-0">
        iOS
      </header>
    </div>
  </a>
</div>
