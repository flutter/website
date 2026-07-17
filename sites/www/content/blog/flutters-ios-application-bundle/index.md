---
title: "Flutter’s iOS Application Bundle"
description: >-
  This document describes how Flutter’s build system converts your Flutter
  project (along with its assets), into an iOS application bundle. I…
publishDate: 2018-07-20
author: chinmaygarde
image: images/1xfvovQJT-5OsHBDBIQa92A.webp
category: engineering
layout: blog
---

This document describes how Flutter’s build system converts your Flutter project (along with its assets), into an iOS application bundle. I hope to demystify some of the build steps and explain the purpose of generated artifacts, so that you can integrate the same processes into your custom build environment.

**A note about workflow**: When building your application for release, you may use Flutter tooling, which makes the build process easy. However, some developers may find that this process is not as configurable, or doesn’t fit well in their custom build or continuous integration (CI) setups.

If you have a custom Xcode build or Gradle setup, all the "magic" added by Flutter tooling is optional, and you can configure the build to suit your own workflow.

All the information in this document applies to iOS application bundles prepared for release to the App Store. This means projects built to Flutter’s [release mode](https://github.com/flutter/flutter/wiki/Flutter's-modes). Compiling to either debug or profile mode uses a different runtime and packaging model in order to support tooling such as [hot reload](https://flutter.io/hot-reload/) and [observatory](https://dart-lang.github.io/observatory/get-started.html).

A Flutter application renders the user interface into a single view in the native view hierarchy.

<DashImage figure src="images/1xfvovQJT-5OsHBDBIQa92A.webp" alt="The Flutter view hierarchy visualized in Xcode. There is not much to see." caption="The Flutter view hierarchy visualized in Xcode. There is not much to see." />

## The Application Bundle

The application bundle created using the `flutter build ios --release` command (or using your IDE) looks remarkably similar to a typical iOS app bundle that contains the application executable along with any referenced frameworks and resources.

Flutter’s generated bundle for the `Runner` app:

```plaintext
Runner.app
├── AppFrameworkInfo.plist
├── Assets.car
├── Base.lproj
│   ├── LaunchScreen.storyboardc
│   └── Main.storyboardc
├── Debug.xcconfig
├── Frameworks
│   ├── App.framework            # See "App framework bundle"
│   │   ├── App
│   │   ├── Info.plist
│   └── Flutter.framework        # See "Flutter framework bundle"
│       ├── Flutter
│       ├── Info.plist
│       └── icudtl.dat
├── Info.plist
├── Runner
└── flutter_assets
├── AssetManifest.json
├── FontManifest.json
├── LICENSE
├── fonts
└── packages
└── cupertino_icons
└── assets
└── CupertinoIcons.ttf
```

## Compiling the Application

When compiling a release mode version of the app (as opposed to [profile or debug modes](https://github.com/flutter/flutter/wiki/Flutter's-modes)), artifacts from both the [buildbots](https://build.chromium.org/p/client.flutter/waterfall) and your host machine are needed. (For more information on the buildbots, part of the engine build that uses `GN` and `Ninja`, see [Contributing to the Flutter engine](https://github.com/flutter/engine/blob/master/CONTRIBUTING.md).)

When you install the SDK, Flutter tools are cached on your machine. You can see them by looking inside the `bin/cache` directory in your copy of the Flutter SDK. If you decide to integrate any steps of this process into your own build system, this directory contains all the versioned tools you need for working with Flutter.

The following sections describe some of the files unique to Flutter’s iOS app bundles.

## Flutter Engine framework bundle

The `Flutter.framework` directory, packaged as an [iOS framework bundle](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFrameworks/Frameworks.html#//apple_ref/doc/uid/10000183i), includes:

* [Flutter engine](https://github.com/flutter/engine): Contains the core libraries (for example, graphics, file and network I/O, accessibility support, plugin architecture), the DartVM, and the Skia renderer.

* Assets referenced by the Flutter engine: This currently is just ICU data.

The buildbots generate the Flutter engine framework bundle, and the Flutter tools download and cache it on your machine.

## AOT framework bundle

The `App.framework` bundle contains an AOT snapshot of all the Dart application code written by the user, as well as the Dart code for the Flutter framework and plugins, in `armv7s` and `aarch64` formats.

During a release build, the compiler performs tree-shaking on the Dart code, so only the code that is actually used ends up in the bundle. The `gen_snapshot` tool cached on your machine generates the artifacts necessary to create the `App.framework` bundle.

### AOT Snapshot

The AOT snapshot library contains the ahead-of-time code compiled from Dart to machine native bits.

The snapshot library, generated by `gen_snapshot`, [contains four main symbols](https://github.com/flutter/engine/wiki/Flutter-Engine-Operation-in-AOT-Mode). These symbols can be dumped by the `nm` command. For example:

```plaintext
$ nm -gU Runner.app/Frameworks/App.framework/App
Runner.app/Frameworks/App.framework/App (for architecture armv7):
003c6f60 S _kDartIsolateSnapshotData
00007000 T _kDartIsolateSnapshotInstructions
003c16a0 S _kDartVmSnapshotData
00004000 T _kDartVmSnapshotInstructions

Runner.app/Frameworks/App.framework/App (for architecture arm64):
00000000004041a0 S _kDartIsolateSnapshotData
0000000000009000 T _kDartIsolateSnapshotInstructions
00000000003fc740 S _kDartVmSnapshotData
0000000000005000 T _kDartVmSnapshotInstructions
```

Their purpose is as follows:

* Dart VM Snapshot (***`kDartVmSnapshotData`***):
  Represents the initial state of the Dart heap shared between isolates. This helps launch Dart isolates faster, but doesn’t contain any isolate-specific information.

* Dart VM Instructions (***`kDartVmSnapshotInstructions`***):
  Contains AOT instructions for common routines shared between all Dart isolates in the VM. This snapshot is typically extremely small and mostly contains stubs.

* Isolate Snapshot (***`kDartIsolateSnapshotData`***):
  Represents the initial state of the Dart heap and includes isolate-specific information.

* Isolate Instructions (***`kDartIsolateSnapshotInstructions`***):
  Contains the AOT code that is executed by the Dart isolate.

Invoking `gen_snapshot` is simple. You point it to the Dart source code, and it spits out a blob for each of these four symbols. Then, Xcode packages the symbols into an iOS framework bundle just like it would for a framework written in C, C++, Objective-C or Swift.

Learn more about how to configure the snapshot and the engine [in the Flutter engine wiki](https://github.com/flutter/engine/wiki/Flutter-Engine-Operation-in-AOT-Mode#snapshot-generation).

Apart from munging code, the Flutter tools also make sure that the assets referenced by the application (and its plugins), end up in the app bundle. It does this by reading the assets listed in the project’s `pubspec.yaml` file.

## A Note about Android

The process for building an Android APK bundle (using `flutter build apk --release`, or your IDE) results in the following file structure:

```plaintext
$ Runner.apk.unzipped
├── AndroidManifest.xml
├── assets
│   ├── flutter_assets
│   │   ├── fonts
│   │   │   └── MaterialIcons-Regular.ttf
│   │   └── packages
│   │       └── cupertino_icons
│   │           └── assets
│   │               └── CupertinoIcons.ttf
│   ├── icudtl.dat
│   ├── isolate_snapshot_data
│   ├── isolate_snapshot_instr
│   ├── vm_snapshot_data
│   └── vm_snapshot_instr
├── classes.dex
├── lib
│   └── armeabi-v7a
│       └── libflutter.so
├── output.json
├── res
└── resources.arsc
```

It is mostly the same as an iOS release bundle, except:

* The Flutter engine is packaged as an ELF library (`libflutter.so`).

* The 4 symbols detailed in the previous section are now just binary blobs in the assets directory.

The second point may be a bit unexpected and begs explanation: You didn’t have to download the NDK to build the release APK. That’s because, in the absence of the NDK on your machine, the Flutter tools add the blobs as assets. On Android, the Flutter engine can mark pages as executable. So, when it detects that AOT assets are packaged as binary blobs, it maps these blobs in memory, and marks the corresponding pages as executable. If you have access to the NDK on your machine, you can specify the [location to it,](https://github.com/flutter/engine/wiki/Flutter-Engine-Operation-in-AOT-Mode#android-configuration) and generate a dynamic library with these symbols. In this case, the Flutter engine uses the 4 symbols in the dynamic library instead.

## Summary

The key points about building an iOS app bundle are:

* You can place a Flutter View anywhere in the native view hierarchy. All contents rendered by Flutter will be composited into this view.

* Dart code is compiled to native machine code and packaged as a library or framework bundle just like any other C++/Objective/Swift library. This means that all the crash reporting and symbolication tools work the same way for Dart AOT code.

* You can integrate Flutter into your own custom build system and not depend on Flutter tooling on your development machine (though using it makes your life easier). All the tools are available in the `bin/cache` directory of the Flutter SDK.
