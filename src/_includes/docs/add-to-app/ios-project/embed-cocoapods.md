### Use CocoaPods and the Flutter SDK {:#method-a .no_toc}

#### Approach {:#method-a-approach}

This first method uses CocoaPods to embed the Flutter modules.
CocoaPods manages dependencies for Swift projects,
including Flutter code and plugins.
Each time Xcode builds the app,
CocoaPods embeds the Flutter modules.

This allows rapid iteration with the most up-to-date
version of your Flutter module without running additional
commands outside of Xcode.

To learn more about CocoaPods,
consult the [CocoaPods getting started guide][].

#### Watch the video

If watching a video helps you learn,
this video covers adding Flutter to an iOS app:

{% ytEmbed 'IIcrfrTshTs', 'Step by step on how to add Flutter to an existing iOS app' %}

#### Requirements {:#method-a-reqs}

Every developer working on your project must have a local version
of the Flutter SDK and CocoaPods installed.

#### Example project structure {:#method-a-structure}

This section assumes that your existing app and
the Flutter module reside in sibling directories.
If you have a different directory structure,
adjust the relative paths.
The example directory structure resembles the following:

```plaintext
/path/to/MyApp
├── my_flutter/
│   └── .ios/
│       └── Flutter/
│         └── podhelper.rb
└── MyApp/
    └── Podfile
```

#### Update your Podfile

Add your Flutter modules to your Podfile configuration file.
This section presumes you called your Swift app `MyApp`.

1. _(Optional)_ If your existing app lacks a `Podfile` config file,
   navigate to the root of your app directory.
   Use the `pod init` command to create the `Podfile` file.

1. Update your `Podfile` config file.

   1. Add the following lines after the `platform` declaration.

      ```ruby title="MyApp/Podfile"
      flutter_application_path = '../my_flutter'
      load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
      ```

   1. For each [Podfile target][] that needs to embed Flutter,
      add a call to the
      `install_all_flutter_pods(flutter_application_path)` method.
      Add these calls after the settings in the previous step.

      ```ruby title="MyApp/Podfile"
      target 'MyApp' do
        install_all_flutter_pods(flutter_application_path)
      end
      ```

   1. In the `Podfile`'s `post_install` block,
      add a call to `flutter_post_install(installer)`.
      This block should be the last block in the `Podfile` config file.

      ```ruby title="MyApp/Podfile"
      post_install do |installer|
        flutter_post_install(installer) if defined?(flutter_post_install)
      end
      ```

To review an example `Podfile`, consult this [Flutter Podfile sample][].

#### Embed your frameworks

At build time, Xcode packages your Dart code, each Flutter plugin,
and the Flutter engine into their own `*.xcframework` bundles.
CocoaPod's `podhelper.rb` script then embeds these
`*.xcframework` bundles into your project.

* `Flutter.xcframework` contains the Flutter engine.
* `App.xcframework` contains the compiled Dart code for this project.
* `<plugin>.xcframework` contains one Flutter plugin.

To embed the Flutter engine, your Dart code, and your Flutter plugins
into your iOS app, complete the following procedure.

1. Refresh your Flutter plugins.

   If you change the Flutter dependencies in the `pubspec.yaml` file,
   run `flutter pub get` in your Flutter module directory.
   This refreshes the list of plugins that the `podhelper.rb` script reads.

   ```console
   flutter pub get
   ```

1. Embed the plugins and frameworks with CocoaPods.

   1. Navigate to your iOS app project at `/path/to/MyApp/MyApp`.

   1. Use the `pod install` command.

      ```console
      pod install
      ```

   Your iOS app's **Debug** and **Release** build configurations embed
   the corresponding [Flutter components for that build mode][build-modes].

1. Build the project.

   1. Open `MyApp.xcworkspace` in Xcode.

      Verify that you're opening `MyApp.xcworkspace` and
      not opening `MyApp.xcodeproj`.
      The `.xcworkspace` file has the CocoaPod dependencies,
      the `.xcodeproj` doesn't.

   1. Select **Product** > **Build** or press <kbd>Cmd</kbd> + <kbd>B</kbd>.

[build-modes]: /testing/build-modes
[CocoaPods getting started guide]: https://guides.cocoapods.org/using/using-cocoapods.html
[Podfile target]: https://guides.cocoapods.org/syntax/podfile.html#target
[Flutter Podfile sample]: https://github.com/flutter/samples/blob/main/add_to_app/plugin/ios_using_plugin/Podfile
