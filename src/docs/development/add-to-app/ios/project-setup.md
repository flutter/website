---
title: Integrate a Flutter module into your iOS project
short-title: Integrate Flutter
description: Learn how to integrate a Flutter module into your existing iOS project.
---

TODO(jmagman): add the pre-built framework alternative and review.

## Integration steps

To integrate a Flutter module into your app, use the following steps:

 1. [Create Flutter Module](#create-a-flutter-module)
   f Creates the Flutter project that is hosted in the existing app.
 1. [Add Module Dependency in Existing
    App](#make-the-host-app-depend-on-the-flutter-module)
    Sets up Xcode to include your Flutter project into the build of your
    existing app.

## Create a Flutter module

Flutter projects created using `flutter create xxx` include simple host apps for
your Flutter/Dart code (a single-ViewController iOS host). You can modify these
host apps to suit your needs and build from there.

If you're starting off with an *existing* host app for either platform, you'll
likely want to include your Flutter project in that app as some form of library
instead.

In order to embed Flutter as a library, use the Flutter module template.
Executing `flutter create -t module xxx` produces a Flutter project with a
CocoaPods pod designed for consumption by your existing host app.

Assume you have an existing iOS app at `some/path/MyApp`, and that you
want your Flutter project as a sibling:

```bash
cd some/path/
flutter create -t module my_flutter
```

This creates a `some/path/my_flutter/` Flutter module project with some Dart
code to get you started, and a `.ios/` hidden subfolder. The `.ios/` folder wraps
the module project that contains some CocoaPods and a helper Ruby script.

## Make the host app depend on the Flutter module

The description below assumes that your existing iOS app has a structure similar
to what you get by asking Xcode to generate a new "Single View App" project
using Objective-C. If your existing app has a different folder structure
and/or existing `.xcconfig` files, you can reuse those, but you'll probably need
to adjust some of the relative paths mentioned below accordingly.

The assumed folder structure is as follows:

```text
some/path/
  my_flutter/
    lib/main.dart
    .ios/
  MyApp/
    MyApp/
      AppDelegate.h
      AppDelegate.m (or swift)
      :
```

### Add your Flutter app to your Podfile

Integrating the Flutter framework requires using the CocoaPods dependency
manager. This is because the Flutter framework needs to be available to any
Flutter plugins that you might include in `my_flutter`.

For information on how to install CocoaPods on your development machine, see
[cocoapods.org](https://cocoapods.org/).

If your host application (`MyApp`) is already using CocoaPods, you only have to do the
following to integrate with your `my_flutter` app:

1. Add the following lines to your `Podfile`:

```ruby
  flutter_application_path = 'path/to/my_flutter/'
  load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
```

2. For each Xcode [target](https://guides.cocoapods.org/syntax/podfile.html#target) that needs to embed Flutter, call `install_all_flutter_pods(flutter_application_path)`.

```ruby
  target 'MyApp' do
    install_all_flutter_pods(flutter_application_path)
  end
```

3. Run `pod install`.

Whenever you change the Flutter plugin dependencies in `some/path/my_flutter/pubspec.yaml`,
you need to run `flutter pub get` from `some/path/my_flutter` to refresh the list
of plugins read by the `podhelper.rb` script. Then run `pod install` again from
`some/path/MyApp`.

The `podhelper.rb` script ensures that your plugins, the Flutter.framework, and
the App.framework are embedded in your project.

You should now be able to build the project using `⌘B`.

### Under the hood

If you have some reason to do this manually or debug why these steps aren't
working, here's what's going on under the hood:

- `Flutter.framework` (the Engine library) is getting embedded into your app for you.  This has to match up with the release type
(debug/profile/release) as well as the architecture for your app (arm*, x86_64, etc.).  CocoaPods pulls this in as a vendored
framework and makes sure it gets embedded into your native app.
- `App.framework` (your Flutter application binary) is embedded into your app.  CocoaPods also pulls this in as a vendored framework and
makes sure it gets embedded into your native app.
- Any plugins are added as CocoaPod pods.  In theory, it should be possible to manually merge those in as well, but those instructions
vary on the pod dependencies of each plugin.
- A build script is added to the Podfile targets that call `install_all_flutter_pods` to ensure that the binaries you build stay up to date
with the Dart code that's actually in the folder.  It also uses your Xcode build configuration (Debug, Profile, Release) to embed the matching
release type of `Flutter.framework` and `App.framework`.