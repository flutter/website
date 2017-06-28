---
layout: page
title: Developing Packages & Plugins
permalink: /developing-packages/
---

* TOC
{:toc}

## Package introduction

Packages enable the creation of modular code that can be shared easily. A
minimal package consists of:

* A `pubspec.yaml` file: A metadata file that declares the package name,
  version, author, etc.

* A `lib` directory containing the public code in the package, minimally a
  single `<package-name>.dart` file.

### Package types {#types}

Packages can contain several kinds of content:

* *Dart packages*: General packages written in Dart, for example the
  [`path`](https://pub.dartlang.org/packages/path) package. Some of these may
  contain Flutter specific functionality and thus have a dependency on the
  Flutter framework, restricting their use to Flutter only, for example the
  [`fluro`](https://pub.dartlang.org/packages/fluro) package.

* *Plugin packages*: A specialized Dart package which contain an API written in
  Dart code combined with a platform-specific implementation for Android (using
  ObjC or Kotlin), and/or for iOS (using ObjC or Swift). A concrete example is
  the [`battery`](https://pub.dartlang.org/packages/battery) plugin package.

## Developing Dart packages {#dart}

### Step 1: Create the package

Flutter currently lacks a dedicated command for creating a package
(issue [#10377](https://github.com/flutter/flutter/issues/10377)). As a
workaround use these steps to create a package called `example`:

1. Create a standard Flutter application:
    * `flutter create example`

1. Delete the iOS and Android application containers:
  * `rm -rf ios`
  * `rm -rf android`

1. Remove the main application:
  * `rm lib/main.dart`

1. Add a main package file `lib/example.dart` with the following contents:
    <!-- skip -->
    ```dart
    library example;

    // Add public package code (Classes, etc.) here:
    ```  

### Step 2: Implement the package

For pure Dart packages, simply add the functionality inside the main
`lib/<package name>.dart` file, or in several files in the `lib` directory.

To test the package, add [unit tests](https://flutter.io/testing/#unit-testing)
in a `test` directory.

For additional details on how to organize the package contents, see the [Dart
library
package](https://www.dartlang.org/guides/libraries/create-library-packages)
documentation.

## Developing plugin packages {#plugin}

If you want to develop a package that calls into platform-specific APIs, you
need to develop a plugin package. A plugin package is a specialized version of a
Dart package, that in addition to the content described above also contains
platform-specific implementations written for Android (Java or Kotlin code), for
iOS (Objective-C or Swift code), or for both. The API is connected to the
platform-specific implementation(s) using [platform channels](/platform-channels/).

### Step 1: Create the package

To create a plugin package, use the `--plugin` flag with `flutter create`. 

Use the `--org` option to specify your organization, using reverse domain name
notation. This value is used in various package and bundle identifiers in the
generated Android and iOS code.


```
flutter create --org com.example --plugin hello
```

This creates a plugin project in the `hello/` folder with the following
specialized content:

* `lib/hello.dart`:
   - The Dart API for the plugin.
* `android/src/main/java/com/yourcompany/hello/HelloPlugin.java`:
   - The Android platform specific implementation of the plugin API.
* `ios/Classes/HelloPlugin.m`: 
   - The iOS platform specific implementation of the plugin API.
* `example/`:
   - A Flutter app that depends on the plugin, and illustrates how to use it.

By default, the plugin project uses Objective-C for iOS code and
Java for Android code. If you prefer Swift or Kotlin, you can specify the
iOS language using `-i` and/or the Android language using `-a`. For example:
```
flutter create --plugin -i swift -a kotlin hello
```

### Step 2: Implement the package {#edit-plugin-package}

As a plugin package contains code for several platforms written in several
programming languages, some specific steps are needed to ensure a smooth
experience.

#### Step 2a: Define the package API (.dart)

The API of the plugin package is defined in Dart code. Open the main `hello/`
folder in IntelliJ IDEA (or your favorite Dart editor). Locate the file
`lib/hello.dart`.

#### Step 2b: Add Android platform code (.java/.kt)

We recommend you edit the Android code using Android Studio.

Before editing the Android platform code in Android Studio, first make sure that
the code has been built at least once (i.e., run the example app from IntelliJ, 
or in a terminal execute `cd hello/example; flutter build apk`). 

Next,

1. Launch Android Studio
1. Select 'Import project' in 'Welcome to Android Studio' dialog, or select 
'File > New > Import Project...'' in the menu, and select the
`hello/example/android/build.gradle` file.
1. In the 'Gradle Sync' dialog, select 'OK'.
1. In the 'Android Gradle Plugin Update' dialog, select 'Don't remind me again
   for this project'.

The Android platform code of your plugin is located in
`hello/java/com.yourcompany.hello/HelloPlugin`.

You can run the example app from Android Studio by pressing the &#9654; button.

#### Step 2c: Add iOS platform code (.h+.m/.swift)

We recommend you edit the iOS code usign Xcode.

Before editing the iOS platform code in Xcode, first make sure that
the code has been built at least once (i.e., run the example app from IntelliJ, 
or in a terminal execute `cd hello/example; flutter build ios`).

Next,

1. Launch Xcode
1. Select 'File > Open', and select the `hello/example/ios/Runner.xcworkspace` file.

The iOS platform code of your plugin is located in `Pods/Development
Pods/hello/Classes/` in the Project Navigator.

You can run the example app by pressing the &#9654; button.

#### Step 3: Connect the API and the platform code

Finally, you need to connect the API written in Dart code with the platform-specific
implementations. This is done using [platform channels](/platform-channels/).
   
## Publishing packages {#publish}

Once you have implemented a package, you can publish it on
[Pub](https://pub.dartlang.org/), so that other developers can easily use it.

Prior to publishing, make sure to review the `pubspec.yaml`, `README.md`, and
`CHANGELOG.md` files to make sure their content is complete and correct.

Next, run the dry-run command to see if everything passes analysis: `flutter
packages pub publish --dry-run`. Finally, run the actual publish command:
`flutter packages pub publish`.

For details on publishing, see the [Pub publishing docs](https://www.dartlang.org/tools/pub/publishing).

