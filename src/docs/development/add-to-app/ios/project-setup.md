---
title: Integrate a Flutter module into your iOS project
short-title: Integrate Flutter
description: Learn how to integrate a Flutter module into your existing iOS project.
---

Flutter can be incrementaly added into your existing iOS application as embedded
frameworks.

## System requirements

Your development environment must meet the [macOS system requirements for Flutter][]
with [Xcode installed][]. Flutter supports iOS 8.0 and later.

## Create a Flutter module

To embed Flutter into your existing application, first create a Flutter module.

From the command line, run:

```sh
cd some/path/
flutter create --template module my_flutter
```

A Flutter module project will be created at `some/path/my_flutter/`. From that
directory, you can run the same `flutter` commands you would
in any other Flutter project, like `flutter run --debug` or `flutter build ios`.
You can also run the module in [Android Studio/IntelliJ][] or [VS Code][] with
the Flutter and Dart plugins.
This project contains a single-view example version of your module before it is
embedded in your existing application, which is useful for incrementally
testing the Flutter-only parts of your code.

### Module organization

The `my_flutter` module directory structure is similar to a normal Flutter
application:

```text
my_flutter/
├─.ios/
│ ├─Runner.xcworkspace
│ └─Flutter/podhelper.rb
├─lib/
│ └─main.dart
├─test/
└─pubspec.yaml
```

Add your Dart code to the `lib/` directory.

Add Flutter dependencies to `my_flutter/pubspec.yaml`, including Flutter packages
and plugins.

The `.ios/` hidden subfolder contains a Xcode workspace where you can
run a stand-alone version of your module, and is a wrapper project to bootstrap
your Flutter code. It contains helper scripts to build frameworks or
embed the module into your existing application with [CocoaPods][].

{{site.alert.note}}
Add custom iOS code to your existing application or a plugin, not to
the module in `.ios/`. Changes made in `.ios/` are not embedded in your existing application.
Regenerate the directory by running `flutter clean` or `flutter pub get` in the
`my_flutter` directory.
{{site.alert.end}}

## Embed the Flutter module in your existing application

There are two ways to embed Flutter in your existing application.

1. Use the CocoaPods dependency manager and installed Flutter SDK. Recommended.
1. Create frameworks for the Flutter engine, your compiled Dart code, and all
   Flutter plugins. Manually embed the frameworks and update your existing
   application's build settings in Xcode.

### Option A - Embed with CocoaPods and the Flutter SDK

This method requires every developer working on your project to have a locally installed
version of the Flutter SDK. Simply build your application in Xcode to automatically run the script to
embed your Dart and plugin code. This allows for rapid iteration with the most up-to-date
version of your Flutter module without running additional commands outside of Xcode.

The following example assumes that your existing application and the Flutter module are in sibling directories.
If you have a different directory organization, you may need to adjust the relative paths.

```text
some/path/
├── my_flutter/
│   └── .ios/
│       └── Flutter/
│         └── podhelper.rb
└── MyApp/
    └── Podfile
```

If your existing application (`MyApp`) does not already have a Podfile, follow the
[CocoaPods getting started guide][] to add a `Podfile` to your project.

1. Add the following lines to your `Podfile`:

    <?code-excerpt "MyApp/Podfile" title?>
    ```ruby
      flutter_application_path = '../my_flutter'
      load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
    ```

2. For each [Podfile target][] that needs to
embed Flutter, call `install_all_flutter_pods(flutter_application_path)`.

    <?code-excerpt "MyApp/Podfile" title?>
    ```ruby
      target 'MyApp' do
        install_all_flutter_pods(flutter_application_path)
      end
    ```

3. Run `pod install`.

{{site.alert.note}}
When you change the Flutter plugin dependencies in `my_flutter/pubspec.yaml`,
run `flutter pub get` in your Flutter module directory to refresh the list
of plugins read by the `podhelper.rb` script. Then run `pod install` again from
in your application at`some/path/MyApp`.
{{site.alert.end}}

The `podhelper.rb` script embeds your plugins, `Flutter.framework`, and
`App.framework` into your project.

{{site.alert.tip}}
`Flutter.framework` is the library for the Flutter engine and `App.framework` is
the compiled Dart code for this project.
{{site.alert.end}}

Open `MyApp.xcworkspace` in Xcode. You can now build the project using `⌘B`.

### Option B - Embed frameworks in Xcode

Alternatively, you can generate the necessary frameworks and embed them in your application
by manually editing your existing Xcode project. You may choose to do this if members of your
team cannot locally install Flutter SDK and CocoaPods, or if you do not wish to use CocoaPods
as a dependency manager in your existing applications. You must run `flutter build ios-framework`
every time you make code changes in your Flutter module.

If you are using the above [Embed with CocoaPods and Flutter tools](#option-a---embed-with-cocoapods-and-the-flutter-sdk)
method, you can skip these instructions.

The following example assumes you want to generate the frameworks to `some/path/MyApp/Flutter/`.

```sh
flutter build ios-framework --output=some/path/MyApp/Flutter/
```

```text
some/path/MyApp/
└── Flutter/
    ├── Debug/
    │   ├── Flutter.framework
    │   ├── App.framework
    │   ├── FlutterPluginRegistrant.framework
    │   └── example_plugin.framework (each plugin with iOS platform code is a separate framework)
      ├── Profile/
      │   ├── Flutter.framework
      │   ├── App.framework
      │   ├── FlutterPluginRegistrant.framework
      │   └── example_plugin.framework
      └── Release/
          ├── Flutter.framework
          ├── App.framework
          ├── FlutterPluginRegistrant.framework
          └── example_plugin.framework
```

{{site.alert.tip}}
With Xcode 11 installed you can generate [XCFrameworks][] instead of universal frameworks by adding
the flags `--xcframework --no-universal`.
{{site.alert.end}}

Embed the generated frameworks into your existing application in Xcode. For example, you can
drag the frameworks from `some/path/MyApp/Flutter/Release/` in Finder
into your targets's build settings > General > Frameworks, Libraries, and Embedded Content. Then, select
"Embed & Sign" from the drop-down.

{% include app-figure.md image="development/add-to-app/ios/project-setup/embed-xcode.png" alt="Embed frameworks in Xcode" %}

There are multiple ways to embed frameworks into a Xcode project—use the method that is best for your project.

You should now be able to build the project in Xcode using `⌘B`.

{{site.alert.tip}}
To embed the Debug version of the Flutter frameworks in your Debug build configuration
and the Release version in your Release configuration, in your `MyApp.xcodeproj/project.pbxproj` try
replacing `path = Flutter/Release/example.framework;`
with `path = "Flutter/$(CONFIGURATION)/example.framework";` for all added frameworks (note the added `"`).

You must also add `$(PROJECT_DIR)/Flutter/$(CONFIGURATION)` to your Framework Search Paths build setting.
{{site.alert.end}}

## Development

You can now [add a Flutter screen][] to your existing application.

[macOS system requirements for Flutter]: /docs/get-started/install/macos#system-requirements
[Xcode installed]: /docs/get-started/install/macos#install-xcode
[Android Studio/IntelliJ]: /docs/development/tools/android-studio
[VS Code]: /docs/development/tools/vs-code
[CocoaPods]: https://cocoapods.org/
[CocoaPods getting started guide]: https://guides.cocoapods.org/using/using-cocoapods.html
[Podfile target]: https://guides.cocoapods.org/syntax/podfile.html#target
[XCFrameworks]: https://developer.apple.com/documentation/xcode_release_notes/xcode_11_release_notes
[add a Flutter screen]: /docs/development/add-to-app/ios/add-flutter-screen
