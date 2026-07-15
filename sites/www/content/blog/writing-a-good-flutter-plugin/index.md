---
title: "Writing a good Flutter plugin"
description: "Plugins are essential to the Flutter ecosystem. They allow Flutter developers to interact with libraries of the platform the app is…"
publishDate: 2018-10-03
author: mehmetf
category: tutorial
layout: blog
---

Plugins are essential to the Flutter ecosystem. They allow Flutter developers to interact with the platform the app is running on.

As of October 2018, there are [hundreds of](https://pub.dartlang.org/flutter/packages) plugins available on pub. It is very important for plugins to be of high quality, regardless of whether they come from Google or outside contributors. This article explores what makes a good plugin and how to write one.

## Think functionality first, then APIs

Often when writing a plugin, you are trying to use an existing native library. The natural thing to do is to look at that library’s API and expose Dart equivalent API for it. Problems arise when APIs don’t match across platforms and you are forced to expose an intersection of the API often with crippling consequences…

When writing plugins, *think about functionality first, not APIs*. For instance, if you are writing a local storage plugin, you probably need APIs that support storing values of various types along with an ability to recall them. After you established what kind of functionality you want to provide, then think about your Dart API design:

```dart
class StoragePlugin {
  
  /// Reads a string
  Future<String> getString(String key) async {}
  
  /// Writes a string
  Future<void> setString(String key, String value) async {}
}
```

Only after you have the Dart API, start looking at the public API and see your API calls need to be adapted to the platform specific library API calls:

```dart
class StoragePlugin {
  
  Future<String> getString(String key) async {
    if (Platform.isIos) {
      return await callMethodChannel('fetchValue', {'id': base64encode(key)});
    } else if (Platform.isAndroid) {
      return await callMethodChannel('fetchValue', {'id': key});
    }
  }
  
  Future<void> setString(String key, String value) async {
    if (Platform.isIos) {
      await callMethodChannel('setValue', {'id': base64encode(key), 'value': value});
    } else if (Platform.isAndroid) {
      await callMethodChannel('setValue', {'id': key, 'value': value});
    }
  }
}
```
> If there’s a functionality you would like to provide which is not supported by one platform, it is OK for that API to **gracefully** fail for that platform.
> You should not crash the app and the behavior should be thoroughly documented. You should also request the missing functionality from the platform so your plugin can be complete.

## Avoid platform-specific API methods

Flutter is platform agnostic so it is out of character for Flutter apps to be forced to write platform specific code. If the plugin user is doing the following in their application:

```dart
if (Platform.isIos) {
  myPlugin.doIOSThing();
} else if (Platform.isAndroid) {
  myPlugin.doAndroidThing();
}
```


consider moving the platform specific logic to the plugin itself so that, they can write:

```dart
myPlugin.doThing();
```


## Avoid supporting only one platform

You might be tempted to start small and write a plugin for a functionality you want just for Android. Unfortunately, when the plugin is published, this creates confusion for plugin users when their app misbehaves on unsupported platforms.
> There are counterexamples to this such as [Android Intent](https://github.com/flutter/plugins/tree/master/packages/android_intent). Intents are applicable only on Android so it is OK to expose an Android-only plugin for them.

## Make your plugin easy to navigate and test

As a rule of thumb, your plugin should contain mostly Dart code.

* Native layer is non-trivial to test since it typically deals with libraries that do not function on emulators.

* Flutter is mostly written in Dart. Flutter apps are *entirely* written in Dart. When tracing code, it would be nice if the majority of the logic can be derived from Dart.

The only reason why you would need native layer is if the implementation on that platform requires you to keep state and/or do processing. One good example is biometric authentication which has its own complex lifecycle on Android that needs to be managed on the native side.

*If you need to write extensive native code, consider moving the functionality to individual classes that can be unit tested.*

Ideally, your native layer will simply listen for method calls, forward them to an existing library and pipe the results back to Dart. If you are doing anything more than that, try to see if it can be moved to Dart side. You will end up writing less code that way since the logic will likely need to be repeated across several platforms.

## Avoid writing static (or global) methods

It is tempting to expose just:

```dart
Future<User> authenticate() async {
  // Some code
}
```


However, prefer:

```dart
class AuthenticatePlugin {
  Future<User> authenticate() async {
    // Some code
  }
}
```


which makes the plugin mock or fake friendly. Users can easily swap out the real implementation so their apps work on an emulator or a test harness.

Plugins are one of the best ways to enhance functionality of Flutter. If you have more ideas on plugin best practices, please share via comments. Happy coding!