---
title: "Modern Flutter Plugin Development"
description: >-
  Explore modern Flutter plugin architecture,
  including federated plugins and platform implementations.
publishDate: 2020-04-30
author: csells
image: images/1yM2BlF_ckdUzoDnSdAjPoA.webp
category: engineering
layout: blog
---

_Authored by Amir Hardon, Chris Sells, Collin Jackson, Harry Terkelsen, and Matt Carroll_

2019 was a big year for advancements in technology for Flutter plugin authors. We introduced the Android Plugin API 2.0, which provides a more robust and full-featured way to implement Android support in your plugins. We updated the `pubspec.yaml` format to make it possible to clearly specify Android and iOS support but also web, macOS, Windows, and Linux. Furthermore, as we push Flutter to support multiple platforms, we enabled federation, making it possible for multiple teams with different expertise to bring their code together into a seamless experience for the Flutter developer using the plugin. And finally, we made great strides in testing plugins, with more to come.

## Android Plugin API 2.0

In December of 2019, Flutter published a new version of its Android embedding. This is the Android code that is responsible for integrating Flutter within an Android app. It includes classes like `FlutterActivity`, `FlutterFragment`, `FlutterView`, and `FlutterEngine`. The v2 Android embedding includes support for standard Android lifecycle events and the separation of Flutter execution from the Android UI, which were missing in the v1 Android embedding. During the development of the v2 Android embedding it became clear that the existing API for Flutter plugins was insufficient to handle the new capabilities of the v2 Android embedding. A new Android plugin API was needed. We’ll discuss that API and how to use it.

First, it is important to understand the `FlutterEngine` class within the v2 Android embedding. A `FlutterEngine` object represents a single Flutter execution context. This means that a `FlutterEngine` controls a Dart isolate (your Dart code that begins with an entrypoint like `main`). It also means that a `FlutterEngine` sets up a number of standard platform channels that all Flutter apps require; it includes support for platform views, it knows how to paint a texture with a Flutter UI, and it handles all other fundamental requirements to execute a single Flutter/Dart app. Additionally, an Android app may contain multiple `FlutterEngines` at the same time.

The fundamental concept of “adding a plugin” to a Flutter app means applying that plugin to a single `FlutterEngine`. For example, if a Flutter app requires access to a camera, that capability is achieved by registering a camera plugin with a specific `FlutterEngine` instance. This registration is done for you automatically with a `GeneratedPluginRegistrant`, but it is important to understand that every `FlutterEngine` maintains its own set of Flutter plugins.

<DashImage figure src="images/1V4h-nurkyQZvRIjJFifWUQ.webp" />

In the old v1 Android embedding, all plugins were initialized and configured at the very beginning of the Android app and there was only ever one Flutter experience. In the v2 embedding, we make no assumption about when a plugin is initialized, and a plugin must be initialized once per `FlutterEngine`. As a result, all Flutter plugins for Android must now support instantiation instead of static initialization, and they must support being attached to, and detached from a `FlutterEngine`. The following code samples demonstrate the difference between the old v1 plugin initialization implementation and the new v2 plugin initialization process.

**Old plugin initialization**

```java
class MyOldPlugin {
  public static void registerWith(PluginRegistrar registrar) {
    // Obtain any references that the plugin requires from the
    // registrar.
    //
    // This plugin is now considered "initialized" and "attached"
    // to a Flutter experience.
  }
}
```

**New plugin initialization**

```java
class MyNewPlugin implements FlutterPlugin {
  public MyNewPlugin() {
    // All Android plugin classes must support a no-args
    // constructor. A no-arg constructor is provided by
    // default without declaring one, but we include it here for
    // clarity.
    //
    // At this point your plugin is instantiated, but it
    // isn't attached to any Flutter experience. You should not
    // attempt to do any work here that is related to obtaining
    // resources or manipulating Flutter.
  }

  @override
  public void onAttachedToFlutterEngine(FlutterPluginBinding binding) {
    // Your plugin is now attached to a Flutter experience
    // represented by the given FlutterEngine.
    //
    // You can obtain the associated FlutterEngine with
    // binding.getFlutterEngine()
    //
    // You can obtain a BinaryMessenger with
    // binding.getBinaryMessenger()
    //
    // You can obtain the Application context with
    // binding.getApplicationContext()
    //
    // You cannot access an Activity here because this
    // FlutterEngine is not necessarily displayed within an
    // Activity. See the ActivityAware interface for more info.
  }

  @override
  public void onDetachedFromFlutterEngine(FlutterPluginBinding binding) {
    // Your plugin is no longer attached to a Flutter experience.
    // You need to clean up any resources and references that you
    // established in onAttachedToFlutterEngine().
  }
}
```

