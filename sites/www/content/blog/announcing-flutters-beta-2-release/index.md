---
title: "Announcing Flutter’s beta 2 release"
description: "We have a second beta build available of Flutter, Google’s new mobile UI framework that helps developers craft high-quality apps."
publishDate: 2018-04-09
author: mit-mit
image: images/14DxDp03lkhJN3engJhXhWQ.webp
category: releases
layout: blog
---

## Announcing Flutter beta 2

We have a second beta build (v0.2.8) available of Flutter, Google’s new mobile UI framework that helps developers craft high-quality native interfaces for both iOS and Android. We’ve been working hard to continue to support Flutter’s rapidly expanding community and are now introducing easier installation, default support for Dart 2, and more. If you are a new to Flutter, [get started](https://flutter.io/get-started/?utm_source=google&utm_medium=blog&utm_campaign=beta_get_started) today with beta 2 at [flutter.io](https://flutter.io/?utm_source=google&utm_medium=blog&utm_campaign=beta_announcement). If you are an existing Flutter user please review the ‘Call to action’ below to ensure your code is compatible with Dart 2.

<DashImage figure src="images/14DxDp03lkhJN3engJhXhWQ.webp" />


## A view back at beta 1

We have been delighted to see the [strong reception](https://twitter.com/_eseidel/status/973641697962770432) since we launched [our first beta](https://medium.com/flutter-io/announcing-flutter-beta-1-build-beautiful-native-apps-dc142aea74c0) at Mobile World Congress in Barcelona in February. We saw a nice collection of posts in the general tech press (for example, [Ars Technica](https://arstechnica.com/gadgets/2018/02/google-starts-a-push-for-cross-platform-app-development-with-flutter-sdk/), [TechCrunch](https://techcrunch.com/2018/02/27/googles-flutter-ui-framework-is-now-in-beta/), [VentureBeat](https://venturebeat.com/2018/02/27/google-launches-flutter-beta-a-mobile-ui-framework-for-building-native-android-and-ios-apps/), [9to5Google](https://9to5google.com/2018/02/27/googles-flutter-sdk-now-available-beta/)), lots of new [Flutter posts on Medium](https://medium.com/tag/flutter/latest) by our awesome community, and a huge influx of new developers and organizations around the world downloading and using Flutter.

## Improvements in our second beta

### Easier installation

We heard feedback that installation of Flutter could be easier; installing beta 1 required cloning our GitHub repo with git command line tools. So we reworked our installation procedure, and now support installing beta 2 by simply downloading and extracting an installation archive: [Windows](https://flutter.io/setup-windows/), [macOS](https://flutter.io/setup-macos/), and [Linux](https://flutter.io/setup-linux/). For Windows users, we also added a cool new Flutter Console so you can get started with Flutter commands right after downloading:

<DashImage figure src="images/1hjgDPasw3bTtB9N54wxX2Q.webp" alt="Screenshot of the new Flutter Console for Windows" caption="Screenshot of the new Flutter Console for Windows" />


### Improved developer tools

Flutter’s developer tools and experience team shipped the [M23 tools milestone](https://groups.google.com/forum/#!topic/flutter-dev/E15CK8Eq8GM) featuring many improvements. Android Studio & IntelliJ gained a new ‘Outline view’ providing a structured tree view of the UI widgets in a build method, and support for ‘Format on Save’. VS Code gained support for running tests, multi project support, and a new picker to select the current Flutter SDK when several are installed.

### Improved asset system

We have done some pretty significant optimization of our asset system. We now place the assets using the structure that the underlying platform (Android, iOS) expects. This has a number of advantages.

First, Flutter apps now launch faster as we don’t make unneeded extractions of the assets. The previous asset system occasionally caused slow launch times on older Android phones.

Second, it enables plugins to access the assets from the native-code side of a plugin (i.e., from Java, Kotlin, Objective-C, or Swift). Let’s look at a concrete example, the [`video_player`](https://pub.dartlang.org/packages/video_player) plugin we launched a few months ago. Until now it was only capable of playing videos from the network, but several developers requested the ability to “pass” it video files that had been embedded into the app using Flutter’s asset system. With beta 2, and version 0.4.0 of the plugin, this is now possible. Because we place the assets as the underlying platform expects, they can be shared between Flutter and the native platform. And we provide new APIs ([Android](https://docs.flutter.io/javadoc/io/flutter/plugin/common/PluginRegistry.Registrar.html#lookupKeyForAsset-java.lang.String-), [iOS](https://docs.flutter.io/objcdoc/Protocols/FlutterPluginRegistrar.html#/c:objc(pl)FlutterPluginRegistrar(im)lookupKeyForAsset:)) for getting a suitable asset lookup key for use in the native code, for example the Android [AssetManager](https://developer.android.com/reference/android/content/res/AssetManager.html):

```java
String assetName = call.argument("asset");
String assetLookupKey = registrar.lookupKeyForAsset(assetName);
AssetFileDescriptor fd = registrar.context().getAssets().openFd(assetLookupKey);
player = new VideoPlayer(eventChannel, handle, fd, result);
```

### Dart 2 enabled by default

Our first beta offered a preview of the Dart 2 programming language. Our testing has shown Dart 2 to be near complete, and very stable. Flutter’s second beta has Dart 2 enabled by default. As a result you will get [faster async](https://groups.google.com/forum/#!msg/flutter-dev/3R9qhjNGZk4/DJqZlep_AAAJ) calls, and a [much richer type system](https://www.dartlang.org/guides/language/sound-dart).

As one example of how the new type system can save you a lot of debugging time, consider the following:

```dart
void main() {
  List todo = ['Eat', 'Sleep', new Task('Code Flutter', Priority.high), 'Profit'];
  runApp(
    new MaterialApp(home: new TodoList(todo)),
  );
}
class TodoList extends StatefulWidget {
  final List<Widget> items;
  TodoList(this.items);
}
```

The code has a bug. It’s passing a list of strings and tasks to a widget that expects a list of widgets. Static analysis does not catch this, because the programmer intentionally used lax static typing for the todo list (`List` is shorthand for `List&lt;dynamic&gt;`).

Next consider how the app is using this list:

```dart
Widget build(BuildContext context) {
  List<Widget> remaining = widget.items.sublist(_done);
  return new Scaffold(
    body: (remaining.length <= 3)
        ? new Column(children: remaining)
        : new Text('${remaining.length} items left to do'),
    floatingActionButton: new FloatingActionButton(onPressed: _doOneThing),
  );
}
```

Because access to the todo list items is conditional, the error kicks in late. In Flutter beta 1, there would be no error at startup, and only once the user has tapped the button would you be informed that a string cannot be used as a widget:

```text
The following assertion was thrown building TodoList(dirty, state: TodoListState#fd618):
type 'String' is not a subtype of type 'Widget' of 'child' where
  String is from dart:core
  Widget is from package:flutter/src/widgets/framework.dart
```

With the new complete run-time checks in Dart 2, we prevent “errors waiting to happen” like this by instead failing early, at the point where your code makes a false claim about generic types. In this case, we fail as soon as the app launches, and the dynamic list `todo` is passed to the `TodoList` constructor, which expects a `List&lt;Widget&gt;`:

```text
type 'List<dynamic>' is not a subtype of type 'List<Widget>' where
  List is from dart:core
  Object is from dart:core
  List is from dart:core
  Widget is from package:flutter/src/widgets/framework.dart

main (file:///Users/mit/tmp/todo/lib/main.dart:4:37)
```

### Dart 2 and optional new/const

Dart 2 also added support for making the new and const keywords optional when calling constructors, as discussed in our last beta blog post. During our final testing of beta 2 we found a number of [issues](https://github.com/dart-lang/sdk/issues/32798) so for now we recommend postponing any non-experimental use of optional new/const until we launch a new beta build declaring it ready.

## Call to action: upgrading your code to Dart 2

As with all change, there is a cost: If you have existing Flutter code, you may have to upgrade some of it to be compatible with Dart 2. To begin upgrading, please make sure to [update the Flutter SDK to beta 2 (v0.2.8)](https://flutter.io/upgrading/), and your [Flutter IDE plugin](https://flutter.io/get-started/editor/) for Android Studio, IntelliJ, or VS Code to the latest release.

Next, validate that your code passes static analysis (from the terminal, run `flutter analyze`, or use the problems view in [Android Studio/IntelliJ](https://flutter.io/using-ide/#editing-code-and-viewing-code-problems) or [VS Code](https://flutter.io/using-ide-vscode/#editing-code-and-viewing-issues)). Then, consult the comprehensive guidance in our [breaking changes post](https://groups.google.com/forum/#!topic/flutter-dev/H8dDhWg_c8I) for how to resolve issues you may see with the new, much more comprehensive runtime type checks in Dart 2.

Should you need a bit more time to work through this, you can temporarily switch back to the old behavior with the [Dart 2 opt-out](https://github.com/flutter/flutter/wiki/Opting-out-of-Dart-2-with-Flutter-beta-2). This opt-out is expected to be supported for a single beta release only.

## Closing thoughts

We hope that you will enjoy our second beta, and feel our ongoing commitment to improving the Flutter product as we get to work on our next beta build. We really [welcome feedback](https://flutter.io/support/), and hope you will all share what you are working on; we truly enjoy seeing all the ways Flutter is being used to build great, beautiful apps! We are also excited to look ahead to next months Google I/O, where you can catch our [three sessions](https://events.google.com/io/schedule/?section=day&topic=flutter), experience our interactive sandbox area, and meet with us for great discussion! Oh, and before we leave, make sure to checkout the [great video](https://medium.com/flutter-io/video-hamilton-app-built-in-3-months-with-flutter-reaches-1m-installs-f37f81856be4) the Hamilton team published on their experience with Flutter.

<YoutubeEmbed id="kfd-oLypqFI" title="Hamilton app built with Flutter and featured on iOS and Android (Flutter Developer Story)" fullwidth="true"/>
