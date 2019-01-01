---
title: Developing packages & plugins
short-title: Developing
description: How to write packages and plugins for Flutter.
---

## Package introduction

Packages enable the creation of modular code that can be shared easily. A
minimal package consists of:

* A `pubspec.yaml` file: A metadata file that declares the package name,
  version, author, etc.

* A `lib` directory containing the public code in the package, minimally a
  single `<package-name>.dart` file.

{{site.alert.note}}
  For a list of dos and don'ts when writing an effective plugin,
  see [Writing a good
  plugin](https://medium.com/flutter-io/writing-a-good-flutter-plugin-1a561b986c9c)
  on Medium.
{{site.alert.end}}

### Package types {#types}

Packages can contain several kinds of content:

* *Dart packages*: General packages written in Dart, for example the
  [`path`](https://pub.dartlang.org/packages/path) package. Some of these may
  contain Flutter specific functionality and thus have a dependency on the
  Flutter framework, restricting their use to Flutter only, for example the
  [`fluro`](https://pub.dartlang.org/packages/fluro) package.

* *Plugin packages*: A specialized Dart package which contain an API written in
  Dart code combined with a platform-specific implementation for Android (using
  Java or Kotlin), and/or for iOS (using ObjC or Swift). A concrete example is
  the [`battery`](https://pub.dartlang.org/packages/battery) plugin package.

## Developing Dart packages {#dart}

### Step 1: Create the package

To create a Dart package, use the `--template=package` flag with `flutter create`:

{% commandline %}
flutter create --template=package hello
{% endcommandline %}

This creates a package project in the `hello/` folder with the following
specialized content:

* `lib/hello.dart`:
   - The Dart code for the package.
* `test/hello_test.dart`:
   - The [unit tests](/docs/testing#unit-testing) for the package.

### Step 2: Implement the package

For pure Dart packages, simply add the functionality inside the main
`lib/<package name>.dart` file, or in several files in the `lib` directory.

To test the package, add [unit tests](/docs/testing#unit-testing)
in a `test` directory.

For additional details on how to organize the package contents, see the
[Dart library
package](https://www.dartlang.org/guides/libraries/create-library-packages)
documentation.

## Developing plugin packages {#plugin}

If you want to develop a package that calls into platform-specific APIs, you
need to develop a plugin package. A plugin package is a specialized version of a
Dart package, that in addition to the content described above also contains
platform-specific implementations written for Android (Java or Kotlin code), for
iOS (Objective-C or Swift code), or for both. The API is connected to the
platform-specific implementation(s) using [platform
channels](/docs/development/platform-integration/platform-channels).

### Step 1: Create the package

To create a plugin package, use the `--template=plugin` flag with `flutter create`.

Use the `--org` option to specify your organization, using reverse domain name
notation. This value is used in various package and bundle identifiers in the
generated Android and iOS code.

{% commandline %}
flutter create --org com.example --template=plugin hello
{% endcommandline %}

This creates a plugin project in the `hello/` folder with the following
specialized content:

* `lib/hello.dart`:
   - The Dart API for the plugin.
* <code>android/src/main/java/com/example/&#8203;hello/HelloPlugin.java</code>:
   - The Android platform specific implementation of the plugin API.
* `ios/Classes/HelloPlugin.m`:
   - The iOS platform specific implementation of the plugin API.
* `example/`:
   - A Flutter app that depends on the plugin, and illustrates how to use it.

By default, the plugin project uses Objective-C for iOS code and
Java for Android code. If you prefer Swift or Kotlin, you can specify the
iOS language using `-i` and/or the Android language using `-a`. For example:

{% commandline %}
flutter create --template=plugin -i swift -a kotlin hello
{% endcommandline %}

### Step 2: Implement the package {#edit-plugin-package}

As a plugin package contains code for several platforms written in several
programming languages, some specific steps are needed to ensure a smooth
experience.

#### Step 2a: Define the package API (.dart)

The API of the plugin package is defined in Dart code. Open the main `hello/`
folder in your favorite [Flutter editor](/docs/get-started/editor). Locate the file
`lib/hello.dart`.

#### Step 2b: Add Android platform code (.java/.kt)

We recommend you edit the Android code using Android Studio.

Before editing the Android platform code in Android Studio, first make sure that
the code has been built at least once (i.e., run the example app from your IDE/editor,
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
<code>hello/java/com.example.hello/&#8203;HelloPlugin</code>.

You can run the example app from Android Studio by pressing the &#9654; button.

#### Step 2c: Add iOS platform code (.h+.m/.swift)

We recommend you edit the iOS code using Xcode.

Before editing the iOS platform code in Xcode, first make sure that
the code has been built at least once (i.e., run the example app from your IDE/editor,
or in a terminal execute `cd hello/example; flutter build ios --no-codesign`).

Next,

1. Launch Xcode
1. Select 'File > Open', and select the `hello/example/ios/Runner.xcworkspace` file.

The iOS platform code of your plugin is located in `Pods/Development
Pods/hello/Classes/` in the Project Navigator.

You can run the example app by pressing the &#9654; button.

#### Step 2d: Connect the API and the platform code

Finally, you need to connect the API written in Dart code with the platform-specific
implementations. This is done using [platform
channels](/docs/development/platform-integration/platform-channels).

## Adding documentation

It is recommended practice to add the following documentation to all packages:

1. A `README.md` file that introduces the package
1. A `CHANGELOG.md` file that documents changes in each version
1. A `LICENSE` file containing the terms under which the package is licensed
1. API documentation for all public APIs (see below for details)

### API documentation

When you publish a package, API documentation is automatically generated and
published to dartdocs.org, see for example the [device_info
docs](https://www.dartdocs.org/documentation/device_info/0.0.4/index.html).

If you wish to generate API documentation locally on your developement machine, use the following commands:

1. Change directory to the location of your package:

   `cd ~/dev/mypackage`

1. Tell the documentation tool where the Flutter SDK is (change to reflect where you placed it):

   `export FLUTTER_ROOT=~/dev/flutter` (on macOS or Linux)

   `set FLUTTER_ROOT=~/dev/flutter` (on Windows)

1. Run the `dartdoc` tool (comes as part of the Flutter SDK):

   `$FLUTTER_ROOT/bin/cache/dart-sdk/bin/dartdoc` (on macOS or Linux)

   `%FLUTTER_ROOT%\bin\cache\dart-sdk\bin\dartdoc` (on Windows)

For tips on how to write API documentation, see [Effective Dart:
Documentation](https://www.dartlang.org/guides/language/effective-dart/documentation).

## Publishing packages {#publish}

Once you have implemented a package, you can publish it on the
[Package site](https://pub.dartlang.org/), so that other developers can
easily use it.

Prior to publishing, make sure to review the `pubspec.yaml`, `README.md`, and
`CHANGELOG.md` files to make sure their content is complete and correct.

Next, run the dry-run command to see if everything passes analysis:

{% commandline %}
flutter packages pub publish --dry-run
{% endcommandline %}

Finally, run the actual publish command:
{% commandline %}
flutter packages pub publish
{% endcommandline %}

For details on publishing, see the
[publishing docs](https://www.dartlang.org/tools/pub/publishing).
for the Package site.

## Handling package interdependencies {#dependencies}

If you are developing a package `hello` that depends on the Dart API exposed by another package,
you need to add that package to the `dependencies` section of your `pubspec.yaml` file.
The code below makes the Dart API of the `url_launcher` plugin available to `hello`:

In `hello/pubspec.yaml`:
```yaml
dependencies:
  url_launcher: ^0.4.2
```

You can now `import 'package:url_launcher/url_launcher.dart'` and `launch(someUrl)` in
the Dart code of `hello`.

This is no different from how you include packages in Flutter apps or any other Dart project.

But if `hello` happens to be a _plugin_ package whose platform-specific code needs access
to the platform-specific APIs exposed by `url_launcher`, you also need to add
suitable dependency declarations to your platform-specific build files, as shown below.

### Android

In `hello/android/build.gradle`:
```groovy
android {
    // lines skipped
    dependencies {
        provided rootProject.findProject(":url_launcher")
    }
}
```
You can now `import io.flutter.plugins.urllauncher.UrlLauncherPlugin` and access the `UrlLauncherPlugin`
class in the source code at `hello/android/src`.

### iOS

In `hello/ios/hello.podspec`:
```ruby
Pod::Spec.new do |s|
  # lines skipped
  s.dependency 'url_launcher'
```
You can now `#import "UrlLauncherPlugin.h"` and access the `UrlLauncherPlugin` class in the source code
at `hello/ios/Classes`.

### Conflict resolution

Suppose you want to use `some_package` and `other_package` in your package
`hello`, and both of these depend on `url_launcher`, but in different
versions. Then we have a potential conflict. The best way to avoid this
is for package authors to use [version
ranges](https://www.dartlang.org/tools/pub/dependencies#version-constraints)
rather than specific versions when specifying dependencies.

```yaml
dependencies:
  url_launcher: ^0.4.2    # Good, any 0.4.x with x >= 2 will do.
  image_picker: '0.1.1'   # Not so good, only 0.1.1 will do.
```

If `some_package` declares the dependencies above and `other_package`
declares a compatible  `url_launcher` dependency like `'0.4.5'` or `^0.4.0`,
`pub` is able to resolve the issue automatically. Similar
remarks apply to plugin packages' platform-specific dependencies on
[Gradle modules][] and/or [CocoaPods][].

Even if `some_package` and `other_package` declare incompatible versions for
`url_launcher`, it may still be that they actually use `url_launcher` in
compatible ways. Then the conflict can be dealt with by adding
a dependency override declaration to the `pubspec.yaml` file in `hello`,
forcing the use of a particular version.

Forcing the use of `url_launcher` version `0.4.3` in `hello/pubspec.yaml`:

```yaml
dependencies:
  some_package:
  other_package:
dependency_overrides:
  url_launcher: '0.4.3'
```

If the conflicting dependency is not itself a package,
but an Android-specific library like `guava`, the dependency override
declaration must be added to Gradle build logic instead.

Forcing the use of `guava` version `23.0` in `hello/android/build.gradle`:

```groovy
configurations.all {
    resolutionStrategy {
        force 'com.google.guava:guava:23.0-android'
    }
}
```

CocoaPods does not currently offer dependency override functionality.

[CocoaPods]: https://guides.cocoapods.org/syntax/podspec.html#dependency
[Gradle modules]: https://docs.gradle.org/current/userguide/introduction_dependency_management.html