As shown in the new plugin API, your plugin must wait until `onAttachedToFlutterEngine()` completes before taking any meaningful actions, and it must respect `onDetachedFromFlutterEngine()` by releasing all resources. It’s possible that your plugin will be attached and detached multiple times.

Additionally, your plugin must not depend upon an `Activity` reference within `onAttachedToFlutterEngine()`. Just because your plugin is attached to a Flutter experience doesn’t mean that the Flutter experience is being displayed in an Activity. **This is one of the most significant differences between the old and new plugin APIs.** In the old v1 plugin API, plugin authors could depend upon an `Activity` being available immediately and permanently. This is no longer true.

Plugins that require access to an `Activity` must implement a 2nd interface called `ActivityAware`. The `ActivityAware` interface adds callbacks to your plugin class that tell your plugin when it’s sitting in an `Activity`, when that `Activity` goes through config changes, and when your plugin is no longer sitting in an `Activity`. Your plugin must respect these callbacks. The following example shows the outline of an `ActivityAware` plugin:

```java
class MyNewPlugin implements FlutterPlugin, ActivityAware {
  @override
  public void onAttachedToFlutterEngine(FlutterPluginBinding binding) {
    // ...
  }

  @override
  public void onDetachedFromFlutterEngine(FlutterPluginBinding binding) {
    // ...
  }

  @override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
    // Your plugin is now associated with an Android Activity.
    //
    // If this method is invoked, it is always invoked after
    // onAttachedToFlutterEngine().
    //
    // You can obtain an Activity reference with
    // binding.getActivity()
    //
    // You can listen for Lifecycle changes with
    // binding.getLifecycle()
    //
    // You can listen for Activity results, new Intents, user
    // leave hints, and state saving callbacks by using the
    // appropriate methods on the binding.
  }

  @override
  public void onDetachedFromActivityForConfigChanges() {
    // The Activity your plugin was associated with has been
    // destroyed due to config changes. It will be right back
    // but your plugin must clean up any references to that
    // Activity and associated resources.
  }

  @override
  public void onReattachedToActivityForConfigChanges(
    ActivityPluginBinding binding
  ) {
    // Your plugin is now associated with a new Activity instance
    // after config changes took place. You may now re-establish
    // a reference to the Activity and associated resources.
  }

  @override
  public void onDetachedFromActivity() {
    // Your plugin is no longer associated with an Activity.
    // You must clean up all resources and references. Your
    // plugin may, or may not ever be associated with an Activity
    // again.
  }
}
```

The new plugin API explicitly recognizes that a plugin may or may not have an `Activity` associated with it, and that any such `Activity` might be destroyed and recreated at any time due to configuration changes. These concerns should be familiar to all Android developers.

The key to writing a plugin for Flutter’s v2 Android embedding is to respect each plugin lifecycle callback that your plugin implements. As long as you wait until the right time to establish references, and you release those references at the appropriate time, your plugin will work as intended.

<DashImage figure src="images/1I4K18qd0H98EZixwMmWGmg.webp" />

Some plugins, like a camera plugin, only make sense when an `Activity` is available. So what are these plugins to do? In the case of UI-only plugins, those plugins can wait until `onAttachedToActivity()` executes before doing any work. Then, in `onDetachedFromActivity()`, those plugins can clean up all references and essentially deactivate themselves. There is no requirement that a plugin do anything special within `onAttachedToFlutterEngine()`. It’s OK for a plugin to only do work when attached to an `Activity`.

For more details about how to migrate your Android plugin from the v1 API to the v2 API, see [Supporting the new Android plugins APIs](https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration) on flutter.dev.

## New `pubspec` format

Traditionally a Flutter plugin was a single package that enabled Flutter applications running on Android and iOS to access platform-specific functionality; technically a plugin was composed of Dart code backed by Android-specific and iOS-specific code. Even though the assumption that any Flutter plugin supports Android and iOS wasn’t accurate (for example, the `android_intent` plugin only supports Android), it was chosen to initially design the plugin ecosystem under that assumption. The assumption was mostly correct, which meant the overall cost for the few instances where it was wrong was low, and the simplified assumption enabled rapid progress and focus.

