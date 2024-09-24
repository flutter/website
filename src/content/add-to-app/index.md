---
title: Add Flutter to an existing app
short-title: Add to app
description: Adding Flutter as a library to an existing Android or iOS app.
---

## Add-to-app

If you are writing a new application from scratch, it is easy to [get started][]
using Flutter. But what if you already have an app that's not written in
Flutter, and it's impractical to start from scratch?

For those situations, Flutter can be integrated into your existing application
piecemeal, as a module. This feature is known as "add-to-app". The module can be
imported into your existing app to render part of your app using Flutter, while
the rest can be rendered using existing technology. This method can also be used
to run shared non-UI logic by taking advantage of Dart's portability and
interopability with other languages.

Add-to-app is currently supported on Android, iOS, and web.

Flutter supports two flavors of add-to-app:

- **Multi-engine**: supported on Android and iOS, allows running one or more
  instances of Flutter, each rendering a widget embedded into the host
  application. Each instance is a separate Dart program, running in isolation
  from other programs. Having multiple Flutter instances allows each instance to
  maintain independent application and UI state while using minimal memory
  resources. See more in the [multiple Flutters][] page.
- **Multi-view**: supported on the web, allows creating multiple
  [FlutterView][]s, each rendering a widget embedded into the host application.
  In this mode there's only one Dart program and all views and widgets can share
  objects.

Add-to-app supports integrating multiple Flutter views of any size, supporting
various use-cases. Two of the most common use-cases are:

* **Hybrid navigation stacks**: an app is made of multiple screens, some of
  which are rendered by Flutter, and others by another framework. The user can
  navigate from one screen to another freely, no matter which framework is used
  to render the screen.
* **Partial-screen views**: a screen in the app renders multiple widgets, some
  of which are rendered by Flutter, and others by another framework. The user
  can scroll and interact with any widget freely, no matter which framework is
  used to render the widget.

## Supported features

### Add to Android applications

{% render docs/app-figure.md, image:"development/add-to-app/android-overview.gif", alt:"Add-to-app steps on Android" %}

* Auto-build and import the Flutter module by adding a
  Flutter SDK hook to your Gradle script.
* Build your Flutter module into a generic
  [Android Archive (AAR)][] for integration into your
  own build system and for better Jetifier interoperability
  with AndroidX.
* [`FlutterEngine`][java-engine] API for starting and persisting
  your Flutter environment independently of attaching a
  [`FlutterActivity`][]/[`FlutterFragment`][] etc.
* Android Studio Android/Flutter co-editing and module
  creation/import wizard.
* Java and Kotlin host apps are supported.
* Flutter modules can use [Flutter plugins][] to interact
  with the platform.
* Support for Flutter debugging and stateful hot reload by
  using `flutter attach` from IDEs or the command line to
  connect to an app that contains Flutter.

### Add to iOS applications

{% render docs/app-figure.md, image:"development/add-to-app/ios-overview.gif", alt:"Add-to-app steps on iOS" %}

* Auto-build and import the Flutter module by adding a Flutter
  SDK hook to your CocoaPods and to your Xcode build phase.
* Build your Flutter module into a generic [iOS Framework][]
  for integration into your own build system.
* [`FlutterEngine`][ios-engine] API for starting and persisting
  your Flutter environment independently of attaching a
  [`FlutterViewController`][].
* Objective-C and Swift host apps supported.
* Flutter modules can use [Flutter plugins][] to interact
  with the platform.
* Support for Flutter debugging and stateful hot reload by
  using `flutter attach` from IDEs or the command line to
  connect to an app that contains Flutter.

See our [add-to-app GitHub Samples repository][]
for sample projects in Android and iOS that import
a Flutter module for UI.

### Add to web applications

Flutter can be added to any existing HTML DOM-based web app written in any
client-side Dart web framework ([jaspr][], [ngdart][], [over_react][], etc),
any client-side JS framework ([React][], [Angular][], [Vue.js][], etc),
any server-side rendered framework ([Django][], [Ruby on Rails][],
[Apache Struts][], etc), or even no framework (affectionately known as
"[VanillaJS][]"). The minimum requirement is only that your existing application
and its framework support importing JavaScript libraries, and creating HTML
elements for Flutter to render into.

