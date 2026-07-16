---
title: "Introducing background isolate channels"
description: "Now as of Flutter 3.7, I’m pleased to announce that developers can use Plugins and Platform Channels from any isolate. This has been one of…"
publishDate: 2023-01-09
author: gaaclarke
image: images/1bSKidxVM7-brUJFuyKdVFg.webp
category: engineering
layout: blog
---

<DashImage figure src="images/1bSKidxVM7-brUJFuyKdVFg.webp" />


Now as of Flutter 3.7, I’m pleased to announce that developers can use Plugins and Platform Channels from *any* isolate. This has been one of our [highest ranked issues](https://github.com/flutter/flutter/issues/13937) and has been around since 2018. It was deprioritized since it wasn’t trivial to implement and there was a workaround, albeit cumbersome: always use Plugins from the root isolate (the isolate that Flutter provides). However, as Flutter has matured it has increasingly focused on performance, following the old software adage “Make it work, make it right, make it fast.” Choosing to implement this feature was a happy intersection of improving performance and also making Flutter easier to use. So, it became an easy decision to make the investment.

If you want to see how this feature is used, check out the [sample code](https://github.com/flutter/samples/tree/main/background_isolate_channels) on GitHub.

## Use cases

Why would someone want to use plugins from a background isolate? Well it’s clear that there is a need for plugins since not all of the world’s code is written in Dart. There are years of effort from the community to make that code accessible using plugins, things like: *path_provider*’s ability to find the temporary directory or *flutter_local_notifications*’s ability to post notifications.

The next logical question is: “why would someone execute code on a background isolate?” The answer is that sometimes you don’t have a choice, a library might be invoking callbacks on a background isolate, like *android_alarm_manager_plus*. Or an app might be doing significant computations and the developer doesn’t want those to interfere with the UI.

In my time on the team helping other teams at Google adopt Flutter, it was inevitable that, as a product matured, they would eventually get into a situation where the root isolate would become a bottleneck. So, we need to make sure everything in the framework is optimized and give tools to users to easily offload work when necessary.

Here is a contrived concrete use case for Background Isolate Channels:

Imagine an app for generating high resolution images from text prompts with AI. The user’s previous creations are stored on Firebase Cloud Storage and there is a feature to export and share the creations from the user’s phone. The Flutter app launches a background isolate which downloads the 8k version of their image from Firebase Cloud Store, downsample the image to the desired export size, save the image to the camera roll, and finally post a local notification when the export is finished.

At least 3 plugins were used from a background isolate in this example, one to read from Firebase Cloud Store, one to save to the phone’s camera roll, and one to post a local notification. Without Background Isolate Channels, the app would have to copy the 8k image from the root isolate to the background isolate in order for it to be downsampled. There is no way to make that a constant time operation with Dart today.

## Quick sample

Here is a quick sample using the new API to call the *shared_preferences* plugin from a background isolate:

```dart
import ‘package:flutter/services.dart’;
import ‘package:shared_preferences/shared_preferences.dart’;

void main() {
 // Identify the root isolate to pass to the background isolate.
 // (API introduced in Flutter 3.7)
 RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
 Isolate.spawn(_isolateMain, rootIsolateToken);
}

void _isolateMain(RootIsolateToken rootIsolateToken) async {
 // Register the background isolate with the root isolate.
 BackgroundIsolateBinaryMessenger
   .ensureInitialized(rootIsolateToken);
 // You can now use the shared_preferences plugin.
 SharedPreferences sharedPreferences =
   await SharedPreferences.getInstance();
 print(sharedPreferences.getBool(‘isDebug’));
}
```


## Technical details

Here is a high level overview of how Platform Channels work:

<DashImage figure src="images/0Db7Niu7FqKGszecZ.webp" />


When the result from the Platform Channel was invoked there was a hardcoded hop to the *platform* thread. In order for Background Isolate Channels to work, the isolate sending the message must be stored so that the engine can schedule the result on that isolate’s event loop. That was implemented by using [Dart’s *ports](https://github.com/dart-lang/sdk/blob/eb9554d70e386bb3177f63509ba8f7e4bbf500a0/runtime/include/dart_native_api.h#L125).* Dart *ports* store the isolate that owns them and is the only way to schedule on those isolates from the C API.

The other thing needing to be implemented was some way of associating background isolates with their root isolate. This was a surprise to me, but in order to shut down platform channels when a Flutter engine is destructed, one must know what background isolates are associated with that engine. Otherwise a background isolate could try to communicate with a Flutter engine that is in the process of being destroyed. The ramifications of this can be seen in the final API where a *RootIsolateToken* must be used to initialize the *BackgroundIsolateBinaryMessenger*.

For more information on the implementation, check out the [Isolate Platform Channels](https://docs.google.com/document/d/1yAFw-6kBefuurXWTur9jdEUAckWiWJVukP1Iay8ehyU/edit#heading=h.722pnbmlqbkx) design doc. This doc also contains proposals for communicating in the opposite direction, which have not been implemented or accepted yet.

Thank you to the Flutter community for your support and I hope you all find amazing uses for this new feature.