With Flutter growing to support many more platforms we have decided to lose this simplifying assumption as:

1. We expect many plugins to only support a subset of Flutter’s supported platforms (even more so with federated plugins, described below).

1. We want to unlock tooling features that require knowledge of a plugin’s supported platforms (such as a smarter pub.dev search and platform-informed tool operations).

The core missing piece was a clear indication for which platforms a plugin supports, and so we’ve redesigned the Flutter plugin’s `pubspec` schema around multi-platform support.

Under the previous `pubspec` schema the `flutter.plugin` key contained the different plugin configuration bits, instead we’ve introduced a new key per platform under the `flutter.plugin.platforms` key with the platform-specific plugin configuration. For example, here’s what the `pubspec` for a plugin that supports Android, iOS, macOS, and web looks like:

```yaml
flutter:
  plugin:
    platforms:
      android:
        package: com.example.hello
        pluginClass: HelloPlugin
      ios:
        pluginClass: HelloPlugin
      macos:
        pluginClass: HelloPlugin
      web:
        pluginClass: HelloPlugin
        fileName: hello_web.dart

environment:
  sdk: ">=2.1.0 <3.0.0"
  # Flutter versions prior to 1.10 did not support
  # the flutter.plugin.platforms map.
  flutter: ">=1.10.0"
```

A plugin that supports a subset of these platforms can omit platform keys from the platforms map, for example:

```yaml
flutter:
  plugin:
    platforms:
      android:
        package: com.example.hello
        pluginClass: HelloPlugin
      ios:
        pluginClass: HelloPlugin

environment:
  sdk: ">=2.1.0 <3.0.0"
  # Flutter versions prior to 1.10 did not support
  # the flutter.plugin.platforms map.
  flutter: ">=1.10.0"
```

Note that requiring a Flutter SDK greater than 1.10.0 is required when using the new schema as this is the first version where the Flutter tool supported this schema.

### Migrating an existing plugin to use the new schema

This section uses the battery plugin as an example and walks through the migration of a sample plugin from the previous schema to the new one.

The most important thing to do when migrating is to only declare support for platforms that are supported by the plugin (this was not possible previously which meant that plugins which only supported Android had to include a no-op iOS implementation and vice versa).

These are the relevant parts of a sample plugin’s `pubspec.yaml` file prior to the migration:

```yaml
name: sample
version: 0.3.1+5

flutter:
  plugin:
    androidPackage: io.flutter.plugins.sample
    iosPrefix: FLT
    pluginClass: SamplePlugin

environment:
  flutter: ">=1.6.7 <2.0.0"
```

Assuming that the plugin supports Android and iOS, upgrading to the new schema involves:

* Increasing the minimally required Flutter version to 1.10.0 (which is the first version that supports the new schema).

* A minor version bump

* Replacing the current fields in `flutter.plugin` with the new platforms field.

* If the `iosPrefix` field was previously used, renaming the main iOS plugin file (more details below).

The updated `pubspec` for this plugin looks like:

```yaml
name: sample
version: 0.3.2

flutter:
  plugin:
    platforms:
      android:
        package: io.flutter.plugins.sample
        pluginClass: SamplePlugin
      ios:
        pluginClass: FLTSamplePlugin

environment:
  flutter: ">=1.10.0 <2.0.0"
```

Note that since the plugin supports Android and iOS these are the only keys under the flutter.plugin.platforms. The value of `flutter.plugin.androidPackage` field in the old schema becomes the value of `flutter.plugin.platforms.android.package`. The new schema has no equivalent for the `iosPrefix` field, as the `pluginClass` for iOS has a dedicated key we can use the prefix in the `flutter.plugin.platforms.ios.pluginClass` field which is set to `FLTSamplePlugin`.

#### Plugins that were previously using the iosPrefix field

The previous schema implied an inconsistency between the iOS plugin’s main interface name and its file name, e.g. for this sample plugin as defined with the previous schema, there would be a `SamplePlugin.h` file that declares an `FLTSamplePlugin` interface. This kind of inconsistency is no longer supported, which means the `SamplePlugin.h` file must be renamed to `FLTSamplePlugin.h` when upgrading to the new schema. Plugins that did not use the `iosPrefix` key don’t require renaming any files.