To add Flutter to an existing app, build it normally, then follow the
[embedding instructions][] for putting Flutter views onto the page.

[jaspr]: https://pub.dev/packages/jaspr
[ngdart]: https://pub.dev/packages/ngdart
[over_react]: https://pub.dev/packages/over_react
[React]: https://react.dev/
[Angular]: https://angular.dev/
[Vue.js]: https://vuejs.org/
[Django]: https://www.djangoproject.com/
[Ruby on Rails]: https://rubyonrails.org/
[Apache Struts]: https://struts.apache.org/
[VanillaJS]: http://vanilla-js.com/
[embedding instructions]: {{site.docs}}/platform-integration/web/embedding-flutter-web#embedded-mode

## Get started

To get started, see our project integration guide for
Android and iOS:

<div class="card-grid">
  <a class="card" href="/add-to-app/android/project-setup">
    <div class="card-body">
      <header class="card-title card-center">
        Android
      </header>
    </div>
  </a>
  <a class="card" href="/add-to-app/ios/project-setup">
    <div class="card-body">
      <header class="card-title card-center">
        iOS
      </header>
    </div>
  </a>
  <a class="card" href="/platform-integration/web/embedding-flutter-web#embedded-mode">
    <div class="card-body">
      <header class="card-title card-center">
        Web
      </header>
    </div>
  </a>
</div>

## API usage

After Flutter is integrated into your project,
see our API usage guides at the following links:

<div class="card-grid">
  <a class="card" href="/add-to-app/android/add-flutter-screen">
    <div class="card-body">
      <header class="card-title card-center">
        Android
      </header>
    </div>
  </a>
  <a class="card" href="/add-to-app/ios/add-flutter-screen">
    <div class="card-body">
      <header class="card-title card-center">
        iOS
      </header>
    </div>
  </a>
  <a class="card" href="/platform-integration/web/embedding-flutter-web#manage-flutter-views-from-js">
    <div class="card-body">
      <header class="card-title card-center">
        Web
      </header>
    </div>
  </a>
</div>

## Limitations

Mobile limitations:

* Multi-view mode is not supported (multi-engine only).
* Packing multiple Flutter libraries into an
  application isn't supported.
* Plugins that don't support `FlutterPlugin` might have unexpected
  behaviors if they make assumptions that are untenable in add-to-app
  (such as assuming that a Flutter `Activity` is always present).
* On Android, the Flutter module only supports AndroidX applications.

Web limitations:

* Multi-engine mode is not supported (multi-view only).
* There's no way to completely "shutdown" the Flutter engine. The app can remove
  all the [FlutterView][] objects and make sure all data is garbage collected
  using normal Dart concepts. However, the engine will remain warmed up, even if
  it's not rendering anything.

[get started]: /get-started/codelab
[add-to-app GitHub Samples repository]: {{site.repo.samples}}/tree/main/add_to_app
[Android Archive (AAR)]: {{site.android-dev}}/studio/projects/android-library
[Flutter plugins]: {{site.pub}}/flutter
[`FlutterActivity`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterActivity.html
[java-engine]: {{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html
[ios-engine]: {{site.api}}/ios-embedder/interface_flutter_engine.html
[FlutterFire]: {{site.github}}/firebase/flutterfire/tree/master/packages
[`FlutterFragment`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterFragment.html
[`FlutterPlugin`]: {{site.api}}/javadoc/io/flutter/embedding/engine/plugins/FlutterPlugin.html
[`FlutterViewController`]: {{site.api}}/ios-embedder/interface_flutter_view_controller.html
[iOS Framework]: {{site.apple-dev}}/library/archive/documentation/MacOSX/Conceptual/BPFrameworks/Concepts/WhatAreFrameworks.html
[maintained by the Flutter team]: {{site.repo.packages}}/tree/main/packages
[multiple Flutters]: /add-to-app/multiple-flutters
[FlutterView]: https://api.flutter.dev/flutter/dart-ui/FlutterView-class.html