For more information about development plugins that support any number of platforms, see [Developing plugin packages](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin) on flutter.dev.

## Federation

Not only does the new `pubspec` schema allow you to specify exactly which platforms your plugin supports, it also gives you the flexibility to spread implementations across multiple packages. In the past, the plugin’s Dart code, the Android Java (or Kotlin) code, and the iOS Objective-C (or Swift) code all needed to be in the same Dart package. Now, if we want to add support for another platform (Web, Mac OS, Windows, etc.), it doesn’t need to be in the same package. Plugins that are distributed across multiple packages are called *federated plugins*.

Federated plugins have several advantages over single-package plugins, including:

* A plugin author does not need to have domain expertise for every supported Flutter platform (Android, iOS, Web, Mac OS, etc.).

* You can add support for a new platform without the original plugin author needing to review and pull in your code.

* Each package can be maintained and tested separately.

So, how exactly do you create a *federated plugin*? Let’s start with some terminology:

* **app-facing package:** This is the package you would import in your app in order to use the plugin. For example, `package:url_launcher` is an app-facing package. The app-facing package declares the app-facing API and works with various *platform packages* to perform platform-specific functionality.

* **platform package**: This is a package that implements the platform-specific functionality needed by the *app-facing package*. An example is `package:url_launcher_web`: this package is used by `package:url_launcher` to launch URLs when running the Flutter app on the web platform. Platform packages should not be imported in the app, they are only for use by the *app-facing package* to call into the required platform-specific code.

* **platform interface package**: This is the glue that holds the *app-facing package* and the *platform packages* together. Whereas the *app-facing package* declares an API that can be called from a Flutter app, the *platform interface package* declares an interface that each *platform package* must implement in order to support the *app-facing package*. Having a single package that defines this interface ensures that all *platform packages* implement the same functionality in a uniform way.

<DashImage figure src="images/1yM2BlF_ckdUzoDnSdAjPoA.webp" />

The figure above shows the dependency graph between the app, the app-facing package, the platform packages, and the platform interface package. The app only ever imports the app-facing package (in this case `package:url_launcher`).

How does the *platform interface* glue together the app-facing package and the correct platform package? In the past, there were no “platform packages”, only a subfolder for the Android code and another subfolder for the iOS code. The app-facing package communicated to the platform code via a `MethodChannel`. You can think of the `MethodChannel` as the de-facto “platform interface” because the app-facing package calls into the `MethodChannel`, and the corresponding platform code must be listening on a `MethodChannel` for the correct methods with the correct arguments. There is no way to statically confirm that the Android code or iOS code is listening for the correct `MethodChannel` calls.

### Old way of launching a URL

```dart
Future<void> launch(String url) {
  channel.invokeMethod('launch', {
    'url': url,
  });
}
```

In the federated plugin structure, the *platform interface package* replaces the `MethodChannel`. The platform-specific functionality that the app-facing package needs from the platform packages is encapsulated in a platform interface. In our example, the app-facing package is `package:url_launcher`, and the only platform-specific functionality it needs is the ability to launch a URL on the given platform. A (very) simple platform interface would look like:

```dart
abstract class UrlLauncherPlatform {
  /// Launches the given [url].
  Future<void> launch(String url);

  /// The live "instance" of this platform interface.
  ///
  /// This is set when the platform package is registered,
  /// usually when the platform is initializing.
  ///
  /// For example, the web platform package
  /// (package:url_launcher_web) would extend this class with an
  /// implementation that launched the URL in a new tab,
  /// and at initialization time would set itself to be the live
  /// instance with:
  ///
  ///     UrlLauncherPlatform.instance = WebUrlLauncher();
  static UrlLauncherPlatform instance;
}
```

Now, instead of calling on the `MethodChannel`, the app-facing package would call into the platform interface.

### New way of launching a URL

```dart
Future<void> launch(String url) {
  return UrlLauncherPlatform.instance.launch(url);
}
```

So, the *app-facing package* calls into the *platform interface*. How does the platform interface glue into the *platform packages*? The platform packages implement the platform interface, and register themselves as the default instance of the platform interface when the platform is initializing.

For example, if we wanted to write `package:url_launcher_web`, we would only need to write a class that extends `UrlLauncherPlatform` and launches a URL for the web platform. The code would look something like this:

```dart
class UrlLauncherWeb extends UrlLauncherPlatform {
  /// The web platform automatically calls this when the app
  /// initializes.
  static void registerWith(Registrar registrar) {
    var webLauncher = UrlLauncherWeb();
    UrlLauncherPlatform.instance = webLauncher;
  }

  @override
  Future<void> launch(String url) => window.open(url, '');
}
```

The nice thing about migrating to a federated plugin structure, is that once you are set up with the app-facing package and platform interface package, adding support for a new platform is simple (and you don’t even have to do it yourself!) All that is required is to create a new platform package which extends the platform interface declared in the platform interface package.

For more details about federated plugins, see [Federate plugins](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#federated-plugins) on flutter.dev.

## Testing plugins

As you write new cross-platform plugins or add platforms to existing ones, you can save yourself time and future headaches by writing tests. Automated tests protect your plugin from functional regressions so that you can rapidly develop new features and merge contributions.

A well-tested plugin typically includes several styles of test spread across multiple packages. It’s possible to slow yourself down writing tests that are flaky or unlikely to never fail, so focus on the test writing that gives you confidence that the key use cases are still functional.

### AutomatedWidgetsFlutterBinding tests

Tests that use `AutomatedWidgetsFlutterBinding` run on the development machine, rather than a device or browser. Because of this, they run faster and some functionality needs to be provided by mocks.

**In the app-facing package** (such as `myplugin`), the package’s unit tests ensure that calls to the app-facing API result in expected interactions with the platform interface package. These tests typically import `package:mockito` to provide a fake platform interface and verify that it receives the correct calls. Here is an [example test](https://github.com/flutter/plugins/blob/master/packages/url_launcher/url_launcher/test/url_launcher_test.dart#L25) from package:url_launcher:

```dart
test('returns true', () async {
  when(mock.canLaunch('foo')).thenAnswer((_) =>
    Future<bool>.value(true));
  final bool result = await canLaunch('foo');
  expect(result, isTrue);
});
```

**In the platform interface package** (such as `myplugin_platform_interface`), a platform interface is an abstract class and cannot be instantiated directly. However, the platform interface package typically contains the method channel implementation of the platform interface as well, so that’s what you should test. Tests for this package should focus on the method channel invocations that result from calls to the platform interface and the method channel. These tests typically use [`setMockMethodCallHandler`](https://api.flutter.dev/flutter/services/MethodChannel/setMockMethodCallHandler.html) with the [`isMethodCall`](https://api.flutter.dev/flutter/flutter_test/isMethodCall.html) matcher to verify behavior.

```dart
test('canLaunch', () async {
  await launcher.canLaunch('http://example.com/');
  expect(
    log,
    <Matcher>[
      isMethodCall('canLaunch', arguments: <String, Object>{
        'url': 'http://example.com/',
      })
    ],
  );
});
```

**In the platform tests** (such `myplugin_web`), you can take advantage of platform-specific functionality. In the current Flutter SDK, flutter test provides an experimental `--platform` flag that allows you to choose to run tests in a Chrome-like environment where dart:html is available.

This test mode is useful for writing tests in the platform implementation package (for example, `myplugin_web`).

```dart
test('cannot launch "tel" URLs', () {
  expect(canLaunch('tel:5551234567'), completion(isFalse));
});
```

In addition, you can run your GUI tests in Chrome using [experimental support for ‘flutter drive’ testing on the web](https://github.com/flutter/flutter/wiki/Running-Flutter-Driver-tests-with-Web).

For more information about plugin testing, see [Testing your plugin](https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration#testing-your-plugin) on flutter.dev.

## Summary

As you can see, there’s a lot of new features for the Flutter plugin developer, allowing you to build more full-featured and more robust plugins across more platforms. If you’re interested in some web-specific details, I recommend Harry Terkelsen’s two-part series on How to Write a Flutter Web Plugin ([part 1](https://medium.com/flutter/how-to-write-a-flutter-web-plugin-5e26c689ea1) and [part 2](https://medium.com/flutter/how-to-write-a-flutter-web-plugin-part-2-afdddb69ece6)). For more information on writing plugins in general, the [Developing plugin packages](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin) documentation on flutter.dev is also a great resource.
